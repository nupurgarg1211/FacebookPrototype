$(document).ready(function() {/* off-canvas sidebar toggle */
	$('[data-toggle=offcanvas]').click(function() {
		$(this).toggleClass('visible-xs text-center');
		$(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
		$('.row-offcanvas').toggleClass('active');
		$('#lg-menu').toggleClass('hidden-xs').toggleClass('visible-xs');
		$('#xs-menu').toggleClass('visible-xs').toggleClass('hidden-xs');
		$('#btnShow').toggle();
	});
	// onhover change color
	$(document).on("mouseover", "li.searchLi", function() {
		$(this).addClass("ahoverColor");
	});
	$(document).on("mouseout", "li.searchLi", function() {
		$(this).removeClass("ahoverColor");
	});

	$('#eventDateTxt').datepicker({
		format : "dd/mm/yyyy"
	}).on("show", function(e) {
		$(this).find("td").css("color", "#000");
	});

});

/* nitin js functions for event and search */

//dropdown
function setDropDown(thees){
	var val = $(thees).text();
	$(thees).parent().parent().parent().find("button").text(val).append('<span class="caret"></span>');
	$(thees).parent().parent().parent().find("button").val(val);
}

//search functionality on the header search bar
function search(thees){
	var term = $.trim($(thees).val());
	if(term.length <= 0){
		return false;
	}else{
		var data = '{"searchTerm":"'+ term+'"}';
		//data = JSON.parse(data);
		$.ajax({
			url:"search",
			dataType: "json",
			data : data,
			contentType: 'application/json;charset=utf-8',
			type: "post",
			success:function(data){
				showSearchResultDropDown(data);
				$(".searchSuggestions").addClass("displayBlock");
			},
			failure:function(){
				alert("error");	
			}
		});
	}
}

function showSearchResultDropDown(data){
	//data = JSON.stringify(data);
	var html = "";	
	$.each(data.userList, function(index, element) {
	    var name = element.name;
	    var org = element.organisation;
	    var place = element.place;
	    var position = element.position;
	    var school = element.school;
	    var pic = element.profilePic;
	    var id = element.userId;
	    html += '<li class="searchLi">';
		html+= '<div class="searchDiv"><a href="userNewsFeedAction?user_id='+id+'">';
		html+= '<span class="searchImg"><img src="imageAction?path=Albums/'+ id +'_profilePicture/'+ pic +'" height="48" width="48"></span>';
		html+= '<span class="searchName">'+ name +'</span>';
		if(school != null){
			html+= '<span class="searchCompany">'+ school ;
		}
		if(org != null){
			if(school == null){
				html+= '<span class="searchCompany">';
			}
			var t = org;
			if(position != null) t = position+" at "+ org;
			html+= ' . ' + t +'</span>';
		}
		html+= '</a></div></li>';
	    });
	html +='<li><a href="searchAll?searchTerm='+data.searchTerm+'" style="color:#000"><i class="glyphicon glyphicon-search"></i> search more</a></li>';
	$("#searchList ul.searchLi").html(html);
}

function creatEvent(){
	
	var name = $("#eventNameTxt").val();
	var detail = $("#eventDtTxt").val();
	var place = $("#eventPlaceTxt").val();
	var date = $("#eventDateTxt").val();
	
	if($.trim(name).length == 0 || name == null ){
		return false;
	}else if($.trim(detail).length == 0 || detail == null ){
		return false;
	}else if($.trim(place).length == 0 || place == null ){
		return false;
	}else if($.trim(date).length == 0 || date == null ){
		return false;
	}
	
	var data = '{"name":"'+ name+'","detail":"'+ detail +'","place":"'+ place +'","date":"'+ date +'","privacy": "public"}';
	
	$.ajax({
		url:"event",
		dataType: "json",
		data : data,
		contentType: 'application/json;charset=utf-8',
		type: "post",
		success:function(data){
			var loc = "events?eventId="+data.eventId;
			location.href = loc;
		},
		failure:function(){
			alert("error");
			return true;
		}
	});
}

function invitefrnd(eventId){
	var html = "";
	var data = JSON.stringify({eventId:eventId});
	$.ajax({
		url:"eventFriendList",
		dataType: "json",
		data : data,
		contentType: 'application/json;charset=utf-8',
		type: "post",
		success:function(data){
			$.each(data.frndList,function(key,val){
				html +=	'<tr><td class="ivfrndLi">'+val.firstName +' '+val.lastName+'</td><td><input type="checkbox" onclick="addToList(this)" name="option'+ val.userId +'" value="'+ val.userId +'"/></td></tr>';
			});
			$("#frndUL").html(html);
			$("#inviteFriendModal").modal();
		},
		failure:function(){
			alert("error");
			return true;
		}
	});
}

function addToList(thees){
	if($(thees).is(":checked") == true){
		var name = $(thees).parent().parent().find(".ivfrndLi").text();
		var className = $(thees).attr("name");
		html =	'<tr class="'+className+'"><td>'+name+'</td></tr>';
		$("#frndSelTbl").append(html);
	}else{
		var name = $(thees).attr("name");
		$("#frndSelTbl").find("tr."+name).remove();
	}
}

function inviteFriends(eventId){
	var arr = [];
	$("input:checkbox").each(function(){
		if($(this).is(":checked") == true)
			arr.push($(this).attr("name").replace("option",""));
	});
	if($.isEmptyObject(arr)){
		return false;
	}
	var url = location.href;
	var data = JSON.stringify({eventId:eventId,invitees:arr});
	$.ajax({
		url:"inviteFriends",
		dataType: "json",
		contentType: 'application/json;charset=utf-8',
		data : data,
		type: "post",
		success:function(data){
			location.reload(true);
		},
		failure:function(){
			alert("error");
			//return true;
		}
	});
}

function respondRSVP(eventId,code){
	var data = JSON.stringify({eventId:eventId,code:code})
	$.ajax({
		url:"respondRSVP",
		dataType: "json",
		contentType: 'application/json;charset=utf-8',
		data : data,
		type: "post",
		success:function(data){
			location.reload(true);
		},
		failure:function(){
			alert("error");
			location.reload(true);
		}
	});
}

function getList(eventId,code){
	var data = JSON.stringify({eventId:eventId,code:code});
	$.ajax({
		url:"getInvitedStatusList",
		dataType: "json",
		contentType: 'application/json;charset=utf-8',
		data : data,
		type: "post",
		success:function(data){
			$("#inviteListTitle").html(code+" List");
			var html = "";
			
			
			$.each(data.invitedUserList,function(k,v){
				html +="<p>"+ v +"</p>";
			});
			$("#inviteList").html(html);
			$("#inviteListModal").modal();
		},
		failure:function(){
			alert("error");
			//return true;
		}
	});
}


/* end */