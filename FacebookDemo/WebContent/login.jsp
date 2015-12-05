<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Facebook-Prototype</title>
<link rel="stylesheet" href="css/homestyleAnish.css" type="text/css" />
<script
	src="js/jquery-1.10.2.min.js"></script>
<script
	src="js/bootstrap.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">
	function checkValidation(){
		var firstName=$("#firstName").val();
		
		var lastName=document.getElementById("lastName").value;
		
		var reEmail=document.getElementById("reEmail").value;
		
		var email=document.getElementById("email").value;
		
		var pass=document.getElementById("regPass").value;
		
		var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    	var filterM = /^[0-9-+]+$/;
    	
		if(firstName=="" || firstName==" " || firstName==null){
			alert("FirstName / LastName is required.")
			document.getElementById("spanFirstName").style.display="none";
			return false;
		}
		if(email=="" || email==" " || email==null){
			alert("Email is required.")
			document.getElementById("spanEmail").display="block";
			return false;
		}
		if(reEmail=="" || reEmail==" " || reEmail==null){
			alert("reEmail field is required.")
			return false;
		}
		if(!(email==reEmail)){
			alert("Both the email should be same.")
			return false;
		}
		
		if (!filter.test(email)) {
			alert("Email Should be valid email Id")
			document.getElementById("spanEmail").display="block";
	   		document.getElementById("spanEmail").innerHTML="Email Id is incorrect";
	   		return false;
   		}
		if(pass=="" || pass==" " || pass==null){
			alert("Password is required.")
			document.getElementById("spanPass").display="block";
			return false;
		}
		
		if(document.getElementById("male").checked==true || document.getElementById("female").checked==true){
			
		}else{
			alert("Gender is required.");
			document.getElementById("spanGen").display="block";
			return false;
		}
		var month=document.getElementById("month").value;
		var day=document.getElementById("day").value;
		var year=document.getElementById("year").value;
		if(month==-1 || day==-1 || year==-1){
			alert("Birth date is required.");
			return false;
		}else{
			document.getElementById("birthday").value=year+"-"+month+"-"+day;
		}
		
		$("#register").submit();
		return true;
	}
	
	function checkLogin(){
		var emailID=document.getElementById("emailID").value;
		var pass=document.getElementById("pass").value;
		if(emailID=="" || emailID==" " || emailID==null){
			alert("EmailID is required.")
			return false;
		}
		if(pass=="" || pass==" " || pass==null){
			alert("Password is required.")
			return false;
		}
		$("#login_form").submit();
	}
	
</script>
<style type="text/css">
.modalBlock {
	display: block;
	position: relative;
}
</style>

</head>

<body class="login">
<!-- header starts here -->
<div id="facebook-Bar">
  <div id="facebook-Frame">
    <div id="logo"> <a href="#">Facebook</a> </div>
        <div id="header-main-right">
          <div id="header-main-right-nav">
        <form method="post" action="loginAction" id="login_form" name="login_form">
          <table border="0" style="border:none">
            <tr>
              <td ><input type="text" tabindex="1"  id="emailID" placeholder="Email or Phone" name="userID" class="inputtext radius1" value=""></td>
              <td ><input type="password" tabindex="2" id="pass" placeholder="Password" name="password" class="inputtext radius1" ></td>
              <td >
               <input type="submit" class="xyz" name="login" value="Login" onclick="return checkLogin();"/></td>
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
<s:if test="hasActionErrors()">
<div class="loginbox1 radius">
	<s:actionerror/>
</div>
</s:if>
<s:if test="hasActionMessages()">
		<div class="loginbox1 radius">
	<s:actionmessage/>
</div>	
</s:if>

<div class="loginbox radius" align="right">
<h2 style="color:#141823; text-align:center;">Welcome to Facebook</h2>
	<div class="loginboxinner radius">
    	<div class="loginheader">
    		<h4 class="title">Connect with friends and the world around you.</h4>
    	</div><!--loginheader-->
        
        <div class="loginform">
                	
        	<form id="register" method="post" action="registerAction">
            <p>
                    <input type="text" id="firstName" name="firstName" placeholder="First Name" value="" class="radius mini" style="color: black;" /> <input type="text" id="lastName" name="lastName" placeholder="Last Name" style="color: black;" value="" class="radius mini" />
                	<div style="color: red;display: none;" id="spanFirstName">First/last name is required.</div>
                </p>
            	<p>
                    <input type="text" id="email" name="email" placeholder="Your Email" value="" class="radius" style="color: black;"/>
                    <div style="color: red;display:none;" id="spanEmail">Email is required.</div>
                </p>
                <p>
                    <input type="text" id="reEmail" name="reEmail" placeholder="Re-enter Email" class="radius" style="color: black;"/>
                    <div style="color: red;display:none;" id="spanReEmail">Email is required.</div>
                </p>
                <p>
                    <input type="password" id="regPass" name="password" placeholder="New Password" class="radius" style="color: black;"/>
                    <div style="color: red;display:none;" id="spanPass">Password is required.</div>
                </p>
                <label style="text-align: left;font-size: 20px;">&nbsp;&nbsp;&nbsp;<b>Birthday:</b></label>
                <input type="hidden" id="birthday" name="birthday" value=""/>
                 <p>
                   <select name="month" class="mini1" id="month">
                   		<option value="-1">Month</option>
                   		<%for(int i=1;i<=12;i++){ %>
                   		<option value="<%=i%>"><%=i %></option>
                   		<%} %>
                   </select>
                   <select name="day" class="mini1" id="day">
                   		<option value="-1">Day</option>
                   		<%for(int i=1;i<=31;i++){ %>
                   		<option value="<%=i%>"><%=i %></option>
                   		<%} %>
                   </select>
                   <select name="year" class="mini1" id="year">
                   		<option value="-1">Year</option>
                   		<%for(int i=2015;i>=1905;i--){ %>
                   		<option value="<%=i%>"><%=i %></option>
                   		<%} %>
                   </select>
                    <div style="color: red;display: none;" id="spanBirth">Birthdate is required.</div>
                </p>
                 <p align="left">
                 		<input type="radio" class="gen" name="gender" id="male" value="Male">Male</input>
                 		<input type="radio" class="gen" name="gender" id="female" value="Female">Female</input>
                </p>
                <div style="color: red;display: none;" id="spanGen">Gender is required.</div>
                <p>
                	<button  name="client_login" id="signUp" onclick="return checkValidation();">Sign Up for Facebook</button>
                </p>
            </form>
        </div><!--loginform-->
    </div><!--loginboxinner-->
</div><!--loginbox-->


</body>

</html>
