<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<!-- overlayScrollbars -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
	<!-- iCheck for checkboxes and radio inputs -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/icheck-bootstrap/icheck-bootstrap.css">
	<!-- fontAwesome -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/fontawesome-free/css/all.min.css">
	<!-- AdminLte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<!-- overlayScrollbars -->
	<script src="/css/AdminLTE_main/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE_main App -->
	<script src="/css/AdminLTE_main/dist/js/adminlte.js"></script>

	<style>
		.card:hover
		{
			box-shadow: 0 0 5px rgba(60,140,187, 0.5), 0 1px 3px rgba(0,0,0,.2);
		}
		.info-box.hoverBox:hover
		{
			box-shadow: 0 0 5px rgba(60,140,187, 0.5), 0 1px 3px rgba(0,0,0,.2);
		}
		.btn-primary
		{
			color: #fff;
			background-color: #544e4c;
    		border-color: #544e4c;
			box-shadow: none;
		}
		.btn-primary :hover
		{
			color: #fff;
			background-color: #4f5962;
			border-color: #525D6B;
		}
	</style>

	<script>
		let select
		$(document).ready(function () {
			init();
		});
		/* 초기설정 */
		async function init() {

			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "edms");

			/* 이벤트 셋팅 */
			selectHome();

			/* 그리드생성 */

			/* 조회 */
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
				
			
		

		/**********************************************************************
		 * 화면 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 START
		 ***********************************************************************/
			/** table 팝업창
			 * */
			async function popupHandler(name,divi,params,callback){
					var names = name.split('_');
					switch (names[0]) {
						case 'busi':
							if(divi==='open'){
								var param={}
								param.corpCd= document.getElementById('corpCd').value;
								param.busiNm=  document.getElementById('busiNm').value;
								param.name= name;
								await edsIframe.openPopup('BUSIPOPUP',param)
							}else{
								document.getElementById('busiCd').value=callback.busiCd;
								document.getElementById('busiNm').value=callback.busiNm;
								const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
								data.messageDivi='insert';
								document.getElementById("iframSubmit").contentWindow.postMessage(data);			
							}
						break;
						case 'approver':{
							if(divi==='open'){
								var param={}
									param.corpCd= document.getElementById('corpCd').value;
									param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
									param.name= name;
								await edsIframe.openPopup('SUBMITUSERPOPUP',param)
							}else{
								addUser(callback,'approver');
							}
						}
						break;		
						case 'ccUser':{
							if(divi==='open'){
								var param={}

									param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
									param.name= name;
								await edsIframe.openPopup('SUBMITUSERPOPUP',param)
							}else{
								addUser(callback,'ccUser');
							}
						}
						break;	
						case 'edmsDoc':{
							if(divi==='open'){
								params.name= name;
								await edsIframe.openPopupEdms('EDMSDOCPOPUP',params)
							}else{
								
							}
						}
						break;		
						case 'edmsTemp':{
							if(divi==='open'){
								params.name= name;
								await edsIframe.openPopupEdms('EDMSTEMPPOPUP',params)
							}else{
								
							}
						}	
						break;	
					}
				}
	

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/
		async function selectHome()
		{
			var param ={}; //조회조건
			let data=edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectHomeList", param);
			for (const [key, value] of Object.entries(data[0])) {
				if(document.getElementById(key))document.getElementById(key).innerHTML = value+'건';
			}
		}
		function sendHome(id)
		{
			const data= {};			
			data.messageDivi='home';//
			data.id=id;
			window.parent.postMessage(data);
		}

	
		// if(parent) {//부모 iframe 과통신
		// 	//수신 이벤트 발생 
		// 	window.addEventListener("message", async function(message) {
		// 		console.log('message')
		// 	})}


		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body class="h-auto"style="min-height: calc(100% - 4.25rem);">
	<div style="position:relative">

		<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id='navHeightBar' style>
			<a class="navbar-brand" href="#"><h3>결재홈</h3></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="tebs">
				<ul class="navbar-nav mr-auto">
				<!-- <li class="nav-item active">
				  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item">
				  <a class="nav-link" href="#">Features</a>
				</li>
				<li class="nav-item">
				  <a class="nav-link" href="#">Pricing</a>
				</li>
				<li class="nav-item">
				  <a class="nav-link" href="#">About</a>
				</li> -->
			  </ul>
			  
			  <form class="form-inline" id="searchForm"  name="searchForm" onsubmit="return false;"> 
				<div class="input-group mr-2 mb-2">
					<label>기안양식 &nbsp;</label>
					<div class="input-group-prepend" style="min-width: 200px;">
						<select class="form-control select2" style="width: 100%;" name="docDivi" id="docDivi" >
						</select>
					</div>
					<!-- <div class="select2-blue">
					  <select class="select2"multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-blue" style="width: 100%;" name="depaCd" id="depaCd">
					  </select>
					</div> -->
				</div>
				<div class="input-group mr-2 mb-2">
					<input class="form-control" type="text" placeholder="문서명 검색"  id='searchNm' onkeyup="if(window.event.keyCode==13){addSubmitEl('homeTimeLine')}">
					<span class="input-group-append mr-1">
						<button class="btn btn-outline-dark"  type="button" onclick="addSubmitEl('homeTimeLine')">검색</button>
					</span>
					<button type="button" class="btn btn-sm btn-primary " name="btnSearch" id="btnSearch" onclick="approveDoc()"><i class="fa fa-"></i> 일괄승인</button>
				</div>	
			  </form>
			</div>
		  </nav>
		<!-- <section class="content-header" style="margin-top: calc(3.5rem + 1px);">
			<div class="container-fluid">
				<div class="row mb-2">
				  <div class="col-sm-12">
					<h3>HOME</h3>
				  </div>
				  <div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
					  <li class="breadcrumb-item"><a href="#">Home</a></li>
					  <li class="breadcrumb-item active">Advanced Form</li>
					</ol>
				  </div> 
				</div>
			  </div>
		</section> -->
		<section class="content" id="printid" style="margin-top: calc(4.25rem);">
			<div class="container-fluid">
				<div class="row" >
					<div class="col-6 col-sm-3">
						<div class="small-box bg-lightblue">
							<div class="inner">
							  <h3 id="longUnSubmit">0건</h3>
			  
							  <p>7일이상 지연된 결제</p>
							</div>
							<div class="icon">
							  <i class="fa-solid fa-exclamation-triangle"></i>
							</div>
							<a onclick="sendHome('130')" href="#" class="small-box-footer">
							  바로가기 <i class="fas fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					
					<div class="col-6 col-sm-3">
						<div class="small-box bg-lightblue">
							<div class="inner">
							  <h3 id="unSubmit">0건</h3>
			  
							  <p>확인하지 않은 결재수신</p>
							</div>
							<div class="icon">
								<i class="fa-solid fa-file-circle-exclamation"></i>
							</div>
							<a onclick="sendHome('130')" href="#" class="small-box-footer">
							  바로가기 <i class="fas fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					<div class="col-6 col-sm-3">
						<div class="small-box bg-lightblue">
							<div class="inner">
							  <h3 id="unCc">0건</h3>
			  
							  <p>확인하지 않은 수신참조</p>
							</div>
							<div class="icon">
							  <i class="fa-solid fa-file-circle-exclamation"></i>
							</div>
							<a onclick="sendHome('132')" href="#" class="small-box-footer">
							  바로가기 <i class="fas fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					<div class="col-6 col-sm-3">
						<div class="small-box bg-lightblue">
							<div class="inner">
							  <h3 id="completeSubmit">0건</h3>
			  
							  <p>결재내역보기</p>
							</div>
							<div class="icon">
								<i class="fa-solid fa-file-circle-check"></i>
							</div>
							<a onclick="sendHome('134')" href="#" class="small-box-footer">
							  바로가기 <i class="fas fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					<div class="col-sm-12">

					</div>

				</div>
			</div>
		</section>
	</div>
</body>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
<script type="text/javascript" src='/js/com/eds.edms.js'></script>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>