<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<%@ page import="java.util.*"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<!DOCTYPE html>
<html>
<head>
	<!-- Select2 -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css" />
	<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>	
	<script type="text/javascript" src='/js/com/eds.edms.js'></script>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
	<script src="/css/smarteditor/js/HuskyEZCreator.js"></script>
	<!-- adminlte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<style>

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
		body {

		width: 100%;

		height: auto;

		margin: 0;

		padding: 0;

		}

		* {

		box-sizing: border-box;

		-moz-box-sizing: border-box;

		}
		.paper {

		width: 210mm;

		min-height: 297mm;

		padding: 10mm;

		margin: 10mm auto;

		border-radius: 5px;


		box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);

		border: 2px #fff solid;

		}
		.eeeeeee {

		padding: 0;

		border: 1px #888 solid;

		height: auto;
		

		}


		@page {

		size: A4;

		margin: 0;

		}

		@media print {
		
		html, body {
		
			width: 210mm;
		
			height: 297mm;
		
			background: #fff;
		
		}

		.paper {
		
			margin: 0;
		
			border: initial;
		
			border-radius: initial;
		
			width: initial;
		
			min-height: initial;
		
			box-shadow: initial;
		
			background: initial;
		
			page-break-after: always;
		
		}

}
	</style>
</head>

