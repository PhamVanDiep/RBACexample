<%-- 
    Document   : authentication
    Created on : Jul 11, 2022, 11:02:49 PM
    Author     : dieppv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <div class="alert alert-danger" style="display: none">
                        <strong>This code is incorrect</strong>
                    </div>
                    <div class="alert alert-success">
                        <strong>An authentication code was sent to your register email.</strong>
                        <strong>Type that code into below edit text to complete sign up your account.</strong>
                    </div>
                    <center><h2>Authentication Page</h2></center>
                    <br>
                    <div class="">
                        <label class="col-sm-3 control-label" style="text-align: right">Authentication code</label>
                        <div class="col-sm-6">
                            <input type="text" name="txt_code" class="form-control" placeholder="enter authentication code" />
                        </div>
                    </div>
                    <center>
                        <input type="button" name="btn_authen" class="btn btn-success" value="Authentication">
                    </center>
                </div>
            </div>
        </div>
    </body>
</html>
