<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="org.iiitb.facebook.model.*" %>
<%@ page import="java.util.*" %>
<%@page import ="org.iiitb.facebook.dao.impl.*" %>
<%@page import="org.iiitb.facebook.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		<title>Timeline</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		
		
		<style type="text/css">
			.panel-group .panel {
		  			overflow: visible;
			}
			.likes_others{
					color: #6D84B4;
			}
			.likes_others:hover{
				text-decoration: underline;
				cursor: pointer;
			}
			#likeOthersModal .modal-body{
					max-height: 500px;
					overflow-y: auto;
			}
			likes_list_others{
	 			  width: 600px;
    				box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    			background-color: #FFF;
    			border: 1px solid rgba(0, 0, 0, 0.2);
    			border-radius: 6px;
    			outline: 0 none;
			}
		</style>
		<% User u=(User)session.getAttribute("user");
		  NewsFeedDAOImpl d=new NewsFeedDAOImpl();
		  String userProfilePicPath=d.profilePicPath(u.getUserId());
		  
		  String tempUserId=(String)request.getParameter("user_id"); 
         	if(session!=null){
         		session.removeAttribute("tempUserId");
         		session.setAttribute("tempUserId", tempUserId);
         	}
         	String checkFriend = (String)request.getAttribute("isFriend");
         	String full_name = (String)request.getAttribute("full_name");
         	String cover_pic=(String)request.getAttribute("cover_pic");
         	String profile_pic=(String)request.getAttribute("profile_pic");
         	System.out.println(checkFriend);
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
		  

		  </script>
	<script type="text/javascript">
	
	
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
						temp += '&nbsp;&nbsp;<a href="#"><p style="font-weight:bold; width:50%;float:left;position:relative;">&nbsp;&nbsp;'+value.userName+'</p></a>';
						temp += "<br><br><hr>";
					});
					
				}else{
					$.each(data.commentList, function(index, value){
						temp += '<a href="#"><img src="'+value.picPath+'" height="50px" width="50px" style="float:left;position:relative;"></a>';
						temp += '&nbsp;&nbsp;<a href="#"><p style="font-weight:bold; width:50%;float:left;position:relative;">&nbsp;&nbsp;'+value.userName+'</p></a>';
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
	  function postOnUserWall(){
		  var postDesc=document.getElementById("postDesc");
		  if(postDesc=="" || postDesc==" " || postDesc==null){
			  alert("Enter Post Description");
			  return false;
		  }
		  $('#whatsNew').submit();
	  }
	  function AutoRefresh( t ) {
			setTimeout("location.reload(true);", t);
		}
	  function unhideYouTubeText(){
		  document.getElementById("youtubeLink").style.display="block";
	  }
	  function likeAJAX(postid,postUserId,userId,type){
		 
		 // alert(pcount);
		  $.ajax({
		            url: "increaseLikeAction",
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
		            		$("#ahrefLike"+postid).text("You and "+(response.pcount-1)+" people");
		            		
		            		$('#like'+postid).hide();
		            		
		            		$('#unlike'+postid).show();
		            	}
		      	      	
		            },
		            error:function(jqXhr, textStatus, errorThrown){
		            alert("Error Occured. Please try again later");
		            }
		        }); 
	  }
	  function updatePrivacy(priName,postId){
	 		 $.ajax({
		            url: "updatePrivacyAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"privacyName":priName,
		            	"postId" :postId,
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
		            url: "addCommentAction",
		            type: 'get',
		            dataType: 'json',
		            data: {
		            	"postId":postid,
		            	"comment" : text,
		            },
		            contentType: "application/json; charset=utf-8",
		            success:function(response){
			            	 document.getElementById("comment"+postid).value="";
			 		        $("#ul"+postid).prepend("<li class=\"list-group-item\"> <img src=\"<%=userProfilePicPath%>\" class=\"img-rounded\" width=\"44\" height=\"036\"/>&nbsp;<a href=\"#\" style=\"color: #3B5999\"><b>"+userName+"</b></a>:"+text+"</li>");
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
		            url: "deletePostAction",
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
			            url: "editPostAction",
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
			            url: "editCommentAction",
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
		            url: "deleteCommentAction",
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
	<link href="css/bootstrap-theme.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css" />
	<link rel="stylesheet" href="css/fontdhruvik.css" />
	<link rel="stylesheet" href="css/ace.min.css" />
	<link rel="stylesheet" href="css/ace-skins.min.css" />
	<link rel="stylesheet" href="css/ace-rtl.min.css" />
	<script src="js/ace-extra.min.js"></script>
	</head>
	<%ArrayList<Post> feedList=(ArrayList<Post>)request.getAttribute("feedList");%>
		
	<body onload="checkFriend()">
	
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
            <div class="column col-sm-10 col-xs-11" id="main">
                
               
              
                <div class="padding">
                    <div class="full col-sm-9">
                      
                        <!-- content -->                      
                      	<div class="row">
                          
                          
                         <!-- main col left --> 
                         <div class="col-sm-8">
                           <s:if test="hasActionErrors()">
								<div class="alert alert-danger alert-dismissable">
								 <a class="panel-close close" data-dismiss="alert">×</a> 
								  <i class="fa fa-coffee"></i>
				 		 <s:actionerror/>
						</div>
						</s:if>
						
						<s:if test="hasActionMessages()">
							 <div class="alert alert-info alert-dismissable">
								 <a class="panel-close close" data-dismiss="alert">×</a> 
								  <i class="fa fa-coffee"></i>
								  <s:actionmessage/>
							</div>
						</s:if>
						
						
						
						
						
						
                           <div class="well"> 
                                   <form class="form-horizontal" role="form" id="whatsNew" enctype="multipart/form-data" action="UserPostTimelineAction" method="post">
                                    <h4>What's New</h4>
                                     <div class="form-group" style="padding:14px;">
                                      <textarea class="form-control" id="postDesc"  name="postDesc" placeholder="Update your status"></textarea>
                                      <input type="text" id="youtubeLink" name="youtubeLink" placeholder="YouTube Video Link" style="display: none;"/> 
                                    </div>
                                    <button class="btn btn-primary pull-right" type="button" onclick="return postOnUserWall();">Post</button><ul class="list-inline"><li>
												<%
                                  		ArrayList<String> plist1=NewsFeedDAOImpl.getPrivacyDetail();
                                  	%>
									<select name="privacyName" id="privacyNameID">
										<%for(int f=0;f<plist1.size();f++){
										%>
										<option value="<%=plist1.get(f)%>"><%=plist1.get(f)%></option>
										<%} %>
									</select>
												<s:file name="pic"/>
										</li><li><b><a href="#" onclick="unhideYouTubeText();">Upload Video From YouTube</a></b></li></ul>
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
                            	 boolean flag=false;
                            	 if(p.getUserFrom().equalsIgnoreCase(u.getUserId()))
                            	 {
                            		flag=true; 
                            	 }else{
                            		 if(!p.getUserFrom().equalsIgnoreCase(u.getUserId()) && (p.getPrivacyName().equalsIgnoreCase(StringUtils.publicPrivacy) || p.getPrivacyName().equalsIgnoreCase(StringUtils.friendPrivacy))){
                            			 flag=true;
                            		 }
                            	 }
                            	 if(flag)
                            	 {
                              %>
                              <div class="panel panel-default" id="panel<%=p.getPostId()%>">
                              <div class="panel-heading hover-link" data-toggle="collapse" data-parent="false" data-target="#collapseTableOne<%=p.getPostId()%>">
                               <h4 class="panel-title">
                               	<input type="hidden" name=""id="postid<%=p.getPostId() %>"  value=""/>
           							<%=p.getPostType() %>
           							<%if((p.getPostType()!=null && p.getUserFrom().equalsIgnoreCase(u.getUserId()))){ %>
           							<div class="dropdown" align="left">
					                      <a data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-plus"></i></a>
					                      <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dLabel">
					                      	
					                        <li><a href="#" id="editpost<%=p.getPostId()%>" onclick="editPost('<%=p.getPostId()%>')">Edit Post</a></li>
					                        <li><a href="#" id="deletePost<%=p.getPostId()%>" onclick="deletePost('<%=p.getPostId()%>');">Delete Post</a></li>
					                      
					                      </ul>
					                    </div>
					                    <%} %>
          						</h4>
          						
        					</div>
                                    <div id="collapseTableOne<%=p.getPostId()%>" class="panel-collapse collapse in">
                                  <div class="panel-body">
                                  <input type="hidden" name="postId" value="<%=p.getPostId()%>"/>
                                    <img src="<%=p.getUserProfilePic()%>" class="img-circle pull-left"><br>&nbsp;<a href="#" style="color: #3B5999"><b><%=p.getUserName()%></b></a><br>&nbsp;<font size="1"><%=p.getPostDate() %></font>
                                    <div class="clearfix"></div>
                                    <hr class="hrpost">
                                    <p id="postdesc<%=p.getPostId() %>"><%=p.getPostDesc() %></p>
                                    <%if(!(p.getPicPath()==null) && !(p.getPicPath()=="")){ %>
                                     <img src="<%=p.getPicPath() %>" class="img-rounded" alt="No Image Available" width="720" height="451">
                                     <%} %>
                                     <%if(!(p.getYouTubeLink()==null) && !(p.getYouTubeLink()=="")){ %>
                                     <object width="750" height="451" data="<%=p.getYouTubeLink()%>">
										</object>
                                     <%} %>
                                     <%if(ll!=null)
                                    	 for(int j=0;j<ll.size();j++){
                                    		 Like l=ll.get(j);
                                    		 if(l!=null && l.getUserId().equalsIgnoreCase(u.getUserId())){
                                    			 likeFlag=true;break;
                                    		 }
                                    	 }
                                    	  %>
                                    <br><p>&nbsp;
                                    
                                    <b><a href="#" id="like<%=p.getPostId()%>"  <%if(!likeFlag){ %>style="display:block;width: 50%"<%}else{ %>style="display:none;width: 50%"<%} %> onclick="likeAJAX('<%= p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','L');" style="color: #3B5999">Like</a>
                                  </b><b>
                                    <a href="#" id="unlike<%=p.getPostId()%>"  <%if(!likeFlag){ %>style="display:none;width: 50%"<%}else{ %>style="display:block;width: 50%"<%} %> onclick="likeAJAX('<%= p.getPostId()%>','<%=p.getUserFrom()%>','<s:property value="#session.user.userId"/>','U');" style="color: #3B5999">UnLike</a>
                                  	</b>
                                   <!--   - <a href="" style="color: #3B5999">Comment</a> --> </p>
                                   
                                   	<%
                                  	ArrayList<String> plist=NewsFeedDAOImpl.getPrivacyDetail();
                                  		if(p.getUserFrom().equalsIgnoreCase(u.getUserId())){
                                  	%>
                                  	<div class="btn-group">
													<button type="button" data-toggle="dropdown"
														class="btn btn-default dropdown-toggle" id="abc<%=p.getPostId()%>">
														<b ><%=p.getPrivacyName() %></b> <span class="caret"></span>
													</button>
													<ul class="dropdown-menu">
														<%for(int f=0;f<plist.size();f++){
															if(!p.getPrivacyName().equalsIgnoreCase(plist.get(f))){
															%>
														<li><a href="#"  onclick="updatePrivacy('<%=plist.get(f)%>','<%=p.getPostId()%>')"><b><%=plist.get(f)%></b></a></li>
														<%} }%>
													</ul>
									</div>
                                  	<%} %>
                                  	
                                    <hr class="hrpost">
                                         <ul class="list-group">
                                    	<li class="list-group-item"><a href="#" class="likes_others" onclick="callModal('<%=p.getPostId()%>','like')" id="ahrefLike<%=p.getPostId()%>"><%=(likeFlag)?"You and ":""%><%if(likeFlag){%><%=(Integer.parseInt(p.getLikeCount())-1<0)?"0":Integer.parseInt(p.getLikeCount())-1%><%}else{ %><%=p.getLikeCount()%><%} %> people</a> like this</li>
                                    	<li class="list-group-item"><a href="#" onclick="callModal('<%=p.getPostId()%>','comment')" id="ahrefComment<%=p.getPostId()%>"><%=p.getCommentCount() %> people</a> Commented this</li>
                                    </ul>
                                   <ul class="list-group" id="ul<%=p.getPostId()%>">
                                   		<%for(int j=0;j<ac.size();j++){ 
                                   			Comment c=ac.get(j);
                                   		%>
	                                    	<li class="list-group-item" id="commentli<%=c.getCommentId()%>">
	                                    	<img src="<%=c.getPicPath()%>" class="img-rounded" width="44" height="036"/>&nbsp;<a href="#" style="color: #3B5999"><b><%=c.getUserName()%></b></a>&nbsp;&nbsp;&nbsp;<span id="commentText<%=c.getCommentId()%>"><%=c.getComment() %></span>
	                                    	<div class="dropdown" align="left">
							                      <a data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-plus"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;<font size="1"><%=c.getDate() %></font>
							                      <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dLabel">
							                      	
							                        <li><a href="#" id="editcomment<%=c.getCommentId()%>" onclick="editComment('<%=p.getPostId()%>','<%=c.getCommentId()%>')">Edit Comment</a></li>
							                        <li><a href="#" id="deletecomment<%=c.getCommentId()%>" onclick="deleteComment('<%=p.getPostId()%>','<%=c.getCommentId()%>');">Delete Comment</a></li>
							                      
							                      </ul>
					                   	    </div>
	                                    	
	                                    	
	                                    	
                                    	</li>
                                    	<%} %>
                                    	
                                    </ul>
                                    
                                    
                                    <div class="input-group">
                                      <div class="input-group-btn">
                                      <img src="<%=userProfilePicPath %>" class="img-rounded" width="44" height="036"/>
                                      </div>
                                      <input type="text" class="form-control" name="comment" id="comment<%=p.getPostId()%>"
                                       onclick="this.select()" onkeypress="addComment(this, event,'<%=p.getPostId()%>','<s:property value="#session.user.firstName"/>')";
                                       placeholder="Add a comment.." >
                                    </div>
                                    </form>
                                    </div>
                                  </div>
                               </div>
                               <%}} %>
                              </div>
                              
                               
                               
                            
                           		
                           
                          </div>
                          
                          <!-- main col right -->
                       </div><!--/row-->
                      
                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->
          
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

	</body>
</html>