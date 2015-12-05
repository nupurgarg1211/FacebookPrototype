<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="org.iiitb.facebook.model.*"%>
<%@ page import="java.util.*"%>
<%@page import="org.iiitb.facebook.dao.impl.*"%>
<%@page import="org.iiitb.facebook.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Facebook</title>
<meta name="generator" content="Bootply" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

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

.groupWallpaper {
	height: 295px;
	border: 1px solid #CCC;
	background-size: 100% 100%;
	background-repeat: no-repeat;
}

.dateBox {
	background-color: rgba(0, 0, 0, .15);
	border: 2px solid #fff;
	-webkit-border-radius: 5px;
	left: 12px;
	padding: 7px 0 9px 0;
	position: absolute;
	width: 46px;
}

.modal-body {
	padding: 20px;
}

.infoContainer {
	position: relative;
	top: 214px;
	left: 0px;
}

.floatleft {
	float: left;
	margin-left: 80px;
	margin-top: 24px;
	font-size: 22px;
}
</style>

<%
	User u=(User)session.getAttribute("user");
		  EventNewsFeedDAOImpl d=new EventNewsFeedDAOImpl();
		  String userProfilePicPath=d.profilePicPath(u.getUserId());
		  String eventId = (String)request.getAttribute("eventId");
%>
<script type="text/javascript">
	
	
	function callModal(postid,type){
		$('#likeOthersModal').modal('show');
		$("#likes_list_others").html("");
		$("#loader_likes").show();
		$("#loader_likes").delay(1000).hide(1);
		if(type=="like")
			$("#myModalLabel").text("People who like this");
		else
			$("#myModalLabel").text("People who commented on this");
		$.ajax({
			url : 'getAllPeople',
			type: 'get',
	        dataType: 'json',
	        data: {
            	"postId":postid,
            	"queryType":type,
            },
            contentType: "application/json; charset=utf-8",
			success: function(data){
				var temp = "";
				if(type=="like"){
					$.each(data.likeList, function(index, value){
						temp += '<a href="#"><img src="'+value.picPath+'" height="50px" width="50px" style="float:left;position:relative;"></a>';
						temp += '&nbsp;&nbsp;<a href="userNewsFeedAction?user_id='+value.userId+'"><p style="font-weight:bold; width:50%;float:left;position:relative;">&nbsp;&nbsp;'+value.userName+'</p></a>';
						temp += "<br><br><hr>";
					});
					
				}else{
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
		  window.location.href="<%=StringUtils.hostname%>/FacebookDemo/eventNewsFeedAction";
	  }
	  function AutoRefresh( t ) {
		  	//getAllGroups();
			setTimeout("location.reload(true);", t);
		}
	  function unhideYouTubeText(){
		  document.getElementById("youtubeLink").style.display="block";
	  }
	  function likeAJAX(postid,postUserId,userId,type,eventId){
		 
		 // alert(pcount);
		  $.ajax({
		            url: "eventIncreaseLikeAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            	"liketype":type,
		            	"eventId" : eventId
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
		            	if(type=="U"){
		            		$("#ahrefLike"+postid).text(response.pcount+" people");
		            		
		            		$('#like'+postid).show();
		            		
		            		$('#unlike'+postid).hide();
		            	}else{
		            		var a =0;
		            		if((response.pcount-1)<0){
		            			a=0;
		            		}else{
		            			a = response.pcount-1;
		            		}
		            		$("#ahrefLike"+postid).text("You and "+(response.pcount-1)+" people");
		            		
		            		$('#like'+postid).hide();
		            		
		            		$('#unlike'+postid).show();
		            	}
		            	location.reload(true);
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            location.reload(true);
		            }
		        }); 
	  }
	  function addComment(element,e,postid,userName,eventId){
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
		            url: "eventAddCommentAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            	"comment" : text,
		            	"eventId" : eventId
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
		            url: "eventDeletePostAction",
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
			            url: "eventEditPostAction",
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
			            url: "eventEditCommentAction",
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
		            url: "eventDeleteCommentAction",
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
	
	<!-- <link href="css/bootstrap-theme.min.css" rel="stylesheet"> -->
	<!-- <link rel="stylesheet" href="css/bootstrap.min.css" /> -->
	<link rel="stylesheet" href="css/font-awesome.min.css" />
	<link rel="stylesheet" href="css/fontdhruvik.css" />
	<link rel="stylesheet" href="css/ace.min.css" />
	<link rel="stylesheet" href="css/ace-skins.min.css" />
	<link rel="stylesheet" href="css/ace-rtl.min.css" />
	<script src="js/ace-extra.min.js"></script>
	
</head>
<%
	ArrayList<Post> feedList = (ArrayList<Post>) request
			.getAttribute("feedList");
	if (feedList == null) {
%>
<body>
	<%
		} else {
	%>
	<!-- <body onload="JavaScript:AutoRefresh(60000);"> -->

	<body>
	<%
		}
	%>

<div class="wrapper">
		<div  style="background-color: #E9EAED">
			<%@ include file="header.jsp"%>
			<div class="row row-offcanvas row-offcanvas-left">
				<!-- sidebar -->
				<%@ include file="leftnav.jsp"%>
				<!-- /sidebar -->
				<div class="divider"></div>
				<!-- main right col -->
				<div class="column col-sm-10 col-xs-11" id="main">

					<div class="col-sm-9" style="padding-top: 50px;">
						<!-- content -->
						<s:iterator value="eventList" var="list">
							<div class="row">
								<div class="groupWallpaper"
									style="position: relative; background-image: url('imageAction?path=images/bg1.jpg');">
									<!-- <div style="position: absolute; top: 10px; right: 20px;">
										<button onclick="uploadwallpaper()">upload Cover
											Photo</button>
									</div> -->
									<div class="infoContainer">
										<div class="floatleft">
											<div>
												<s:property value="#list.eventname" />
											</div>
										</div>
									</div>

								</div>
								<div class="well">
									<span>Hosted by: </span><a href="#"><s:property
											value="#list.organizerName" /></a>
									<div style="float: right">
										<button onclick='return invitefrnd(<s:property value="#list.eventId" />)'>Invite</button>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="well" style="margin-bottom: 0">
									<s:date name="#list.eventDate" nice="true" />
									<div style="float: right; display: relative:top:-10px;">
										<table>
											<tr>
												<th>Invited</th>
												<th>Going</th>
												<th>Maybe</th>
											</tr>
											<tr>
												<td class="alert-info" style="text-align: center"><a href="#" onclick="getList(<s:property value="#list.eventId"/>,'invited')" ><s:property
														value="#list.invited" /></a></td>
												<td class="alert-info" style="text-align: center"><a href="#" onclick="getList(<s:property value="#list.eventId"/>,'going')" ><s:property
														value="#list.going" /></a></td>
												<td class="alert-info" style="text-align: center"><a href="#" onclick="getList(<s:property value="#list.eventId"/>,'maybe')" ><s:property
														value="#list.maybe" /></a></td>
											</tr>
										</table>
									</div>
									<%-- <s:property value="#list.eventDate" /> --%>
								</div>
								<div class="well">
									<s:property value="#list.place" />
								</div>
							</div>
							<div class="row">
								<div class="well">
									<s:property value="#list.eventDetails" />
								</div>
							</div>
						</s:iterator>
						<!-- code for post -->

						<!-- content -->
						<div class="row">

							<!-- main col left -->
							<div class="col-md-12">
								<s:if test="hasActionErrors()">
									<div class="alert alert-danger alert-dismissable">
										<a class="panel-close close" data-dismiss="alert">�</a> <i
											class="fa fa-coffee"></i>
										<s:actionerror />
									</div>
								</s:if>

								<s:if test="hasActionMessages()">
									<div class="alert alert-info alert-dismissable">
										<a class="panel-close close" data-dismiss="alert">�</a> <i
											class="fa fa-coffee"></i>
										<s:actionmessage />
									</div>
								</s:if>

								<div class="well">
									<form class="form-horizontal" role="form" id="whatsNew"
										enctype="multipart/form-data" action="eventPostAction"
										method="post">
										<input type="hidden" name="eventId" value="<%=eventId%>">
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
											<li><s:file name="pic" cssStyle="display:none" /></li>
										</ul> 
									</form>
								</div>
								<div class="panel-group">
									<%
										if (feedList != null)
											for (int i = 0; i < feedList.size(); i++) {
												Post p = feedList.get(i);
												ArrayList<Comment> ac = p.getCommentList();
												ArrayList<Like> ll = p.getLikeList();
												boolean likeFlag = false;
									%>
									<div class="panel panel-default" id="panel<%=p.getPostId()%>">
										<div class="panel-heading hover-link" data-toggle="collapse"
											data-parent="false"
											data-target="#collapseTableOne<%=p.getPostId()%>">
											<h4 class="panel-title">
												<input type="hidden" name="" id="postid<%=p.getPostId()%>"
													value="" />
												<%-- <%=p.getPostType()%> --%>
												<%
													if ((p.getPostType() != null && p.getUserFrom()
																	.equalsIgnoreCase(u.getUserId()))) {
												%>
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
												<%
													}
												%>
											</h4>

										</div>
										<div id="collapseTableOne<%=p.getPostId()%>"
											class="panel-collapse collapse in">
											<div class="panel-body">
												<input type="hidden" name="postId"
													value="<%=p.getPostId()%>" /> <img
													src="<%=p.getUserProfilePic()%>"
													class="img-circle pull-left"><br>&nbsp;<a
													href="userNewsFeedAction?user_id=<%=p.getUserFrom()%>"
													style="color: #3B5999"><b><%=p.getUserName()%></b></a><br>&nbsp;<font
													size="1"><%=p.getPostDate()%></font>
												<div class="clearfix"></div>
												<hr class="hrpost">
												<p id="postdesc<%=p.getPostId()%>"><%=p.getPostDesc()%></p>
												<%
													if (!(p.getPicPath() == null) && !(p.getPicPath() == "")) {
												%>
												<img src="<%=p.getPicPath()%>" class="img-rounded"
													alt="No Image Available" width="720" height="451">
												<%
													}
												%>
												<%
													if (ll != null)
																for (int j = 0; j < ll.size(); j++) {
																	Like l = ll.get(j);
																	if (l != null
																			&& l.getUserId().equalsIgnoreCase(
																					u.getUserId())) {
																		likeFlag = true;
																		break;
																	}
																}
												%>
												<br>
												<p>
													&nbsp; <b><a href="#" id="like<%=p.getPostId()%>"
														<%if (!likeFlag) {%> style="display: block; width: 50%"
														<%} else {%> style="display:none;width: 50%" <%}%>
														onclick="likeAJAX('<%=p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','L','<s:property value="eventId"/>');"
														style="color: #3B5999">Like</a> </b><b> <a href="#"
														id="unlike<%=p.getPostId()%>" <%if (!likeFlag) {%>
														style="display: none; width: 50%" <%} else {%>
														style="display:block;width: 50%" <%}%>
														onclick="likeAJAX('<%=p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','U','<s:property value="eventId"/>');"
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
														id="ahrefComment<%=p.getPostId()%>"><%=p.getCommentCount()%>
															people</a> Commented this</li>
												</ul>
												<ul class="list-group" id="ul<%=p.getPostId()%>">
													<%
														for (int j = 0; j < ac.size(); j++) {
																	Comment c = ac.get(j);
													%>
													<li class="list-group-item"
														id="commentli<%=c.getCommentId()%>"><img
														src="<%=c.getPicPath()%>" class="img-rounded" width="44"
														height="036" />&nbsp;<a
														href="userNewsFeedAction?user_id=<%=c.getUserId()%>"
														style="color: #3B5999"><b><%=c.getUserName()%></b></a>&nbsp;&nbsp;&nbsp;<span
														id="commentText<%=c.getCommentId()%>"><%=c.getComment()%></span>
														<div class="dropdown" align="left">
															<a data-toggle="dropdown" href="#"><i
																class="glyphicon glyphicon-plus"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;<font
																size="1"><%=c.getDate()%></font>
															<ul class="dropdown-menu dropdown-menu-right" role="menu"
																aria-labelledby="dLabel">

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
													<%
														}
													%>

												</ul>


												<div class="input-group">
													<div class="input-group-btn">
														<img src="<%=userProfilePicPath%>" class="img-rounded"
															width="44" height="036" />
													</div>
													<input type="text" class="form-control" name="comment"
														id="comment<%=p.getPostId()%>" onclick="this.select()"
														onkeypress="addComment(this, event,'<%=p.getPostId()%>','<s:property value="#session.user.firstName"/>' ,'<s:property value="eventId"/>')"
														;
                                      placeholder="Add a comment..">
												</div>
												</form>
											</div>
										</div>
									</div>
									<%
										}
									%>
								</div>






							</div>

							<!-- main col right -->
						</div>
					</div>
					<!--/row-->



					<div class="row" id="footer">
						<div class="col-sm-6"></div>

					</div>

					<!-- end code for post -->
				</div>
			</div>
		</div>
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
		<%@include file="eventPopup.jsp"%>
		<%@include file="inviteFriends.jsp"%>
		<%@include file="invitedFriendStatusList.jsp"%>
	</div>
</body></html>