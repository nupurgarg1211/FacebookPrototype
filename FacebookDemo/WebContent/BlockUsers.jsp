<!DOCTYPE html>
<html lang="en">
	<head>
		<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script src="js/scripts.js"></script>
<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Facebook Home</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<%@ taglib prefix="s" uri="/struts-tags"%>
		
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		
		
		<script>
		
			function unblock(uid){
				
				
				document.unblockedUsers.action = 'unBlockedUsers?user_id='+uid;
				document.unblockedUsers.submit();
				
				
			}
		
		
		
		</script>
		
		
		
		
		<!-- ===================================== our code ======================================= -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<meta name="description" content="" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<link rel="stylesheet" href="css/font-awesome.min.css" />

		<!-- page specific plugin styles -->

		<!-- text fonts -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

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
    <div>
   
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

								<!-- main col left -->
								<div class="col-sm-8">
									<div class="well">

										<h4 align="left">Blocked Users</h4>
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
											<s:form class="form-horizontal" id="unblockedUsers">
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
																	
														 			
																	<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Unblock User" name="unblock_user"
																			onclick="unblock('<%=u1.getUserid()%>')">
																	</div>
																
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
																	
																	
																	<div align="right">
																		<input type="button" id="<%=u1.getUserid()%>"
																			value="Unblock User" name="unblock_user"
																			onclick="hello('<%=u1.getUserid()%>')" />
																	</div>
																	
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
												
											</s:form>




										</div>
									</div>


								</div>

								<!-- main col right -->

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

	</body>
</html>