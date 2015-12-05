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
 <%
            About about = (About)request.getAttribute("about");
			ArrayList<Work> list_work = (ArrayList<Work>) (request.getAttribute("list_work"));
			ArrayList<Education> list_education = (ArrayList<Education>)(request.getAttribute("list_education"));
			ArrayList<Relationship> list_relationship = (ArrayList<Relationship>) (request.getAttribute("list_relationship"));
%>
<head>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/moment.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script src="js/scripts.js"></script>
<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">
<style type="text/css">
.clsDatePicker{z-index:100000;}
</style>
<script type="text/javascript">
function education_edit()
{
	var n = document.getElementById("education_size").value;
	for(var i=0;i<n;i++)
	{
		document.getElementById("button_edit_education"+i).style.visibility = "visible";
		document.getElementById("button_cancel_education"+i).style.visibility = "visible";
		document.getElementById("button_delete_education"+i).style.visibility = "visible";
		$("#institution_name"+i).prop("readonly", false);
		$("#studied"+i).prop("readonly", false);
		$('#e_start_date'+i).datepicker({
			format : "yyyy-mm-dd"
		});
		$('#e_end_date'+i).datepicker({
			format : "yyyy-mm-dd"
		});
	}
	return false;
}
function work_edit()
{
	var n = document.getElementById("work_size").value;
	
	for(var i=0;i<n;i++)
	{
		document.getElementById("button_edit_work"+i).style.visibility = "visible";
		document.getElementById("button_cancel_work"+i).style.visibility = "visible";
		document.getElementById("button_delete_work"+i).style.visibility = "visible";
		$("#company_name"+i).prop("readonly", false);
		$("#position"+i).prop("readonly", false);
		$('#w_start_date'+i).datepicker({
			format : "yyyy-mm-dd"
		});
		$('#w_end_date'+i).datepicker({
			format : "yyyy-mm-dd"
		});
	}
	return false;
}
function education_cancel(id)
{
	document.getElementById("button_edit_education"+id).style.visibility = "hidden";
	document.getElementById("button_cancel_education"+id).style.visibility = "hidden";
	document.getElementById("button_delete_education"+id).style.visibility = "hidden";
	$("#institution_name"+id).prop("readonly", true);
	$("#studied"+id).prop("readonly", true);
	$("#e_start_date"+id).attr("readonly", true).datepicker("destroy");
	$("#e_end_date"+id).attr("readonly", true).datepicker("destroy");
}
function work_cancel(id)
{
	document.getElementById("button_edit_work"+id).style.visibility = "hidden";
	document.getElementById("button_cancel_work"+id).style.visibility = "hidden";
	document.getElementById("button_delete_work"+id).style.visibility = "hidden";
	$("#company_name"+id).prop("readonly", true);
	$("#position"+id).prop("readonly", true);
	$("#w_start_date"+id).attr("readonly", true).datepicker("destroy");
	$("#w_end_date"+id).attr("readonly", true).datepicker("destroy");
}
function save_education(id)
{
	var we_id = $('#education_id'+id).val();
    var organization = $('#institution_name'+id).val(); 
    var position = $('#studied'+id).val(); 
    var start_date = $('#e_start_date'+id).val();
    start_date = moment(start_date);
    start_date = start_date.format('YYYY/MM/DD');
    var end_date = $('#e_end_date'+id).val();
    end_date = moment(end_date);
    end_date = end_date.format('YYYY/MM/DD');
    $.ajax({
        url: "educationEditSave",
        type: 'get',
        dataType: 'json',
        data: {
        	"we_id" : we_id,
        	"organization" : organization,
        	"position" : position,
        	"start_date" : start_date,
        	"end_date" : end_date,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	 $('#institution_name'+id).val(response.organization);
             $('#studied'+id).val(response.position); 
             $('#e_start_date'+id).val(response.start_date); 
             $('#e_end_date'+id).val(response.end_date); 
             
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
    education_cancel(id);
}
function save_work(id)
{
	var we_id = $('#work_id'+id).val();
    var organization = $('#company_name'+id).val(); 
    var position = $('#position'+id).val(); 
    var start_date = $('#w_start_date'+id).val();
    start_date = moment(start_date);
    start_date = start_date.format('YYYY/MM/DD');
    var end_date = $('#w_end_date'+id).val();
    end_date = moment(end_date);
    end_date = end_date.format('YYYY/MM/DD');
    $.ajax({
        url: "educationEditSave",
        type: 'get',
        dataType: 'json',
        data: {
        	"we_id" : we_id,
        	"organization" : organization,
        	"position" : position,
        	"start_date" : start_date,
        	"end_date" : end_date,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	 $('#company_name'+id).val(response.organization);
             $('#position'+id).val(response.position); 
             $('#w_start_date'+id).val(response.start_date); 
             $('#w_end_date'+id).val(response.end_date); 
             
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
    work_cancel(id);
}
function cancel_education(id)
{
	var we_id = $('#education_id'+id).val();
    $.ajax({
        url: "educationEditCancel",
        type: 'get',
        dataType: 'json',
        data: {
        	"we_id" : we_id,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	 $('#institution_name'+id).val(response.organization);
             $('#studied'+id).val(response.position); 
             $('#e_start_date'+id).val(response.start_date); 
             $('#e_end_date'+id).val(response.end_date); 
             
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
    education_cancel(id);
}
function cancel_work(id)
{
	var we_id = $('#work_id'+id).val();
    $.ajax({
        url: "educationEditCancel",
        type: 'get',
        dataType: 'json',
        data: {
        	"we_id" : we_id,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	 $('#company_name'+id).val(response.organization);
             $('#position'+id).val(response.position); 
             $('#w_start_date'+id).val(response.start_date); 
             $('#w_end_date'+id).val(response.end_date); 
             
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
    work_cancel(id);
}
function delete_education(id)
{
		var we_id = $('#education_id'+id).val();
	    $.ajax({
	        url: "deleteWorkEducation",
	        type: 'get',
	        dataType: 'json',
	        data: {
	        	"we_id" : we_id,
	        },
	        contentType: "application/json; charset=utf-8",
	        success:function(response){
	        	 location.reload();
	        },
	        error:function(jqXhr, textStatus, errorThrown){
	        alert("Error Occured. Please try again later");
	        }
	    });
}
function delete_work(id)
{
		var we_id = $('#work_id'+id).val();
	    $.ajax({
	        url: "deleteWorkEducation",
	        type: 'get',
	        dataType: 'json',
	        data: {
	        	"we_id" : we_id,
	        },
	        contentType: "application/json; charset=utf-8",
	        success:function(response){
	        	 location.reload();
	        },
	        error:function(jqXhr, textStatus, errorThrown){
	        alert("Error Occured. Please try again later");
	        }
	    });
}
function about_edit()
{
	document.getElementById("button_edit").style.visibility = "visible";
	document.getElementById("button_cancel").style.visibility = "visible";
	$("#first_name").prop("readonly", false);
	$("#last_name").prop("readonly", false);
	$("input[type=radio]").attr('disabled', false);
	$('#dob').datepicker({
		format : "yyyy-mm-dd"
	});
	$("#mobile").prop("readonly", false);
	$("#current_city").prop("readonly", false);
	$("#hometown").prop("readonly", false);
	$("#address").prop("readonly", false);
	$("#relationship").prop("disabled", false);
	return false;
}
function about_cancel()
{
	document.getElementById("button_edit").style.visibility = "hidden";
	document.getElementById("button_cancel").style.visibility = "hidden";
	$("#first_name").prop("readonly", true);
	$("#last_name").prop("readonly", true);
	$("input[type=radio]").attr('disabled', true);
	$("#dob").prop("readonly", true);
	$("#mobile").prop("readonly", true);
	$("#current_city").prop("readonly", true);
	$("#hometown").prop("readonly", true);
	$("#address").prop("readonly", true);
	$("#relationship").prop("disabled", true);
}

function save_about()
{	
    var first_name = $('#first_name').val(); 
    var last_name = $('#last_name').val(); 
    var gender = $('#gender').val(); 
    var dob = $('#dob').val();
    dob = moment(dob);
    dob = dob.format('YYYY/MM/DD');
    var mobile = $('#mobile').val(); 
    var current_city = $('#current_city').val(); 
    var hometown = $('#hometown').val(); 
    var address = $('#address').val();
    var relationship = $('#relationship').val();
    $.ajax({
        url: "aboutEditSave",
        type: 'get',
        dataType: 'json',
        data: {
        	"first_name":first_name,
        	"last_name" : last_name,
        	"gender" : gender,
        	"dob" : dob,
        	"mobile" : mobile,
        	"current_city" : current_city,
        	"hometown" : hometown,
        	"address" : address,
        	"relationship" : relationship,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
            $('#first_name').val(response.first_name);
            $('#last_name').val(response.last_name); 
            $('#gender').val(response.gender); 
            $('#dob').val(response.dob); 
            $('#mobile').val(response.mobile);
            $('#current_city').val(response.current_city); 
            $('#hometown').val(response.hometown); 
            $('#address').val(response.address);
            $('#relationship').val(response.relationship); 
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });    
    about_cancel();
}
function cancel_about(){
    
    
    
    $.ajax({
        url: "aboutEditCancel",
        type: 'get',
        dataType: 'json',
        
        contentType: "application/json; charset=utf-8",
        success:function(response){
            $('#first_name').val(response.first_name);
            $('#last_name').val(response.last_name); 
            $('#gender').val(response.gender); 
            $('#dob').val(response.dob); 
            $('#mobile').val(response.mobile); 
            $('#current_city').val(response.current_city); 
            $('#hometown').val(response.hometown); 
            $('#address').val(response.address);
            $('#relationship').val(response.relationship); 
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });    
    about_cancel();
}
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>About</title>
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
	
	<body onload="checkFriend()">
<div class="modal fade" id="modal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Add Education</b>
					</h5>
				</div>
				<form action="addEducation" method="post">
				<div class="modal-body">
					<table class="table table-striped table-hover">
						<tr><th>Instituon Name</th><td><input type="text" id="instituion_name_add" name="organization" value=""></td></tr>
						<tr><th>Studied</th><td><input type="text" id="studied_add" name="position"></td></tr>
						<tr><th>Start Date</th><td><input type="text" class="clsDatePicker" placeholder="YYYY-MM-DD" id="e_start_date_add" name="start_date" onclick="laodDatePickerES()"></td></tr>
						<tr><th>End Date</th><td><input type="text" class="clsDatePicker" placeholder="YYYY-MM-DD" id="e_end_date_add" name="end_date" onclick="laodDatePickerEE()"></td></tr>
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="center"><input type="submit" value="Add"
								id="submit" class="btn btn-primary" /></td>
						</tr>
					</table>
				</form>
				</div>
			</div>
		</div>
	</div>
	
<div class="modal fade" id="modal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Add Work</b>
					</h5>
				</div>
				<form action="addWork" method="post">
				<div class="modal-body">
					<table class="table table-striped table-hover">
						<tr><th>Company Name</th><td><input type="text" id="company_name_add" name="organization"></td></tr>
						<tr><th>Position</th><td><input type="text" id="position_add" name="position"></td></tr>
						<tr><th>Start Date</th><td><input type="text" class="clsDatePicker" placeholder="YYYY-MM-DD" id="w_start_date_add" name="start_date" onclick="laodDatePickerWS()"></td></tr>
						<tr><th>End Date</th><td><input type="text" class="clsDatePicker" placeholder="YYYY-MM-DD" id="w_end_date_add" name="end_date" onclick="laodDatePickerWE()"></td></tr>
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="center"><input type="submit" value="Add"
								id="submit" class="btn btn-primary" /></td>
						</tr>
					</table>
				</div>
				</form>
			</div>
		</div>
	</div>
<div class="wrapper">
    <div>
   
   			<%@ include file="timelineHeader.jsp"%>

            <!-- main right col -->
            <div class="column col-sm-10 col-xs-11" id="main">
                
               
              
                <div class="padding">
                    <div class="full col-sm-9">
                      
                        <!-- content -->    
                       
                        
                        
                        
                                          
                      	<div class="row">
                       
                         <!-- main col left --> 
                         <div class="col-sm-8">
                         
                              <div class="panel panel-default">
                              <%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
                                <div class="panel-heading"><a href="#" onclick="about_edit();" class="pull-right">Edit</a> <h4>Basic Information</h4></div>
                                <%}else{ %>
                                 <div class="panel-heading"><h4>Basic Information</h4></div>
                                <%} %>
                                  <div class="panel-body">
                                   <s:iterator value="about" var="abt">
                                    <table class="table table-striped table-hover">
                                    		<tr><th>First Name</th><td><input type="text" id="first_name" name="first_name" <%if (about.getFirst_name() != null) {%>value=<%=about.getFirst_name()%> <%}else{%>value=""<%} %> readonly="readonly"></td></tr>
                                    		<tr><th>Last Name</th><td><input type="text" id="last_name" name="last_name" <%if (about.getLast_name() != null) {%>value=<%=about.getLast_name()%> <%}else{%>value=""<%} %> readonly="readonly"></td></tr>
                                    		<tr><th>Gender</th>
                                    		<%if(about.getGender().equalsIgnoreCase("male")){ %>
                                    		<td><input type="radio" id="gender" name="gender" value="male" checked="checked" disabled="disabled">Male
                                    		<input type="radio" id="gender" name="gender" value="female" disabled="disabled">Female</td>
                                    		<%}else if(about.getGender().equalsIgnoreCase("female")){ %>
                                    		<td><input type="radio" id="gender" name="gender" value="male" disabled="disabled">Male
                                    		<input type="radio" id="gender" name="gender" value="female" checked="checked"  disabled="disabled">Female</td>
                                    		<% }else { %>
                                    		<td><input type="radio" id="gender" name="gender" value="male" disabled="disabled">Male
                                    		<input type="radio" id="gender" name="gender" value="female" disabled="disabled">Female</td>
                                    		<%} %>
                                    		</tr>    	
                                    		<tr><th>Date of Birth</th><td><input type="text" id="dob" readonly="readonly" name="dob" <%if (about.getDob() != null) {%>value=<%=about.getDob()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Mobile No</th><td><input type="text" id="mobile" readonly="readonly" name="mobile" <%if (about.getMobile() != null) {%>value=<%=about.getMobile()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Current City</th><td><input type="text" id="current_city" readonly="readonly" name="current_city" <%if (about.getCurrent_city() != null) {%>value=<%=about.getCurrent_city()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Hometown</th><td><input type="text" id="hometown" readonly="readonly" name="hometown" <%if (about.getHometown() != null) {%>value=<%=about.getHometown()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Address</th><td><input type="text" id="address" readonly="readonly" name="address" <%if (about.getAddress() != null) {%>value=<%=about.getAddress()%> <%}else{%>value=""<%} %> ></td></tr>
                                    		<tr><th>Relationship Status</th><td>
                                    		<select  disabled class="form-control" name="relationship" id="relationship" style="width: 190px;">
                                    		<%
												for (int i = 0;i < list_relationship.size(); i++)
												{
															Relationship r = list_relationship.get(i);
															if (r != null && r.getRelationship_id().equalsIgnoreCase((String)about.getRelationship()))
															{
											%>
												<option value="<%=r.getRelationship_id()%>" selected="selected"><%=r.getRelationship_name()%></option>
												<%
															}else{
												%>
												<option value="<%=r.getRelationship_id()%>"><%=r.getRelationship_name()%></option>
												<%
															}
												}
												%>
                                    		</td></tr>								
									</table>
									<p align="middle"><input type="button" id="button_edit" name="submit" value="Save" style="visibility:hidden;" onclick="save_about()"/>
									<align="middle"><input type="button" id="button_cancel" name="submit" value="Cancel" style="visibility:hidden;" onclick="cancel_about()"/></p>
									</s:iterator>
                                  </div>
                               </div>
                              </div>
                             
                         </div>
                              
                         <div class="row">
                          
                         <!-- main col left --> 
                         <div class="col-sm-8">
                              <div class="panel panel-default">
                              <%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
                                <div class="panel-heading"><a href="#" onclick="education_edit();" class="pull-right">Edit</a><br> <a href="#" data-toggle="modal" data-target="#modal1" class="pull-right">Add </a><h4>Education</h4></div>
                                <%}else{ %>
                                 <div class="panel-heading"><h4>Education</h4></div>
                                <%} %>
                                  <div class="panel-body">
                                  <%
                                  	for (int i = 0;i < list_education.size(); i++)
                                    {
                                  	  Education e = list_education.get(i);
                                  %>
                                    <table class="table table-striped table-hover">
                                    		<input type="hidden" id="education_size" value="<%= list_education.size()%>">
                                    		<input type="hidden" id="education_id<%=i%>" value="<%=e.getWe_id()%>">
                                    		<tr><th>Institution Name</th><td><input type="text" id="institution_name<%=i%>" <%if (e.getInstitution_name() != null) {%>value=<%=e.getInstitution_name()%> <%}else{%>value=""<%}%> readonly></td></tr>
                                    		<tr><th>Studied</th><td><input type="text" id="studied<%=i%>" <%if (e.getStudied() != null) {%>value=<%=e.getStudied()%> <%}else{%>value=""<%} %> readonly></td></tr>
                                    		<tr><th>Start Date</th><td><input type="text" id="e_start_date<%=i%>" <%if (e.getStart_date() != null) {%>value=<%=e.getStart_date()%> <%}else{%>value=""<%} %> readonly></td></tr>
                                			<tr><th>End Date</th><td><input type="text" id="e_end_date<%=i%>" <%if (e.getEnd_date() != null) {%>value=<%=e.getEnd_date()%> <%}else{%>value=""<%} %> readonly></td></tr>
									</table>
								
									<p align="middle"><input type="button" id="button_edit_education<%=i%>" name="submit" value="Save" style="visibility:hidden;" onclick="save_education(<%=i%>)"/>
									<align="middle"><input type="button" id="button_cancel_education<%=i%>" name="submit" value="Cancel" style="visibility:hidden;" onclick="cancel_education(<%=i%>)"/>
									<align="middle"><input type="button" id="button_delete_education<%=i%>" name="submit" value="Delete" style="visibility:hidden;" onclick="delete_education(<%=i%>)"/></p>
								  <% 
                                  }
								  %>
                                  </div>
                                  
                               </div>
                               
                              </div>
                         </div>
                         <div class="row">
                          <!-- main col left --> 
                         <div class="col-sm-8">
                              <div class="panel panel-default">
                                <%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
                                <div class="panel-heading"><a href="#" onclick="work_edit();" class="pull-right">Edit</a><br> <a href="#" data-toggle="modal" data-target="#modal3" class="pull-right">Add </a><h4>Work</h4></div>
                              	<%}else{ %>
                              	<div class="panel-heading"><h4>Work</h4></div>
                              	<%} %>
                                  <div class="panel-body">
                                  <%
                                  for (int i = 0;i < list_work.size(); i++)
                                  {
                                	  Work w = list_work.get(i);
                                  %>
                                    <table class="table table-striped table-hover">
                                    		<input type="hidden" id="work_size" value="<%=list_work.size()%>">
                                    		<input type="hidden" id="work_id<%=i%>" value="<%=w.getWe_id()%>">
                                    		<tr><th>Company Name</th><td><input type="text" id="company_name<%=i%>" <%if (w.getCompany_name() != null) {%>value=<%=w.getCompany_name()%><% } else{%>value=""<%} %>></td></tr>
                                    		<tr><th>Position</th><td><input type="text" id="position<%=i%>" <%if (w.getPosition() != null) {%>value=<%=w.getPosition()%> <%}else{%>value=""<%} %>></td></tr>
                                    		<tr><th>Start Date</th><td><input type="text" id="w_start_date<%=i%>" <%if (w.getStart_date() != null) {%>value=<%=w.getStart_date()%><%}else{%> value=""<%} %>></td></tr>
                                    		<tr><th>End Date</th><td><input type="text" id="w_end_date<%=i%>" <%if (w.getEnd_date() != null) {%>value=<%=w.getEnd_date()%> <%}else{%>value=""<%} %>></td></tr>
									</table>
									<p align="middle"><input type="button" id="button_edit_work<%=i%>" name="submit" value="Save" style="visibility:hidden;" onclick="save_work(<%=i%>)"/>
									<align="middle"><input type="button" id="button_cancel_work<%=i%>" name="submit" value="Cancel" style="visibility:hidden;" onclick="cancel_work(<%=i%>)"/>
									<align="middle"><input type="button" id="button_delete_work<%=i%>" name="submit" value="Delete" style="visibility:hidden;" onclick="delete_work(<%=i%>)"/></p>
								  <% 
                                  }
								  %>
                                  </div>
                                  
                               </div>
                              </div>
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