<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Facebook</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script src="js/scripts.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">


<style type="text/css">
body {
	padding-top: 50px;
}

.navbar-blue {
	width: 100%;
}

#jumbobg {
	background-image: url('images/bg1.jpg');
	background-repeat: no-repeat;
	background-position: center 35%;
	background-size: 100% 960px;
}

#jumbotitle {
	color: bisque;
	text-shadow: 3px 3px 2px #202020;
}
</style>
<link rel="stylesheet" href="css/font-awesome.min.css" />
	<link rel="stylesheet" href="css/fontdhruvik.css" />
	<link rel="stylesheet" href="css/ace.min.css" />
	<link rel="stylesheet" href="css/ace-skins.min.css" />
	<link rel="stylesheet" href="css/ace-rtl.min.css" />
	<script src="js/ace-extra.min.js"></script>
</head>
<body>
	<div class="wrapper">
		<div class="box" style="background-color: #E9EAED">
			<%@ include file="header.jsp"%>
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
								<div role="tabpanel" style=" margin: 0 auto; width: 70%">

									<!-- Nav tabs -->
									<ul class="nav nav-tabs" role="tablist" id="mytab">
										<li role="presentation" class="active"><a href="#people"
											aria-controls="people" role="tab" data-toggle="tab">People</a></li>
										<li role="presentation"><a href="#event"
											aria-controls="event" role="tab" data-toggle="tab">Events</a></li>
									</ul>

									<!-- Tab panes -->
									<div class="tab-content">
										<div role="tabpanel" class="tab-pane active" id="people"
											style="background-color: #FFF;">
											<s:iterator value="%{searchMap['people']}" var="item">
												<div class="searchAllBox">
													<div class="searchAllImg">
														<img
															src='imageAction?path=Albums/<s:property value="#item.userId"/>_profilePicture/<s:property value="#item.profilePic"/>' />
													</div>
													<div class="searchAllDetails">
														<ul>
															 <li><a href="userNewsFeedAction?user_id=<s:property value="#item.userId"/>"><s:property value="#item.name" /></a></li>
															<li><s:property value="#item.position" /> at <s:property
																	value="#item.organisation" /></li>
															<li>lives in <s:property value="#item.place" /></li>
														</ul>
													</div>
												</div>
											</s:iterator>
										</div>
										<div role="tabpanel" class="tab-pane" id="event"
											style="background-color: #FFF;">
											<s:iterator value="%{searchMap['event']}" var="item">
												<div class="searchAllBox">
													
													<div class="searchAllDetails">
														<ul>
															<li><a href='events?eventId=<s:property value="#item.eventId"/>'><s:property value="#item.eventname" /></a></li>
															<li><s:property value="#item.place" /></li>
															<li><s:property value="#item.eventDetails" /></li>
															<li><s:property value="#item.organiserName" /></li>
														</ul>
													</div>
												</div>
											</s:iterator>
										</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="eventPopup.jsp" %>
	<!-- script references -->
		<script src="js/jquery-1.10.2.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/jquery.magnific-popup.js"></script>
		<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
		<script src="js/scripts.js"></script>
</body>
</html>