<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><!-- DOCTYPE 및 태그라이브러리정의 -->
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><!-- 공통헤드 -->
<%@ include file="/WEB-INF/views/comm/common-include-url.jspf"%><!-- 공통 Content-Security-Policy -->
<!-- Google Font: Source Sans Pro -->
<link  rel="stylesheet preload"  as="style" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="/AdminLTE_main/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/AdminLTE_main/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet" href="/AdminLTE_main/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- jQuery -->
<script src="/AdminLTE_main/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/AdminLTE_main/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<!-- jQuery inputmask -->
<script type="text/javascript" src='/AdminLTE_main/plugins/inputmask/jquery.inputmask.js'></script>
<script type="text/javascript" src='/js/com/eds.common.js?curr=<c:out value="${common_include_js_curr}" />'></script>
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- 공통코드 Enum, EnumKeys 관련 모듈 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src='/js/com/common.js'></script>
<script type="text/javascript" src='/js/com/commonCode.js'></script>
<!-- Bootstrap 4 -->
<script src="/AdminLTE_main/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- overlayScrollbars -->
<script src="/AdminLTE_main/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE_main App -->
<script src="/AdminLTE_main/dist/js/adminlte.js"></script>
</head>
<style>
	a[class="nav-link active"]{
		background-color: #6d5544 !important;
		font-weight: 600;
	}
</style>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper" id="wrapper">

		<!-- Navbar -->
		<jsp:include page="/WEB-INF/views/eds/erp/global/head.jsp"></jsp:include>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="/WEB-INF/views/eds/erp/global/sidebar.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper iframe-mode" data-widget="iframe" data-loading-screen="750">
			<div class="nav navbar navbar-expand navbar-white navbar-light border-bottom p-0" style="background-color: #d9d7cc!important;">
			  <div class="nav-item dropdown">
				<a class="nav-link bg-danger dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Close</a>
				<div class="dropdown-menu mt-0">
				  <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all">Close All</a>
				  <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all-other">Close All Other</a>
				</div>
			  </div>
			  <a class="nav-link" href="#" data-widget="iframe-scrollleft" style="background-color: #6d5544;"><i class="fas fa-angle-double-left"></i></a>
			  <ul class="navbar-nav overflow-hidden" role="tablist"></ul>
			  <a class="nav-link" href="#" data-widget="iframe-scrollright" style="background-color: #6d5544;"><i class="fas fa-angle-double-right"></i></a>
			  <a class="nav-link" href="#" data-widget="iframe-fullscreen" style="background-color: #6d5544;"><i class="fas fa-expand"></i></a>
			</div>
			<div class="tab-content">
			  <div class="tab-empty">
				<h2 class="display-4">No tab selected!</h2>
			  </div>
			  <div class="tab-loading" style="background-color:#e9e7e2;">
				<div>
				  <h2 class="display-4" style="height: auto;"><i class="fa fa-sync fa-spin"></i></h2>
				</div>
			  </div>
			</div>
		  </div>

		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%--
		-- 버전 때문에 그리드 숨겨짐
		----%>
		<%--<jsp:include page="/WEB-INF/views/eds/erp/global/footer.jsp"></jsp:include>--%>
	</div>
	<!-- ./wrapper -->

	<script>
	$(document).ready(function() {
		// 공통코드 셋팅
		// if(!checkStorage()) {
			var data = {
				corpCd: '<c:out value="${LoginInfo.corpCd}"/>'
			}
			setStorage(data)
		// };

		// 사이드바 메뉴리스트 셋팅
		var objmenu, objmenulist;
		var params = {
			corpCd: '<c:out value="${LoginInfo.corpCd}"/>'
		}
		$.ajax({
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
				sidebarmunulist="<li class='nav-item'>"+
							"<a href='#' class='nav-link'>"+
							"<i class='"+objmenu[i].menuIcon+"'></i>"+
							"<p>"+objmenu[i].menuNm+"<i class='right fas fa-angle-left'></i></p>"+
							"</a>"+
							"<ul class='nav nav-treeview'>";

				for(var j=0; j<objmenulist.length; j++){
					if(objmenu[i].menuId == objmenulist[j].menuId){
						sidebarmunulist +=
								"<li class='nav-item '>"+
									"<a href='"+objmenulist[j].pgmUrl+"' class='nav-link' id='" +objmenulist[j].pgmId +"' style='padding-top: 2px; padding-bottom: 2px;'>&nbsp;&nbsp;&nbsp;<i class='" +objmenulist[j].pgmIcon +"'></i>&nbsp;<p>" +objmenulist[j].pgmNm +"</p></a>"+
								"</li>";
					}
				}

				sidebarmunulist += "</ul></li>";
				$('#menulist').append(sidebarmunulist);
			}

			// $('#documents').append("<li class='header'>LABELS</li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-red'></i> <span>Important</span></a></li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-yellow'></i> <span>Warning</span></a></li>");
			// $('#documents').append("<li><a href='#'><i class='fa fa-circle-o text-aqua'></i> <span>Information</span></a></li>");
		}
		selectAlarm();//알람창 데이터 이닛
	});
	const clientId = '<c:out value="${LoginInfo.empCd}"/>'; // Replace with the actual client ID
	const eventSource = new EventSource("/notifications/"+clientId);
	eventSource.addEventListener("notification", function (event) {
		selectAlarm();
	   console.log('tes');
    })
	
	async function selectAlarm(){
		
		var alarmDiv=document.getElementById('alarmDiv');
		var alarmCount=document.getElementById('alarmCount');
		alarmDiv.innerHTML='';
		var param = [];
		var data={};
		data.corpCd='1001'
		param.push(data);
		var test = await edsUtil.getAjax("/ALARM_REG/selectAlarmList", data)
		
		for(var i=0; i<test.length; i++){
			var corpCd = test[i].corpCd;//회사코드
			var saveNm = test[i].saveNm;//저장명
			var ext = test[i].ext;//확장자

			// var src = "/file/1001/user/face/"+ saveNm+".jpg";

			var src = "/BASE_USER_MGT_LIST/selectUserFaceImage/" + corpCd+":"+saveNm+":"+ext;

			var initDiv="<a href='#'' class='dropdown-item'>"+
            		"<!-- Message Start -->"+
            		"<div class='media'>"+
              		"<img src='"+src+"'' alt='User Avatar' class='img-size-50 mr-3 img-circle'>"+
              		"<div class='media-body'>"+
                	"<h3 class='dropdown-item-title'>"+test[i].empNm+
                  	"<span class='float-right text-sm text-danger'><i class='fas fa-star'></i></span>"+
                	"</h3>"+
                	"<p class='text-sm'>"+test[i].message+"</p>"+
                	"<p class='text-sm text-muted'><i class='far fa-clock mr-1'></i> 4 Hours Ago</p>"+
              		"</div>"+
            		"</div>"+
            		"<!-- Message End -->"+
          			"</a>"+
          			"<div class='dropdown-divider'></div>";
			alarmDiv.innerHTML=alarmDiv.innerHTML+initDiv;
			}
		alarmCount.innerHTML=test.length;
	}
</script>

</body>
</html>