<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String eventidee = (String)request.getAttribute("eventId");%>
<div id="inviteFriendModal" class="modal fade" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title">Invite Friends</h4>
			</div>
			<div class="modal-body" style="overflow:auto;height:200px">
				<p>
				<div style="overflow-y:auto;height:200px;width:50%;float:left">
					<table id="frndUL" class="table table-striped">
					</table>
				</div>
				<div style="overflow-y:auto;height:200px;width:40%;float:right">	
					<table id="frndSelTbl" class="table table-striped">
					</table>
				</div>
				</p>
			</div>
			<div class="modal-footer">
				<div>
					<button onClick="return inviteFriends(<%=eventidee %>)"
						class="btn btn-primary btn-sm" data-dismiss="modal"
						aria-hidden="true">Done</button>
					<button class="btn btn-sm" data-dismiss="modal" aria-hidden="true">Cancel</button>
				</div>
			</div>
		</div>
	</div>
</div>