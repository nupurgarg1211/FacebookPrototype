<%@page import="org.apache.struts2.ServletActionContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="org.iiitb.facebook.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
		if(session==null || session.getAttribute("login")==null){
			response.sendRedirect("login.jsp");
		}
 %>
  <!-- top nav -->
              	<div class="navbar navbar-blue navbar-static-top">  
                    <div class="navbar-header">
                      
                      <a href="#" class="navbar-brand logo">b</a>
                  	</div>
                  	<nav class="collapse navbar-collapse" role="navigation">
                    <form class="navbar-form navbar-left">
                        <div class="input-group input-group-sm" style="width:360px;">
                          <input type="text" class="form-control" placeholder="Search" name="srch-term" onKeyUp="return search(this)">
                           <div id="searchList" class="searchSuggestions">
                          	<ul class="searchLi"></ul>
                          </div>
                          <div class="input-group-btn">
                            <button class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
                          </div>
                        </div>
                    </form>
                   
                    <ul class="nav navbar-nav navbar-right">
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i></a>
                        <ul class="dropdown-menu">
                      
                          <li><a href="setting">Setting</a></li>
                          <li><a href="allBlockedUsers">Blocked Users</a></li>
                           <li><a href="logoutAction">LogOut</a></li>
                        </ul>
                      </li>
                    </ul>
                     <ul class="nav navbar-nav navbar-right">
                      <li>
                        <a href="userNewsFeedAction?user_id=<s:property value="#session.user.userId"/>"> <s:property value="#session.user.firstName"/></a>
                      </li>
                      <li>
                       <a href="newsFeedAction">  <i class="glyphicon glyphicon-home"></i>Home</a>
                     </li>
                      
                      
                       <!-- --------------------our code start------------ -->
                     
                      <script  type="text/javascript" language="javascript" >
                     
                     function showAllUpdates(response){
                    	 //data = JSON.stringify(data);
                    	 var global='';
                    	 
                    	
                    	 var req = '<li><a data-toggle="dropdown" class="dropdown-toggle" href="#">	<img src="images/friendreq.png" width="30px" height="30px" style="margin-top : 10px;"><span class="badge badge-important">';
                    	 req += response.size_frndrequest;
                    	 req += '</span></a><ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">';
                    	 req += '<li class="dropdown-header" style="font-size: 15px">'+response.size_frndrequest +' Request(s) Pending</li>';
                    	 var allreq='';
                    	 $.each(response.al_UserFriend, function(index, element) {
                    	    var rfirst = element.first_name;
                    	    var rlast = element.last_name;
                    	    var rpic = element.profile_pic;
                    	    var ruserid = element.userid;
                       	    var rmainli ='<li>';
                    	    var rsubdivspani = '<div class="clearfix">';
                    	    var rmainlink = '<a href="userNewsFeedAction?user_id='+ruserid+'"><span class="msg-body"><span class="msg-title">';
                    	    var rimages = '<img src="'+rpic+'" width="25px" height="25px">&nbsp;';
                    	    var rmessages = rfirst + " " + rlast;
                    	    var rname = '</span></span></a><span class="pull-right"><div id="'+ruserid+'">';
                    	    var accpt = '<a href="#" onclick="acceptReq('+ruserid+')"><img src="images/accept1.png" width="18px" height="18px"></a>&nbsp;';
							var rejct = '<a href="#" onclick="rejectReq('+ruserid+')"><img src="images/reject1.png" width="18px" height="18px"></a>&nbsp;';
							var rendtags = '</div></span></div></li>';
                    	    
                    	    
                    	    allreq += rmainli + rmainlink + rsubdivspani + rimages + rmessages + rname + accpt + rejct + rendtags;
                    	 });
                    	 
                    	 req += allreq;
                    	 req += '<li class="dropdown-footer">';
                    	 req += '<a href="getAllFriends?user_id='+response.userid+'">';
                    	 req += 'See all Requests';
                    	 req += '<i class="ace-icon fa fa-arrow-right"></i>';	
                    	 req += '</a>';	
                    	 req += '</li>';
                    	 req += '</ul>';
                    	 req += '</li>';
                    	 
                    	 global += req;
                    	 
                    	  
                    	 
                    	 
                    	 
                    	 var msgs = '<li><a data-toggle="dropdown" class="dropdown-toggle" href="#">	<img src="images/messages.png" width="30px" height="30px" style="margin-top : 10px;"><span class="badge badge-important">';
                    	 msgs += response.size_messages;
                    	 msgs += '</span></a><ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">';
                    	 msgs += '<li class="dropdown-header" style="font-size: 15px">'+response.size_messages +' Messages</li>';
                    	 var allmsg='';
                    	 $.each(response.al_msgs, function(index, element) {
                    	    var first = element.first_name;
                    	    var last = element.last_name;
                    	    var pic = element.profile_pic;
                    	    var userid = element.userid;
                    	    var mainlim ='<li>';
                    	    var mainlinkm = '<a href="loadMessage?friendid='+userid+'">';
                    	    var subdivspanim = '<div class="clearfix"><span class="msg-body"><span class="msg-title">';
                    	    var images = '<img src="'+pic+'" width="25px" height="25px">&nbsp;';
                    	    var messagesm = first + " " + last;
                    	    var endtagsm = '</span></span></div></a></li>';
                    	    
                    	    
                    	    allmsg += mainlim + mainlinkm + subdivspanim + images + messagesm + endtagsm;
                    	 });
                    	 
                    	 msgs += allmsg;
                    	 msgs += '<li class="dropdown-footer">';
                    	 msgs += '<a href="getConversations">';
                    	 msgs += 'See all Messagees';
                    	 msgs += '<i class="ace-icon fa fa-arrow-right"></i>';	
                    	 msgs += '</a>';	
                    	 msgs += '</li>';
                    	 msgs += '</ul>';
                    	 msgs += '</li>';
                    	 
                    	 global += msgs;
                    	 
                    	 
                    	 
                    	 
                    	 var noti = '<li><a data-toggle="dropdown" class="dropdown-toggle" href="#" onclick="clearunseen()">	<img src="images/Notification.png" width="30px" height="30px" style="margin-top : 10px;"><span class="badge badge-important">';
                    	 noti += response.size_notification;
                    	 noti += '</span></a><ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">';
                    	 noti+= '<li class="dropdown-header" style="font-size: 15px">'+response.size_notification +' Notifications</li>';
                    	 var all='';
                    	 $.each(response.al_noti, function(index, element) {
                    	    var date = element.date;
                    	    var is_seen = element.is_seen;
                    	    var msgs = element.msg;
                    	    var type = element.notification_type;
                    	    var url = element.url;
                    	    var to = element.user_to;
                    	    var from = element.user_from;
                    	    var mainli ='<li>';
                    	    var mainlink = '<a href="'+url+'">';
                    	    var subdivspani = '<div class="clearfix"><span class="msg-body"><span class="msg-title">';
                    	    var messages = msgs;
                    	    var endtags = '</span></div></a></li>';
                    	    
                    	    
                    	    all += mainli + mainlink + subdivspani + messages + endtags;
                    	 });
                    	 
                    	 noti += all;
                    	 noti += '<li class="dropdown-footer">';
                    	 noti += '<a href="getAllNotifications">';
                    	 noti += 'See all notifications';
                    	 noti += '<i class="ace-icon fa fa-arrow-right"></i>';	
                    	 noti += '</a>';	
                    	 noti += '</li>';
                    	 noti += '</ul>';
                    	 noti += '</li>';
                    	 
                    	 global += noti;
                    	 $('#headerdynamicpart').replaceWith(global);
                    	 }
                     
                     
                     
                     $(document).ready(function(){
                      	// var data = '{"searchTerm":"'+ term+'"}';
                    	// data = JSON.parse(data);
                    	 $.ajax({
                    	 url:"getnotification",
                    	 dataType: "json",
         				data:{
         					name : "dhruvik"
         				},
                    	 contentType: 'application/json;charset=utf-8',
                    	 type: "get",
                    	 success:function(response){
                    		 //alert("lol"+response.name);
                    		// document.write("here");
                    	 showAllUpdates(response);
                    	 },
                    	 error:function(){
                    	 alert("error");
                    	 } 
                    	 });
                     });
                    
                     
                     function clearunseen(){
                    	 $.ajax({
                        	 url:"clearnotification",
                        	 dataType: "json",
             				data:{
             					name : "dhruvik"
             				},
                        	 contentType: 'application/json;charset=utf-8',
                        	 type: "get",
                        	 success:function(response){
                        		// alert("lol");
                        		// document.write("here");
                        	 //showSearchResultDropDown(response);
                        	 },
                        	 error:function(){
                        	 alert("error");
                        	 } 
                        	 });
                    	 
                    	 
                     }
                     
                     function acceptReq(uid){
                    	 
                    	 
                    	 //alert("in accept "+uid);
                      	  $.ajax({
                        	 url:"acceptRequest?pending_friend="+uid,
                        	 dataType: "json",
             				data:{
             					name : "dhruvik"
             				},
                        	 contentType: 'application/json;charset=utf-8',
                        	 type: "get",
                        	 success:function(response){
                        		 var accptmsg = '<div style="color: #3B5999"><b>Accepted</b></div>';
                            	 $('#'+uid).replaceWith(accptmsg);
                        	 },
                        	 error:function(){
                        	 alert("error");
                        	 } 
                        	 }); 
                        	 

                    	
                    	 
                    	 
                     }
                     
                     function rejectReq(uid){
                    	 
                    	 //alert("in reject "+uid);
                    	 	 
                    	 $.ajax({
                        	 url:"rejectRequest?pending_friend="+uid,
                        	 dataType: "json",
             				data:{
             					name : "dhruvik"
             				},
                        	 contentType: 'application/json;charset=utf-8',
                        	 type: "get",
                        	 success:function(response){
                        		 var rejectmsg = '<div style="color: #3B5999"><b>Rejected</b></div>';
                            	 $('#'+uid).replaceWith(rejectmsg);
                        	 },
                        	 error:function(){
                        	 alert("error");
                        	 } 
                        	 }); 
                     	 
                     	 
                      }
                     
                     
                     
                     
                     
                    	 </script>	
             <!--         
                     <script>

				$(document).ready(function(){
					var choice;
					/* $("#choice").click(function(){
							
						$("#choice:selected").text(); //the text content of the selected option
						choice=$("#choice").val();
						
					      $.getJSON('checkStock', function(jsonResponse) {
					      
					      	var select = $('#list');
					        select.find('option').remove();
					        $.each(jsonResponse.list, function(key, value) {
					          $('<option>').val(key).text(value).appendTo(select);
					        });
						
						});
					});	 */
					
					 $.getJSON('checkStock', function(jsonResponse) {
						 
						 function(data) {
				                $('#abc').append('<br>' + data.capacity);
				                $('#abc').append('<br>' + data.countryList);
				                $('#xyz').attr('value', data.greeting);
				                $('#pqr').attr('list', data.countryList);
				            });
					      	
					        $.each(jsonResponse.list, function(key, value) {
					          $('<option>').val(key).text(value).appendTo(select);
					        });
						
						});
					
					
					
					
					
					$("#generate_details").click(function(){
						
						var select=$('#personDataTable');
						select.find('td').remove();
						
						 	
						$("#list:selected").text(); //the text content of the selected option
						var choice2=$("#list").val();
					//	var table = $('<table/>').appendTo($('#somediv'));
						
						$.getJSON('checkStock', {
					        choice : choice,choice2:choice2
					      }, function(jsonResponse) {
					    	  
					    	  $.each(jsonResponse.productlistoflowstock, function(key,value) {
					    		  drawRow(value);
					    	  });
					      });
					});
					      
				    });
					    	
					
					
					function drawRow(rowData) {
					    var row = $("<tr />");
					    $("#personDataTable").append(row); //this will append tr element to table... keep its reference for a while since we will add cels into it
					    row.append($("<td>" + rowData.p_name + "</td>"));
					    row.append($("<td>" + rowData.p_price + "</td>"));
					    row.append($("<td>" + rowData.stock + "</td>"));
					}
				
					
				
				
				
				</script> -->
                
                     
                     <li>
                  <!--  <div class="no-skin"> -->
					  <div id="navbar" class="navbar navbar-default">  
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

	 	<div class="navbar-container" id="navbar-container"> 
	 	
	 	<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<div id="headerdynamicpart">
						<li>
							<a data-toggle="dropdown" class="dropdown-toggle" href="#" onclick="clearunseen()">
								<img src="images/Notification.png"  width="40px" height="40px">
								<span class="badge badge-important"><s:property value = "size_notification" /></span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-exclamation-triangle" style="font-size: 10px"></i>
									<s:property value = "size_notification" /> Notifications
								</li>

								<li>
									
										<div class="clearfix">
										<a href="#">
											<span class="pull-left">
											&nbsp;
											&nbsp;
												<!-- <i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> -->
												
												New Comments
											
											</span>
											</a>	
											<span class="pull-right">
											<div id="frndlinks">
											<a href="#"><img src="images/accept1.png" width="18px" height="18px"></a>&nbsp;
											 <a href="#"><img src="images/reject1.png" width="18px" height="18px"></a>&nbsp;
										<!-- 	<input type="button"  src="images/accept1.png" /> -->
											</div>
											</span>
										</div>
									
								</li>

								<li>
									<a href="#">
										<i class="btn btn-xs btn-primary fa fa-user"></i>
										Bob just signed up as an editor ...
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success fa fa-shopping-cart"></i>
												New Orders
											</span>
											<span class="pull-right badge badge-success">+8</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info fa fa-twitter"></i>
												Followers
											</span>
											<span class="pull-right badge badge-info">+11</span>
										</div>
									</a>
								</li>

								<li class="dropdown-footer">
									<a href="#">
										See all notifications
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<img src="images/facebook-messenger.jpg" height="25px" width="25px">
								<!--<i class="ace-icon fa fa-envelope icon-animated-vertical"></i> -->
								<span class="badge badge-success">5</span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-envelope-o"></i>
									5 Messages
								</li>

								<li class="dropdown-content">
									<ul class="dropdown-menu dropdown-navbar">
										<li>
											<a href="#">
												<img src="images/bg.png" class="msg-photo" alt="Alex's Avatar" />
												<span class="msg-body">
													<span class="msg-title">
														<span class="blue">Alex:</span>
														Ciao sociis natoque penatibus et auctor ...
													</span>

													<span class="msg-time">
														<i class="ace-icon fa fa-clock-o"></i>
														<span>a moment ago</span>
													</span>
												</span>
											</a>
										</li>

										<li>
											<a href="#">
												<img src="images/bg.png" class="msg-photo" alt="Susan's Avatar" />
												<span class="msg-body">
													<span class="msg-title">
														<span class="blue">Susan:</span>
														Vestibulum id ligula porta felis euismod ...
													</span>

													<span class="msg-time">
														<i class="ace-icon fa fa-clock-o"></i>
														<span>20 minutes ago</span>
													</span>
												</span>
											</a>
										</li>

										<li>
											<a href="#">
												<img src="images/bg.png" class="msg-photo" alt="Bob's Avatar" />
												<span class="msg-body">
													<span class="msg-title">
														<span class="blue">Bob:</span>
														Nullam quis risus eget urna mollis ornare ...
													</span>

													<span class="msg-time">
														<i class="ace-icon fa fa-clock-o"></i>
														<span>3:15 pm</span>
													</span>
												</span>
											</a>
										</li>

										<li>
											<a href="#">
												<img src="images/bg.png" class="msg-photo" alt="Kate's Avatar" />
												<span class="msg-body">
													<span class="msg-title">
														<span class="blue">Kate:</span>
														Ciao sociis natoque eget urna mollis ornare ...
													</span>

													<span class="msg-time">
														<i class="ace-icon fa fa-clock-o"></i>
														<span>1:33 pm</span>
													</span>
												</span>
											</a>
										</li>

										<li>
											<a href="#">
												<img src="images/bg.png" class="msg-photo" alt="Fred's Avatar" />
												<span class="msg-body">
													<span class="msg-title">
														<span class="blue">Fred:</span>
														Vestibulum id penatibus et auctor  ...
													</span>

													<span class="msg-time">
														<i class="ace-icon fa fa-clock-o"></i>
														<span>10:09 am</span>
													</span>
												</span>
											</a>
										</li>
									</ul>
								</li>

								<li class="dropdown-footer">
									<a href="inbox.html">
										See all messages
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
						</div>
						</ul>
						
				</div>
			 </div><!-- /.navbar-container --> 
	 	</div> 
	<!-- 	
	</div>
              -->        
                     </li>

                     <!-- --------------------our code end------------ -->
             
                  
                    </ul>
                  	</nav>
                </div>
                <!-- /top nav -->
   