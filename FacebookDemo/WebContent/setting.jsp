<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.ArrayList" %>
<%@page import="org.iiitb.facebook.model.About" %>
<%@page import="org.iiitb.facebook.model.Work" %>
<%@page import="org.iiitb.facebook.model.Education" %>
<%@page import="org.iiitb.facebook.model.Relationship" %>
<!DOCTYPE html>

<html lang="en">

<head>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/moment.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script src="js/scripts.js"></script>
<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">
<script type="text/javascript">
$( document ).ready(function() {
	$('#dob_setting').datepicker({
		format : "yyyy-mm-dd"
	});
});
function save()
{	
    var first_name = $('#first_name_setting').val(); 
    var last_name = $('#last_name_setting').val(); 
    var dob = $('#dob_setting').val();
    dob = moment(dob);
    dob = dob.format('YYYY/MM/DD');
    var password = $('#password_setting').val();
    $.ajax({
        url: "saveSetting",
        type: 'get',
        dataType: 'json',
        data: {
        	"first_name":first_name,
        	"last_name" : last_name,
        	"dob" : dob,
        	"password" : password,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
            $('#first_name_setting').val(response.first_name);
            $('#last_name_setting').val(response.last_name); 
            $('#dob_setting').val(response.dob); 
            $('#password_setting').val(response.password);
            alert("Your Setting has been saved");
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
}
function cancel()
{    
    $.ajax({
        url: "cancelSetting",
        type: 'get',
        dataType: 'json',
        
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	$('#first_name_setting').val(response.first_name);
            $('#last_name_setting').val(response.last_name); 
            $('#dob_setting').val(response.dob); 
            $('#password_setting').val(response.password);
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });    
}

</script>
<script type="text/javascript">
		function updateSetting(privacyId){
			var id1="privacy"+privacyId;
			
			var priName=document.getElementById(id1).value;
			 $.ajax({
		            url: "updateAllPrivacyAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"privacyName":priName,
		            	"postId" :privacyId,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
		            	location.reload(true);	
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		           		 alert("Error Occured. Please try again later");
		            }
		        }); 
		}
	</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Setting</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<link href="css/newfeedstyles.css" rel="stylesheet">
		<style type="text/css">
		</style>
		<link href="css/bootstrap-theme.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css" />
	<link rel="stylesheet" href="css/fontdhruvik.css" />
	<link rel="stylesheet" href="css/ace.min.css" />
	<link rel="stylesheet" href="css/ace-skins.min.css" />
	<link rel="stylesheet" href="css/ace-rtl.min.css" />
	<script src="js/ace-extra.min.js"></script>
	</head>
	<body>
<div class="wrapper">
    <div class="">
   
   			<%@ include file="header.jsp"%>
   			 
 
        <div class="row row-offcanvas row-offcanvas-left">
                  
          
            <!-- sidebar -->
            <%@ include file="leftnav.jsp"%>
            <!-- /sidebar -->
          
            <!-- main right col -->
            <div class="column col-sm-10 col-xs-11" id="main">
                
               
              
                <div class="padding">
				
                    <div class="full col-sm-9">
                      
                        <!-- content -->    
                        <%
                        		User u=(User)session.getAttribute("user");
                        		About about = (About)request.getAttribute("about");
                        		ArrayList<String> plist1=NewsFeedDAOImpl.getPrivacyDetail();
                        		ArrayList<Setting> al=SettingDAOImpl.getPrivacySetting(u.getUserId());
						%>
                        
                        
                        
                                          
                      	<div class="row">
                       
                         <!-- main col left --> 
                         <div class="col-sm-8">
                         
                              <div class="panel panel-default">
                              
                                 <div class="panel-heading"><h4>Account Settings</h4></div>
                                
                                  <div class="panel-body">
                                   <s:iterator value="about" var="abt">
                                    <table class="table table-striped table-hover">
                                    		<tr><th>First Name</th><td><input type="text" id="first_name_setting" name="first_name" <%if (about.getFirst_name() != null) {%>value=<%=about.getFirst_name()%> <%}else{%>value=""<%} %>></td></tr>
                                    		<tr><th>Last Name</th><td><input type="text" id="last_name_setting" name="last_name" <%if (about.getLast_name() != null) {%>value=<%=about.getLast_name()%> <%}else{%>value=""<%} %>></td></tr>
                                    		
                                    		<tr><th>Date of Birth</th><td><input type="text" id="dob_setting" name="dob" <%if (about.getDob() != null) {%>value=<%=about.getDob()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Password</th><td><input type="password" id="password_setting" name="password" <%if (about.getPassword() != null) {%>value=<%=about.getPassword()%> <%}else{%>value=""<%} %> ></td></tr>							
									</table>
									<p align="middle"><input type="button" id="button_edit" name="submit" value="Save" onclick="save()"/>
									</p>
									</s:iterator>
                                  </div>
                               </div>
                               
                               <div class="panel panel-default">
                              
                                 <div class="panel-heading"><h4>Access Control Settings</h4></div>
                                
                                  <div class="panel-body">
                                   <s:iterator value="about" var="abt">
                                    <table class="table table-striped table-hover">
                                    	<%for(int i=0;i<al.size();i++){ 
                                    		Setting s=al.get(i);
                                    	%>
                                    		<tr><th><%=s.getPrivacyType() %></th><td>
                                    			<select name="privacy<%=s.getPrivacyId()%>" id="privacy<%=s.getPrivacyId()%>" onchange="updateSetting('<%=s.getPrivacyId()%>')">
                                    				<option value="<%=s.getPrivacyName()%>"><%=s.getPrivacyName()%></option>
                                    				<%for(int f=0;f<plist1.size();f++){
                                    					if(!s.getPrivacyName().equalsIgnoreCase(plist1.get(f))){
														%>
															<option value="<%=plist1.get(f)%>"><%=plist1.get(f)%></option>
														<%}} %>
                                    			</select>
                                    		</td></tr>
                                    		<%} %>
                                    								
									</table>
									
									</s:iterator>
                                  </div>
                               </div>
                              </div>
                             
                         </div>
                              
                         <div class="row">
                          
                         <!-- main col left --> 
                         
                         </div>
                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->
          
        </div>
    </div>

	<!-- script references -->
		
		
	</body>
</html>