<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><!-- DOCTYPE 및 태그라이브러리정의 -->
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><!-- 공통헤드 -->
<%@ include file="/WEB-INF/views/comm/common-include-url.jspf"%><!-- 공통 Content-Security-Policy -->
<!-- Font Awesome -->
<link rel="stylesheet" href="/css/AdminLTE_main/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet" href="/css/AdminLTE_main/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- fontNoto -->
<link type="text/css" rel="stylesheet" href="/css/fontNoto.css">
<!-- jQuery -->
<script src="/css/AdminLTE_main/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/css/AdminLTE_main/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<!-- jQuery inputmask -->
<script type="text/javascript" src='/css/AdminLTE_main/plugins/inputmask/jquery.inputmask.js'></script>
<script type="text/javascript" src='/js/com/eds.common.js?curr=<c:out value="${common_include_js_curr}" />'></script>
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- 공통코드 Enum, EnumKeys 관련 모듈 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src='/js/com/common.js'></script>
<script type="text/javascript" src='/js/com/commonCode.js'></script>
<!-- Bootstrap 4 -->
<script src="/css/AdminLTE_main/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- overlayScrollbars -->
<script src="/css/AdminLTE_main/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE_main App -->
<script src="/css/AdminLTE_main/dist/js/adminlte.js"></script>
<!-- moment App -->
<script src="/tui/@toast-ui/calendar/dist/moment.min.js"></script>
<!-- sweetalert2 App -->
<script type="text/javascript" src="/AdminLTE_main/plugins/sweetalert2/sweetalert2.all.min.js"></script>
<!-- edsiframe App -->
<script src="/js/com/eds.iframe.js"></script>
<!-- alarm App -->
<script src="/js/com/eds.alarm.js"></script>
</head>
<style>
 .scnavlink>active
 {
	background-color: #6d5544 !important;
	color: #ffffff !important;
 }
.nav-treeview>.nav-item.menu-open>.scnavlink.nav-link
 {
	background-color: #8c715eb0 !important;
    color: #fff !important;
 }
 .fitcon
 {
	width: fit-content !important;
 }
 .alarmDiv p {
    margin: 0;
    white-space: normal;
	
}
.alarmDiv
{
	background-color: #f5f6f8;
}
.notify {
	-webkit-touch-callout: none;
     user-select: none;
     -moz-user-select: none;
     -ms-user-select: none;
     -webkit-user-select: none;
   }
.dropdown-divider
{
    margin: 0 0.5rem 0 0;
}
img
{
	margin-top: -3px;
    margin-right: 0.25rem;
}
.readState
{
	background-color:#76737326 !important;
	color: #0000009e;
}
.alarmCard
{
	border: 0 solid rgba(0,0,0,.125);
    background-clip: border-box;
	background-color: #fff;
    border-radius: 0.5rem;
	margin: 0.5rem 1rem;
	width: unset;
	/* box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2); */
	box-shadow: 0 0 1px rgb(0 0 0 / 50%), 0 1px 3px rgb(0 0 0 / 30%);
}
.dropdown-item-title
{
	margin: 0.25rem 0;
}
 
