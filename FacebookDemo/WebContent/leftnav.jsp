<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.iiitb.facebook.model.*"%>
<%@ page import="org.iiitb.facebook.util.ConnectionPool"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@page import ="org.iiitb.facebook.dao.impl.*" %>
<%-- <%!	ArrayList<Group> grplist = new ArrayList<Group>();
	int i;
	String isAdmin = "";%>
<%
	Connection conn = ConnectionPool.getConnection();
	PreparedStatement ps = conn.prepareStatement("select a.group_name,a.group_id,a.icon,b.is_admin from groups a INNER JOIN group_members b ON a.group_id = b.group_id WHERE b.user_id = 3 and member_request = 'A'");
	ResultSet rs = ps.executeQuery();
	grplist = new ArrayList<Group>();
	while (rs.next()) {
		Group g = new Group();
		g.setGroup_name(rs.getString("group_name"));
		g.setGroup_id(rs.getInt("group_id"));
		g.setIcon(rs.getString("icon"));
		g.setIsAdmin(rs.getString("is_admin"));
		grplist.add(g);
	}
	rs.close();
	
%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
.image_picker_image {
	max-width: 500px;
	max-height: 100px;
	background-color: #FF0000;
}

.drop {
	display: inline-block;
}
</style>


<style>
#selectable-1 .ui-selecting {
	background: #707070;
}

#selectable-1 .ui-selected {
	background: #EEEEEE;
	color: #000000;
}

#selectable-1 {
	list-style-type: none;
	margin: 0;
	padding: 0;
	width: 20%;
}

#selectable-1 li {
	margin: 3px;
	padding: 0.4em;
	font-size: 16px;
	height: 18px;
}

.ui-widget-content {
	background: #cedc98;
	border: 1px solid #DDDDDD;
	color: #333333;
}
</style>
		
<script type="text/javascript" language="javascript">

function showdob(response){
	 //data = JSON.stringify(data);
	 var global='';
	 var allreq='';
	 $.each(response.al, function(index, element) {
		// alert(element.first_name);
	    var rfirst = element.first_name;
	    var rlast = element.last_name;
	    var rpic = element.profile_pic;
	    var ruserid = element.userid;
  	    var rmainli ='<li>';
	    var rmainlink = '<a href="userNewsFeedAction?user_id='+ruserid+'">';
	   // var rimages = '<img src="'+rpic+'" width="25px" height="25px">&nbsp;';
	    var rmessages = rfirst + " " + rlast;
	   // var rname = '</span></span></a><span class="pull-right"><div id="'+ruserid+'">';
	   // var accpt = '<a href="#" onclick="acceptReq('+ruserid+')"><img src="images/accept1.png" width="18px" height="18px"></a>&nbsp;';
	//	var rejct = '<a href="#" onclick="rejectReq('+ruserid+')"><img src="images/reject1.png" width="18px" height="18px"></a>&nbsp;';
	//	var rendtags = '</div></span></div></li>';
		var rendtags = '</li>';
	    
	    
	    allreq += rmainli + rmainlink + rmessages + rendtags;
	 });
	 global+= allreq;

	 $('#dob').replaceWith(global);
}


function showdob1()
 {
                   	// var data = '{"searchTerm":"'+ term+'"}';
                 	// data = JSON.parse(data);
                 	 $.ajax({
                 	 url:"getdob",
                 	 dataType: "json",
      				data:{
      					name : "dhruvik"
      				},
                 	 contentType: 'application/json;charset=utf-8',
                 	 type: "get",
                 	 success:function(response){
                 		 //alert("lol"+response.name);
                 		// document.write("here");
                 	 showdob(response);
                 	 },
                 	 error:function(){
                 	 	alert("error");
                 	 } 
                 	 });
                  }

 </script>
</head>
<body onload="showdob1()">

	<%
	ArrayList<Group> grplist=(ArrayList<Group>)request.getAttribute("grpList"); 
	%>
	<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar" style="height:1000px;">

		<ul class="nav">
			<li><a href="#" data-toggle="offcanvas"
				class="visible-xs text-center"><i
					class="glyphicon glyphicon-chevron-right"></i></a></li>
		</ul>
<% User u11=(User)session.getAttribute("user");
		  NewsFeedDAOImpl d11=new NewsFeedDAOImpl();
		  String userProfilePicPath11=d11.profilePicPath(u11.getUserId());
		
		  %>
		<img
			src="<%=userProfilePicPath11 %>" class="img-rounded" width="44" height="036" /><a
			href="userNewsFeedAction?user_id=<s:property value="#session.user.userId"/>"><b><s:property value="#session.user.firstName"/></b></a>

		<ul class="nav hidden-xs" id="lg-menu">
			<!-- For Demo only , dont use it-->
			<li><a href="newsFeedAction"><i class="glyphicon glyphicon-paperclip"></i>
					NewsFeed</a></li>
			<li><a href="userNewsFeedAction?user_id=<%=u11.getUserId()%>"><i class="glyphicon glyphicon-list-alt"></i>
					TimeLine</a></li>

			<li><a href="getConversations"><i class="glyphicon glyphicon-list"></i>
					Message</a></li>
			
