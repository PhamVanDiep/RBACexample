<%@page import="java.sql.*"%>

<%
    if(request.getParameter("btn_register")!=null)  //check condition button register click event not null "btn_register"
    {
        String firstname,lastname,email,password,role; //create blank bariable
        
        firstname=request.getParameter("txt_firstname");	//textbox name "txt_fristname"
        lastname=request.getParameter("txt_lastname");	//textbox name "txt_lastname"
        email=request.getParameter("txt_email");	//textbox name "txt_email"
        password=request.getParameter("txt_password");	//textbox name "txt_password"
        role=request.getParameter("txt_role"); //select option name "txt_role"
        
        String dburl="jdbc:mysql://localhost:3306/rbac"; //database url string the "jsp_multiuser_login_db" is database name
        String dbuname="root"; //database username   
        String dbpwd ="diep171101"; //database password
        
        try
        {
            Class.forName("com.mysql.jdbc.Driver"); //load driver
            Connection con=DriverManager.getConnection(dburl,dbuname,dbpwd); //create connection
            
            PreparedStatement pstmt=null; //create statement
            
            pstmt=con.prepareStatement("SELECT * FROM tbl_user WHERE email=? "); //sql select query
            pstmt.setString(1,email); 
            ResultSet rs=pstmt.executeQuery(); //execute query and set in ResultSet object "rs".
           
            if(rs.next())
            {
                String checkEmail=rs.getString("email");
                
                if(email.equals(checkEmail))    //check condition email already exist from user email
                {
                    request.setAttribute("errorMsg", "sorry email already exist"); //error message for email already exist
                }
            }
            else
            {
                pstmt=con.prepareStatement("INSERT INTO tbl_user(firstname,lastname,email,password,role) VALUES(?,?,?,?,?)"); //sql insert query
                pstmt.setString(1,firstname);
                pstmt.setString(2,lastname);
                pstmt.setString(3,email);           //set all variables
                pstmt.setString(4,password);
                pstmt.setString(5,role);
                pstmt.executeUpdate(); //execute query
                
                request.setAttribute("successMsg", "register successfully please login account"); //register successfully message
            }
            
            pstmt.close();  //close statement 
            con.close(); //close connection
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Role Based Access Control in Java Web Application Example</title>

<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.12.4-jquery.min.js" type="text/javascript"></script>
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        
<!--valiadtion css & js start here-->	
<style type="text/css">
label.error
{
	color:red;
	font-family:Times New Roman;
	font-size:17px;
}		
</style>

<script src="js/validate.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
   $('#registerForm').validate({
        rules:
            {
                txt_firstname:
                {
                    required:true
                },
                txt_lastname:
                {
                    required:true
                },
                txt_email:
                {
                    required:true,
                    email:true
                },
                txt_password:
                {
                    required:true,
                    minlength:6,
                    maxlength:12
                },
                txt_role:
                {
                    required:true				
                }
            },
        messages:
            {
                txt_firstname:
                {
                    required:"enter firstname" 
                },
                txt_lastname:
                {
                    required:"enter lastname" 
                },
                txt_email:
                {
                    required:"enter proper email address"  
                },
                txt_password:
                {
                    required:"enter password 6 to 12"
                },
                txt_role:
                {
                    required:"please select role"
                }
            }
   }); 
});
</script>
<!--valiadtion css & js end here-->

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
    
    <div class="wrapper">
	<div class="container">
	
		<div class="col-lg-12">
		<%
		if(request.getAttribute("errorMsg")!=null)
        {
        %>
        	<div class="alert alert-danger">
        		<strong>WRONG! <% out.println(request.getAttribute("errorMsg")); %></strong>
            </div>
       <%
        }
        if(request.getAttribute("successMsg")!=null)
        {
        %>
        	<div class="alert alert-success">
            	<strong>SUCCESS! <% out.println(request.getAttribute("successMsg")); %></strong>
            </div>
        <%
        }
        %>
		<center><h2>Register Page</h2></center>
		<form method="post" id="registerForm" class="form-horizontal">
					
        	<div class="form-group">
            <label class="col-sm-3 control-label">Firstname</label>
            <div class="col-sm-6">
            <input type="text" name="txt_firstname" class="form-control" placeholder="enter firstname" />
            </div>
            </div>
                    
            <div class="form-group">
            <label class="col-sm-3 control-label">Lastname</label>
            <div class="col-sm-6">
            <input type="text" name="txt_lastname" class="form-control" placeholder="enter lastname" />
            </div>
            </div>
                    
            <div class="form-group">
            <label class="col-sm-3 control-label">Email</label>
            <div class="col-sm-6">
            <input type="text" name="txt_email" class="form-control" placeholder="enter email" />
            </div>
            </div>
			
            <div class="form-group">
            <label class="col-sm-3 control-label">Password</label>
            <div class="col-sm-6">
            <input type="password" name="txt_password" class="form-control" placeholder="enter passowrd" />
            </div>
            </div>
					
            <div class="form-group">
            <label class="col-sm-3 control-label">Select Type</label>
            <div class="col-sm-6">
            <select class="form-control" name="txt_role">
            	<option value="" selected="selected"> - select role - </option>
                <option value="employee">Employee</option>
                <option value="user">User</option>
            </select>
            </div>
            </div>
				
            <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9 m-t-15">
            <input type="submit" name="btn_register" class="btn btn-primary" value="Register">
            </div>
            </div>
			
			<div class="form-group">
            <div class="col-sm-offset-3 col-sm-9 m-t-15">
            You have a account login here? <a href="index.jsp"><p class="text-info">Login Account</p></a>		
            </div>
            </div>
				
		</form>
		</div>
	</div>
	</div>
    
</body>
</html>