<body>
<div style="position:relative" id="printid">
	<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id="navt">
		<a class="navbar-brand" href="#"><h3>품의서</h3></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="#tebs" aria-expanded="false" aria-label="Toggle navigation">
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
		  <form class="form-inline">
			<div class="input-group">
				<div class="float-right ml-auto">
					<div class="container">
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSave" id="btnSave" onclick="btnEvent('save')"><i class="fa fa-solid fa-share"></i> 기안상신</button>
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnTempSave" id="btnTempSave" onclick="btnEvent('tempSave')"><i class="fa fa-solid fa-share"></i> 임시저장</button>
						<button type="button" class="btn btn-sm btn-primary mr-1 "name="btnCancel" id="btnCancel" onclick="btnEvent('cancel')"><i class="fa fa-solid fa-share"></i> 삭제</button>
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnClose" id="btnClose" onclick="btnEvent('close')"><i class="fa fa-close"></i> 닫기</button>
					</div>
				</div>
			</div>	
		  </form>
		</div>
	  </nav>

	<section class="content" id="printtest" style="margin-top: calc(4.25rem); ">
		<div class="container-fluid" >
			<div class="row" >
				<div class="col-md-12">
					<div class="card">
						<!-- form start -->
						<form class="form-horizontal" id="submitInfo">

							  <!-- /.card-body -->
						</form>
					</div>
				</div>
				<div class="col-md-12">
					<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="custCd" id="custCd" value="">
						<input type="hidden" id="currApproverCd" >
						<input type="hidden" id="docDivi">
						<input type="hidden" id="inpId" >
						<input type="hidden" name="submitDivi" id="submitDivi" title="기안상신코드">
						<div class="card">
							<!-- form start -->
							<div class="card-body">
								<div class="form-group row">
									<label for="busiNm" class="col-sm-2 col-form-label">계열사</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="busiNm" readonly>
									</div>
								</div>
								<div class="form-group row">
								  <label for="submitNm" class="col-sm-2 col-form-label">문서명</label>
								  <div class="col-sm-10">
									<input type="text" class="form-control" id="submitNm" required >
								  </div>
								</div>
								<div class="form-group row">
									<label for="submitDt" class="col-sm-2 col-form-label">작성일자</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="submitDt" readonly >
									</div>
								</div>
								<div class="form-group row">
									<label for="inpNm" class="col-sm-2 col-form-label">기안자</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="inpNm" readonly>
									</div>
								</div>
								<div class="form-group row">
									<label for="appUsers" class="col-sm-2 col-form-label">결재자   <i class="fa-solid fa-user-plus fa-beat" onclick="popupHandler('appUsers','open'); return false;"></i></label>
									<div class="col-sm-10" >
									  <div class="select2-info">
										<select class="select2" multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-purple" style="width: 100%;" id="appUsers" disabled>
										</select>
									  </div>
									</div>
								</div>
								<div class="form-group row">
									<label for="ccUsers" class="col-sm-2 col-form-label">참조자   <i class="fa-solid fa-user-plus fa-beat" onclick="popupHandler('ccUsers','open'); return false;"></i></label>
									<div class="col-sm-10">
										<div class="select2-info" >
										  <select class="select2" multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-purple" style="width: 100%;" id="ccUsers" disabled>
										  </select>
										</div>
									  </div>
								</div>
							</div>
						</div>
						<div class="card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title" style="">문서정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="row">
									<div class="col-sm-6">
										<div class="form-group">
											<label>업무담당</label>
											<select class="form-control select2" style="width: 100%;"name="empCd" id="empCd" >
											</select>
											<!-- <div class="select2-blue">
											<select class="select2"  multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-blue" style="width: 100%;" name="empCd" id="empCd">
											</select>
											</div> -->
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label>담당부서</label>
											<select class="form-control select2" style="width: 100%;" name="depaCd" id="depaCd" >
											</select>
											<!-- <div class="select2-blue">
											<select class="select2"multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-blue" style="width: 100%;" name="depaCd" id="depaCd">
											</select>
											</div> -->
										</div>
										<!-- /.form-group -->
									</div>
								</div>
							</div>
						</div>	
						<div class="row">
							<div class="col-md-12">
							  <div class="card card-outline card-info">
								<div class="card-header">
								  <h3 class="card-title">
									  <label class="card-title" style="">품의서</label>
								  </h3>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
								  <textarea name ="editerArea" id="editerArea" class="w-100"  rows="20">
								  </textarea>
								</div>
								<div class="card-footer">
								   <a href="https://github.com/summernote/summernote/">Eds</a>품의내용을 작성하세요.
								</div>
							  </div>
							</div>
							<!-- /.col-->
						</div>
						<button class="btn btn-sm btn-primary" name="submitbtn" id="submitbtn" type="submit" hidden ></button>
					</form>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-12">
							<div class="card card card-lightblue card-outline">
								<div class="card-header">
									<label class="card-title">첨부파일 <small><em>파일을 업로드 하세요.</em></small></label>
								</div>
								<div class="card-body">
									<div class="dropzone" style=" min-height: 50px;height: 50px;text-align: center;padding: 0;" >
										<div class="dz-message needsclick" style="margin: 0;">
											<span class="text">
												<img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png" alt="Camera"  style="width: 50px;"/>
												첨부파일을 마우스로 끌어다 놓으세요.
											</span>
											<span class="plus">+</span>
										</div>
									</div>
									<!-- 포스팅 - 이미지/동영상 dropzone 영역 -->
								<div>
									<div class="wrapper" id="dropzone-preview">
										<div class="border rounded-3" id="dropzone-preview-list"  style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
										<!-- This is used as the file preview template -->
											<div class="" style=" height: 120px; width: inherit;">
												<img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#" alt="Dropzone-Image" style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
											</div>
											<div class="" style="margin-top: 2px; height: 80px;">
												<small class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down" >&nbsp;</small>
												<div class="row" style="margin: 0;">
													<p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
													<div class="col-6"style="padding: 0;">
														<button data-dz-remove="data-dz-remove" class="btn btn-sm btn-danger " >삭제</button>
													</div>
												</div>
												<strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
											</div>
										</div>
									</div>
								</div>
								</div>
								<!-- /.card-body -->
							</div>
						<!-- /.card -->
						</div>
						
					</div>	
					<div class="card card-widget">
						<div class="card-header">
							<label class="card-title">결재의견 <small><em>결재의견을 입력하세요.</em></small></label>
						</div>
						<!-- /.card-header -->
						<!-- /.card-body -->
						<div class="card-footer card-comments" id="messageBox">

						</div>
						<!-- /.card-footer -->
						<div class="card-footer">
							<img class="img-fluid img-circle img-sm" src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}" alt="Alt Text" id="messageFace">
							<!-- .img-push is used to add margin to elements next to floating images -->
							<div class="img-push">
							   <textarea class="form-control form-control-sm" placeholder="엔터... 입력 , 쉬프트 + 엔터 줄바꿈..." onkeyup="if(window.event.keyCode==13){  if (!window.event.shiftKey){window.event.preventDefault();edsEdms.initMessage(this)}}" ></textarea>
							</div>
						</div>
						<!-- /.card-footer -->
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var edmsEstGridItem;
	let dropzone;
	let dropzeneRemoveFile=new Array;
	var select
	var test=tui.Grid;
	var oEditors = [];
	Dropzone.autoDiscover = false;//dropzone 정의	
	$(document).ready(async function () {
		dropZoneEvent();
				edsEdms.slideEvent();
		await init();
		await TEMPFUNCTIONGDATA();
		// 스마트에디터
		 nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors
			, elPlaceHolder: "editerArea" // element ID
			, sSkinURI: "/css/smarteditor/SmartEditor2Skin.html"
			, fCreator: "createSEditor2"
			,	fOnAppLoad : function(){
			//예제 코드
			let value=document.getElementById("editerArea").value;
			//oEditors.getById["editerArea"].exec("PASTE_HTML", [value]); // 에디터에 내용 삽입
			},
			}
		);
		
	});

	/* 초기설정 */
	async function init() {

		
		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#edmsGridItemForm"), "basma");
		select =$('.select2').select2();
		edsUtil.FormValidationEvent($('#edmsGridItemForm'));
		/* 조회옵션 셋팅 param setting*/

		/* searchform 셋팅 */
		
		/* 조회옵션 셋팅 */
		await edsIframe.setParams();

		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/
		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		// document.getElementById('btnTempSave').onclick = async function () {
		// 	await insertEst();
		// };
		// document.getElementById('btnSave').onclick = async function () {
		// 	await insertEst();
		// };
		document.edmsGridItemForm.addEventListener("keydown", evt => {
			if ((evt.code) === "Enter") {
				if(!(evt.target.name==="editerArea"))
				evt.preventDefault();
			}
		});
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		
	
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/** 버튼이벤트
	 * */
	async function btnEvent(name){
		switch (name) {
			case 'cancel':
			{
				let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));
				if(!(await edsEdms.deleteSubmitList([param]))) return;
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
			}
			break;
			case 'save':
			{
				oEditors.getById["editerArea"].exec("UPDATE_CONTENTS_FIELD", []); 	
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='01'//저장
				const parentData=data;
				var result=await edsEdms.insertSubmit(null,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
			}
			break;		
			case 'tempSave':
			{
				oEditors.getById["editerArea"].exec("UPDATE_CONTENTS_FIELD", []); 	
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='02'//임시저장
				const parentData=data;
				var result= await edsEdms.insertSubmit(null,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
				
			}
			break;		
			case 'close':	
			{
				let param = {};
				param.name = document.getElementById('name').value;
				await edsIframe.closePopup(param);
			}
			case 'move':
			{
				window.parent.location.href ='/EDMS_SUBMIT_TEMP_LIST_VIEW';
				window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_LIST_VIEW"]').click();
			}
			break;			
		}
	}
	/**********************************************************************
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 START
	 ***********************************************************************/
	 async function popupHandler(name,divi,callback){
			var names = name.split('_');
			switch (names[0]) {
				case 'adress':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('EMAILADRESSPOPUP',param);
					}else{
						/**
						 * name = adress_documentId => documentId setting
						 * */
						var returnName = name.split('_');
						var input = document.getElementById(returnName[1]);

						/**
						 * inputArr + callbackArr and remove duplicates
						 * */
						var inputArr = [...new Set(input.value.split(',').concat(callback.adress))]

						/**
						 * 보내는 사람일 경우 첫번째 선택한 사람 적용
						 * */
						if(returnName[1] === 'setFrom'){
							input.value = (inputArr[1]==undefined?input.value:inputArr[1]);
						}else{
							/**
							 * 보내는 사람일 외 경우 빈값 처리 후 적용
							 * */
							for (let i = 0; i < inputArr.length; i++) {
								if(inputArr[i] === ''){
									inputArr.splice(i, 1);
									i--;
								}
							}
							input.value = inputArr;
						}

					}
					break;
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						if(callback.custCd === undefined) return;
						document.getElementById('custCd').value=callback.custCd;
						document.getElementById('custNm').value=callback.custNm;
					}
					break;
				case 'appUsers':{
						if(divi==='open'){
							var param={}
								param.corpCd= document.getElementById('corpCd').value;
								param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
								param.name= name;
							await edsIframe.openPopup('SUBMITUSERPOPUP',param)
						}else{
							await addUser(callback,'appUsers');
						}
					}
					break;		
				case 'ccUsers':{
					if(divi==='open'){
						var param={}
							param.corpCd= document.getElementById('corpCd').value;
							param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
							param.name= name;
						await edsIframe.openPopup('SUBMITUSERPOPUP',param)
					}else{
						await addUser(callback,'ccUsers');
					}
					}
					break;
			}
		}

	/* dropzone 이벤트 끝*/
	function dropZoneEvent()
	{
      	var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
      	dropzonePreviewNode.id = '';
      	var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
      	dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

    	dropzone = new Dropzone(".dropzone", {
      		url: "/EDMS_SUBMIT_LIST/fileUpload", // 파일을 업로드할 서버 주소 url. 
      		method: "post", // 기본 post로 request 감. put으로도 할수있음
			autoProcessQueue:false,
      		previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
      		previewsContainer: '#dropzone-preview',
			acceptedFiles: ".xlsx,.xls,application/pdf,image/*,.hwp",   //파일 종류

			maxFilesize: 100,
			init: function() {
		    	// 파일이 업로드되면 실행
				this.on('addedfile', function (file) {
					var ext = file.name.split('.').pop();
					if (ext == "pdf") {
						this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
					} else if (ext.indexOf("doc") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/wordimg.jpg");
					} else if (ext.indexOf("xls") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/exclimg.jpg");
					}else if (ext.indexOf("hwp") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/hwpimg.jpg");
					}
				});
				
				// 업로드 에러 처리
				this.on('error', function (file, errorMessage) {
					this.removeFile(file);
					alert(errorMessage);
				});

				this.on('removedfile', function (file) {
					if(document.getElementById('submitCd').value){dropzeneRemoveFile.push(file)};//저장이 되었을 때만 작동
				});
				this.on('downloadedFile', async function (file) {
					if(document.getElementById('submitCd').value){
						if (file)
						{
							let fileInfo={};
							fileInfo.saveRoot=file.saveRoot;
							fileInfo.name=file.name;
							$.ajax({
							type: 'POST',
							url: '/EDMS_SUBMIT_LIST/EdmsfileDownload',
							data: JSON.stringify(fileInfo),
							contentType: 'application/json',
							xhrFields: {
								responseType: 'blob' // Set the response type to 'blob'
							},
							success: function(data) {
								if (window.navigator && window.navigator.msSaveOrOpenBlob) {
									window.navigator.msSaveOrOpenBlob(data, fileInfo.name);
								} else {
									const url = window.URL.createObjectURL(data);
									const link = document.createElement('a');
									link.href = url;
									link.setAttribute('download', fileInfo.name);
									document.body.appendChild(link);
									link.click();
									window.URL.revokeObjectURL(url);
								}
							},
							error: function(xhr, status, error) {
								console.error(error);
							}
						});
						}
					};//저장이 되었을 때만 작동
				});		
      	  }, 
      	}
	  	);
	}
	/* dropzone 이벤트 끝*/

	async function TEMPFUNCTIONGDATA()
	{
		let params={};
		params.submitCd=document.getElementById("submitCd").value;
		let reqData = edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitTempList", params); // 데이터 set
		if(reqData.length>0)
		{
			let param={};
			param.data=reqData[0];
			param.form=document.getElementById('edmsGridItemForm');
			await edsUtil.eds_dataToForm(param);
		}
		/* form data 조회 */
		const result = await edsEdms.selectSubmit(document.edmsGridItemForm);
		if(!result) return 	Swal.fire({icon: 'error',title: '실패',text:"조회가능한 데이터가 없습니다."});; 
		await edsEdms.selectSubmitFileList(document.edmsGridItemForm);//파일조회
		await edsEdms.selectMessageData();//메시지조회
		document.getElementById('submitDt').value= edsUtil.getToday("%Y-%m-%d");				
        if(document.getElementById('submitDivi').value=='04') document.getElementById('btnCancel').hidden= true;
		/*유저리스트인서트*/
		if(reqData[0].appUsers)
		{
			let appUsersCd=reqData[0].appUsers.toString().split(',')
			let appUsersName=reqData[0].appUsersName.toString().split(',')
			let appList=[];
			for(var i=0; i<appUsersCd.length;i++)
			{
				var temp={};
				temp.empCd=appUsersCd[i];
				temp.empNm=appUsersName[i];
				appList.push(temp);
			}
			await addUser(appList,'appUsers');
		}
		if(reqData[0].ccUsers)
		{
			let ccUsersCd=reqData[0].ccUsers.toString().split(',')
			let ccUsersName=reqData[0].ccUsersName.toString().split(',')
			let ccList=[];
			for(var i=0; i<ccUsersCd.length;i++)
			{
				var temp={};
				temp.empCd=ccUsersCd[i];
				temp.empNm=ccUsersName[i];
				ccList.push(temp);
			}
			await addUser(ccList,'ccUsers');
		}
	}

	function printsss()
		{
			var g_oBeforeBody = document.getElementById('printid');
			var g_oBeforeavt = document.getElementById('tebs');
			var g_oBeforeavtnavt = document.getElementById('navt');
			var g_test = document.getElementById('printtest');

			window.onbeforeprint = async function (ev) {
					g_oBeforeavt.remove();
					g_oBeforeavtnavt.classList.remove('fixed-top')
					g_test.classList.add('eeeeeee')
					g_oBeforeBody.classList.add('paper')
					document.body = g_oBeforeBody;
					edmsEstGridItem.refreshLayout();
				};

				// window.onafterprint 로 다시 화면원복을 해주는게 맞으나,
				// 문제가 있기에 reload로 처리
			/*
				var initBody = document.body.innerHTML;
				window.onafterprint = function(){
					document.body.innerHTML = initBody;
				}
			*/

			window.print();
		}
	async function addUser(param,target)
		{
			let userData=param;
			let select=[];
			$("#"+target+ " option").remove();
			$("#"+target ).val(null).trigger('change');
			for(const data of userData)
			{
				select.push(data.empCd)
				var newOption = new Option(data.empNm, data.empCd, false, false);
				$("#"+target).append(newOption).trigger('change');
			}
			$("#"+target).val(select).trigger('change');
		}


	
	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>