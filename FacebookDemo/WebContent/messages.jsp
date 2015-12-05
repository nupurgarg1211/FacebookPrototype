<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html> 
<%@page import="com.sun.xml.internal.txw2.Document"%>

<html lang="en">
<head>
<!-- script references -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
		<script src="js/scripts.js"></script>
		<link href="css/customStyle.css" rel="stylesheet">
		
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<meta charset="utf-8">
<title>Create Message</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/newfeedstyles.css" rel="stylesheet">
<%@ page import="java.util.*"%>
<%@ page import="org.iiitb.facebook.model.*"%>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<%-- <script type="text/javascript" src="js/jquery.tokeninput.js"></script>
<link rel="stylesheet" href="css/token-input.css" type="text/css" />
<link rel="stylesheet" href="css/token-input-facebook.css"
	type="text/css" /> --%>

<script src="js/jquery.js"></script> 
	
		<!-- ===================================== our code ======================================= -->
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
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lte IE 8]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
				<!--  ===================================== our code =======================================  -->
		
<script type="text/javascript">

function searchfriendJson() {
	
	var to = $.trim($("#to").val());
	if (to.length <= 0) {
		return false;
	} else {
		var data = '{"to":"' + to + '"}';
		
		
		$.ajax({
			url : "getFriendsSearchBox",
			dataType : "json",
			data : data,
			contentType : 'application/json;charset=utf-8',
			type : "post",
			success : function(data) {
				getMarkup(data);
				$("#FriendsearchList").addClass("displayBlock");
			},
			failure : function() {
				alert("error");
			}

		});

	}
}
function getMarkup(data){	
var html = "<ul>";
$.each(data.userData, function(index, element) {
		//alert(element.first_name);
		var user_id = element.userid;
	var first_name = element.first_name;
	var last_name = element.last_name;
	var searchIn = element.first_name + " " + element.last_name	+ " ";
	var name = $.trim(element.name);
	html += '<li class="searchLi list-group-item" onclick="selectUser('+ user_id +',\''+name+'\')">';
	html+= '<div class="searchDiv">';
	html+= '<span class="searchName">'+ first_name +'</span>';
	html+='<span class="searchName"> '+ last_name +'</span>';
	html+= '</div></li>';
});
html+= "</ul>";
  $("#FriendsearchList").html(html);
}
function selectUser(id,name){
//alert(name);
$("#to").val(name);
$("#userId").val(id);
$("#FriendsearchList").removeClass("displayBlock").hide();
} 







function about_edit()
{
	document.getElementById("create_message_to").style.visibility = "visible";
	document.getElementById("new_button").style.visibility = "hidden";
	document.getElementById("label_val").innerHTML="Create Message";
	document.getElementById("blank_box").style.visibility = "hidden";
}
function block()
{
	document.getElementById("blank_box").style.visibility = "visible";
	
}
function load()
{
	document.getElementById("create_message_to").style.visibility = "hidden";
	document.getElementById("new_button").style.visibility = "visible";
	document.getElementById("message_to").style.visibility = "visible";
	//document.getElementById("blank_box").style.visibility = "hidden";
	
}

function send(id) {
	var idvar = id;
	document.getElementById("temp").value = idvar;
	$("#friendid").val(id);
//		document.getElementById(idvar).value = idvar;
		$('#message').submit();
//	document.dhruvik.action = 'removeFriend';
//	document.message.submit();
}


</script>
</head>

<body onload="load()">
	<div class="wrapper">
		<div>

			<%@ include file="header.jsp"%>

			<div class="row row-offcanvas row-offcanvas-left">


				<!-- sidebar -->
				<%-- <%@ include file="leftnav.jsp"%> --%>