<hr/>

		Birthday Notifications
	
							<div id="dob">
							
							Loading....
							</div>

						<hr/>
			<li><a href="#eventModal" data-toggle="modal"><i class="glyphicon glyphicon-calendar"></i>
					Create Event</a></li>
			<li><a href="eventList"><i class="glyphicon glyphicon-calendar"></i>
					Events</a></li>
			<hr/>		
			<li><a href="#"><i></i><b>GROUPS</b></a></li>
<!-- 
			<div id="grpNames"> -->
				 <%
					if (grplist != null && grplist.size() > 0) {
						for (int i = 0; i < grplist.size(); i++) {
				%> 
			
			<li><a href='getGroupDetailAction.action?group_id=<%=grplist.get(i).getGroup_id()%>'>
					<img src=<%=grplist.get(i).getIcon()%> width="15" height="15" /><%=grplist.get(i).getGroup_name()%>
			</a> 
			 </li> 
<%
 	}
 	}
 %>
 <!-- 

 </div> -->
 
 
 
 
 
 <!-- data-toggle="modal" data-target="#modal1" -->
			<li><a href="createGroup.jsp" ><img
					src="images/createGroup.png" width="30" height="30" /> Create
					Group</a></li>
		</ul>

		<!-- tiny only nav-->
		<ul class="nav visible-xs" id="xs-menu">
			<li><a href="#featured" class="text-center"><i
					class="glyphicon glyphicon-list-alt"></i></a></li>
			<li><a href="#stories" class="text-center"><i
					class="glyphicon glyphicon-list"></i></a></li>
			<li><a href="#" class="text-center"><i
					class="glyphicon glyphicon-paperclip"></i></a></li>
			<li style=""><a href="#" class="text-center"><i
					class="glyphicon glyphicon-refresh"></i></a></li>
				

		</ul>
		
		
		
							
							
						
		

	</div>
	<div class="modal fade" id="modal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Create New Group</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Group
									Name</label></td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 300px"
								name="grpName" id="grpName" required /></td>
						</tr>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Members</label>&nbsp;&nbsp;&nbsp;</td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 300px"
								id="search1" name="search1" required/></td>
						</tr>
					</table>
					<hr width="100%">
					<!-- <table>
						<tr>

							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Privacy&nbsp;<br>
									<br> <br> <br> <br> <br>

							</label></td>
							<td align="left">
								<ul class="list-unstyled">
									<li>&nbsp;&nbsp;<input type="radio" name="privacy" />&nbsp;&nbsp;<img
										src="images/public.jpeg" width="13" height="12" />&nbsp;<b>Public</b>
										<div>Anyone can see the group, its members and their
											posts</div>
										<hr width="100%"></li>
									<li>&nbsp;&nbsp;<input type="radio" name="privacy" />&nbsp;&nbsp;<img
										src="images/public.jpeg" width="13" height="12" />&nbsp;<b>Private</b>
										<div>Anyone can see the group, its members and their
											posts</div></li>
								</ul>
							</td>
						</tr>

					</table> -->
					<table width="100%">
						<tr align="right">
							<td align="right"><input type="submit" value="cancel"
								align="right" id="cancelBtn1" class="btn btn-default" /><input type="submit" value="create"
								align="right" id="Button1"  class="btn btn-primary" /></td>
						</tr>
					</table>
					<hr width="100%">
					
					
				</div>
			</div>
		</div>
	</div>

<!-- nitin -included event popup.jsp for creating events -->
<%@include file="eventPopup.jsp" %>
<!--end nitin -->

	<div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<label id="grpnameLbl"></label>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Choose an icon</b>
					</h5>
				</div>
				<div class="modal-body">

					<div></div>
					<table align="center">
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td><input type="radio" name="icon" value="images/grp1.jpeg" /><img
								src="images/grp1.jpeg" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp2.jpeg" /><img
								src="images/grp2.jpeg" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp3.jpeg" /><img
								src="images/grp3.jpeg" width="40" height="40" /></td>
						</tr>
						<tr>
							<td><input type="radio" name="icon" value="images/grp4.jpeg" /><img
								src="images/grp4.jpeg" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp5.png" /><img
								src="images/grp5.png" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp6.jpeg" /><img
								src="images/grp6.jpeg" width="40" height="40" /></td>
						</tr>
						<tr>
							<td><input type="radio" name="icon" value="images/grp7.jpeg" /><img
								src="images/grp7.jpeg" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp8.jpeg" /><img
								src="images/grp8.jpeg" width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp9.png" /><img
								src="images/grp9.png" width="40" height="40" /></td>
						</tr>
						<tr>
							<td><input type="radio" name="icon"
								value="images/grp10.jpeg" /><img src="images/grp10.jpeg"
								width="40" height="40" /></td>
							<td><input type="radio" name="icon"
								value="images/grp11.jpeg" /><img src="images/grp11.jpeg"
								width="40" height="40" /></td>
							<td><input type="radio" name="icon" value="images/grp12.png" /><img
								src="images/grp12.png" width="40" height="40" /></td>
						</tr>
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="left"><input type="submit" value="skip"
								align="left" id="skipBtn2" class="btn btn-default" /></td>
							<td align="right"><input type="submit" value="create"
								align="right" id="Button2"  class="btn btn-primary" /></td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="hidMem" /> <input type="hidden"
				id="hidName" />
		</div>
	</div>
</body>
</html>