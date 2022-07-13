<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("btn_authen") != null) {
        String auth_code = request.getParameter("txt_code");
//        String true_auth_code = request.getParameter("true_auth_code");
        String true_auth_code = request.getSession().getAttribute("true_auth_code").toString();
        if (true_auth_code.equals(auth_code)) {
            String firstname, lastname, email, password; //create blank bariable
            int roleID;
            firstname = request.getSession().getAttribute("txt_firstname").toString();	//textbox name "txt_fristname"
            lastname = request.getSession().getAttribute("txt_lastname").toString();	//textbox name "txt_lastname"
            email = request.getSession().getAttribute("txt_email").toString();	//textbox name "txt_email"
            password = request.getSession().getAttribute("txt_password").toString();	//textbox name "txt_password"
            roleID = Integer.parseInt(request.getSession().getAttribute("txt_role").toString()); //select option name "txt_role"
            
            String dburl = "jdbc:mysql://localhost:3306/rbac"; //database url string the "jsp_multiuser_login_db" is database name
            String dbuname = "root"; //database username   
            String dbpwd = "diep171101"; //database password
            
            try {
                Class.forName("com.mysql.jdbc.Driver"); //load driver
                Connection con = DriverManager.getConnection(dburl, dbuname, dbpwd); //create connection

                PreparedStatement pstmt = null; //create statement
                
                // insert into data base.
                pstmt = con.prepareStatement("INSERT INTO user(firstname,lastname,email,password,roleID) VALUES(?,?,?,?,?)"); //sql insert query
                pstmt.setString(1, firstname);
                pstmt.setString(2, lastname);
                pstmt.setString(3, email);           //set all variables
                pstmt.setString(4, password);
                pstmt.setInt(5, roleID);
                pstmt.executeUpdate(); //execute query

                pstmt = con.prepareStatement("update employee_email set status = 1 where email=?");
                pstmt.setString(1, email);
                pstmt.executeUpdate();
                
                request.setAttribute("successMsg", "register successfully please login account"); //register successfully message
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            request.setAttribute("errorMsg", "Incorrect Authentication code.");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Role Based Access Control in Java Web Application Example</title>
        <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="./js/jquery-1.12.4-jquery.min.js" type="text/javascript"></script>
        <script src="./bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        
        <!--valiadtion css & js start here-->	
        <style type="text/css">
            label.error
            {
                color:red;
                font-family:Times New Roman;
                font-size:17px;
            }
        </style>
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
        
        <div class="wrapper">
            <div class="container">
                <div class="col-lg-12">
                    <%
                        if (request.getAttribute("errorMsg") != null) {
                    %>
                    <div class="alert alert-danger">
                        <strong>WRONG! <% out.println(request.getAttribute("errorMsg")); %></strong>
                    </div>
                    <%
                        }
                        if (request.getAttribute("successMsg") != null) {
                    %>
                    <div class="alert alert-success">
                        <strong>SUCCESS! <% out.println(request.getAttribute("successMsg")); %></strong>
                    </div>
                    <%
                        }
                    %>
                    <h3><a href="index.jsp">Login</h3>
                </div>
            </div>
        </div>
    </body>
</html>