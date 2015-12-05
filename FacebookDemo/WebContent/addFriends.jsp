<!DOCTYPE html>
<html lang="en">
<head>
<!-- script references -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
		<script src="js/scripts.js"></script>
		<link href="css/customStyle.css" rel="stylesheet">
		
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%@ taglib prefix="s" uri="/struts-tags"%>
<meta charset="utf-8">
<title>All Friends</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
<link href="css/newfeedstyles.css" rel="stylesheet">

<%@ page import="java.util.*"%>
<%@ page import="org.iiitb.facebook.model.*"%>
<style type="text/css">
body {
	padding-top: 50px;
}

#jumbobg {
	background-image: url('images/bg1.jpg');
	background-repeat: no-repeat;
	background-position: center 0%;
	background-size: 99% 360px;
}

#jumbotitle {
	color: bisque;
	text-shadow: 3px 3px 2px #202020;
}
</style>
<script>
	function hello(id) {
		var idvar = id;
		document.getElementById("temp").value = idvar;
		//window.location = "http://www.yoururl.com";
	//		document.getElementById(idvar).value = idvar;
			$('#dhruvik').submit();
	//	document.dhruvik.action = 'removeFriend';
	//	document.dhruvik.submit();

	}
</script>
<!-- ===================================== our code ======================================= -->

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />

<!-- page specific plugin styles -->

<!-- text fonts -->
<link rel="stylesheet" href="css/fontdhruvik.css" />

<!-- ace styles -->
<link rel="stylesheet" href="css/ace.min.css" />

<!--[if lte IE 9]>
	<link rel="stylesheet" href="assets/css/ace-part2.min.css" />
<![endif]-->
<link rel="stylesheet" href="css/ace-skins.min.css" />
<link rel="stylesheet" href="css/ace-rtl.min.css" />

<!--[if lte IE 9]>
  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="js/ace-extra.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lte IE 8]>
<script src="assets/js/html5shiv.js"></script>
<script src="assets/js/respond.min.js"></script>
<![endif]-->
		<!--  ===================================== our code =======================================  -->
</head>
<body>
	<div class="wrapper">
		<div class="box">

			<%@ include file="header.jsp"%>

			<div class="jumbotron1" id="jumbobg">
				<h1 id="jumbotitle"></h1>
				<br>
				<br>
				<br> <img src="images/bg.jpg" width="180" height="180" />


			</div>
			<div class="row row-offcanvas row-offcanvas-left">


				<!-- sidebar -->
				<%@ include file="leftnav.jsp"%>
				<!-- /sidebar -->
				<div class="divider"></div>
				<!-- main right col -->
				<div class="column col-sm-10 col-xs-11" id="main">



					<div class="padding">
						<div class="full col-sm-9">

							<!-- content -->
							<div class="row">

								<!-- main col left -->
								<div class="col-sm-8">
									<div class="well">

										<h4 align="left">People You May know</h4>
										<hr />
  
										<%
											ArrayList<UserDhruvik> userData=(ArrayList<UserDhruvik>)request.getAttribute("userData");
										%>
										<%-- if(userData!=null && userData.size()>0){
				 for(int i=0;i<userData.size();){
					 int len=(userData.size())-i;
					 if(len>=4)len=4;
			 %>  --%>
										<!-- Projects Row -->
										<div class="row">
											<s:form class="form-horizontal" id="dhruvik" action="addFriend">
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
																	href="userNewsFeedAction?friendid=<%=u1.getUserid()%>"
																	style="color: #3B5999"><b><%=u1.getFirst_name()%>
																			<%=u1.getLast_name()%></b></a><br />
																<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Add Friend" name="add_friend"
																			onclick="hello('<%=u1.getUserid()%>')">
																	</div></li>


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
																	href="userNewsFeedAction?friendid=<%=u1.getUserid()%>"
																	style="color: #3B5999"><b><%=u1.getFirst_name()%>
																			<%=u1.getLast_name()%></b></a><br />
																<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Add Friend" name="add_friend"
																			onclick="hello('<%=u1.getUserid()%>')" />
																	</div></li>


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
								
								<!-- <div class="col-sm-4">

								<div class="panel panel-default">
										<div class="panel-heading">
											
											<h4>Pending Friend Request </h4>
										</div>
										<div class="panel-body">
										<ul class="list-group">
                                    	<li class="list-group-item">
                                    	<img src="images/bg.jpg" class="img-rounded" width="75" height="75"/>&nbsp;&nbsp;&nbsp;<a href="#" style="color: #3B5999"><b>Setu Patani</b></a>
                                    	<br/>
                                    	<br/>
                                    	<div align="center">
                                    	<input type="button" id="accept", name="accept_friend_request" value="Accept" />
                                    	&nbsp;&nbsp;&nbsp;
                                    	<input type="button" id="Reject", name="reject_friend_request" value="Reject" />
                                    	</div>
                                    	</li>
                                    	</ul>
											
											
										</div>
									</div>

								</div> -->
								
								
								
								
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
	<div id="postModal" class="modal fade" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					Update Status
				</div>
				<div class="modal-body">
					<form class="form center-block">
						<div class="form-group">
							<textarea class="form-control input-lg" autofocus=""
								placeholder="What do you want to share?"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<div>
						<button class="btn btn-primary btn-sm" data-dismiss="modal"
							aria-hidden="true">Post</button>
						<ul class="pull-left list-inline">
							<li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li>
							<li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li>
							<li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- script references -->
</body>
</html>