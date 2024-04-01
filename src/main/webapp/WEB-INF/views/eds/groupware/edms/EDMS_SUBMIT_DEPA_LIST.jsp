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

			/* 그리드생성 */

			/* 조회 */
			addSubmitEl('homeTimeLine');
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
						case 'edmsConf':{
							if(divi==='open'){
								params.name= name;
								await edsIframe.openPopupEdms('EDMSCONFPOPUP',params)
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
		async function addSubmitEl(target)
		{
			var param = {};
			param.submitNm=document.getElementById('searchNm').value;
			param.docDivi=document.getElementById('docDivi').value;
			param.edmsDivi='09';
			param.stDt=document.getElementById('stDt').value;
			param.edDt=document.getElementById('edDt').value;
		    let reqData = edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitReqList", param); // 데이터 set
			let targetEl=document.getElementById(target);
			targetEl.innerHTML='';
			let strEL='';
			let posiCode=getCommCode('SYS004');
			let respCode=getCommCode('SYS003');
			let projNmCode=getCommCode('COM027');
			let iconCode=getIconCode('COM027');
			let checkTimeBar={};
			for(const data of reqData)
			{	
				//얼굴이미지
				var corpCd = data.inpCorpCd;//회사코드
				var saveNm = data.saveNm;//저장명
				var ext = data.ext;//확장자
				var src = "/BASE_USER_MGT_LIST/selectUserFaceImage/" + corpCd+":"+saveNm+":"+ext;
				let completeDate = ""
				if(data.completeDt)
				{
					completeDate=data.completeDt.substr(0, 10);
				}
				
				//시간바
				if(!checkTimeBar[completeDate]){
					let timeData=`<div class="time-label" id='`+completeDate+`''>
						<span class="bg-gray w-100 ">`+completeDate+`</span>
					</div>`
					checkTimeBar[completeDate]=true;
					strEL+=timeData;
				}

				//유저row
				let userDate=
					`<div>	
						<div class="fas icheck-blue d-inline img-circle ">
                        	<input type="checkbox" id="`+data.submitCd+`" value='`+data.currApproverCd+`' submitNm='`+data.submitNm+`'>
                        	<label for="`+data.submitCd+`">
                        	</label>
                      	</div>	
						<div class="timeline-item">
							<div class="info-box hoverBox" style="flex-wrap:wrap; min-height:50px" doc="`+data.submitCd+`" busi="`+data.busiCd+`" onclick=addEDMSclikcEventtarget(this,`+data.submitDivi+`,`+data.docDivi+`)>
							<div class="col-12 col-md-4 p-1">
								<div class='row p-1' style='flex-wrap: nowrap;'>
									<div class="pr-1 pl-1 m-auto" style="max-width:80px" data:'1000sss'>
										<div class="text-center">
											<i class="mainIcon `+iconCode[data.docDivi]+`"></i>
										</div>
										<span class="info-box-text text-sm">`+projNmCode[data.docDivi]+`</span>
									</div>
									<div class="col overflow-hidden col-9">
										<span class="info-box-text"><b>`+data.submitNm+`</b></span>
										<span class="info-box-text text-sm">결재완료일:`+data.completeDt+`</span>
									</div>
								</div>
							</div>
							<div class="col-12 col-md-4 p-1">
								<div class='row flex-nowrap p-1'>
									<div class="image" style="padding: 0.5rem 0.5rem; ">
										<img class="img-circle elevation-2 " alt="User Image" id="userFace" style="height: 2.1rem; width: 2.1rem" src='`+src+`' onerror="this.src='/login/img/usersolid.jpg'">
							  		</div>
									<div class="col overflow-hidden" >
										<span class="info-box-text"><b>`+data.inpNm+`</b></span>
										<span class="info-box-text text-sm">`+data.inpCorpNm+`>`+data.inpBusiNm+`>`+data.depaNm+`>`+posiCode[data.posiDivi]+`>`+respCode[data.respDivi]+`</span>
									</div>
								</div>
							</div>
							<div class="ml-auto p-1 text-right overflow-hidden">
								<div class= "row float-right flex-nowrap overflow-auto w-100" style=" margin: 0;">
								`+initApprovers(data.currApproverCd,data.appUsers,data.appUsersName,data.submitDivi)+`
								</div>
							  </div>
							</div>
						</div>
					</div>`
				// let userDate=					
				// 	`<div class="col-sm-12">
	
				// 	</div>`;


				strEL+=userDate;
			}
			targetEl.innerHTML=strEL;
		}
		function initApprovers(nowApprover,approvers,approversName,submitDivi)
		{
			if(!approvers) return ;
			let appList=approvers.split(',')
			let nameList=approversName.split(',')
			let stanEl='';
			let stan=false;
			for(const data in appList)
			{
				if(appList[data]==nowApprover&&submitDivi=='01')
				{
					stan=true;
					stanEl+=`
					<div class="pr-1 pl-1 m-auto">
						<div class="text-center">
							<i class="rowIcon fa fa-pencil bg-blue"></i>
						</div>
						<span class="info-box-text text-blue">`+nameList[data]+`</span>
					</div>`
				}
				else
				{
					if(stan==false)
					{
						stanEl+=`
						<div class="pr-1 pl-1 m-auto">
							<div class="text-center">
								<i class="smallIcon fa fa-check bg-green"></i>
							</div>
							<span class="info-box-text text-sm">`+nameList[data]+`</span>
						</div>`
					}
					else
					{
						stanEl+=`
						<div class="pr-1 pl-1 m-auto">
							<div class="text-center">
								<i class="smallIcon fa  fa-pause "></i>
							</div>
							<span class="info-box-text text-sm ">`+nameList[data]+`</span>
						</div>`
					}
				}
				if(data!=(appList.length-1))
				{
					stanEl+=`
					<div class="pr-1 pl-1 m-auto">
						<span class="info-box-text text-sm">></span>
					</div>`
				}
			}
			return stanEl;
		}
		async function approveDoc()
		{
			let form=document.getElementById('test');
			let data =ut.serializeObject(form);
			let params=[];
			for (const [key, value] of Object.entries(data)) {
				let obj={};
				obj.submitCd=key;
				obj.currApproverCd=value
				obj.submitNm=document.getElementById(key).getAttribute('submitNm');
				params.push(obj);
			}
			if(params.length>0)
			{
				const check=await edsEdms.approveSubmit(params);
				if(check)
				{
					addSubmitEl('homeTimeLine');
				};
			}
			else
			{
				return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '선택된 결재가 없습니다.',
						});
			}
		}
		async function addEDMSclikcEventtarget(target,submitDivi,docDivi)
		{
			let param = {};
			param.submitCd=target.getAttribute('doc');
			param.busiCd=target.getAttribute('busi');
			param.submitNm=document.getElementById(target.getAttribute('doc')).getAttribute('submitNm');
			if(submitDivi=='02'||submitDivi=='04')
			{
				if(docDivi=='01')param.url="/EDMS_EST_REPORT_CONF_VIEW"
				else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_CONF_VIEW"
				else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_CONF_VIEW"
				else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_CONF_VIEW"
				else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='11')param.url="/EDMS_PROJECT_UPDATE_REPORT_CONF_VIEW"
				else {return ;}
				await popupHandler('edmsConf','open',param)
			}
			else
			{
				if(docDivi=='01')param.url="/EDMS_EST_REPORT_CONF_VIEW"
				else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_CONF_VIEW"
				else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_CONF_VIEW"
				else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_CONF_VIEW"
				else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
				else if(docDivi=='11')param.url="/EDMS_PROJECT_UPDATE_REPORT_CONF_VIEW"
				else {return ;}
				await popupHandler('edmsConf','open',param)
			}

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

