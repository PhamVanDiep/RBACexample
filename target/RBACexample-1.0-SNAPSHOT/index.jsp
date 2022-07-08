<%@ page import="java.sql.*" %>

<%
    //check condition login not back index.jsp(login) page
    if (session.getAttribute("session_login") != null) {
        response.sendRedirect("./homepage.jsp");
    }
    if (request.getParameter("btn_login") != null) //check condition button login click event not null "btn_login"
    {
        String email, password;
        int roleID;
        email = request.getParameter("txt_email"); //textbox name "txt_email"
        password = request.getParameter("txt_password"); //textbox name "txt_password"
        roleID = Integer.parseInt(request.getParameter("txt_role")); //textbox name "txt_role"

        String dburl = "jdbc:mysql://localhost:3306/rbac"; //database url string the "jsp_multiuser_login_db" is database name
        String dbuname = "root"; //database username   
        String dbpwd = "diep171101"; //database password

        try {
            Class.forName("com.mysql.jdbc.Driver"); //load driver
            Connection con = DriverManager.getConnection(dburl, dbuname, dbpwd); //create connection

            PreparedStatement pstmt = null; //create statement

            pstmt = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=? AND roleID=? "); //sql select query
            pstmt.setString(1, email);
            pstmt.setString(2, password);    //set above all variable
            pstmt.setInt(3, roleID);
            ResultSet rs = pstmt.executeQuery(); //execute query and set in ResultSet object "rs".

            if (rs.next()) {
                String dbemail = rs.getString("email");
                String dbpassword = rs.getString("password");     //fetch MySQL database record and store new variable  dbemail,dbpassword,dbrole
                int dbroleID = rs.getInt("roleID");

                if (email.equals(dbemail) && password.equals(dbpassword) && roleID == dbroleID) //check fethable database record and user input value are match after continue
                {
                    session.setAttribute("session_login", dbemail); //session name is "admin_login" and store fetchable database "dbemail" address
                    session.setAttribute("roleID", roleID);
                    response.sendRedirect("./homepage.jsp"); //after login success redirect to "admin_home.jsp" page in admin folder
                }
            } else {
                request.setAttribute("errorMsg", "invalid email or password or role"); //invalid error message for email or password or role wrong
            }

            pstmt.close(); //close statement 
            con.close(); //close connection 
        } catch (Exception e) {
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
            $(document).ready(function () {
                $('#loginForm').validate({
                    rules:
                            {
                                txt_email:
                                        {
                                            required: true,
                                            email: true
                                        },
                                txt_password:
                                        {
                                            required: true
                                        },
                                txt_role:
                                        {
                                            required: true
                                        }
                            },
                    messages:
                            {
                                txt_email:
                                        {
                                            required: "enter proper email address"
                                        },
                                txt_password:
                                        {
                                            required: "enter password"
                                        },
                                txt_role:
                                        {
                                            required: "please select role"
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
                %>
                <center><h2>Login Page</h2></center>
                <form method="post" id="loginForm" class="form-horizontal">

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
                            <select name="txt_role" class="form-control">
                                <option value="" selected="selected"> - select role - </option>
                                <option value="1">Admin</option>
                                <option value="2">Employee</option>
                                <option value="3">User</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9 m-t-15">
                            <input type="submit" name="btn_login" class="btn btn-success" value="Login">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9 m-t-15">
                            You don't have a account register here? <a href="register.jsp"><p class="text-info">Register Account</p></a>		
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>

</body>
</html>
