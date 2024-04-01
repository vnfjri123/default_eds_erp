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
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
	<!-- adminlte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<script src="/css/smarteditor/js/HuskyEZCreator.js"></script>

	
</head>

<body>
<div style="position:relative">
	<section class="content-header">
		<div class="container-fluid">
	        <div class="row mb-2">
	          <div class="col-sm-12">
	            <h3>품의서</h3>
	          </div>
			  
	        </div>
	      </div>
	</section>
	<section class="content" >
		<div class="container-fluid">
			<div class="row" >
				<div class="col-md-12">
					<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" id="docDivi">
					<!-- Form 영역 -->
					<div class="card card-lightblue card-outline">
						<div class="card-header">
						<label class="card-title" style="">문서정보</label>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12">
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="submitNm">문서제목</label>
										<input type="text" class="form-control" placeholder="Enter ..." name="submitNm" id="submitNm" required>
									</div>
									<!-- /.form-group -->
								</div>
							</div>
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
							<!-- ./form -->
						</div>
						<!-- /.card-body -->
					</div>
					<div class="row">
						<div class="col-md-12">
						  <div class="card card-outline card-info">
							<div class="card-header">
							  <h3 class="card-title">
								  <label class="card-title" style="">품의서</label>
							  </h3>
							  <div class="card-tools" hidden>
								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnPrivew" id="btnPrivew" onclick="btnEvent('preview')"><i class="fa-regular fa-eye"></i> 미리보기</button>
							</div>
							</div>
							<!-- /.card-header -->
							<div class="card-body p-0">
							  <textarea name ="editerArea" id="editerArea" class="w-100" rows="20">
							  </textarea>
							</div>
							<div class="card-footer">
							  Eds <a></a>품의내용을 작성하세요.
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
										<div class="test border rounded-3" id="dropzone-preview-list"  style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
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
		window.parent.postMessage('complete');
		// 스마트에디터
		await nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors
		, elPlaceHolder: "editerArea" // element ID
		, sSkinURI: "/css/smarteditor/SmartEditor2Skin.html"
		, fCreator: "createSEditor2"
		,	fOnAppLoad : function(){
		//예제 코드
		let value=document.getElementById("editerArea").value;
		//oEditors.getById["editerArea"].exec("PASTE_HTML", [value]); // 에디터에 내용 삽입
		},
		});
	
		
	});
	

	/* 초기ss설정 */
	async function init() {



		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#edmsGridItemForm"), "basma");
		select =$('.select2').select2();
		edsUtil.FormValidationEvent($('#edmsGridItemForm'));
		/* 조회옵션 셋팅 param setting*/

		/* searchform 셋팅 */


		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

			/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		document.edmsGridItemForm.addEventListener("keydown", evt => {
			if ((evt.code) === "Enter") {
				if(!(evt.target.name==="note1"))
				evt.preventDefault();
			}
		});
		
		if(parent) {//부모 iframe 과통신
			//수신 이벤트 발생 
			window.addEventListener("message", async function(message) {
				if(message.data.messageDivi=='save')
				{
					oEditors.getById["editerArea"].exec("UPDATE_CONTENTS_FIELD", []); 	
					const parentData=message.data;
					await edsEdms.insertSubmit(null,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='tempSave')
				{
					oEditors.getById["editerArea"].exec("UPDATE_CONTENTS_FIELD", []);
					const parentData=message.data;
					await edsEdms.insertSubmit(null,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='insert')
				{
					//oEditors.getById["editerArea"].exec("UPDATE_CONTENTS_FIELD", []); 	
					for (const [key, value] of Object.entries(message.data)) {
						if(document.getElementById(key))document.getElementById(key).value = value;
						if(key === 'docDivi'){
							switch (value) {
								case '04': document.getElementById('submitNm').value = '품의서 - ';break;
								case '06': document.getElementById('submitNm').value = '지원요청서품의서 - ';break;
								case '07': document.getElementById('submitNm').value = '휴가신청품의서 - ';break;
								case '08': document.getElementById('submitNm').value = '업무추진비품의서 - ';break;
								case '09': document.getElementById('submitNm').value = '출장신청품의서 - ';break;
								case '10': document.getElementById('submitNm').value = '입찰품의서 - ';break;
							}
						}
					}
					select.trigger('change');
					let valueHtml =await inputDocHtml(message.data.docDivi);

					//dropzeneRemoveFile=null;
				}

				return ;
			})}
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

	}
	document.addEventListener("click", evt => {
		});
	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	 async function btnEvent(name){
		switch (name) {
			case 'preview':	
			{
				EdmsPreview();
			}
			break;			
		}
	}
	async function EdmsPreview()
		{
			let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));
			param.docDivi=document.getElementById("docDivi").value;
			console.log(docDivi);
			param.tempDivi="01";
			if(docDivi=='01')param.url="/EDMS_EST_REPORT_CONF_VIEW"
			else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_CONF_VIEW"
			else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_CONF_VIEW"
			else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_CONF_VIEW"
			else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='05')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else {return ;}
			await popupHandler('edmsConf','open',param);
		}

	function btnEvent(divi)
	{
		if(divi==='01'){
			window.parent.location.href ='/EDMS_SUBMIT_LIST_INS_VIEW';
			window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_LIST_VIEW"]').click();
		}else if(divi==='02'){
			window.parent.location.href ='/EDMS_SUBMIT_LIST_INS_VIEW';
			window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_TEMP_LIST_VIEW"]').click();
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
					//저장이 되었을 때만 작동
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

	async function inputDocHtml(docDivi)
	{
		return await new Promise(async (resolve, reject) => {
		let HTML='';
		console.log(docDivi)
		switch (docDivi) {
			case "06":
				{
					HTML=`<div style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 13.3333px; background-color: rgb(255, 255, 255);"><br></span></div><div style="text-align: center;" align="center"><br></div><div style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 13.3333px; background-color: rgb(255, 255, 255);"><br></span></div><div style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 13.3333px; background-color: rgb(255, 255, 255);">다음과 같이 타부서의 지원을 요청드리오니 결재하여 주시기 바랍니다.</span><br></div><div style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px; background-color: rgb(255, 255, 255);"><br></span></div><div style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px; background-color: rgb(255, 255, 255);"><br></span></div><table class="__se_tbl" _se2_tbl_template="8" style="text-align: center; margin: auto; background-color: rgb(199, 199, 199); border-width: 1px 1px 0px 0px; border-top-style: solid; border-right-style: solid; border-bottom-style: initial; border-left-style: initial; border-top-color: rgb(199, 199, 199); border-right-color: rgb(199, 199, 199); border-bottom-color: initial; border-left-color: initial; border-image: initial;" border="0" cellpadding="0" cellspacing="0"><tbody><tr><td style="width: 185px; height: 18px; text-align: left; font-weight: normal; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(255, 255, 255); background-color: rgb(255, 239, 0);" class=""><p style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 10pt; background-color: rgb(255, 228, 0);">요청자</span></p></td><td style="width: 553px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102);" class="" colspan="3"><p style="text-align: center;"><span style="font-size: 9pt;">﻿</span><br></p></td></tr><tr><td style="width: 185px; height: 18px; text-align: left; font-weight: normal; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(255, 255, 255); background-color: rgb(255, 239, 0);" class="" rowspan="1"><p style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 10pt; background-color: rgb(255, 228, 0);">지원 부서</span><span style="font-family: 굴림, gulim; font-size: 10pt;">&nbsp;</span></p></td><td style="width: 249px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(102, 102, 102); background-color: rgb(255, 255, 255);" class="" rowspan="1" colspan="1"><p style="text-align: center;"><span style="font-size: 9pt;">﻿</span><br></p></td><td style="text-align: center; width: 127px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(102, 102, 102); background-color: rgb(255, 239, 0);" class="" rowspan="1" colspan="1"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 13.3333px; background-color: rgb(255, 228, 0);">지원 인원</span><br></td><td style="text-align: center; width: 177px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(102, 102, 102); background-color: rgb(255, 255, 255);" class="" rowspan="1" colspan="1"><p><br></p></td></tr><tr><td style="width: 185px; height: 17px; text-align: left; font-weight: normal; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(255, 255, 255); background-color: rgb(255, 239, 0);" class=""><p style="text-align: center; " align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 10pt; background-color: rgb(255, 228, 0);">프로젝트명</span></p></td><td style="width: 553px; height: 17px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(102, 102, 102); background-color: rgb(255, 255, 255);" class="" colspan="3"><p style="text-align: center;"><span style="font-size: 9pt;">﻿</span><br></p></td></tr><tr><td style="width: 185px; height: 18px; text-align: left; font-weight: normal; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(255, 255, 255); background-color: rgb(255, 239, 0);" class=""><p style="text-align: center; " align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 10pt; background-color: rgb(255, 228, 0);">지원 기간</span></p></td><td style="width: 553px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102);" class="" colspan="3"><p style="text-align: center;"><span style="font-size: 9pt;">﻿</span><br></p></td></tr><tr><td style="width: 185px; height: 18px; text-align: left; font-weight: normal; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; color: rgb(255, 255, 255); background-color: rgb(255, 239, 0);" class=""><p style="text-align: center;" align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 10pt; background-color: rgb(255, 228, 0);">지원 내용</span></p></td><td style="width: 553px; height: 18px; border-width: 0px 0px 1px 1px; border-top-style: initial; border-right-style: initial; border-bottom-style: solid; border-left-style: solid; border-top-color: initial; border-right-color: initial; border-bottom-color: rgb(199, 199, 199); border-left-color: rgb(199, 199, 199); border-image: initial; padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102);" class="" colspan="3"><p style="text-align: center;" align="center"><span style="font-size: 9pt;">﻿</span><br></p></td></tr></tbody></table><p></p><p><br></p><div style="text-align: center;" align="left"><br></div><div style="text-align: center;"><span style="color: rgb(18, 52, 86); font-family: 굴림, gulim; font-size: 13.3333px; text-align: start; background-color: rgb(255, 255, 255);">*. 결재 완료 후 지원 부서장에게 회람 전달 필수!!!</span><br></div><div style="text-align: left;" align="left"><br></div>`;
				}
				break;
			case "07":
				{
					let empNm='<c:out value="${LoginInfo.empNm}"/>';
					let depaNm='<c:out value="${LoginInfo.depaNm}"/>';
					HTML=`<p><span style="font-size: 9pt;"></span>&nbsp;<span style="font-size: 9pt;">﻿</span></p><p>&nbsp;</p><div style="text-align: center;" align="center"><span style="color: rgb(76, 76, 76);  nanumgodic; font-size: 25px; font-weight: 700; background-color: rgb(255, 255, 255);">휴가품의서</span><br></div><div style="text-align: center;" align="center"><span style="color: rgb(76, 76, 76); nanumgodic; font-size: 25px; font-weight: 700; background-color: rgb(255, 255, 255);"><br></span></div><div style="text-align: center;" align="center"><span style="background-color: rgb(255, 255, 255); color: rgb(76, 76, 76);  nanumgodic; font-size: 12pt;">휴가/경조사 사용 신청을 아래와 같이 하오니 재가 바랍니다.</span></div><div style="text-align: center;" align="center"><span style="background-color: rgb(255, 255, 255); color: rgb(76, 76, 76); nanumgodic; font-size: 12pt;"><br></span></div><p>&nbsp;</p>
						  <p><br></p>
						  <table border="0" cellpadding="0" cellspacing="0" style="font-family: 돋움;border:1px solid #000000; border-left:0; border-bottom:0; border-collapse: collapse; margin:auto" class="__se_tbl"><tbody>
						  <tr><td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 110px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-size: 9pt;">부서</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 113px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p><span style="font-size: 9pt;">`+depaNm+`</span></p></td>
						  <td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 112px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-family: 돋움, dotum; font-size: 9pt;">&nbsp;신청자</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 235px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p><span style="font-size: 9pt;">`+empNm+`</span></p></td>
						  </tr>
						  <tr><td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 110px; height: 30px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-size: 9pt;">휴가종류</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 460px; height: 30px; background-color: rgb(255, 255, 255);" class="" colspan="3" rowspan="1"><p><span style="font-size: 9pt;"><br></span></p></td>
						  </tr>
						  <tr><td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 110px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-family: 돋움, dotum; font-size: 9pt;">기간</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 113px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p><span style="font-size: 9pt;">﻿</span><br></p></td>
						  <td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 112px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-family: 돋움, dotum; font-size: 9pt;">휴가일수</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 235px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p><span style="font-size: 9pt;">﻿</span><br></p></td>
						  </tr><tr>
						  <td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 110px; height: 30px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; "><b><span style="font-family: 돋움, dotum; font-size: 9pt;">사유</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 460px; height: 30px; background-color: rgb(255, 255, 255);" class="" colspan="3" rowspan="1"><p><span style="font-size: 9pt;">﻿</span><br></p></td>
						  </tr>
						  <tr><td style="border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 110px; height: 29px; background-color: rgb(255, 255, 255);" class=""><p style="text-align: center; " align="center"><b><span style="font-family: 돋움, dotum; font-size: 9pt;">대리업무자</span></b></p></td>
						  <td style="text-align: center; border-width: 0px 0px 1px 1px; border-bottom-style: solid; border-left-style: solid; border-bottom-color: rgb(0, 0, 0); border-left-color: rgb(0, 0, 0); border-image: initial; border-top-style: initial; border-top-color: initial; border-right-style: initial; border-right-color: initial; width: 460px; height: 29px; background-color: rgb(255, 255, 255);" class="" colspan="3" rowspan="1"><p><span style="font-size: 9pt;"><br></span></p></td>
						  </tr></tbody></table> <p><br></p> <p><br></p> <p><br></p> <p><br></p> <p><br></p> <p><br></p>`;
				}
				break;
			case "08":
				{
					HTML=`<p style="margin-left: 0px;">&nbsp;</p><p style="text-align: center;">&nbsp;</p><p style="text-align: center; margin-left: 0px;">-&nbsp; 아&nbsp; &nbsp;래&nbsp; -</p><p style="text-align: center;">&nbsp;</p><p style="text-align: center;">&nbsp;</p><table class="txc-table __se_tbl" cellspacing="0" cellpadding="0" border="0" style="border: none; border-collapse: collapse; font-family: 굴림; font-size: 13.3333px; margin: 0px auto;"><tbody><tr><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 142px; height: 24px; border-width: 1px; border-style: solid; border-color: rgb(204, 204, 204); background-color: rgb(206, 251, 201);" class=""><p style="text-align: center; margin-left: 0px;"><b>고&nbsp; 객&nbsp; 사</b>&nbsp;</p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 210px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">ex) (주)xxxx</p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 137px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204); background-color: rgb(206, 251, 201);" class=""><p style="text-align: center; margin-left: 0px;"><b>참 여 인 원</b></p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 344px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">ex) 김도현 외 2인</p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 142px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(206, 251, 201);" class=""><p style="text-align: center; margin-left: 0px;"><b>사용예정일</b></p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 210px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">ex) 20xx.xx.xx</p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 137px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); background-color: rgb(206, 251, 201);" class=""><p style="text-align: center; margin-left: 0px;"><b>업무추진방법/비용</b></p></td><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 344px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;"><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 142px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(206, 251, 201);" class=""><p style="text-align: center; margin-left: 0px;"><b>관련 프로젝트</b></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 690px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td colspan="1" rowspan="3" style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 142px; height: 76px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center; margin-left: 0px;"><b>용&nbsp; &nbsp; &nbsp; 도</b></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 690px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">1)&nbsp;<span style="font-size: 10pt;">xx사업 수주를 위한 친목도모</span></p></td></tr><tr><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 690px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">2)&nbsp;</p></td></tr><tr><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; color: rgb(18, 52, 86); width: 690px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="margin-left: 0px;">3)&nbsp;</p></td></tr></tbody></table><p style="text-align: center;">&nbsp;</p><p style="text-align: center;">&nbsp;</p><p style="margin-left: 40px;">&nbsp;</p>`;
				}
				break;
			case "09":
				{
					HTML=`<p style="margin-left: 320px; text-align: left;" align="center">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center"><span style="font-size: 32px;">출 장 신 청 서</span>&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center"><span style="font-size: 32px;">&nbsp;</span></p><table class="__se_tbl" _se2_tbl_template="8" cellspacing="0" cellpadding="0" border="0" style="margin: auto; color: rgb(18, 52, 86); font-family: 굴림; border: none; border-collapse: collapse; font-size: 13.3333px;"><tbody><tr><td style="line-height: 1.5; font-size: 10pt; width: 94px; height: 25px; border-width: 1px; border-style: solid; border-color: rgb(204, 204, 204); background-color: rgb(250, 236, 197);"><p style="text-align: center;"><span style="color: rgb(0, 0, 0);">책 임 자</span></p></td><td style="line-height: 1.5; font-size: 10pt; width: 245px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: center;">&nbsp;</p></td><td style="line-height: 1.5; font-size: 10pt; width: 145px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;"><span style="color: rgb(0, 0, 0);">직&nbsp; &nbsp; &nbsp;위</span></p></td><td style="line-height: 1.5; font-size: 10pt; width: 225px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: center;"><span style="font-size: 10pt;">&nbsp;</span><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 94px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;">장&nbsp; &nbsp; 소</p></td><td colspan="3" rowspan="1" style="text-align: left; line-height: 1.5; font-size: 10pt; width: 608px; height: 26px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 94px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);"><p style="text-align: center;"><span style="color: rgb(0, 0, 0);">프로젝트명</span></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 609px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: center;">&nbsp;</p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 94px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);"><p style="text-align: center;"><span style="color: rgb(0, 0, 0);">사&nbsp; &nbsp; 유</span></p></td><td colspan="1" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 245px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: center;">&nbsp;</p></td><td colspan="1" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 145px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); text-align: center; background-color: rgb(250, 236, 197);" class=""><p>기&nbsp; &nbsp; 간</p></td><td colspan="1" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 173px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr></tbody></table><p style="color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;">&nbsp;</p><table class="__se_tbl" _se2_tbl_template="8" cellspacing="0" cellpadding="0" border="0" style="margin: auto; color: rgb(18, 52, 86); font-family: 굴림; border: none; border-collapse: collapse; font-size: 13.3333px;"><tbody><tr><td colspan="4" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 703px; height: 25px; border-width: 1px; border-style: solid; border-color: rgb(204, 204, 204); background-color: rgb(228, 247, 186);" class=""><p style="text-align: center;"><b>예 상 출 장 비 용<br></b></p></td></tr><tr><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 286px; height: 24px; border-width: 1px; border-style: solid; border-color: rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;"><b>항&nbsp; 목</b></p></td><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 122px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;"><b>예상비용</b></p></td><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 119px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;"><b>매입처</b></p></td><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 176px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204); background-color: rgb(250, 236, 197);" class=""><p style="text-align: center;"><b>비&nbsp; 고</b></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 286px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 122px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: right;"><span style="font-size: 10pt;">&nbsp;</span><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 119px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p>&nbsp;</p></td><td style="line-height: 1.5; font-size: 10pt; width: 176px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p>&nbsp;</p></td></tr><tr><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 286px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td rowspan="1" style="text-align: right; line-height: 1.5; font-size: 10pt; width: 122px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: right;" align="right"><br></p></td><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 119px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 176px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 286px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 122px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: right;">&nbsp;</p></td><td style="line-height: 1.5; font-size: 10pt; width: 119px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 176px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 286px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 122px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p style="text-align: right;" align="right">&nbsp;</p></td><td style="line-height: 1.5; font-size: 10pt; width: 119px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 176px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 286px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(255, 187, 0);" class=""><p style="text-align: center;"><b>합&nbsp; 계</b></p></td><td style="line-height: 1.5; font-size: 10pt; width: 122px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); background-color: rgb(255, 187, 0);" class=""><p style="text-align: right;"><b>원</b></p></td><td style="line-height: 1.5; font-size: 10pt; width: 119px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); background-color: rgb(255, 187, 0);" class=""><p style="text-align: left;" align="left"><b>(부가세 포함)</b></p></td><td style="line-height: 1.5; font-size: 10pt; width: 176px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); background-color: rgb(255, 187, 0);" class=""><p>&nbsp;</p></td></tr></tbody></table><p style="color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">위와 같이 출장신청서를 제출하오니 재가하여 주시기 바랍니다.&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">20&nbsp; 년&nbsp; &nbsp; 월&nbsp; &nbsp;&nbsp;일</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center"><span style="font-size: 13.3333px;">신&nbsp; 청&nbsp; 자&nbsp; :&nbsp; O O O</span>&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">&nbsp;</p><p style="text-align: center; color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px;" align="center">&nbsp;</p>`
				}
				break;
			case "10":
				{
					HTML=`<p style="text-align: center;" align="center"><font color="#123456" face="굴림"><span style="font-size: 13.3333px;"><br></span></font></p><p style="text-align: center;" align="center">&nbsp;</p><p style="text-align: center;" align="center"><font color="#123456" face="굴림"><span style="font-size: 13.3333px;">다음과 같이 입찰공고에 대한 투찰금액을 품의하오니 재가하여 주시기 바랍니다.</span></font>&nbsp;</p><p style="text-align: center;" align="left"><font color="#123456" face="굴림"><span style="font-size: 13.3333px;"><br></span></font></p><p style="text-align: center;" align="left"><font color="#123456" face="굴림"><span style="font-size: 13.3333px;"><br></span></font></p><table class="txc-table __se_tbl" cellspacing="0" cellpadding="0" border="0" style="color: rgb(18, 52, 86); font-family: 굴림; border: none; border-collapse: collapse; font-size: 13.3333px; margin: 0px auto;"><tbody><tr><td style="line-height: 1.5; font-size: 10pt; width: 141px; height: 25px; border-width: 1px; border-style: solid; border-color: rgb(204, 204, 204); background-color: rgb(183, 240, 177);" class=""><p style="text-align: center;"><b>요청자</b></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 539px; height: 26px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-top: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 141px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(183, 240, 177);" class=""><p style="text-align: center;"><b>발주처</b></p></td><td style="line-height: 1.5; font-size: 10pt; width: 211px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td><td style="line-height: 1.5; font-size: 10pt; width: 133px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); background-color: rgb(183, 240, 177);" class=""><p style="text-align: center;"><b>사업 구분</b></p></td><td style="line-height: 1.5; font-size: 10pt; width: 195px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p><br></p></td></tr><tr><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 141px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); text-align: center; background-color: rgb(183, 240, 177);" class=""><p><b>입찰공고명</b></p></td><td rowspan="1" colspan="3" style="line-height: 1.5; font-size: 10pt; width: 539px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p>&nbsp;</p></td></tr><tr><td style="line-height: 1.5; font-size: 10pt; width: 141px; height: 24px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); background-color: rgb(183, 240, 177);" class=""><p style="text-align: center;"><b>입찰공고기간</b></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 539px; height: 25px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><p>&nbsp;</p></td></tr><tr><td rowspan="1" style="line-height: 1.5; font-size: 10pt; width: 141px; height: 109px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204); border-left: 1px solid rgb(204, 204, 204); text-align: center; background-color: rgb(183, 240, 177);" class=""><p><b>투찰금액</b></p><p><b>결정기준</b></p></td><td colspan="3" rowspan="1" style="line-height: 1.5; width: 539px; height: 110px; border-bottom: 1px solid rgb(204, 204, 204); border-right: 1px solid rgb(204, 204, 204);" class=""><div style="text-align: left;" align="left"><p style="margin-left: 0px;">&nbsp;</p></div></td></tr></tbody></table><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p style="text-align: center; " align="center"><span style="color: rgb(18, 52, 86); font-family: 굴림; font-size: 13.3333px; background-color: rgb(255, 255, 255);">*. 첨부자료(공고서, 시방서, 분석자료) 필히 첨부!!!!</span>&nbsp;</p>`;
				}
				break;
			break;
		}
		document.getElementById("editerArea").value=HTML;
		resolve(HTML);
		});
	}

	/**************H********************************************************
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