<body class="h-auto" style="min-height: calc(100% - 4.25rem);">
	<div style="position:relative">

		<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id='navHeightBar' style>
			<a class="navbar-brand" href="#"><h3>부서문서함</h3></a>
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
				<div class="input-group mb-2 mr-2">
					<label for="stDt">조회기간 &nbsp;</label>
					<div class="input-group-prepend">
						<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="stDt" id="stDt" title="끝">
					</div>
					<span>&nbsp;~&nbsp;</span>
					<div class="input-group-append">
						<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="edDt" id="edDt" title="끝">
					</div>
				</div>
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
					<!-- <button type="button" class="btn btn-sm btn-primary " name="btnSearch" id="btnSearch" onclick="approveDoc()"><i class="fa fa-"></i> 일괄승인</button> -->
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
					<div class="col-sm-12">
						<div class="card min-h-edms">
							<div class="card-header border-0">
								
								<h3 class="card-title">부서별 결재완료문서</h3>
								<div class="card-tools">
									<button type="button" class="btn btn-tool" data-card-widget="collapse">
									  <i class="fas fa-minus"></i>
									</button>
									<button type="button" class="btn btn-tool" data-card-widget="remove">
									  <i class="fas fa-times"></i>
									</button>
								</div>
							</div>
							<div class="card-body" >
								<form  name="test" id="test" method="post" onsubmit="return false;">
									<div class="timeline" id="homeTimeLine">
									</div>
								</form>
							</div>
						</div>
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