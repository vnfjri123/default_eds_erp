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
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
	<!-- adminlte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<style>
		.addr {
		display:block; overflow:hidden; width:100%; height:2.7rem; padding:0.6rem;
		font-size:1.2rem; color:#000; border-radius:0.2rem; border:1px solid #ccc; resize:none;
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

		border: 2px #ff0000 solid;

		}
		.eeeeeee {

		padding: 0;

		border: 1px #f13232 solid;

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
	<div id="printid">
		<div style="position:relative" id="printtest">
			<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id="navt">
				<a class="navbar-brand" href="#"><h3>지출품의 등록</h3></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="#tebs" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="tebs">
					<ul class="navbar-nav mr-auto">
						<!-- <li class="nav-item active">
						  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
						</li>-->
					</ul>
				  <form class="form-inline">
					<div class="input-group">
						<div class="float-right ml-auto">
							<div class="container">
								<!-- <button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnSearch" onclick="btnEvent('approve')"><i class="fa fa-solid fa-share"></i> 승인</button>
								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnDecline" onclick="btnEvent('decline')"><i class="fa fa-solid fa-share"></i> 반려</button>
								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnCheck" onclick="btnEvent('over')"><i class="fa fa-solid fa-share"></i> 검토</button> -->
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
							<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
								<input type="hidden" name="keyCd" id="keyCd" value="">
								<input type="hidden" name="corpCd" id="corpCd" value="">
								<input type="hidden" name="busiCd" id="busiCd" value="">
								<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
								<input type="hidden" name="name" id="name" title="구분값">
								<input type="hidden" name="custNm" id="custNm" title="고객번호">
								<input type="hidden" id="currApproverCd" >
								<input type="hidden" id="docDivi" >
								<input type="hidden" id="inpId" >
							<!-- Form 영역 -->
							<div class="card mt-1">
								<!-- form start -->
								<div class="card-body">
									<div class="form-group row">
										<label for="busiNm" class="col-sm-2 col-form-label">계열사</label>
										<div class="col-sm-10">
										  <input type="text" class="form-control" id="busiNm" readonly>
										</div>
									</div>
									<div class="form-group row">
									  <label for="inputPassword3" class="col-sm-2 col-form-label">문서명</label>
									  <div class="col-sm-10">
										<input type="text" class="form-control" id="submitNm" readonly>
									  </div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3" class="col-sm-2 col-form-label">작성일자</label>
										<div class="col-sm-10">
										  <input type="text" class="form-control" id="submitDt" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3" class="col-sm-2 col-form-label">기안자</label>
										<div class="col-sm-10">
										  <input type="text" class="form-control" id="inpNm"readonly >
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3" class="col-sm-2 col-form-label">결재자</label>
										<div class="col-sm-10">
										  <input type="text" class="form-control" id="appUsersName" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3" class="col-sm-2 col-form-label">참조자</label>
										<div class="col-sm-10">
										  <input type="text" class="form-control" id="ccUsersName" readonly>
										</div>
									</div>
								</div>
							</div>
							<div class="card card-lightblue card-outline">
								<div class="card-header">
								<label class="card-title" style="">지출품의 정보</label>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<div class="row">
										<div class="col-sm-12">
											<!-- text input -->
											<div class="form-group" style="text-align: center;">
											<label>아래와 같이 지출내역을 품의하오니, 재가하여 주시기 바랍니다. </label>
											</div>
											<!-- /.form-group -->
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<!-- text input -->
											<div class="form-group" style="text-align: center;">
											<label>- 아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래 - </label>
											</div>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="row">
										<div class="col-sm-6">
											<div class="card card-warning card-outline h-100">
												<div class="card-header">
													<label class="card-title">총금액</label>
												</div>
												<div class="card-body">
													<div class="form-group">
														<label>합계금액</label>
														<input type="text" class="form-control" placeholder="입력 ..." name="totAmt" id="totAmt" readonly>
													</div>
													<div class="form-group">
														<label>공급가액</label>
														<input type="text" class="form-control" placeholder="입력 ..." name="supAmt" id="supAmt" readonly>
													</div>
													<div class="form-group">
														<label>부가세액</label>
														<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt" id="vatAmt" readonly>
													</div>
												</div>
											</div>
										<!-- /.form-group -->
										</div>
										<div class="col-sm-6">
											<div class="card card-warning card-outline h-100">
												<div class="card-header">
													<label class="card-title">계정과목별합계금액</label>
												</div>
												<div class="card-body">
													<div class="row" id="accountBox">
													</div>
												</div>
											</div>
										<!-- /.form-group -->
										</div>
									</div>
								</div>
								<!-- /.card-body -->
							</div>
							<div class="card card-lightblue card-outline">
								<div class="card-header">
									<label class="card-title">이슈사항</label>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-sm-12">
											<!-- text input -->
											<div class="form-group">
												<textarea class="form-control" rows="8" placeholder="입력 ..." name ="note1" id="note1"></textarea>
											</div>
											<!-- /.form-group -->
										</div>
									</div>
								</div>
							</div>
							<!-- /.cnt-in -->
							<div class="card card-lightblue card-outline">
								<div class="card-header">
									<label class="card-title">지출품목</label>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0 overflow-auto">
								  <table class="table table-bordered hover">
									<thead class="tableTitle">
										<th style="min-width: 80px;width: 10%;">일자</th>
										<th style="min-width: 200px;width: 25%;">프로젝트</th>
										<th style="min-width: 120px; width: 15%;">계정과목명</th>
										<th style="min-width: 120px; width: 10%;">거래처</th>
										<th style="min-width: 80px; width: 10%;">지출금액</th>
										<th style="min-width: 240px;width: 15%;">사용목적</th>
										<th style="min-width: 240px;width: 15%;">적요</th>
									  </tr>
									</thead>
									<tbody  class="tableBodys" id="tableBody">
									</tbody>
								  </table>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.row -->

								<button class="btn btn-sm btn-primary" name="submitbtn" id="submitbtn" type="submit" hidden ></button>
							</form>
							<!-- /.row -->
							
							<div class="row">
								<div class="col-md-12">
								<div class="card card card-lightblue card-outline">
									<div class="card-header" >
										<label class="card-title">첨부파일 <small><em>파일을 목록입니다.</em></small></label>
									</div>
									<div class="card-body">
										<div class="dropzone" style=" min-height: 50px;height: 50px;text-align: center;padding: 0;" hidden>
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
														<div class="col-6"style="padding: 0;" hidden>
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
	</div>
<script>
	let edmsExpenseGridItem;
	let dropzone;
	let dropzeneRemoveFile=new Array;
	let select
	let test=tui.Grid;
	Dropzone.autoDiscover = false;//dropzone 정의	
	$(document).ready(async function () {
		dropZoneEvent();
		edsEdms.slideEvent();
		await init();
		TEMPFUNCTIONGDATA();
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
			// tui.Grid.applyTheme('striped', {
			// });
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
	

		if(parent) {//부모 iframe 과통신
			//수신 이벤트 발생 
			window.addEventListener("message", async function(message) {
				if(message.data.messageDivi=='save')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='tempSave')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='insert')
				{
					for (const [key, value] of Object.entries(message.data)) {
						if(document.getElementById(key))document.getElementById(key).value = value;
					}
					//dropzeneRemoveFile=null;
				}
				return ;
			})}
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		let height = window.innerHeight - 40;
		
	
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/** 버튼이벤트
	 * */
	async function btnEvent(name){
		switch (name) {
			case 'approve':
			{
				let Edmsdata = ut.serializeObject(document.querySelector("#edmsGridItemForm"));
				let param={};
				param.data=Edmsdata;
				param.form=document.querySelector("#edmsGridItemForm");
				param.select=select;
				await edsUtil.eds_FormToData(param);//param에 폼데이터 입력
				let itemList = await edsUtil.getAjax("/EDMS_EXPENSE_REPORT/selectExpenseItemList", Edmsdata);
				if(itemList.length>0)
				Edmsdata.itemData=itemList;
				await edsEdms.approveSubmit([Edmsdata]);
			}
			break;
			case 'decline':
			{
				console.log('decline')
				let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));;
				await edsEdms.declineSubmit(param)
			}
			break;		
			case 'over':
			{
				
			}
			case 'close':	
			{
				let param = {};
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
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
	/* dropzone 이벤트 끝*/
	function dropZoneEvent()
	{
      	let dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
      	dropzonePreviewNode.id = '';
      	let previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
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
					console.log("sss");
					if(document.getElementById('submitCd').value){
						if (file)
						{
							let fileInfo={};
							fileInfo.saveRoot=file.saveRoot;
							fileInfo.name=file.name;
							console.log("sss");
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

	/* 화면정보입력이벤트*/
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
		/* 품목 조회 */
		await selectItem();
		//await doAction("edmsExpenseGridItem", "search");
		await edsEdms.selectSubmitFileList(document.edmsGridItemForm);//파일조회
		await edsEdms.selectMessageData();
		let txtArea = $(".addr");//texttera 크기조정
		if (txtArea) {
			txtArea.each(function(){
				$(this).height(this.scrollHeight);
			});
		}
		
	}
	/* 화면정보입력이벤트 끝*/
	/* 품목el생성 이벤트 시작*/
	async function selectItem()
	{
		let param = await ut.serializeObject(document.querySelector("#edmsGridItemForm")); //조회조건
		let data = edsUtil.getAjax("/EDMS_EXPENSE_REPORT/selectExpenseItemList", param);
		  // Create table data rows
		  const table = document.getElementById('tableBody');
		  let sumData={};
		  for (const obj of data) {
			if(sumData[obj.accountCd])
			{
				sumData[obj.accountCd].totAmt+=Number(obj.totAmt);
			}
			else
			{
				let sumObj={};
				sumObj.accountCd=obj.accountCd;
				sumObj.accountNm=obj.accountNm;
				sumObj.totAmt=Number(obj.totAmt);
				sumData[obj.accountCd]=sumObj;
			}
			const dataRow = document.createElement('tr');
			const costDtCell = document.createElement('td');
			costDtCell.setAttribute("class","itemAlign");
			costDtCell.textContent = obj['costDt'];
			dataRow.appendChild(costDtCell);
			const projCell = document.createElement('td');
			projCell.textContent = obj['projNm'];
			dataRow.appendChild(projCell);
			const itemNmCell = document.createElement('td');
			itemNmCell.textContent = obj['accountNm'];
			dataRow.appendChild(itemNmCell);
			const custNmCell = document.createElement('td');
			custNmCell.textContent = obj['custNm'];
			dataRow.appendChild(custNmCell);
			const totAmt3Cell = document.createElement('td');
			totAmt3Cell.setAttribute("class","numberAlign");
			totAmt3Cell.textContent = edsUtil.addComma(obj['totAmt'])+'원';
			dataRow.appendChild(totAmt3Cell);
			const costPurCell = document.createElement('td');
			costPurCell.textContent = obj['costPur'];
			dataRow.appendChild(costPurCell);
			const noteCell = document.createElement('td');
			noteCell.textContent = obj['note'];
			dataRow.appendChild(noteCell);
			table.appendChild(dataRow);
			
		}
		console.log(sumData)
		await addAccountNm(sumData);
	}
	/* 품목el생성 이벤트 끝*/
	function printsss()
	{
		let g_oBeforeBody = document.getElementById('printid');
		let g_oBeforeavt = document.getElementById('tebs');
		let g_oBeforeavtnavt = document.getElementById('navt');
		let g_test = document.getElementById('printtest');
		window.onbeforeprint = async function () {
			g_oBeforeavt.remove();
			g_oBeforeavtnavt.classList.remove('fixed-top')
			g_test.classList.add('eeeeeee')
			g_oBeforeBody.classList.add('paper')
			document.body = g_oBeforeBody;
			
		};
			// window.onafterprint 로 다시 화면원복을 해주는게 맞으나,
			// 문제가 있기에 reload로 처리
		/*
			let initBody = document.body.innerHTML;
			window.onafterprint = function(){
				document.body.innerHTML = initBody;
			}
		*/
		window.print();
	}
	async function addAccountNm(params)
	{
		console.log(params)
		if(!params) return ;
		console.log(params)
		let accountBox=document.getElementById('accountBox');
		let tempAccountRow=''
		let rows=Object.values(params);
		for(const data of rows)
		{
			let accountEl=`<div class="col-sm-4">
				<!-- text input -->
				<div class="form-group">
				<label>`+data.accountNm+`</label>
				<input type="text" class="form-control" value="`+edsUtil.addComma(data.totAmt)+`원"readonly>
				</div>
				<!-- /.form-group -->
			</div>`;
			tempAccountRow+=accountEl;
		}
		accountBox.innerHTML=tempAccountRow;
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