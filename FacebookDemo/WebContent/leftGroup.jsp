<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="org.iiitb.facebook.model.*"%>
<%@ page import="java.util.*"%>
<%@page import="org.iiitb.facebook.dao.impl.*"%>
<%@page import="org.iiitb.facebook.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<link href="css/customStyle.css" rel="stylesheet">


<link rel="stylesheet" href="css/jquery-ui.css">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Facebook Home</title>

<script type="text/javascript" src="js/jquery.min.js"></script>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- <link href="css/bootstrap-theme.min.css" rel="stylesheet"> -->
<link href="css/newfeedstyles.css" rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.js"></script>


<style type="text/css">
#flip-tabs {
	width: 600px;
	margin: 20px auto;
	position: relative;
}

#flip-navigation {
	margin: 0 0 10px;
	padding: 0;
	list-style: none;
}

#flip-navigation li {
	display: inline;
}

#flip-navigation li a {
	text-decoration: none;
	padding: 10px;
	margin-right: 0px;
	background: #f9f9f9;
	color: #333;
	outline: none;
	font-family: Arial;
	font-size: 12px;
	text-transform: uppercase;
}

#flip-navigation li a:hover {
	background: #999;
	color: #f0f0f0;
}

#flip-navigation li.selected a {
	background: #999;
	color: #f0f0f0;
}

#flip-container {
	width: 300px;
	font-family: Arial;
	font-size: 13px;
}

#flip-container div {
	background: #fff;
}

body {
	
}

#jumbobg {
	/* background-image: url('images/bg1.jpg'); */
	background-repeat: no-repeat;
	background-position: center 35%;
	background-size: 100% 400px;
}

#jumbotitle {
	color: bisque;
	text-shadow: 3px 3px 2px #202020;
}
</style>

<style type="text/css">
.panel-group .panel {
	overflow: visible;
}

.likes_others {
	color: #6D84B4;
}

.likes_others:hover {
	text-decoration: underline;
	cursor: pointer;
}

#likeOthersModal .modal-body {
	max-height: 500px;
	overflow-y: auto;
}

likes_list_others {
	width: 600px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
	background-color: #FFF;
	border: 1px solid rgba(0, 0, 0, 0.2);
	border-radius: 6px;
	outline: 0 none;
}
</style>
<% 
		User u=(User)session.getAttribute("user"); 
		  NewsFeedDAOImpl d=new NewsFeedDAOImpl();
		  //String userProfilePicPath=d.profilePicPath(u.get); 
		String userProfilePicPath=d.profilePicPath(u.getUserId()); 
		
		  %>

<script type="text/javascript">
	$(document).ready(
			function() {

				$("#Button3").click(
						function() {
							var nametxt;
							var backImage;
							var grpId;
							var isAdmin;
							var yourText = $(".dropdown-menu li a").text();
							var group_id = $("#hidGrpTxt").val();
							//alert("groooooooop" + group_id);
							//alert(yourText);
							var posting = $.post("leaveGroup.action", {
								"group_id" : group_id
							});
							posting.done(function(response) {
								$(window.location).attr(
										'href',
										'getGroupDetailAction.action?group_id='+group_id);
								});
						});

				$("#Button4").click(
						function() {
							var nametxt;
							var backImage;
							var grpId;
							var isAdmin;
							var yourText = $(".dropdown-menu li a").text();
							var group_id = $("#hidGrpTxt").val();
							//alert("groooooooop" + group_id);
							//alert(yourText);
							var posting = $.post("leaveGroup.action", {
								"group_id" : group_id
							});
							posting.done(function(response) {
								$(window.location).attr(
										'href',
										'getGroupDetailAction.action?group_id='+group_id);
							});
						});

				$("#joinBtn").click(
						function() {
							var nametxt;
							var backImage;
							var grpId;
							var isAdmin;
							var yourText = $(".dropdown-menu li a").text();
							var group_id = $("#hidGrpTxt").val();
							//alert("groooooooop" + group_id);
							//alert(yourText);
							var posting = $.post("joinGroupAgain.action", {
								"group_id" : group_id
							});
							posting.done(function(response) {
								$(window.location).attr(
										'href',
										'getGroupDetailAction.action?group_id='+group_id);
							});
						});
				$("#cancelId1").click(
						function() {
							var group_id = $("#hidGrpTxt").val();
							$(window.location).attr(
									'href',	'getGroupDetailAction.action?group_id='+group_id);
						});

				$("#cancelId2").click(
						function() {
							var group_id = $("#hidGrpTxt").val();
							$(window.location).attr(
									'href',	'getGroupDetailAction.action?group_id='+group_id);
						});
				
			});
