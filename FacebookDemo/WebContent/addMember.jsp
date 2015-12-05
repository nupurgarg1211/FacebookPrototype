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
			var group_id = $('#hidGrpId').val();
			var posting = $.post("searchActionToAddMember.action?group_id="+group_id);
			posting.done(function(response) {
				// Pre-process response before passing to make it more friendly to tokenInput
				//alert("inside");
				var grpUserList = [];
				//alert(jQuery
				//	.isEmptyObject(response.grpUserList));
				//var i = 0;
				$.each(response.grpAddUserList, function(index, user) {
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
						var group_id = $('#hidGrpId').val();
						//alert("group_id:::"+group_id);
						//var temp = 'new check';
						//var nametxt = $('#grpName').val();

						$("#search1").prev('ul')
								.find('li:not(:last-child)').each(
										function() {
											memtxt += $(this).text() + " ";
										});
						$('#hidMem').val(memtxt);
						
						var posting = $.post("addMemberToGroupAction.action", {
							"grpMembers" : memtxt,
							"group_id" :group_id
						});
						posting.done(function(response) {
							var group_id = response.group_id;
							$(window.location).attr('href', 'getGroupDetailAction.action?group_id='+group_id);
						});
						//alert($("input[name=icon]:checked").val());
						$('#modal1').modal('hide');
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
						var group_id = $('#hidGrpId').val();
						$('#modal1').modal('hide');
						$(window.location).attr('href', 'getGroupDetailAction.action?group_id='+group_id);
						return false;
					});

			
		});
</script>
</head>

<body>
	<input type="hidden" name="group_id" id="hidGrpId" value='<%=request.getParameter("group_id")%>'/>
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

</body>
</html>