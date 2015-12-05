<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Facebook-Prototype</title>
<link rel="stylesheet" href="css/homestyle.css" type="text/css" />
<script
	src="js/jquery-1.10.2.min.js"></script>
<script
	src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
.modalBlock {
	display: block;
	position: relative;
}
</style>

</head>

<body>
<!-- header starts here -->
<div id="facebook-Bar">
  <div id="facebook-Frame">
    <div id="logo"> <a href="login.jsp">Facebook</a> </div>
    
         
        <div id="header-main-right">
          <div id="header-main-right-nav">
        <form method="post" action="loginAction" id="login_form" name="login_form">
          <table border="0" style="border:none">
            <tr>
              <td ><input type="text" tabindex="1"  id="email" placeholder="Email or Phone" name="userID" class="inputtext radius1" value=""></td>
              <td ><input type="password" tabindex="2" id="pass" placeholder="Password" name="password" class="inputtext radius1" ></td>
              <td >
               <input type="submit" class="xyz" name="login" value="Login" /></td>
            </tr>
            <tr>
           
            <td><label><a href="forgotpassword.jsp" style="color:#ccc; text-decoration:none">forgot your password?</a></label></td>
            </tr>
          </table>
        </form>
      </div>
          </div>
      </div>
</div>
<!-- header ends here -->
<s:if test="hasActionMessages()">
		<div class="loginbox1 radius">
	<s:actionmessage/>
</div>	
</s:if>
<div class="loginbox radius" style="border-style: solid; border-width: 2px;" align="right">
<h3 style="color:#141823; text-align:center; border:15px;">Forgot Your Password?</h2>
	<div class="forgotboxinner radius">
    	<div class="loginheader">
    		<h4 class="title"></h4>
    	</div><!--loginheader-->
        
        <div class="loginform">
                	
        	<form id="forgotPassword" action="forgotPassword" method="post">
            	<p>
                    Email ID <input type="text" id="email" name="email" placeholder="Email ID" value="" style="color: black;" class="radius mini1" required/>
                </p>
                
                	<button class="loginbox button" name="submit">Send Password</button>
            </form>
            
                </p>
            
        </div><!--loginform-->
    </div><!--loginboxinner-->
</div><!--loginbox-->


</body>

</html>
