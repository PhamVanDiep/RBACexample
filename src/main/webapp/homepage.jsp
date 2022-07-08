<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Role Based Access Control in Java Web Application Example</title>
        <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="./js/jquery-1.12.4-jquery.min.js" type="text/javascript"></script>
        <script src="./bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </head>

    <body>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="https://github.com/PhamVanDiep/RBACexample">Source code</a>
            </div>
        </div>
    </nav>

    <center>
        <h1>Home page</h1>
        <%
            //setHeader no-cache because user logut successfully go "index.jsp" page but user click on back button than not show "user_home.jsp" page
            response.setHeader("Cache-Control", "no-cache,no-store, must-revalidate");

            //check if condition get user session is null than user not access "user_home.jsp" page
            if (session.getAttribute("session_login") == null || session.getAttribute("session_login") == "") {
                response.sendRedirect("index.jsp");
            }
        %>
        <h2>Welcome, <%=session.getAttribute("session_login")%></h2>
        <%
            int roleID = Integer.parseInt(session.getAttribute("roleID").toString());
            String dburl = "jdbc:mysql://localhost:3306/rbac"; //database url string the "jsp_multiuser_login_db" is database name
            String dbuname = "root"; //database username   
            String dbpwd = "diep171101"; //database password

            try {
                Class.forName("com.mysql.jdbc.Driver"); //load driver
                Connection con = DriverManager.getConnection(dburl, dbuname, dbpwd); //create connection

                PreparedStatement pstmt = null; //create statement

                pstmt = con.prepareStatement("SELECT p.permission_name, p.permission_file, p.permission_path"
                + " FROM role_permission rp, permission p"
                + " WHERE roleID=? and rp.permissionID = p.permissionID"); //sql select query
                pstmt.setInt(1, roleID);
                ResultSet rs = pstmt.executeQuery(); //execute query and set in ResultSet object "rs".

                while (rs.next()) {
                    out.print("<a href='" + rs.getString("permission_path") + "/" + rs.getString("permission_file") +"'>" 
                    + rs.getString("permission_name") + "</a><br>");
                }

                pstmt.close(); //close statement 
                con.close(); //close connection 
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <h3><a href="logout.jsp">Logout</h3>
    </center>
</body>
</html>