</script>


<script type="text/javascript">
	function callModal(postid,type){
		$('#likeOthersModal').modal('show');
		//var url = 'getAllLikeAction?postId='+postid;
		$("#likes_list_others").html("");
		$("#loader_likes").show();
		$("#loader_likes").delay(1000).hide(1);
		if(type=="like")
			$("#myModalLabel").text("People who like this");
		else
			$("#myModalLabel").text("People who commented on this");
		$.ajax({
			url : 'groupGetAllPeople',
			type: 'get',
	        dataType: 'json',
	        data: {
            	"postId":postid,
            	"queryType":type,
            },
            contentType: "application/json; charset=utf-8",
			success: function(data){
				var temp = "";
				//alert("type"+type);
				if(type=="like"){
					//alert("type"+type);
					$.each(data.likeList, function(index, value){
						temp += '<a href="#"><img src="'+value.picPath+'" height="50px" width="50px" style="float:left;position:relative;"></a>';
						temp += '&nbsp;&nbsp;<a href="userNewsFeedAction?user_id='+value.userId+'"><p style="font-weight:bold; width:50%;float:left;position:relative;">&nbsp;&nbsp;'+value.userName+'</p></a>';
						temp += "<br><br><hr>";
					});
					
				}else{
					//alert("type"+type);
					$.each(data.commentList, function(index, value){
						temp += '<a href="#"><img src="'+value.picPath+'" height="50px" width="50px" style="float:left;position:relative;"></a>';
						temp += '&nbsp;&nbsp;<a href="userNewsFeedAction?user_id='+value.userId+'"><p style="font-weight:bold; width:50%;float:left;position:relative;">&nbsp;&nbsp;'+value.userName+'</p></a>';
						temp += "<br><br><hr>";
					});
				}
				$("#likes_list_others").html(temp);

			},
            error:function(jqXhr, textStatus, errorThrown){
	            alert("Error Occured. Please try again later");
	        }
		});
	}
	  function postOnWall(){
		  var postDesc=document.getElementById("postDesc");
		  if(postDesc=="" || postDesc==" " || postDesc==null){
			  alert("Enter Post Description");
			  return false;
		  }
		  $('#whatsNew').submit();
	  }
	  function redirect(){
		  window.location.href="<%=StringUtils.hostname%>/FacebookDemo/newsFeedAction";
	  }
	 
	  function unhideYouTubeText(){
		  document.getElementById("youtubeLink").style.display="block";
	  }
	  function likeAJAX(postid,postUserId,userId,type){
		 
		 // alert(pcount);
		  $.ajax({
		            url: "groupIncreaseLikeAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            	"liketype":type,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
		            	if(type=="U"){
		            		$("#ahrefLike"+postid).text(response.pcount+" people");
		            		
		            		$('#like'+postid).show();
		            		
		            		$('#unlike'+postid).hide();
		            	}else{
		            		var a=0;
		            		if((response.pcount-1)<0)
		            			a=0;
		            		else
		            			a=response.pcount-1;
		            		$("#ahrefLike"+postid).text("You and "+(a)+" people");
		            		
		            		$('#like'+postid).hide();
		            		
		            		$('#unlike'+postid).show();
		            	}
		      	      	
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            }
		        }); 
	  }
	  function addComment(element,e,postid,userName){
		  var charCode;

		    if(e && e.which){
		        charCode = e.which;
		    }else if(window.event){
		        e = window.event;
		        charCode = e.keyCode;
		    }

		    if(charCode == 13) {
		        var text=document.getElementById("comment"+postid).value;
		        $.ajax({
		            url: "groupAddCommentAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            	"comment" : text,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
			            	 document.getElementById("comment"+postid).value="";
			 		        $("#ul"+postid).prepend("<li class=\"list-group-item\"> <img src=\"<%=userProfilePicPath%>\" class=\"img-rounded\" width=\"44\" height=\"036\"/>&nbsp;<a href=\"userNewsFeedAction?user_id=<%=u.getUserId()%>\" style=\"color: #3B5999\"><b>"+userName+"</b></a>:"+text+"</li>");
			 		      //  $('#ul'+postid).prepend("<li class=\"list-group-item">\" <img src=\"images/bg.jpg\" class=\"img-rounded\" width=\"44\" height=\"036\"/>&nbsp;<a href=\"#\" style=\"color: #3B5999\"><b>"+postid+
			 		        //"</b></a>:"+text+"</li>");
			 		      var pcountText=$("#ahrefComment"+postid).text();
			 		      var pcount=pcountText.split(" ");
			 		      var pcount=eval(pcount[0])+1;
			 		      $("#ahrefComment"+postid).text(pcount+" people");
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            }
		        }); 
		    }
	  }
	  
	  
	  
	  function deletePost(postid){
		  var a=confirm("Are you really want to delete this post??");
		  if(a){
			  $.ajax({
		            url: "groupDeletePostAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
		            	 $("#panel"+postid).hide();
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            }
		        }); 
		  }
	  }
	  function editPost(postid){
			var postdesc=$('#postdesc'+postid).text();
			var a=prompt("Edit post", postdesc);
			if(a!=null){
				 $.ajax({
			            url: "groupEditPostAction",
			            type: 'get',
			            dataType: 'json',
			            data: {
			            	"postId":postid,
			            	"comment":a,
			            },
			            contentType: "application/json; charset=utf-8",
			            success:function(response){
			            	$('#postdesc'+postid).text(a);
			            },
			            error:function(jqXhr, textStatus, errorThrown){
			            alert("Error Occured. Please try again later");
			            }
			        });
			}
		}
	 function editComment(postid,commentid){
		 var postdesc=$('#commentText'+commentid).text();
			var a=prompt("Edit Comment", postdesc);
			if(a!=null){
				 $.ajax({
			            url: "groupEditCommentAction",
			            type: 'get',
			            dataType: 'json',
			            data: {
			            	"commentId":commentid,
			            	"comment":a,
			            },
			            contentType: "application/json; charset=utf-8",
			            success:function(response){
			            	$('#commentText'+commentid).text(a);
			            },
			            error:function(jqXhr, textStatus, errorThrown){
			            alert("Error Occured. Please try again later");
			            }
			        });
			}
	 }
	 function deleteComment(postid,commentid){
		  var a=confirm("Are you really want to delete this post??");
		  if(a){
			  $.ajax({
		            url: "groupDeleteCommentAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"commentId":commentid,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
		            	$('#commentli'+commentid).hide();
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            }
		        }); 
		  }
	  }
	</script>


