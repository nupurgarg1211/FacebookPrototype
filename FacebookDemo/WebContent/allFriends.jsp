<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.*"%>
<%@ page import="org.iiitb.facebook.model.*"%>
<!DOCTYPE html>

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
function hello(id) {
	var idvar = id;
	document.getElementById("temp").value = idvar;
	//window.location = "http://www.yoururl.com";
//		document.getElementById(idvar).value = idvar;
		$('#dhruvik').submit();
//	document.dhruvik.action = 'removeFriend';
//	document.dhruvik.submit();
}
function accept_req(id) {
	var idvar = id;
	document.getElementById("pending").value = idvar;
	//window.location = "http://www.yoururl.com";
//		document.getElementById(idvar).value = idvar;
//		$('#dhruvik').submit();
	document.pending_req.action = 'acceptFriend';
	document.pending_req.submit();
}
function reject_req(id) {
var idvar = id;
document.getElementById("pending").value = idvar;
//window.location = "http://www.yoururl.com";
//	document.getElementById(idvar).value = idvar;
//	$('#dhruvik').submit();
document.pending_req.action = 'rejectFriend';
document.pending_req.submit();
} 
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>All Friends</title>
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
								<div class="col-sm-8">
									<div class="well">

										<h4 align="left">Friends</h4>
										<hr />
 
										<%
											ArrayList<UserDhruvik> userData=(ArrayList<UserDhruvik>)request.getAttribute("userData");
											Integer show_jsp = (Integer)request.getAttribute("show");
										%>
										<%-- if(userData!=null && userData.size()>0){
				 for(int i=0;i<userData.size();){
					 int len=(userData.size())-i;
					 if(len>=4)len=4;
			 %>  --%>
										<!-- Projects Row -->
										<div class="row">
											<s:form class="form-horizontal" id="dhruvik"
												action="removeFriend">
												<table>

													<%
														for(int j=0;j<userData.size();j=j+1){
																									UserDhruvik u1=(UserDhruvik)userData.get(j);
													%>
													<%
														if (j%2==0) {
													%>
													<tr>

														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=u1.getProfile_pic()%>" class="img-rounded"
																	width="100" height="80" />&nbsp;<a
																	href="userNewsFeedAction?user_id=<%=u1.getUserid()%>"
																	style="color: #3B5999"><b><%=u1.getFirst_name()%>
																			<%=u1.getLast_name()%></b></a><br />
																	
														 			 <%if(show_jsp==1){ %>
																	<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Remove Friend" name="remove_friend"
																			onclick="hello('<%=u1.getUserid()%>')">
																	</div>
																<%} %>
																	</li>


															</ul>
														</td>
														<td>&nbsp; &nbsp; &nbsp; &nbsp;</td>
														<%
															} else {
														%>
														<td>
															<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=u1.getProfile_pic()%>" class="img-rounded"
																	width="100" height="80" />&nbsp;<a
																	href="userNewsFeedAction?user_id=<%=u1.getUserid()%>"
																	style="color: #3B5999"><b><%=u1.getFirst_name()%>
																			<%=u1.getLast_name()%></b></a><br />
																	
																	 <%if(show_jsp==1){ %>
																	<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Remove Friend" name="remove_friend"
																			onclick="hello('<%=u1.getUserid()%>')" />
																	</div>
																	<%} %>
																	</li>


															</ul>
														</td>

													</tr>

													<%
														}
													%>

													<%
														}
													%>



												</table>
												<input type="hidden" id="temp" name="friendid">
											</s:form>




										</div>
									</div>


								</div>

								<!-- main col right -->

								<div class="col-sm-4">

									<div class="panel panel-default">
										<div class="panel-heading">

											<h4>Pending Friend Request</h4>
											<%
												ArrayList<UserDhruvik> userpendingData=(ArrayList<UserDhruvik>)request.getAttribute("userpendingData");
											%>
										</div>
										<div class="panel-body">
										<s:form class="form-horizontal" id="pending_req">
												

													<%
																										for(int k=0;k<userpendingData.size();k=k+1){
																																					UserDhruvik u2=(UserDhruvik)userpendingData.get(k);
																									%>
													
													<ul class="list-group">
																<li class="list-group-item" style="width: 300px"><img
																	src="<%=u2.getProfile_pic()%>" class="img-rounded"
																	width="100" height="80" />&nbsp;<a
																	href="userNewsFeedAction?user_id=<%=u2.getUserid()%>"
																	style="color: #3B5999"><b><%=u2.getFirst_name()%>
																			<%=u2.getLast_name()%></b></a><br />
																	<div align="center">
														<input type="button" id="accept"
															, name="accept_friend_request" value="Accept" onclick="accept_req('<%=u2.getUserid()%>')" />
														&nbsp;&nbsp;&nbsp; <input type="button" id="Reject"
															, name="reject_friend_request" value="Reject" onclick="reject_req('<%=u2.getUserid()%>')" />
													</div></li>


															</ul>
														<%
														}
													%> 	
											
											<input type="hidden" id="pending" name="pending_friend">
										</s:form>
										</div>
									</div>

								</div>




							</div>
							<!--/row-->
						</div>
						<!-- /col-9 -->
					</div>
					<!-- /padding -->
				</div>
				<!-- /main -->

			</div>
		</div>
	</div>


	<!--post modal-->
	<!-- script references -->
	
</body>
</html>