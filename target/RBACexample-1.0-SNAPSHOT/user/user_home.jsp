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
            <a class="navbar-brand" href="https://www.onlyxcodes.com/">onlyxcodes</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="https://www.onlyxcodes.com/2019/03/role-based-access-control-in-java.html">Back to Tutorial</a></li>
            </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
	
	<center>
    	<h1>User Page</h1>
        <%
      	//setHeader no-cache because user logut successfully go "index.jsp" page but user click on back button than not show "user_home.jsp" page
        response.setHeader("Cache-Control", "no-cache,no-store, must-revalidate"); 
        
      	//check if condition get user session is null than user not access "user_home.jsp" page
		if(session.getAttribute("user_login")==null || session.getAttribute("user_login")=="") 
		{
            response.sendRedirect("../index.jsp"); 
		}
		%>
		
        <h2>Welcome, <%=session.getAttribute("user_login")%></h2>
        <h3><a href="../logout.jsp">Logout</h3>
        
  	</center>
	    
</body>
</html>