<div class="column col-sm-3 col-xs-1 sidebar-offcanvas" id="sidebar">

					
<br /> <br /> <br />
					<br />
					
					<div class="panel panel-default">
										<div class="panel-heading">

											<h4>Previous Chats</h4>
											
										</div>
										<s:iterator value="userDetail">
										<div class="panel-body">
										<s:form class="form-horizontal" id="previouschat">
																					
													<ul class="list-group">
								<a href="loadMessage?friendid=<s:property value='userid'/>"	style="color: #3B5999" onClick="block()">	
																	
																<li class="list-group-item" style="width: 280px">
																
																<img
																	src="<s:property value='profile_pic'/>" class="img-rounded"
																	width="100" height="80" /> 
														
																	<b><s:property value='first_name'/>
																			<s:property value='last_name'/></b>
																	
																</li>
															
																</a>
																</ul>
													
													<input type="hidden" id="pending" name="pending_friend">
										</s:form>
										</div>
										</s:iterator>
									</div>
					


				</div>
				<!-- /sidebar -->
				<!-- <div class="divider"></div> -->
				<!-- main right col -->
				<div class="column col-sm-9 col-xs-11" id="main">



					<div class="padding">
						<div class="full col-sm-9">

							<!-- content -->
							<div class="row">

								<!-- main col left -->
								<div class="col-sm-8">

									<div class="well">
									<div id="new_button">
									<a href="#" onclick="about_edit();" class="pull-right"><input type="button" value="+New Message" class="btn btn-primary" id="newMsg"/></a>
									</div>
									
										<s:form class="form-horizontal" id="message" action="createmessage">
											
											<div align="right">
											<!-- <input type="button" value="+New Message" class="btn btn-primary" id="newMsg" onclick="hello()"/> -->
											</div>
											<div id="message_to">
											<h4>	<label for="textinput" id="label_val"><b><s:property value="friend_fname" /></b>
											</label>
										</h4><br>	</div>
											<div class="form-group" id="create_message_to">

														<div >
														 <label class="col-sm-1 control-label" for="textinput" >To</label>
														 <div class="col-sm-9 ">
														 	<input type="text" placeholder="Enter Recepient" class="form-control" name="to" id="to"  onKeyUp="return searchfriendJson()" autocomplete="off"></input>
															
														<div id="FriendsearchList" class="searchFreindDD" style="
    background-color: rgb(178, 202, 223);"></div>
													</div>
													
													<div id="listitems">
													
													
													</div>
														 </div>
														
													</div>
												</div>
											<fieldset>
												
													<div class="col-sm-11 col-xs-10 sidebar-offcanvas" id="blank_box" style="max-height: 320px; overflow-y : scroll;">
														<div >
														
														<%
											ArrayList<Message> userMessage=(ArrayList<Message>)request.getAttribute("userChat");
											Integer friend_id_jsp = (Integer)request.getAttribute("friendsid");
																
											if(friend_id_jsp == null){
												%>
												<p><b>Select any user to load chat </b></p>
												
												<%
												
											}
											else{																	  
											for(int k=0;k<userMessage.size();k++){
												
												Message msg = userMessage.get(k);
												if(Integer.parseInt(msg.getUser_from())==(friend_id_jsp)){ %>
												<b><a href="userNewsFeedAction?user_id=<s:property value="friendid" />">	<s:property value="friend_fname" />&nbsp;<s:property value="friend_lname" /> : &nbsp;</a></b>
											<%	}
												else{
											%>
												
												<b><a href="userNewsFeedAction"> <s:property value="user_fname" />&nbsp;<s:property value="user_lname" /> : &nbsp; </a></b>
											<%}
											%>
													<%=msg.getMessage()%><hr/>
												<%
												}
											}
									
										%>
														
														
														
														
														
														
														</div>

													</div>
													<br /> <br /> <br /> <br />
											<!-- 	</div> -->

												<!-- Text input-->
												<div class="form-group">
													<!-- 	<label class="col-sm-1 control-label" for="textinput">  </label> -->
													<div class="col-sm-11">
														<textarea name="message" rows="5" class="form-control"
															placeholder="Enter Message"></textarea>

													</div>
													


												</div>
												
												<div class="msg col-sm-10" id="ack">
													<s:property value="errormsg"></s:property>
												</div>
												<div align="right">
													<br /> <br />
													<!--  <br /> <br /> <br /> <br /> <br /> <br /> -->
													<input type="hidden" id="userId" name="userId"/>
													<input type="reset" class="btn btn-default" /> <input
														type="submit" value="Send" class="btn btn-primary" onClick="send('<s:property value="friendid" />')"/>
												</div>
									
									
									</fieldset>
									
									<input type="hidden" id="temp" name="friendid">
									</s:form>
									</div></div></div></div></div>
									</div>
									
								</div></div></div>
</body>
</html>