<!DOCTYPE html>
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
		<title>Facebook Home</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<%@ taglib prefix="s" uri="/struts-tags"%>
		
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		
		
		
		<!-- ===================================== our code ======================================= -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<meta name="description" content="" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
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

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lte IE 8]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
				<!--  ===================================== our code =======================================  -->
		
	</head>
	<body>
	
<div class="wrapper">
    <div>
   
   			<%@ include file="header.jsp"%>
   
        <div class="row row-offcanvas row-offcanvas-left">
                      
          
            <!-- sidebar -->
            <%@ include file="leftnav.jsp"%>
            <!-- /sidebar -->
          <div class="divider"></div>
            <!-- main right col -->
            <div class="column col-sm-10 col-xs-11" id="main">
             <!-- content -->                      
                      	<div class="row">
                          
                         <!-- main col left --> 
                         <div class="col-sm-8">
                      <br/>
                      <br/>     
                <div class="panel panel-default">
                 <div class="panel-heading"> <h4><b>Your Notifications</b></h4></div>
                      <div class="panel-body">
               <ul class="list-group">
               
               <s:iterator value="al">
               		
		           	<li class="list-group-item" style=" color: #3B5999">
		           	
		           		<a href='<s:property value="url" />'>
		           	 <img src='<s:property value="picUrl"/>'  class="img-rounded" width="44" height="036" />&nbsp;<b><s:property value="msg"/></b></a><br>&nbsp;<font size="1" style="text-align: right; float: right; margin-top: -20px;"><s:property value="date"/></font>
                             <!--        <div class="clearfix"></div> -->
		         
		           	
		          <%--  	<a href='<s:property value="url" />'>
		           	<img src='<s:property value="picUrl"/>'  class="img-rounded" width="44" height="036" width="44" height="036"/>
		           	 &nbsp;
		           	  <b><s:property value="msg"/>	</b>
		          	</a><br>&nbsp;<font size="1"><s:property value="date"/></font> --%>
		           	</li>
		           	
               </s:iterator>
       
               </ul> 
                        </div>
                        </div>
                        </div>
                        </div>
             
                      
               
            </div>
            <!-- /main -->
          
        </div>
    </div>
</div>


<!--post modal-->

	</body>
</html>