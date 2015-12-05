<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.ArrayList" %>
<%@page import="org.iiitb.facebook.model.*" %>
<%@page import ="org.iiitb.facebook.dao.impl.*" %>
<!DOCTYPE html>

<html lang="en">
<%
		ArrayList<Album> albumList=(ArrayList<Album>)request.getAttribute("albumList");
%>
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
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Albums</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<link href="css/newfeedstyles.css" rel="stylesheet">
		<style type="text/css">
		</style>
		
	<script type="text/javascript">
		function updateSetting(albumId){
			var id1="psetting"+albumId;
			var priName=document.getElementById(id1).value;
			 $.ajax({
		            url: "updateAlbumPrivacyAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"privacyName":priName,
		            	"postId" :albumId,
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
	<div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Create Album</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Album
									Name</label></td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 300px"
								name="album_name" id="album_name" /></td>
						</tr>
						
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="center"><input type="button" value="create"
								id="submit"  onclick="create_album()" class="btn btn-primary" /></td>
						</tr>
					</table>
				</div>
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
								<div class="col-sm-12">
									<div class="well">
									<%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
										<a href="#" data-toggle="modal" data-target="#modal2" class="pull-right"><h4>Create</h4></a><h4 align="left">Albums</h4>
										<%}else{ %>
										<h4>Create</h4></a><h4 align="left">Albums</h4>
										<%} %>
										<hr />

										
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
													boolean checkFriend1=NewsFeedDAOImpl.getJustFriend(u.getUserId(),tempUserId);
													ArrayList<String> plist=NewsFeedDAOImpl.getPrivacyDetail();
														for(int j=0;j<albumList.size();j=j+1){
															Album a=(Album)albumList.get(j);
															boolean flag=false;
															if(u.getUserId().equalsIgnoreCase(tempUserId)){
																flag=true;
															}else{
																if(checkFriend1 && (a.getPrivacyName().equalsIgnoreCase("PUBLIC") || a.getPrivacyName().equalsIgnoreCase("FRIENDS"))){
																	flag=true;
																}else if(a.getPrivacyName().equalsIgnoreCase("PUBLIC")){
																	flag=true;
																}else{
																	flag=false;
																}
															}
															
													%>
													<%
														if (j%3==0 && flag) {
													%>
													<tr>

														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="images/album.jpg" 
																	width="100" height="80" />&nbsp;<a href="viewImageAction?albumId=<%=a.getAlbumId()%>&user_id=<%=tempUserId%>" style="color: #3B5999"><b><%=a.getAlbumName()%></b></a></li>
																	<%if(u.getUserId().equalsIgnoreCase(tempUserId)){%>
																	<select id="psetting<%=a.getAlbumId()%>" name="psetting<%=a.getAlbumId()%>" onchange="updateSetting('<%=a.getAlbumId()%>')">
																	<option value="<%=a.getPrivacyName()%>"><%=a.getPrivacyName()%></option>
																		<%for(int f=0;f<plist.size();f++){
																				if(!a.getPrivacyName().equalsIgnoreCase(plist.get(f))){
																				%>	
																		<option value="<%=plist.get(f)%>"><%=plist.get(f)%></option>
																		<%}} %>
																		</select>
																		<%} %>
															</ul>
															
														</td>
														
														<td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
														<%
															} else if(j%3==1 && flag){
														%>
														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="images/album.jpg" 
																	width="100" height="80" />&nbsp;<a href="viewImageAction?albumId=<%=a.getAlbumId()%>&user_id=<%=tempUserId%>" style="color: #3B5999"><b><%=a.getAlbumName()%></b></a></li>
																	<%if(u.getUserId().equalsIgnoreCase(tempUserId)){%>
																	<select id="psetting<%=a.getAlbumId()%>" name="psetting<%=a.getAlbumId()%>" onchange="updateSetting('<%=a.getAlbumId()%>')">
																	<option value="<%=a.getPrivacyName()%>"><%=a.getPrivacyName()%></option>
																		<%for(int f=0;f<plist.size();f++){
																				if(!a.getPrivacyName().equalsIgnoreCase(plist.get(f))){
																				%>	
																		<option value="<%=plist.get(f)%>"><%=plist.get(f)%></option>
																		<%}} %>
																		</select>
																		<%} %>
															
															</ul>
														</td>

													<td>&nbsp; &nbsp; &nbsp; &nbsp;</td>

													<%
														} else if(flag){
													%>
														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="images/album.jpg" 
																	width="100" height="80" />&nbsp;<a href="viewImageAction?albumId=<%=a.getAlbumId()%>&user_id=<%=tempUserId%>" style="color: #3B5999"><b><%=a.getAlbumName()%></b></a></li>
																	<%if(u.getUserId().equalsIgnoreCase(tempUserId)){%>
																	<select id="psetting<%=a.getAlbumId()%>" name="psetting<%=a.getAlbumId()%>" onchange="updateSetting('<%=a.getAlbumId()%>')">
																	<option value="<%=a.getPrivacyName()%>"><%=a.getPrivacyName()%></option>
																		<%for(int f=0;f<plist.size();f++){
																				if(!a.getPrivacyName().equalsIgnoreCase(plist.get(f))){
																				%>	
																		<option value="<%=plist.get(f)%>"><%=plist.get(f)%></option>
																		<%}} %>
																		</select>
																		<%} %>
															
															</ul>
														</td>
													<%
														}}
													%>

													</tr>

												</table>
											</form>




										</div>
									</div>


								</div>

								<!-- main col right -->

</body>
</html>