</style>
<body class="hold-transition sidebar-mini layout-fixed" data-panel-auto-height-mode="height">
	<div class="wrapper" id="wrapper">
		<div hidden id="tempdiv"></div>
		<!-- Navbar -->
		<jsp:include page="/WEB-INF/views/eds/erp/global/head.jsp"></jsp:include>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="/WEB-INF/views/eds/erp/global/sidebar.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper iframe-mode" data-widget="iframe" data-loading-screen="750" id='frames' >
			<div class="nav navbar navbar-expand navbar-white navbar-light border-bottom p-0" style="">
			  <div class="nav-item dropdown" hidden="true">
				<a class="nav-link bg-danger dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Close</a>
				<div class="dropdown-menu mt-0">
				  <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all">Close All</a>
				  <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all-other">Close All Other</a>
				</div>
			  </div>
			  <a class="nav-link bg-light" href="#" data-widget="iframe-scrollleft"><i class="fas fa-angle-double-left"></i></a>
			  <ul class="navbar-nav overflow-hidden" role="tablist"></ul>
			  <a class="nav-link bg-light" href="#" data-widget="iframe-scrollright"><i class="fas fa-angle-double-right"></i></a>
			  <a class="nav-link bg-light" href="#" data-widget="iframe-fullscreen"><i class="fas fa-expand"></i></a>
			</div>
			<div class="tab-content" style=" padding: 0 0.5rem;">
			  <div class="tab-loading" style="background-color:#e9e7e2;">
				<div>
					<h2 class="display-4"><i class="fa fa-sync fa-spin"></i></h2>
				</div>
			  </div>
			  <div class="tab-pane fade active show" id="panel--eds-erp-global-selectMAINCONTENTView" role="tabpanel" aria-labelledby="tab--eds-erp-global-selectMAINCONTENTView">
				<iframe src="/eds/erp/global/selectMAINCONTENTView" style="height: 814px;"></iframe></div>
				</div>
		  </div>

		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%--
		-- 버전 때문에 그리드 숨겨짐
		----%>
		<%--<jsp:include page="/WEB-INF/views/eds/erp/global/footer.jsp"></jsp:include>--%>
		<aside class="control-sidebar control-sidebar-light">
			<!-- Control sidebar content goes here -->
		  <div class="p-3 control-sidebar-content os-host os-theme-light os-host-resize-disabled os-host-scrollbar-horizontal-hidden os-host-transition os-host-overflow os-host-overflow-y" style="height: 797px;"><div class="os-resize-observer-host observed"><div class="os-resize-observer" style="left: 0px; right: auto;"></div></div><div class="os-size-auto-observer observed" style="height: calc(100% + 1px); float: left;">
			<div class="os-resize-observer"></div>
		</div>
		<div class="os-content-glue" style="margin: -16px;"></div>
		<div class="os-padding">
			<div class="os-viewport os-viewport-native-scrollbars-invisible" style="overflow-y: scroll;">
				<div class="os-content" style="padding: 16px; height: 100%; width: 100%; background-color: #f5f6f8;">
					<!-- <button class="btn btn-sm btn-danger float-right " >삭제</button> -->
					<span style="font-weight: bold; font-size: 1.5rem;"><i class="fa-regular fa-envelope"></i> 알림</span>
					<span class="float-right"><button type="button" class="btn btn-sm btn-outline-default ml-3" style="" onclick="edsAlarm.allDeleteAlarm()"><i class="fa-solid fa-trash-can"></i></button><button type="button" class="btn btn-sm btn-block btn-outline-danger" style="" onclick="edsAlarm.checkDeleteAlarm()">삭제</button></span>

					<div class="form-inline">
						<div class="form-group" style="width: 100px;">
							<select name="subDivi" id="subDivi" >
								<option value="00">전체</option>
								<option value="01">결재중</option>
								<option value="02">결재취소</option>
								<option value="03">완료</option>
								<option value="04">반려</option>
							</select>
						</div>
						<div class="form-group" style="width: 100px;">
							<select name="stDivi" id="stDivi" >
								<optgroup label="그룹웨어">
									<option value="00">종류 전체</option>
									<option value="01">메세지</option>
									<option value="03">결재요청</option>
									<option value="04">참조</option>
								</optgroup>
								<optgroup label="성과기획">
									<option value="05">활동</option>
									<option value="07">코멘트</option>
								</optgroup>
								<optgroup label="발주서">
									<option value="08">요청</option>
									<option value="09">승인</option>
									<option value="10">반려</option>
								</optgroup>
								<optgroup label="견적서">
									<option value="11">요청</option>
									<option value="12">승인</option>
									<option value="13">반려</option>
								</optgroup>
							</select>
						</div>

					</div>

					<form id="checkAlarm" method="post" onsubmit="return false;">
						<div class="alarmDiv" id="alarmDiv" style="margin: 0 -16px;">

						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden">
			<div class="os-scrollbar-track">
				<div class="os-scrollbar-handle" style="transform: translate(0px, 0px); width: 100%;"></div>
			</div>
		</div>
		<div class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden">
			<div class="os-scrollbar-track">
				<div class="os-scrollbar-handle" style="transform: translate(0px, 0px); height: 61.6873%;">
				</div>
			</div>
		</div>
		<div class="os-scrollbar-corner">

		</div>
	</div>
