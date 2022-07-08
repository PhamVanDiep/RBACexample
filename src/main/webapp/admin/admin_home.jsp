<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Role Based Access Control in Java Web Application Example</title>
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="../js/jquery-1.12.4-jquery.min.js" type="text/javascript"></script>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
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
        <h1>Admin Page</h1>
        <%
            //setHeader no-cache because admin logut successfully go "index.jsp" page but admin click on back button than not show "admin_home.jsp" page
            response.setHeader("Cache-Control", "no-cache,no-store, must-revalidate");

            //check if condition get admin session is null than admin not access "admin_home.jsp" page
            if (session.getAttribute("session_login") == null || session.getAttribute("session_login") == "") {
                response.sendRedirect("../index.jsp");
            }
        %>

        <h2>Welcome, <%=session.getAttribute("session_login")%></h2>
        <h3><a href="../logout.jsp">Logout</h3>

    </center>

</body>
</html>