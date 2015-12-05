<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.ArrayList" %>
<%@page import="org.iiitb.facebook.model.*" %>
<!DOCTYPE html>
<%
	ArrayList<Image> imageList=(ArrayList<Image>)request.getAttribute("imageList");
	String albumId = request.getAttribute("albumId").toString();
%>
<html lang="en">

<head>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script src="js/scripts.js"></script>
<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">
<style type="text/css">
.clsDatePicker{z-index:100000;}
</style>
<script type="text/javascript">
function showFilepicker()
{
	document.getElementById("togglediv").style.display = "block";
	document.getElementById("b2").style.display="none";
}
function showFilepicker1()
{
	document.getElementById("togglediv1").style.display = "block";
	document.getElementById("b3").style.display="none";
}
function uploadImage()
{
	var albumId = $('#albumId').val();
	
	$.ajax({
        url: "ImageUploadAction",
        type: 'get',
        dataType: 'json',
        data: {
        	"albumId":albumId,
        },
        contentType: "application/json; charset=utf-8",
        success:function(response){
        	alert("hi");
        },
        error:function(jqXhr, textStatus, errorThrown){
        alert("Error Occured. Please try again later");
        }
    });
}

</script>

<script type="text/javascript">
function showFilepicker()
{
	document.getElementById("togglediv").style.display = "block";
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
								<div class="col-sm-12">
									<div class="well">
									<%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
									
									<form id="uploadImage" action="ImageUploadAction" method="post" enctype="multipart/form-data">
										<input type="hidden" id="albumId" name="albumId" value="<%=albumId%>"></input>
										<button class="btn btn-primary pull-right" type="submit" >Upload Photo</button>
										
										<ul class="list-inline"><li>
												<s:file class="pull-right" id="fp" name="pic" />
										</li>
										</ul>
										
										<h4 align="left">Photos</h4>
										<hr/>
									</form>
									
									<%} %>
										
										<%-- if(userData!=null && userData.size()>0){
				 for(int i=0;i<userData.size();){
					 int len=(userData.size())-i;
					 if(len>=4)len=4;
			 %>  --%>
										<!-- Projects Row -->
										
											<div class="row">
											<form>
												<table>

													<%
														for(int j=0;j<imageList.size();j=j+1){
															Image a=(Image)imageList.get(j);
													%>
													<%
														if (j%3==0) {
													%>
													<tr>

														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=a.getPath()%>" 
																	width="280" height="200" />&nbsp;</li>
															</ul>
														</td>
														<td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
														<%
															} else if(j%3==1){
														%>
														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=a.getPath()%>" 
																	width="280" height="200" />&nbsp;</li>
															</ul>
														</td>

														<td>&nbsp; &nbsp; &nbsp; &nbsp;</td>

													<%
														} else {
													%>
														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=a.getPath()%>" 
																	width="280" height="200" />&nbsp;</li>
															</ul>
														</td>
														
													<%
														}
														}
													%>

													</tr>

												</table>
											</form>

										
									</div>
</ul>

								</div>

								<!-- main col right -->

</body>
</html>