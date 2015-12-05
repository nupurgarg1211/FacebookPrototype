<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.iiitb.facebook.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
		<%
			User u=(User)session.getAttribute("user");
			String tempUserId=(String)request.getParameter("user_id"); 
         	if(session!=null)
         	{
         		session.removeAttribute("tempUserId");
         		session.setAttribute("tempUserId", tempUserId);
         	}
         	String checkFriend = (String)request.getAttribute("isFriend");
         	String full_name = (String)request.getAttribute("full_name");
         	String cover_pic=(String)request.getAttribute("cover_pic");
         	String profile_pic=(String)request.getAttribute("profile_pic");
		 %>
		  
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
			function  checkFriend()
			{
				
				var checkFriend = '<%=checkFriend%>';
					
				if(checkFriend == 'S')
				{
					$('#button1').hide();
					$('#button2').hide();
					$('#button3').hide();
					$('#button4').hide();
					//document.getElementById("button4").style.visibility = "hidden";
					
				}
				else if(checkFriend == 'F')
				{
					$('#button1').hide();
					$('#button2').show();
					$('#button3').hide();
					$('#button4').hide();
					//document.getElementById("button4").style.visibility = "hidden";
					
				}
				else if(checkFriend == 'P')
				{
					$('#button1').show();
					$('#button2').hide();
					$('#button3').hide();
					$('#button4').hide();
					//document.getElementById("button4").style.visibility = "hidden";
					
				}
				else if(checkFriend == 'A')
				{
					$('#button1').hide();
					$('#button2').hide();
					$('#button3').show();
					$('#button4').hide();
					//document.getElementById("button4").style.visibility = "hidden";
					
				}
				else if(checkFriend == 'N')
				{
					$('#button1').hide();
					$('#button2').hide();
					$('#button3').hide();
					$('#button4').show();
					//document.getElementById("button4").style.visibility = "visible";
					
				}
			}
		</script>
<div class="wrapper">
    <div>
   
   			<%@ include file="header.jsp"%>
   			
   			<div  id="jumbobg" style="margin:0 50px">
 				 <div class="groupWallpaper" style="position:relative;background-image: url('imageAction?path=<%=cover_pic%>');height:400px;z-index:10">
 				 <%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
									<div style="position:absolute;top:10px;right:20px;"><button class="btn btn-primary" id="b2"  onclick="showFilepicker()">Upload Cover Photo</button></div>
				<%}else{ }%>
									<div  id="togglediv" class="clearfix"style="display: none;">
									
									<form id="uploadImage" style="width: 500px" action="CoverImageUploadAction" method="post" enctype="multipart/form-data">
										<input type="hidden" id="albumId" name="albumId" value=""></input>
										<button class="btn btn-primary pull-right" type="submit" >Upload Photo</button>
										
										<ul class="list-inline"><li>
												<s:file class="pull-right"  name="pic" />
										</li>
										</ul>
										
										<h4 align="left">Photos</h4>
										<hr/>
									</form>

                                   </div>
                                   
                                   <div  id="togglediv1" class="clearfix"style="display: none;">
									
									<form id="uploadImage1" style="width: 500px" action="ProfileImageUploadAction" method="post" enctype="multipart/form-data">
										<input type="hidden" id="albumId" name="albumId" value=""></input>
										
										<button class="btn btn-primary pull-right" type="submit" >Upload Photo</button>
										
										<ul class="list-inline"><li>
												<s:file class="pull-right"  name="pic" />
										</li>
										</ul>
										
										<h4 align="left">Photos</h4>
										<hr/>
									</form>

                                   </div>
                                   
									
									<div class="infoContainer">
										<div class="floatleft">
											<div>
												
											</div>
										</div>
									</div>

								</div>
								<%if(u!=null && u.getUserId().equalsIgnoreCase(tempUserId)){ %>
				<div style="position:absolute;top:490px;left:110px; z-index:20;"><button class="btn btn-primary" id="b3" onclick="showFilepicker1()">Upload Profile Photo</button></div>
				<%}else{ }%>
 				   <img src="<%=profile_pic%>" 
 				   
 				   
 				   width="200" height="200" hspace="50" style="margin-top: 40px;position:absolute;top:300px;z-index:15;" vspace=""/>	
 				   
 				  <div style="padding-left: 500px; display: inline;">
 				 
 				  	<a class="btn"  href="<%=StringUtils.hostname%>/FacebookDemo/loadMessage?friendid=<%=tempUserId%>">Message</a>
 				  </div>
 				  <div class="btn-group" id="button1" style="float:right">
							<button type="button" data-toggle="dropdown"
								class="btn btn-default dropdown-toggle">
								<b>Pending Friend Request</b> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							<li><a href="cancelFriend1?user_id=<%= tempUserId%>" ><b>Cancel Friend Request</b></a></li>							
							</ul>
							
							<a class="btn" style="margin-left: 10px" href="blockUser?user_id=<%= tempUserId%>">Block</a>
					</div>
					
					<div class="btn-group" id="button2" style="float:right">
							<button type="button" data-toggle="dropdown"
								class="btn btn-default dropdown-toggle">
								<b>Friends</b> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							<li><a href="removeFriend1?user_id=<%= tempUserId%>" ><b>Remove Friend</b></a></li>
							</ul>
							<a class="btn" style="margin-left: 10px" href="blockUser?user_id=<%= tempUserId%>">Block</a>
					</div>
					
					<div class="btn-group" id="button3" style="float:right">
							<button type="button" data-toggle="dropdown"
								class="btn btn-default dropdown-toggle">
								<b>Respond to Friend Request</b> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							<li><a href="acceptFriend1?user_id=<%= tempUserId%>" ><b>Accept Request</b></a></li>
							<li><a href="removeFriend1?user_id=<%= tempUserId%>" ><b>Reject Request</b></a></li>	
							</ul>
							<a class="btn" style="margin-left: 10px" href="blockUser?user_id=<%= tempUserId%>">Block</a>
					</div>
					<div id="button4">
					
                    <form id="addFriend1" action="addFriend1" method="post" style="float:right">
                    <input type="hidden" name="user_id" value="<%=tempUserId%>">
 				  <input type="submit" class="btn btn-primary btn-lg" value="Add Friend"></a>
 				  <a class="btn" style="margin-left: 10px" href="blockUser?user_id=<%= tempUserId%>">Block</a>
 				  </form>
 				  </div>
			</div>	
			 
        <div class="row row-offcanvas row-offcanvas-left" style="margin:0 0px;">
                
                    
          	<div style="position:relative;margin-top:0px;margin-left:325px;font-size:20px"><b><%=full_name %></b></div>
            <!-- sidebar -->
            <%@ include file="leftnavprofile.jsp"%>
            <!-- /sidebar -->
          
            <!-- main right col -->
            
            <!-- /main -->
          