<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="org.iiitb.facebook.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">
              
              	<ul class="nav">
          			<li><a href="#" data-toggle="offcanvas" class="visible-xs text-center"><i class="glyphicon glyphicon-chevron-right"></i></a></li>
            	</ul>
               <% 
               		User u0=(User)session.getAttribute("user");
               		String userId1=(String)request.getParameter("user_id");
               		String userId2="";
					if(session!=null){
						userId2=(String)session.getAttribute("tempUserId");
					}
					if(userId1==null){
						userId1=userId2;
					}
               %>
               
   
                   
                <ul class="nav hidden-xs" id="lg-menu">
                <!-- For Demo only , dont use it-->
                    <br/><br/>        	
                    <br/><br/><li></li>
                     <li><a href="userNewsFeedAction?user_id=<%=userId1%>"><i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Timeline</a></li>
                    <li ><a href="about?user_id=<%=userId1%>"><i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;About</a></li>
                    
                    <li><a href="getAllFriends?user_id=<%=userId1%>"><i class="glyphicon glyphicon-list"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Friends</a></li>
                    <%if(!u0.getUserId().equals(userId1)){ %>
                     <li><a href="getSuggestFriend?user_id=<%=userId1%>"><i class="glyphicon glyphicon-list"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Suggest Friends</a></li>
                     <%} %>
                    <li><a href="viewAlbumAction?user_id=<%=userId1%>"><i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Albums</a></li>
                    <!-- <li><a href="#"><i class="glyphicon glyphicon-refresh"></i> Refresh</a></li> -->
                </ul>
              
              	<!-- tiny only nav-->
              <ul class="nav visible-xs" id="xs-menu">
                  	<li><a href="#featured" class="text-center"><i class="glyphicon glyphicon-list-alt"></i></a></li>
                    <li><a href="#stories" class="text-center"><i class="glyphicon glyphicon-list"></i></a></li>
                  	<li><a href="#" class="text-center"><i class="glyphicon glyphicon-paperclip"></i></a></li>
                    <li><a href="#" class="text-center"><i class="glyphicon glyphicon-refresh"></i></a></li>
                </ul>
              
            </div>