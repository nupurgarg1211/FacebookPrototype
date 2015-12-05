<div id="eventModal" class="modal fade" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">x</button>
				<h4 class="modal-title">Create Event</h4>
			</div>
			<div class="modal-body">
			<form>
				<p><label for="inputEmail" class="col-lg-2 control-label">Name</label>
				<input type="text" class="form-control" id="eventNameTxt"
								placeholder="Name" style="width:70%"/></p>
						
					
					<p>
						<label for="inputEmail" class="col-lg-2 control-label">What</label>
						
							<input type="text" class="form-control" id="eventDtTxt"
								placeholder="Event Description" style="width:70%"/>
						</p>
					<p>
						<label for="inputEmail" class="col-lg-2 control-label">Where</label>
						
							<input type="text" class="form-control" id="eventPlaceTxt"
								placeholder="Place" style="width:70%"/>
						</p>
					<p>
						<label for="inputEmail" class="col-lg-2 control-label">When</label>
						
							<input type="text" class="form-control" id="eventDateTxt"
								placeholder="Date" style="width:70%"/>
						</p>
				</form>
			</div>
			<div class="modal-footer">
				<div>
					<button onClick="return creatEvent()"
						class="btn btn-primary btn-sm" data-dismiss="modal"
						aria-hidden="true">Done</button>
					<button class="btn btn-sm" data-dismiss="modal" aria-hidden="true">Cancel</button>
				</div>
			</div>
		</div>
	</div>
</div>