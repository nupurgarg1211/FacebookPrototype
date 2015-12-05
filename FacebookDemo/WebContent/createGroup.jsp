<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<link rel="stylesheet" href="css/jquery-ui.css">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="generator" content="Bootply" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.tokeninput.js"></script>
<link rel="stylesheet" href="css/token-input.css" type="text/css" />
<link rel="stylesheet" href="css/token-input-facebook.css"	type="text/css" />
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/newfeedstyles.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(
		function() {
			var posting = $.post("searchAction.action");
			posting.done(function(response) {
				// Pre-process response before passing to make it more friendly to tokenInput
				//alert("inside");
				var grpUserList = [];
				//alert(jQuery
				//	.isEmptyObject(response.grpUserList));
				//var i = 0;
				$.each(response.grpUserList, function(index, user) {
					//i = i + 1;
					//alert(user.first_name);
					grpUserList.push({
						userId : user.userId,
						firstName : user.firstName,
						lastName : user.lastName,
						searchIn : user.firstName + " " + user.lastName
								+ " "
					});
				});
				$("#search1").tokenInput(
						grpUserList,
						{
							propertyToSearch : "searchIn",
							theme : "facebook",
							tokenFormatter : function(item) {
								return "<li><strong>" + item.firstName
										+ " " + item.lastName + " "
										+ item.userId + "</strong></li>";
							}
						});

			});

			
			$('#modal1').modal({
				show : 'true'
			});

			$("#Button1").click(
					function() {
						var memtxt = '';
						//var temp = 'new check';
						var nametxt = $('#grpName').val();

						$("#search1").prev('ul')
								.find('li:not(:last-child)').each(
										function() {
											memtxt += $(this).text() + " ";
										});
						$('#hidMem').val(memtxt);
						$('#hidName').val(nametxt);

						$('#modal1').modal('hide');
						$('#modal2').modal({
							show : 'true'
						});
						/* 
						 $('#modal1').modal({
						 show: 'false'
						 }); */
						return false;
					});

			$("#Button2").click(function() {

				var memtxt = $('#hidMem').val();
				//alert("members"+memtxt);
				var nametxt = $('#hidName').val();
				var icon = $("input[name=icon]:checked").val();
				var posting = $.post("addGroup.action", {
					"grpMembers" : memtxt,
					"grpName" : nametxt,
					"icon" : icon
				});
				posting.done(function(response) {
					var group_id = response.group_id;
					$(window.location).attr('href', 'getGroupDetailAction.action?group_id='+group_id);
				});
				//alert($("input[name=icon]:checked").val());
				$('#modal1').modal('hide');
				$('#modal2').modal('hide');
				return false;
			});
		/* 	$("#selectImage").imagepicker({
				hide_select : true
			}); */
/* 
			var $container = $('.image_picker_selector');
			// initialize
			$container.imagesLoaded(function() {
				$container.masonry({
					columnWidth : 30,
					itemSelector : '.thumbnail'
				});
			}); */

			$("#cancelBtn1").click(
					function() {
						//alert("cancel");
						$('#modal1').modal('hide');
						$(window.location).attr('href', 'home.jsp');
						return false;
					});

			$("#skipBtn2").click(function() {
				var memtxt = $('#hidMem').val();
				var nametxt = $('#hidName').val();
				var icon = $("input[name=icon]:checked").val();
				var posting = $.post("addGroup.action", {
					"grpMembers" : memtxt,
					"grpName" : nametxt,
					"icon" : ''
				});
				posting.done(function(response) {
					var group_id = response.group_id;
					$(window.location).attr('href', 'getGroupDetailAction.action?group_id='+group_id);
				});
				//alert($("input[name=icon]:checked").val());
				$('#modal1').modal('hide');
				$('#modal2').modal('hide');
				return false;
			});
		});
</script>
</head>

<body>
	
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
				</div>
			</div>
		</div>
	</div>


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