</aside>
	</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true" data-backdrop="static"data-keyboard='false'>
			<div class="modal-dialog modal-dialog-resizable" role="document">
			<div class="modal-content card w-100">
				<div class="card-header" >
				<!-- <h5 class="modal-title" id="exampleModalLongTitle">공지사항</h5> -->
				<h3 class="card-title"><i class="fa-regular fa-envelope"></i> 신규메세지<span class="right badge badge-warning" id="newCount" style="margin-left: 5px;"></span></h3>
				<div class="card-tools">
					<button type="button" class="btn btn-tool" data-card-widget="maximize">
					<i class="fas fa-expand"></i>
					</button>
					<button type="button" class="btn btn-tool" onclick="notify()" >
					<i class="fas fa-times"></i>
					</button>
					</div>
				</div>
				<div class="card-body alarmDiv p-0" id="modalAlarm">
					
				</div>
				<div class="card-footer">
				<button type="button" class="btn btn-secondary float-right"onclick="notify()">닫기</button>
	
				</div>
			</div>
			</div>
		</div>
	<!-- ./wrapper -->
	<!-- Modal -->
	<script>
	const myModal = $('#exampleModalLong');
	let alarmDrop=document.getElementById('alarmDrop');
	$(document).ready(async function() {
		// 공통코드 셋팅
		// if(!checkStorage()) {
			var data = {
				corpCd: '<c:out value="${LoginInfo.corpCd}"/>'
			}
			setStorage(data)
			await setMenu();
			await edsAlarm.selectAlarm('alarmDiv',{});//알람창 데이터 이닛
			await commute(); // 출근 체크
			await edsAlarm.notialr();			
			document.querySelector("#stDivi").addEventListener('change', e => {
				let params ={}
				params.submitDivi=document.getElementById('subDivi').value;
				params.stateDivi=e.currentTarget.value;
				edsAlarm.selectAlarm('alarmDiv',params)
			});
			document.querySelector("#subDivi").addEventListener('change', e => {	
				let params ={}
				params.submitDivi=e.currentTarget.value;
				params.stateDivi=document.getElementById('stDivi').value;
				edsAlarm.selectAlarm('alarmDiv',params)
			});	
			document.querySelector("#alarmDrop").addEventListener('click', e => {	
				if(!alarmDrop.classList.contains('clicked'))
				{
					alarmDrop.classList.add('clicked')
					let params ={}
					params.submitDivi=document.getElementById('subDivi').value;
					params.stateDivi=document.getElementById('stDivi').value;
					edsAlarm.selectAlarm('alarmDiv',params)
				}
				else{alarmDrop.classList.remove('clicked')}

			});	
			//selectHome();
		});
		
	window.addEventListener("message", function(message) {
		if(message.data.messageDivi=='home')
		{
			document.getElementById(message.data.id).click(); //화면이동
		}
		return null;
	})
	

	
	const clientId = "<%=session.getId()%>"; // Replace with the actual client ID
	const eventSource = new EventSource("/notifications/"+clientId);
	eventSource.addEventListener("notification", async function (event) {
		let params ={}
		params.submitDivi=document.getElementById('subDivi').value;
		params.stateDivi=document.getElementById('stDivi').value;
		await edsAlarm.selectAlarm('alarmDiv',params);
    })
	eventSource.addEventListener("reset", async function (event) {
		reset();
    })

	//임시공지알람함수
	 async function notify(){
		return await new Promise(async (resolve, reject) => {
			Swal.fire({
				allowOutsideClick: false, // 배경 클릭으로 닫히지 않도록 설정
				text: "알림창을 닫으시겠습니까.",
				showCancelButton: true,
				confirmButtonText: "네",
				cancelButtonText: `아니오`,
			}). then(async (result) => {
			if (result.isConfirmed) {
				myModal.modal('hide')
				resolve();
				}
			else
			{
				
			}
			
				
			});
		});//promise end
	}
	function setCookie(key, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate()+expiredays);
		document.cookie = key + "="+escape(value)+";path=/;expires="+todayDate.toGMTString()+";"
	}	
	function getCookie(key){
		var	result=null;
		var	cookie=document.cookie.split(';');
		cookie.some(function(item){
		item=item.replace(' ','');
		var dic=item.split('=');
		if(key ===	dic[0]){
			result	=	dic[1];
			return	true;	// break;
		}
		});
		return	result;
	}	
	/**
	 * 출근 처리
	 * @return 출근을 처리해준다. 
	 * */
	async function commute(){
		return await new Promise(async (resolve, reject) => {
		var params = {
			corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
			empCd: '<c:out value="${LoginInfo.empCd}"/>',
			stDt: moment().format('YYYY-MM-DD%'),
		}
		$.ajax({
			url: "/LOGIN/selectCommute",
			type: "POST",
			data: params,
			async: false,
			success: async function(result){
				if(result.data === 0){
					Swal.fire({
						title: "출근 처리하시겠습니까?",
						showCancelButton: true,
						confirmButtonText: "네",
						cancelButtonText: `아니오`,
					}).then((result) => {
					if (result.isConfirmed) {
							var param = {};
							param.status = 'C';
							param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
							param.busiCd = '<c:out value="${LoginInfo.busiCd}"/>';
							param.stDt = moment().format('YYYY-MM-DD HH:mm:00');
							param.edDt = moment().format('YYYY-MM-DD HH:mm:00');
							param.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
							param.empCd = '<c:out value="${LoginInfo.empCd}"/>';
							param.note = '';

							$.ajax({
								url: "/COMMUTE_LOG/cudCommuteLogList",
								headers: {
									'X-Requested-With': 'XMLHttpRequest'
								},
								dataType: "json",
								contentType: "application/json; charset=UTF-8",
								type: "POST",
								async: false,
								data: JSON.stringify(param),
								success: async function(rst){
									var status = rst.status;
									var note = rst.note;
									var exc = rst.exc;
									if(status === 'success'){
										// await doAction('gumaeGridEmail','search');
										Swal.fire({
											icon: 'success',
											title: '출근 처리되었습니다.',
										});
									}else{
										Swal.fire({
											icon: 'error',
											title: '실패',
										})
									}
								}
							});
						}
						resolve();
					});
				}
				else
				{
					resolve();
				}
				}
			});
		});//promise end
	}
	async function setMenu()
	{
		return await new Promise(async (resolve, reject) => {
		// 사이드바 메뉴리스트 셋팅
		var objmenu, objmenulist;
		var params = {
			corpCd: '<c:out value="${LoginInfo.corpCd}"/>'
		}
		await $.ajax({
			url: "/eds/erp/global/selectMENU",
			type: "POST",
			data: params,
			async: false,
			success: function(result){
				objmenu = result.data;
			}
		});

		$.ajax({
			url: "/eds/erp/global/selectMENUList",
			type: "POST",
			data: params,
			async: false,
			success: function(result){
				objmenulist = result.data;
				sessionStorage.setItem('objmenulist', JSON.stringify(objmenulist) );
			}
		});

		if(objmenu.length >0){
			var sidebarmunulist = "";
			
			 for(var i=0; i<objmenu.length; i++){
				var rink ='#'
				
				sidebarmunulist="<li class='nav-item'>"+
							"<a href="+rink+" class='nav-link'>"+
							"<i class='"+objmenu[i].menuIcon+"'></i>"+
							"<p>"+objmenu[i].menuNm+"<i class='right fas fa-angle-left'></i></p>"+
							"</a>"+
							"<ul class='nav nav-treeview'>";
					
				for(var j=0; j<objmenulist.length; j++){
					if(objmenu[i].menuId == objmenulist[j].menuId && objmenulist[j].parent==null){	
						let count=0;
							for(var K=0; K<objmenulist.length; K++){
								
								if(objmenulist[j].pgmId == objmenulist[K].parent){
									if(count==0)
									{
										sidebarmunulist +=
										"<li class='nav-item'>"+
										"<a href='"+objmenulist[j].pgmUrl+"' class='scnavlink nav-link' id='" +objmenulist[j].pgmId +"' style='padding-top: 0.2rem; padding-bottom: 0.2rem;'>&nbsp;&nbsp;&nbsp;<p>" +objmenulist[j].pgmNm +"<i class='right fas fa-angle-left' style='top:0.4rem'></i></p></a>"+
											"<ul class='nav nav-treeview'>"+
												"<li class='nav-item'>"+
													"<a href='"+objmenulist[K].pgmUrl+"' class='nav-link' id='" +objmenulist[K].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;' id='"+objmenulist[K].pgmId+"'>&nbsp&nbsp;&nbsp;&nbsp;&nbsp;<p>" +objmenulist[K].pgmNm +"</p></a>"+
													//"<a href='"+objmenulist[j].pgmUrl+"' class='nav-link' id='" +objmenulist[j].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;'>&nbsp;&nbsp;&nbsp;<i class='" +objmenulist[j].pgmIcon +"'></i>&nbsp;<p>" +objmenulist[j].pgmNm +"</p></a>"+
												"</li>";
									}
									else
									{
										sidebarmunulist +=
											"<li class='nav-item'>"+
												"<a href='"+objmenulist[K].pgmUrl+"' class='nav-link' id='" +objmenulist[K].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;' id='"+objmenulist[K].pgmId+"'>&nbsp&nbsp;&nbsp;&nbsp;&nbsp;<p>" +objmenulist[K].pgmNm +"</p></a>"+
												//"<a href='"+objmenulist[j].pgmUrl+"' class='nav-link' id='" +objmenulist[j].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;'>&nbsp;&nbsp;&nbsp;<i class='" +objmenulist[j].pgmIcon +"'></i>&nbsp;<p>" +objmenulist[j].pgmNm +"</p></a>"+
											"</li>";
									}
									count++;
								}
								}	
						if(count!=0)
						{
							sidebarmunulist+="</ul>";
						}
						else
						{
							sidebarmunulist +=
								"<li class='nav-item'>"+
									"<a href='"+objmenulist[j].pgmUrl+"' class='nav-link' id='" +objmenulist[j].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;' id='"+objmenulist[j].pgmId+"'>	&nbsp;&nbsp;&nbsp;<p>" +objmenulist[j].pgmNm +"</p></a>";
						}
						
						sidebarmunulist+="</li>";
					}

				}

				sidebarmunulist += "</ul></li>";
				$('#menulist').append(sidebarmunulist);
			}
			resolve();
			// $('#documents').append("<li class='header'>LABELS</li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-red'></i> <span>Important</span></a></li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-yellow'></i> <span>Warning</span></a></li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-aqua'></i> <span>Information</span></a></li>");

		}
		})
	}

	/** table 팝업창
	 * */
	 async function popupHandler(name,divi,params,callback){
			var names = name.split('_');
			switch (names[0]) {
				case 'edmsDoc':{
					if(divi==='open'){
						params.name= name;
						await edsIframe.openPopupEdms('EDMSDOCPOPUP',params)
					}else{
						let params ={}
						params.submitDivi=document.getElementById('subDivi').value;
						params.stateDivi=document.getElementById('stDivi').value;
						await edsAlarm.selectAlarm('alarmDiv',params);
					}
				}
				break;		
				case 'edmsTemp':{
					if(divi==='open'){
						params.name= name;
						await edsIframe.openPopupEdms('EDMSTEMPPOPUP',params)
					}else{
						let params ={}
						params.submitDivi=document.getElementById('subDivi').value;
						params.stateDivi=document.getElementById('stDivi').value;
						await edsAlarm.selectAlarm('alarmDiv',params);
					}
				}
				break;
				case 'edmsConf':{
					if(divi==='open'){
						params.name= name;
						await edsIframe.openPopupEdms('EDMSCONFPOPUP',params)
					}else{
						let params ={}
						params.submitDivi=document.getElementById('subDivi').value;
						params.stateDivi=document.getElementById('stDivi').value;
						await edsAlarm.selectAlarm('alarmDiv',params);
					}
				}	
				break;	
			}
		}

	
</script>

</body>
</html>