<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/fontdhruvik.css" />
<link rel="stylesheet" href="css/ace.min.css" />
<link rel="stylesheet" href="css/ace-skins.min.css" />
<link rel="stylesheet" href="css/ace-rtl.min.css" />
<script src="js/ace-extra.min.js"></script>
</head>
<%ArrayList<Post> feedList=(ArrayList<Post>)request.getAttribute("feedList");
String display_members = (String)request.getAttribute("display_members");
ArrayList<User> grpMemberList=(ArrayList<User>)request.getAttribute("grpMemberList");
if(feedList==null){
	%>
<!-- <body onload="redirect();"> -->
<%}else{ %>
<body>
	<%} %>
	<%Group groupDetail=(Group)request.getAttribute("groupDetail");
		if(!(groupDetail==null)){
	%>

<body>
	<div class="wrapper">
		<div>
			<%@ include file="header.jsp"%>
			<%
			String picPath=StringUtils.groupRetrivePhotoPath;
			String back = null;
			back = "images/personalizeGroup.png";
			if(groupDetail.getCoverPic()!=null)
			{
				picPath=picPath+"/"+groupDetail.getGroup_id()+"_"+"coverPicture"+"/"+groupDetail.getCoverPic();
				back = picPath;
			}
			%>

			<%@ include file="leftnav.jsp"%>
			<div class="jumbotron" id="jumbobg" style="background-image: url('<%=back%>');">
			 <form action="GroupImageUploadAction" method="post" enctype="multipart/form-data"> 
				<h1 id="jumbotitle"></h1>
				<br> <br> <br>
				<div align="right"><b>Upload Cover Photo</b>
					&nbsp;	<s:file name="pic"/>
						<input class="btn btn-success" type="Submit" value = "Upload"/> </div>
				<input type="hidden" id="hidTxt" name="albumId" value='<%=groupDetail.getAlbum_id()%>'> 
				<input type="hidden" id="hidGrpTxt" name="group_id" value='<%=groupDetail.getGroup_id()%>'> 
			</form>
			</div>
				
			<%
				String member_request = groupDetail.getMember_request();
				if(member_request!=null)
				{
				if (member_request.equalsIgnoreCase("L")) 
				{
			%> 
			<div id="flip-tabs">
				<label style="color: white">Join this group to see the
					discussion, post and comment.</label>
				<button type="button" class="btn btn-success" id="joinBtn">Join
					Group</button>
				<%-- <ul id="flip-navigation">
					<li><a href="#" id="tab-0"><b><%=groupDetail.getGroup_name()%></b></a></li>
					<li><a href="#" id="tab-1"><b>Members</b></a></li>
					<li><a href="#" id="tab-2"><b>Events</b></a></li>
					<li><a href="#" id="tab-3"><b>Photos</b></a></li>
					<li>
						<div class="btn-group">
							<button type="button" data-toggle="dropdown"
								class="btn btn-default dropdown-toggle">
								<b>Joined</b> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							<%
								if (groupDetail.getIsAdmin().equalsIgnoreCase("T")) {
								%>	<li><a href="#" data-toggle="modal" data-target="#modal3"><b>Leave Group</b></a></li>
								<% } else {%>
								<li><a href="#" data-toggle="modal" data-target="#modal4"><b>Leave Group</b></a></li>
							<%	}
							%>
								
							</ul>
						</div>
					</li>
					<li><a href='addMember.jsp?group_id=<%=groupDetail.getGroup_id()%>' id="tab-3"><b>Add Member</b></a></li>
				</ul> --%>
			</div> 
			<%
				} else {
			%>

			<div id="flip-tabs">
			<input type="hidden" id="group_id" name="group_id" value='<%=groupDetail.getGroup_id()%>'>
				<ul id="flip-navigation">
					<li><a href="getGroupDetailAction.action?group_id=<%=groupDetail.getGroup_id()%>" id="tab-0"><b><%=groupDetail.getGroup_name()%></b></a></li>
					<li><a href='showGroupMembersAction?group_id=<%=groupDetail.getGroup_id()%>' id="tab-1"><b>Members</b></a></li>
				<!-- 	<li><a href="#" id="tab-2"><b>Events</b></a></li>
					<li><a href="#" id="tab-3"><b>Photos</b></a></li> -->
					<li>
						<div class="btn-group">
							<button type="button" data-toggle="dropdown"
								class="btn btn-default dropdown-toggle">
								<b>Joined</b> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<%
									if (groupDetail.getIsAdmin().equalsIgnoreCase("T")) {
								%>
								<li><a href="#" data-toggle="modal" data-target="#modal3"><b>Leave
											Group</b></a></li>
								<%
									} else {
								%>
								<li><a href="#" data-toggle="modal" data-target="#modal4"><b>Leave
											Group</b></a></li>
								<%
									}
								%>

							</ul>
						</div>
					</li>
					<li><a href='addMember.jsp?group_id=<%=groupDetail.getGroup_id()%>' id="tab-3"><b>Add Member</b></a></li>
					
			</ul>
			</div>
			<%
				}}
			%> 
			
			<div class="row row-offcanvas row-offcanvas-left" style="float:right;width:85%;">


				<!-- sidebar -->

				<!-- /sidebar -->
				<div class="divider"></div>
				<!-- main right col -->
				<div class="column col-sm-12 col-xs-11" id="main">



					<div class="padding">
						<div class="full col-sm-9">

							<!-- content -->
							<div class="row">

								<!-- main col left -->
								<%if(display_members==null){ %>
								<div class="col-sm-8">
								
									<s:if test="hasActionErrors()">
										<div class="alert alert-danger alert-dismissable">
											<a class="panel-close close" data-dismiss="alert">×</a> <i
												class="fa fa-coffee"></i>
											<s:actionerror />
										</div>
									</s:if>

									<s:if test="hasActionMessages()">
										<div class="alert alert-info alert-dismissable">
											<a class="panel-close close" data-dismiss="alert">×</a> <i
												class="fa fa-coffee"></i>
											<s:actionmessage />
										</div>
									</s:if>

									<div class="well">
										<form class="form-horizontal" role="form" id="whatsNew"
											enctype="multipart/form-data" action="GroupPostAction"
											method="post">
											<input type="hidden" id="group_id" name="group_id"
												value='<%=groupDetail.getGroup_id()%>'>
											<h4>What's New</h4>
											<div class="form-group" style="padding: 14px;">
												<textarea class="form-control" id="postDesc" name="postDesc"
													placeholder="Update your status"></textarea>
												<input type="text" id="youtubeLink" name="youtubeLink"
													placeholder="YouTube Video Link" style="display: none;" />
											</div>
											<button class="btn btn-primary pull-right" type="button"
												onclick="return postOnWall();">Post</button>
											<ul class="list-inline">
												<li><s:file name="pic" /></li>
												<li><b><a href="#" onclick="unhideYouTubeText();">Upload
															Video From YouTube</a></b></li>
											</ul>
										</form>
									</div>
									<div class="panel-group">
										<% 
                              if(feedList!=null)
                              for(int i=0;i<feedList.size();i++){
                            	  Post p=feedList.get(i);
                            	 ArrayList<Comment> ac=p.getCommentList();
                            	 ArrayList<Like> ll=p.getLikeList();
                            	 boolean likeFlag=false;
                              %>
										<div class="panel panel-default" id="panel<%=p.getPostId()%>">
											<div class="panel-heading hover-link" data-toggle="collapse"
												data-parent="false"
												data-target="#collapseTableOne<%=p.getPostId()%>">
												<h4 class="panel-title">
													<input type="hidden" name="" id="postid<%=p.getPostId() %>"
														value="" />
														<input type="hidden" id="group_id" name="group_id"
												value='<%=groupDetail.getGroup_id()%>'>
													<%=p.getPostType() %>
													
													<%if((p.getPostType()!=null && p.getUserFrom().equalsIgnoreCase(u.getUserId()))){ %>
													<div class="dropdown" align="left">
														<a data-toggle="dropdown" href="#"><i
															class="glyphicon glyphicon-plus"></i></a>
														<ul class="dropdown-menu dropdown-menu-right" role="menu"
															aria-labelledby="dLabel">

															<li><a href="#" id="editpost<%=p.getPostId()%>"
																onclick="editPost('<%=p.getPostId()%>')">Edit Post</a></li>
															<li><a href="#" id="deletePost<%=p.getPostId()%>"
																onclick="deletePost('<%=p.getPostId()%>');">Delete
																	Post</a></li>

														</ul>
													</div>
													<%} %>
												</h4>

											</div>
											<div id="collapseTableOne<%=p.getPostId()%>"
												class="panel-collapse collapse in">
												<div class="panel-body">
													<input type="hidden" name="postId"
														value="<%=p.getPostId()%>" /> 
														<input type="hidden" id="group_id" name="group_id"
												value='<%=groupDetail.getGroup_id()%>'>
														<img
														src="<%=p.getUserProfilePic()%>"
														class="img-circle pull-left"><br>&nbsp;<a
														href="userNewsFeedAction?user_id=<%=p.getUserFrom()%>" style="color: #3B5999"><b><%=p.getUserName()%></b></a><br>&nbsp;<font
														size="1"><%=p.getPostDate() %></font>
													<div class="clearfix"></div>
													<hr class="hrpost">
													<p id="postdesc<%=p.getPostId() %>"><%=p.getPostDesc() %></p>
													<%if(!(p.getPicPath()==null) && !(p.getPicPath()=="")){ %>
													<img src="<%=p.getPicPath() %>" class="img-rounded"
														alt="No Image Available" width="750" height="451">
													<%} %>
													<%if(!(p.getYouTubeLink()==null) && !(p.getYouTubeLink()=="")){ %>
													<object width="750" height="451"
														data="<%=p.getYouTubeLink()%>"> </object>
													<%} %>
													<%if(ll!=null)
                                    	 for(int j=0;j<ll.size();j++){
                                    		 Like l=ll.get(j);
                                    		/*  if(l!=null && l.getUserId().equalsIgnoreCase(u.getUserId())){ */
                                    			if(l!=null && l.getUserId().equalsIgnoreCase(u.getUserId())){ 
                                    			 likeFlag=true;break;
                                    		 }
                                    	 }
                                    	  %>
													<br>
													<p>
														&nbsp; <b><a href="#" id="like<%=p.getPostId()%>"
															<%if(!likeFlag){ %> style="display: block; width: 50%"
															<%}else{ %> style="display:none;width: 50%" <%} %>
															onclick="likeAJAX('<%= p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','L');"
															style="color: #3B5999">Like</a> </b><b> <a href="#"
															id="unlike<%=p.getPostId()%>" <%if(!likeFlag){ %>
															style="display: none; width: 50%" <%}else{ %>
															style="display:block;width: 50%" <%} %>
															onclick="likeAJAX('<%= p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','U');"
															style="color: #3B5999">UnLike</a>
														</b>
														<!--   - <a href="" style="color: #3B5999">Comment</a> -->
													</p>
													<hr class="hrpost">
													<ul class="list-group">
														<li class="list-group-item"><a href="#"
															class="likes_others"
															onclick="callModal('<%=p.getPostId()%>','like')"
															id="ahrefLike<%=p.getPostId()%>"><%=(likeFlag)?"You and ":""%>
																<%if(likeFlag){%><%=(Integer.parseInt(p.getLikeCount())-1<0)?"0":Integer.parseInt(p.getLikeCount())-1%>
																<%}else{ %><%=p.getLikeCount()%>
																<%} %> people</a> like this</li>
														<li class="list-group-item"><a href="#"
															onclick="callModal('<%=p.getPostId()%>','comment')"
															id="ahrefComment<%=p.getPostId()%>"><%=p.getCommentCount() %>
																people</a> Commented this</li>
													</ul>
													<ul class="list-group" id="ul<%=p.getPostId()%>">
														<%for(int j=0;j<ac.size();j++){ 
                                   			Comment c=ac.get(j);
                                   		%>
														<li class="list-group-item"
															id="commentli<%=c.getCommentId()%>"><img
															src="<%=c.getPicPath()%>" class="img-rounded" width="44"
															height="036" />&nbsp;<a href="userNewsFeedAction?user_id=<%=c.getUserId() %>" style="color: #3B5999"><b><%=c.getUserName()%></b></a>&nbsp;&nbsp;&nbsp;<span
															id="commentText<%=c.getCommentId()%>"><%=c.getComment() %></span>
															<div class="dropdown" align="left">
																<a data-toggle="dropdown" href="#"><i
																	class="glyphicon glyphicon-plus"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;<font
																	size="1"><%=c.getDate() %></font>
																<ul class="dropdown-menu dropdown-menu-right"
																	role="menu" aria-labelledby="dLabel">

																	<li><a href="#"
																		id="editcomment<%=c.getCommentId()%>"
																		onclick="editComment('<%=p.getPostId()%>','<%=c.getCommentId()%>')">Edit
																			Comment</a></li>
																	<li><a href="#"
																		id="deletecomment<%=c.getCommentId()%>"
																		onclick="deleteComment('<%=p.getPostId()%>','<%=c.getCommentId()%>');">Delete
																			Comment</a></li>

																</ul>
															</div></li>
														<%} %>

													</ul>


													<div class="input-group">
														<div class="input-group-btn">
															<img src="<%=userProfilePicPath %>" class="img-rounded"
																width="44" height="036" />
														</div>
														<input type="text" class="form-control" name="comment"
															id="comment<%=p.getPostId()%>" onclick="this.select()"
															onkeypress="addComment(this, event,'<%=p.getPostId()%>','<s:property value="#session.user.firstName"/>')"
															;
                                       placeholder="Add a comment..">
													</div>
													
												</div>
											</div>
										</div>
										<%} %>
									</div>

								</div>
								

									

																	

								<!-- -------------------------show members division------------------ -->
								<%}else if(display_members.equalsIgnoreCase("True")){ %> 
								 <div class="col-sm-8" >
								<% int i=0;
									if(grpMemberList!=null){
									for(int j=0;j<grpMemberList.size();j++){
									NewsFeedDAOImpl d1=new NewsFeedDAOImpl();
		  							String userProfilePic=d.profilePicPath(grpMemberList.get(j).getUserId());%>
											<%-- <%
												if(i%2==0)
												{
														i++;
											%> --%>



										<div class="col-sm-4">
											<div  style="height: 200px; width: 200px;  margin-top: 2%; margin-left: 2%; float: left;">
												<a href='userNewsFeedAction?user_id=<%=grpMemberList.get(j).getUserId()%>'><img src='<%=userProfilePic%>' height="100px" width="100px" />
												<%=grpMemberList.get(j).getFirstName()%><%=grpMemberList.get(j).getLastName()%></a>
													
											</div> 
											<!-- <div  style="margin-top: 30%;">
											</div> -->
										</div>
										<%-- <%
											}
											else{	
													i++;
											%>
										<div class="col-sm-4">
											<div  style="height: 50px; width: 50px;  margin-top: 2%; margin-left: 2%; float: left;">
												<a href='#'><img src='<%=userProfilePic%>' height="100px" width="100px" />
												<%=grpMemberList.get(j).getFirstName()%>
													<%=grpMemberList.get(j).getLastName()%></a>
													
											</div>
											<!-- <div  style="margin-top: 5%;">
											</div> -->
										</div> --%>

									<%-- <%
											}
											%>	 --%>									

								
								<%}}%>
								
								 
								 </div>
								<!-- main col right -->
								
																	<%} %>
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


	<div class="modal fade" id="modal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Leave this Group?</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td align="right"><label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Are you sure you want to
									give up your admin privileges and leave <%=groupDetail.getGroup_name()%>
									? <br> The admin role will be offered to other people in
									the group.
							</label></td>
						</tr>
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="right"><input type="submit" value="cancel" id="cancelId1"
								align="right"  class="btn btn-default" /><input type="submit" value="Leave Group"
								align="right" id="Button3" class="btn btn-primary"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modal4" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Leave this Group?</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td align="right"><label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Do you want to leave <%=groupDetail.getGroup_name()%> ?
							</label></td>
						</tr>
					</table>
					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="right"><input type="submit" value="cancel"
								align="right"  class="btn btn-default" id="cancelId2" /><input type="submit" value="Leave Group"
								align="right" id="Button4" class="btn btn-primary" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%} %>	
	<div id="likeOthersModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="likeOthersModalLabel" aria-hidden="true" style="display: none;">
    			<div class="modal-dialog">
      				<div class="modal-content">
					  <div class="modal-header">
          				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          					<h4 class="modal-title" id="myModalLabel">People Who Like This</h4>
        				</div>
        				<div id="loader_likes" style="background-color: #E9EAED;width: 100%;border: 1px solid #e3e3e3;">
         				 	<center><img src="images/loader.gif" height="30px" ></center>
       					</div>
        				<div class="modal-body" id="likes_list_others">
        				
       					</div>
      				</div><!-- /.modal-content -->
   			 	</div><!-- /.modal-dialog -->
 </div>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/scripts.js"></script>
</body>
</html>
