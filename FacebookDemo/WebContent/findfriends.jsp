<%@page import= "java.util.ArrayList"%>
 <%@ page import="org.iiitb.facebook.model.*" %> 

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
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
<title>Facebook</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
<link href="css/newfeedstyles.css" rel="stylesheet">
<link href="css/customStyle.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 50px;
}

.navbar-blue {
	width: 100%;
}

#jumbobg {
	background-image: url('images/bg1.jpg');
	background-repeat: no-repeat;
	background-position: center 35%;
	background-size: 100% 960px;
}

#jumbotitle {
	color: bisque;
	text-shadow: 3px 3px 2px #202020;
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
	
<!-- script references -->

<script src="js/bootstrap.min.js"></script>

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="js/jquerynew.js"></script>
		<script type="text/javascript" src="js/jquery1.js"></script>
      	<script type="text/javascript" src="js/jquery2.js"></script>
		<script type="text/javascript" src="js/tooltip.js"></script>
		<script src="js/jquery.min.js"></script>
   		<script src="js/bootstrap.min.js"></script>
<%ArrayList<returnlist_findfriends> peopleyoumayknowall=(ArrayList<returnlist_findfriends>)request.getAttribute("peopleyoumayknowall");%>
<script type="text/javascript">
	function  hidefunction(i,userId){
		 $.ajax({
	            url: "peopleyoumayknowall_addfriend",
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
 				<%-- alert("size== "+<%=session.getAttribute("peopleyoumayknowallsize")%>); --%>
 				var j;
		var toshow = 'div_mutualfriends_'+ i;// Button that triggered the modal
		j=0;
		for(j=0;j<<%=session.getAttribute("peopleyoumayknowallsize")%>;j++)
		{	
					hide = 'div_mutualfriends_' + j;
					//alert(hide);
					document.getElementById(hide).style.display = "none";
					
			}			
		 
		document.getElementById(toshow).style.display = "block";
		
 	}
  
	
			
</script>
 <!-- Compulsory to include just before end of <head> tag -->

<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/fontdhruvik.css" />
<link rel="stylesheet" href="css/ace.min.css" />
<link rel="stylesheet" href="css/ace-skins.min.css" />
<link rel="stylesheet" href="css/ace-rtl.min.css" />
<script src="js/ace-extra.min.js"></script>

</head>

<body>
	<div class="wrapper">
		<div style="background-color: white">
			<%@ include file="header.jsp"%>
			
			<div role="tabpanel"
				style="padding-top: 60px; margin: 0 auto; width: 70%">
	
				<!-- Nav tabs -->
				 <!-- sidebar -->
            <%@ include file="leftnav.jsp"%>
            <!-- /sidebar -->
				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="people" style="background-color: #FFF;">
						<s:iterator value="%{searchMap['people']}" var="item">
							<div class="searchAllBox">
								<div class="searchAllImg"><img src='imageAction?path=<s:property value="#item.profilePic"/>' /></div>
								<div class="searchAllDetails">
									<ul>
										<li><s:property value="#item.name"/></li>
										<li><s:property value="#item.position"/> at <s:property value="#item.organisation"/></li>
										<li>lives in <s:property value="#item.place"/></li>
										<li>10 mutual friends</li>
									</ul>
								</div>
							</div>
						</s:iterator>
					
					</div>
					<div role="tabpanel" class="tab-pane" id="event" style="background-color: #FFF;">
						<s:iterator value="%{searchMap['event']}" var="item">
							<div class="searchAllBox">
								<div class="searchAllImg"><img src='imageAction?path=<s:property value="#item.profilePic"/>' /></div>
								<div class="searchAllDetails">
									<ul>
										<li><s:property value="#item.eventname"/></li>
										<li><s:property value="#item.place"/></li>
										<li><s:property value="#item.eventDetails"/></li>
										<li><s:property value="#item.organiserName"/></li>
									</ul>
								</div>
							</div>
						</s:iterator>
					</div>
					
				
				
					
					<div role="tabpanel" class="tab-pane" id="group" style="background-color: #FFF;">Groups</div>
					
                               <div class="panel panel-default">
                                 <div class="panel-heading"><h4>People You May Know</h4></div>
                                  
                                  <div class="panel-body">
                                  	
 									
 		 							<%  
 		 							for(int i=0;i<peopleyoumayknowall.size();i++){
 		 								out.println("<div id=div"+i+">");
                                    %>
                                

									<div style="display:block">
                                   <div class="div_display" >
									<a href="userNewsFeedAction?user_id=<%=peopleyoumayknowall.get(i).getUser_id() %>"> <img class="div1_img" src="<%=peopleyoumayknowall.get(i).getProfile_pic()%>"/></a>
									</div>	
									<div class="div_name" >
									<div><a href="userNewsFeedAction?user_id=<%=peopleyoumayknowall.get(i).getUser_id() %>" style="text-decoration:none;color:blue;font-size: 100%;"><%=peopleyoumayknowall.get(i).getFirst_name()%> <%=peopleyoumayknowall.get(i).getLast_name() %></a></div>
									<%out.print("<div><a data-whatever=\"div_mutualfriends_"+i+"\" href=\"#\" style=\"text-decoration:none;color:grey;font-size: 100%;\" data-toggle=\"modal\" data-target=\"#myModal\" onclick=\"showmodal("+i+");\" >"+peopleyoumayknowall.get(i).getNo_of_mutualfriends()+" mutual friends</a></div>" ); %> 
									<form action="peopleyoumayknowall_addfriend">
										<div>
										<input type="hidden" name="user_id" value="<%=peopleyoumayknowall.get(i).getUser_id() %>">
										<input type="button" value="Add&nbsp;friend" style="font-size: 100%;" onclick="hidefunction('<%=i%>','<%=peopleyoumayknowall.get(i).getUser_id() %>');">
										</div>
									</form>
									</div>
									</div>
									
									</div>
									<br>
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
	if(peopleyoumayknowall!=null){
	
	for(int i=0;i<peopleyoumayknowall.size();i++){
		intlen=peopleyoumayknowall.get(i).getMutualfriends_first_name().size();
		
		for(j=0;j<intlen;j++){ 
		
		out.print("<div id=div_mutualfriends_"+i+" style=display:none>");
		%>	<div class="div_display" >
				<a href="userNewsFeedAction?user_id=<%=peopleyoumayknowall.get(i).getMutualfriends_user_id().get(j)%>"> <img class="div1_img" src="<%=peopleyoumayknowall.get(i).getMutualfriends_profile_pic().get(j)%>"></a>
			</div>	
		<div class="div_name" >
			<div><a href="userNewsFeedAction?user_id=<%=peopleyoumayknowall.get(i).getMutualfriends_user_id().get(j)%>" style="text-decoration:none;color:blue;font-size: 100%;"  ><%=peopleyoumayknowall.get(i).getMutualfriends_first_name().get(j)%> <%=peopleyoumayknowall.get(i).getMutualfriends_last_name().get(j)%></a></div>
		</div>
	</div>
		<%} }}%>
	
      </div>
        
         	<div class="modal-footer"><button type="button" class="btn btn-default" id="close" data-dismiss="modal">Close</button></div>
         
         </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
							
				
				
				
				
				
				
				</div>
							</div>
		</div>
	</div>
		
</body>
</html>