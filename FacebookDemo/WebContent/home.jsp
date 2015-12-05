<%@page import="javax.mail.Session"%>
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
		<!-- script references just after starting of head tag. -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
		<script src="js/scripts.js"></script>
		<link href="css/customStyle.css" rel="stylesheet">
		
		
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Facebook Home</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<link href="css/newfeedstyles.css" rel="stylesheet">
		
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
			.div1_img
	{ 
	  height:60px;
	  width:60px;
	  padding:5px;
		}
		
	.div_display
	{	 
		 padding:5px;
		display:inline;
		float:left;
		}	
	.div_name
	{	padding:10px;
		
		}
		</style>
		<% User u=(User)session.getAttribute("user");
		  NewsFeedDAOImpl d=new NewsFeedDAOImpl();
		  String userProfilePicPath=d.profilePicPath(u.getUserId());
		
		  %>
	<script type="text/javascript">
	<%
	ArrayList<returnlist_findfriends> peopleyoumayknow=(ArrayList<returnlist_findfriends>)request.getAttribute("peopleyoumayknow");%>
	function  hidefunction(i,userId){
		 $.ajax({
	            url: "peopleyoumayknow_addfriend",
	            type: 'get',
	            dataType: 'json',
	            data: {
	            	"user_id":userId,
	            },
	            contentType: "application/json; charset=utf-8",
	            success:function(response){
	            	  $("#div"+i).hide();      	
	            },
	            error:function(jqXhr, textStatus, errorThrown){
	           	 alert("Something went wrong.Please refersh the page.");
	            }
	        });    
	}
	
 	function showmodal(i){
 				//alert(i);
 				<%-- alert("size== "+<%=session.getAttribute("peopleyoumayknowsize")%>); --%>
 				var j;
		var toshow = 'div_mutualfriends_'+ i;// Button that triggered the modal
		j=0;
		for(j=0;j<<%=session.getAttribute("peopleyoumayknowsize")%>;j++)
		{	
					hide = 'div_mutualfriends_' + j;
					//alert(hide);
					document.getElementById(hide).style.display = "none";
					
			}			
		 
		document.getElementById(toshow).style.display = "block";
		
 	}
	function callModal(postid,type){
		$('#likeOthersModal').modal('show');
		//var url = 'getAllLikeAction?postId='+postid;
		$("#likes_list_others").html("");
		$("#loader_likes").show();
		$("#loader_likes").delay(1000).hide(1);
		if(type=="like")
			$("#myModalLabel1").text("People who like this");
		else
			$("#myModalLabel1").text("People who commented on this");
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
		  window.location.href="<%=StringUtils.hostname%>/FacebookDemo/newsFeedAction";
	  }
	  function AutoRefresh( t ) {
		  	//getAllGroups();
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
	<!-- ===================================== our code ======================================= -->
	
	
<!-- Compulsory to include just before end of <head> tag -->

<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/fontdhruvik.css" />
<link rel="stylesheet" href="css/ace.min.css" />
<link rel="stylesheet" href="css/ace-skins.min.css" />
<link rel="stylesheet" href="css/ace-rtl.min.css" />
<script src="js/ace-extra.min.js"></script>

<!--  ===================================== our code =======================================  -->
	</head>
	<%ArrayList<Post> feedList=(ArrayList<Post>)request.getAttribute("feedList");
		if(feedList==null){
	%>
	<body onload="redirect();">
	<%}else{ %>
		<!-- <body onload="JavaScript:AutoRefresh(60000);"> -->
		<body>
	<%} %>
<div class="wrapper">
    <div >
    <!-- class="box" -->
   
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
                                   <form class="form-horizontal" role="form" id="whatsNew" enctype="multipart/form-data" action="UserPostAction" method="post">
                                    <h4>What's New</h4>
                                     <div class="form-group" style="padding:14px;">
                                      <textarea class="form-control" id="postDesc"  name="postDesc" placeholder="Update your status"></textarea>
                                      <input type="text" id="youtubeLink" name="youtubeLink" placeholder="YouTube Video Link" style="display: none;"/> 
                                    </div>
                                    <button class="btn btn-primary pull-right" type="button" onclick="return postOnWall();">Post</button><ul class="list-inline"><li>
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
                                    <img src="<%=p.getUserProfilePic()%>" class="img-circle pull-left"><br>&nbsp;<a href="userNewsFeedAction?user_id=<%=p.getUserFrom()%>" style="color: #3B5999"><b><%=p.getUserName()%></b></a><br>&nbsp;<font size="1"><%=p.getPostDate() %></font>
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
                                   <!--   - <a href="" style="color: #3B5999">Comment</a> --> </p>
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
	                                    	<img src="<%=c.getPicPath()%>" class="img-rounded" width="44" height="036"/>&nbsp;<a href="userNewsFeedAction?user_id=<%=c.getUserId() %>" style="color: #3B5999"><b><%=c.getUserName()%></b></a>&nbsp;&nbsp;&nbsp;<span id="commentText<%=c.getCommentId()%>"><%=c.getComment() %></span>
	                                    	<%if(( c.getUserId().equalsIgnoreCase(u.getUserId()))){ %>
	                                    	<div class="dropdown" align="left">
	                                    	 <a data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-plus"></i></a>
	                                    	<%} %><br/>
							                    
							                      
							                      <font size="1"><%=c.getDate() %></font>
							                     <%if(( c.getUserId().equalsIgnoreCase(u.getUserId()))){ %>
							                      <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dLabel">
							                      	
							                        <li><a href="#" id="editcomment<%=c.getCommentId()%>" onclick="editComment('<%=p.getPostId()%>','<%=c.getCommentId()%>')">Edit Comment</a></li>
							                        <li><a href="#" id="deletecomment<%=c.getCommentId()%>" onclick="deleteComment('<%=p.getPostId()%>','<%=c.getCommentId()%>');">Delete Comment</a></li>
							                      
							                      </ul>
					                   	    </div>
	                                    	<%} %>
	                                    	
	                                    	
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
                               <%
                            	 	} 
                    
                            	}%>
                              </div>
                              
                               
                               
                            
                           		
                           
                          </div>
                          
                          <!-- main col right -->
                          <div class="col-sm-4">
                               
                            <%--    <div class="well"> 
                                   <form class="form">
                                    <h4>Sign-up</h4>
                                    <div class="input-group text-center">
                                    <input type="text" class="form-control input-lg" placeholder="Enter your email address">
                                      <span class="input-group-btn"><button class="btn btn-lg btn-primary" type="button">OK</button></span>
                                    </div>
                                  </form>
                                </div> --%>
                      
                       <div class="panel panel-default">
                                 <div class="panel-heading"><a href="findfriends" class="pull-right">See all</a> <h4>People You May Know</h4></div>
                                  
                                  <div class="panel-body">
                                  <% // ArrayList<returnlist_findfriends> peopleyoumayknow=(ArrayList<returnlist_findfriends>)request.getAttribute("peopleyoumayknow");
                                  		for(int i=0;peopleyoumayknow!=null && i<peopleyoumayknow.size();i++){
                                		out.println("<div id=div"+i+">");
                                    %>
                                    <div class="div_display" >
									<a href="userNewsFeedAction?user_id=<%=peopleyoumayknow.get(i).getUser_id() %>"> <img class="div1_img" src="<%=peopleyoumayknow.get(i).getProfile_pic()%>"/></a>
									</div>	
									<div class="div_name" >
									<div><a href="userNewsFeedAction?user_id=<%=peopleyoumayknow.get(i).getUser_id() %>" style="text-decoration:none;color:blue;font-size: 100%;"><%=peopleyoumayknow.get(i).getFirst_name()%> <%=peopleyoumayknow.get(i).getLast_name() %></a></div>
									<%out.print("<div><a data-whatever=\"div_mutualfriends_"+i+"\" href=\"#\" style=\"text-decoration:none;color:grey;font-size: 100%;\" data-toggle=\"modal\" data-target=\"#myModal\" onclick=\"showmodal("+i+");\" >"+peopleyoumayknow.get(i).getNo_of_mutualfriends()+" mutual friends</a></div>" ); %> 
									<form action="peopleyoumayknow_addfriend">
										<div><input type="hidden" name="user_id" value="<%=peopleyoumayknow.get(i).getUser_id() %>">
											<input type="button" value="Add&nbsp;friend" style="font-size: 100%;" onclick="hidefunction('<%=i%>','<%=peopleyoumayknow.get(i).getUser_id() %>');">
										</div>
									</form>
									</div>
									</div>
									<%}%>
									
									
									</div>
									
	
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               Mutual Friends
            </h4>
         </div>
         <div class="modal-body">
         	<div id="modal-body-inner">
  <%
	int intlen=0,j=0;
	if(peopleyoumayknow!=null){
	
	for(int i=0;i<peopleyoumayknow.size();i++){
		intlen=peopleyoumayknow.get(i).getMutualfriends_first_name().size();
		//out.print("length : = <h1>"+intlen+"</h1>");
		for(j=0;j<intlen;j++){ 
		
		out.print("<div id=div_mutualfriends_"+i+" style=display:none>");
		/* System.out.println("mutual friends id== "+peopleyoumayknow.get(i).getMutualfriends_user_id().get(j)); */
		%>	
		<div style="padding: 5px;">
		<div class="div_display" >
				<a href="userNewsFeedAction?user_id=<%=peopleyoumayknow.get(i).getMutualfriends_user_id().get(j)%>"> <img class="div1_img" src="<%=peopleyoumayknow.get(i).getMutualfriends_profile_pic().get(j)%>"></a>
			</div>	
		<div class="div_name" >
			<div><a href="userNewsFeedAction?user_id=<%=peopleyoumayknow.get(i).getMutualfriends_user_id().get(j)%>" style="text-decoration:none;color:blue;font-size: 100%;"  ><%=peopleyoumayknow.get(i).getMutualfriends_first_name().get(j)%> <%=peopleyoumayknow.get(i).getMutualfriends_last_name().get(j)%></a></div>
		</div>
		</div>
		<br>

	</div>
		<%} }}%>
	
      </div>
        
         	<div class="modal-footer"><button type="button" id="close" class="btn btn-default" data-dismiss="modal">Close</button></div>
         
         </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
                      
                              
                            
                              

                               
                            
                              
                            
                          </div>
                       </div><!--/row-->
                      
                       
                      
                        <div class="row" id="footer">    
                          <div class="col-sm-6">
                            
                          </div>
                         
                        </div>
                      
                      <hr>
                      
                      <h4 class="text-center">
                      <a href="#" target="ext">Developed By Students Of IIITB</a>
                      </h4>
                        
                      <hr>
                        
                      
                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->
          
        </div>
    </div>
</div>



<!--post modal-->
<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
  <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Ã</button>
			Update Status
      </div>
      <div class="modal-body">
          <form class="form center-block">
            <div class="form-group">
              <textarea class="form-control input-lg" autofocus="" placeholder="What do you want to share?"></textarea>
            </div>
          </form>
      </div>
      <div class="modal-footer">
          <div>
          <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true">Post</button>
            <ul class="pull-left list-inline"><li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li><li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li><li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li></ul>
		  </div>	
      </div>
  </div>
  </div>
</div>
<div id="wallposts_collection">
<div id="likeOthersModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="likeOthersModalLabel" aria-hidden="true" style="display: none;">
    			<div class="modal-dialog">
      				<div class="modal-content">
					  <div class="modal-header">
          				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          					<h4 class="modal-title" id="myModalLabel1">People Who Like This</h4>
        				</div>
        				<div id="loader_likes" style="background-color: #E9EAED;width: 100%;border: 1px solid #e3e3e3;">
         				 	<center><img src="images/loader.gif" height="30px" ></center>
       					</div>
        				<div class="modal-body" id="likes_list_others">
        				
       					</div>
      				</div><!-- /.modal-content -->
   			 	</div><!-- /.modal-dialog -->
 </div>
</div>
	
	</body>
</html>