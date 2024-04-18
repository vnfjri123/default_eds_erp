<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>

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
		<a class="navbar-brand" href="#"><h3>프로젝트 변경품의</h3></a>
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
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnCancel" id="btnCancel" onclick="btnEvent('cancel')"><i class="fa fa-solid fa-share"></i> 삭제</button>
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
						<input type="hidden" name="keyCd" id="keyCd" value="">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="custCd" id="custCd" value="">
						<input type="hidden" id="currApproverCd" >
						<input type="hidden" id="docDivi" >
						<input type="hidden" id="inpId" >
						<input type="hidden" id="submitDivi" >
						<input type="hidden" id="estDt">

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
									<input type="text" class="form-control" id="submitNm" >
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
		
									<div class="col-sm-10">
									  <div class="select2-info">
										<select class="select2" multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-purple" style="width: 100%;" id="appUsers"disabled>
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
							<label class="card-title" style="">프로젝트 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="row">
									<div class="col-sm-12">
										<!-- text input -->
										<div class="form-group" style="text-align: center;">
										<label>아래와 같이 프로젝트 변경을 품의하오니, 재가하여 주시기 바랍니다. </label>
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
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="projNm">프로젝트명</label>
										<input type="text" class="form-control" placeholder="Enter ..." name="projNm" id="projNm" required style="background-color: yellow">
									</div>
									<!-- /.form-group -->
								</div>
								<div class="col-sm-6">
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="projPur">프로젝트목적</label>
									<input type="text" class="form-control" placeholder="Enter ..." name="projPur" id="projPur" required>
									</div>
									<!-- /.form-group -->
								</div>

								</div>
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<i class="fa-solid fa-circle-check"></i> <label>프로젝트분류</label>
											<select class="form-control select2" style="width: 100%;"name="projDivi" id="projDivi" required >
		
											</select>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>업무담당</label>
											<select class="form-control select2" style="width: 100%;"name="empCd" id="empCd" >
	
											</select>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>담당부서</label>
											<select class="form-control select2" style="width: 100%;" name="depaCd" id="depaCd" >
	
											</select>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<i class="fa-solid fa-circle-check"></i><label for="cntDt"> 계약일자</label>
											<input type="date" name="cntDt" id="cntDt" class="form-control" style="width: 100%; border-radius: 3px;" title="계약일자를 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<i class="fa-solid fa-circle-check"></i><label for="initiateDt"> 착수일자</label>
											<input type="date" name="initiateDt" id="initiateDt" class="form-control" style="width: 100%; border-radius: 3px;" title="착수일자를 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label for="stDt">납기일자</label>
											<input type="date" name="stDt" id="stDt" class="form-control" style="width: 100%; border-radius: 3px;" title="납기일자 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required>
										</div>
									</div>							
								</div>
								<div class="row">
									<div class="col-sm-3">
										<div class="form-group">
											<label>거래처</label>
											<input type="text" class="form-control" placeholder="클릭 ..." name="custNm" id="custNm" onclick="popupHandler('cust','open')" readonly>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>거래처담당자</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="manager" id="manager" >
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>품목</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="item" id="item" >
										</div>
										<!-- /.form-group -->
									</div>
									
									<div class="col-sm-2">
										<div class="form-group">
											<label>분류</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="clas" id="clas" >
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>결재조건</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="payTm" id="payTm" >
										</div>
										<!-- /.form-group -->
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.cnt-in -->
						<div class="card card-warning card-outline">
							<div class="card-header">
								<label class="card-title">견적금액</label>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>합계금액(견적)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="totAmt2" id="totAmt2" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" readonly value="0" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>영업이익(예상)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit" <%--readonly--%> value="0" oninput="edsUtil.formatNumberHtmlInputForInteger(this)" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>영업이익율(예상)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="margin" id="margin" readonly value="0" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>공급가액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="supAmt2" id="supAmt2" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" value="0">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>부가세액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt2" id="vatAmt2" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" value="0">
										</div>
										<!-- /.form-group -->
									</div>
								</div>
								<%--<div class="row">
                                    <div class="col-sm-6">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>예상 영업이익</label>
                                        <input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit">
                                    </div>
                                    <!-- /.form-group -->
                                    </div>
                                    <div class="col-sm-6">
                                        <!-- text input -->
                                        <div class="form-group">
                                        <label>예상 영업이익율</label>
                                        <input type="text" class="form-control" placeholder="입력 ..." name="margin" id="margin">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                </div>--%>
							</div>
						</div>
						<!-- /.cnt-in -->
						<div class="card card-warning card-outline">
							<div class="card-header">
								<label class="card-title">계약금액</label>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>합계금액(계약)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="totAmt3" id="totAmt3" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" readonly value="0" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>영업이익(계약합계금액-매입금액)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="profit2" id="profit2" readonly value="0" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
											<label>영업이익율(예상)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="margin2" id="margin2" readonly value="0" style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>공급가액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="supAmt3" id="supAmt3" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" value="0">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>부가세액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt3" id="vatAmt3" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" value="0">
										</div>
										<!-- /.form-group -->
									</div>
								</div>
								<%--<div class="row">
                                    <div class="col-sm-6">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>예상 영업이익</label>
                                        <input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit">
                                    </div>
                                    <!-- /.form-group -->
                                    </div>
                                    <div class="col-sm-6">
                                        <!-- text input -->
                                        <div class="form-group">
                                        <label>예상 영업이익율</label>
                                        <input type="text" class="form-control" placeholder="입력 ..." name="margin" id="margin">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                </div>--%>
							</div>
						</div>
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">계약품목</label>
								<div class="float-right">
									<div class="container">
										<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnCopy1"	onclick="doAction('edmsEstGridItem', 'copy')"><i class="fa fa-plus"></i> 품목 복사</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('edmsEstGridItem', 'input')"><i class="fa fa-plus"></i> 품목 추가</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('edmsEstGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-12"style="height: calc(60vh)" id="edmsEstGridItem">
										<!-- 그리드 영역 -->
										<!-- 시트가 될 DIV 객체 -->
										<div id="edmsEstGridItemDIV"></div>
									</div>
								</div>
							</div>
						</div>
					<!-- /.row -->
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">적요</label>
							</div>
							<div class="card-body">
								<div class="row">
									<textarea class="form-control" rows="8" placeholder="입력 ..." name ="note1" id="note1"></textarea>
								</div>
							</div>
						</div>
						<button class="btn btn-sm btn-primary" name="submitbtn" id="submitbtn" type="submit" hidden ></button>
					</form>
										<!-- /.row -->
					<div class="row">
						<div class="col-md-12">
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">추가 첨부파일 <small><em>파일을 업로드 하세요.</em></small></label>
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
	Dropzone.autoDiscover = false;//dropzone 정의	
	$(document).ready(async function () {
		dropZoneEvent();
		edsEdms.slideEvent();
		await init();
		TEMPFUNCTIONGDATA();

		document.getElementById('profit').addEventListener('keyup', async ev => {
			var key = ev.keyCode;
			if((key>47 && key<57)||key===8||key===13){
				await applyTotAmt();
			}
		});
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

			edmsEstGridItem = new tui.Grid({
				el: document.getElementById('edmsEstGridItemDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
				header: {
					height: 40,
					minRowHeight: 40,
					complexColumns: [
						/*{
							header: '매입단가',
							name: 'amt',
							childNames: ['cost','supAmt','vatAmt','totAmt']
						},
						{
							header: '견적가',
							name: 'amt2',
							childNames: ['cost2','supAmt2','vatAmt2','totAmt2']
						},
						{
							header: '계약금액',
							name: 'amt3',
							childNames: ['cost3','supAmt3','vatAmt3','totAmt3']
						},*/
					],
				},
				columns:[],
				columnOptions: {
					resizable: true,
					/*frozenCount: 1,
					frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
				},
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						supAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			edmsEstGridItem.setColumns([
				{ header:'*품목명',		name:'itemNm',		width:150,		align:'left',	defaultValue: '',	validation: {required:true}},
				{ header:'규격',			name:'standard',	width:150,		align:'center',	defaultValue: '',	editor:{type:'text'}, validation:{required: true}	},
				{ header:'단위',			name:'unit',		width:50,		align:'center',	defaultValue: '',	editor:{type:'text'}, validation:{required: true}	},
				{ header:'수량',			name:'qty',			width:60,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'견적합계금액',	name:'totAmt2',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'계약합계금액',	name:'totAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'매입단가',		name:'cost',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'매입공급가액',	name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'매입부가세액',	name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'매입합계금액',	name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'적요',			name:'note',		minWidth :250,	align:'left',	defaultValue: '',	editor:{type:'text'}},
				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
				{ header:'품목코드',		name:'itemCd',		width:100,	align:'center',	hidden:true },
				{ header:'할인',			name:'saleDivi',	width:40,	align:'center',	hidden:true },
				{ header:'할인율',		name:'saleRate',	width:100,	align:'right',	hidden:true },
				{ header:'단가',			name:'cost2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'단가',			name:'cost3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'공급가액',		name:'supAmt3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'부가세액',		name:'vatAmt3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	,	hidden:true },
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	,	hidden:true },
				{ header:'과세',			name:'vatDivi',		minWidth:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM006")}},	formatter: 'listItemText',	hidden:true },
				{ header:'TAX',			name:'taxDivi',		minWidth:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM007")}},	formatter: 'listItemText',	hidden:true },

				// hidden(숨김)
			]);
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
		edmsEstGridItem.disableColumn('standard');
		document.edmsGridItemForm.addEventListener("keydown", evt => {
			if ((evt.code) === "Enter") {
				if(!(evt.target.name==="note1"))
				evt.preventDefault();
			}
		});
		edmsEstGridItem.on('editingFinish',async ev => {
			var columnName = ev.columnName;
			var rowKey = ev.rowKey;

			var vatDivi = edmsEstGridItem.getValue(rowKey, 'vatDivi');
			var taxDivi = edmsEstGridItem.getValue(rowKey, 'taxDivi');

			var qty = edmsEstGridItem.getValue(rowKey, 'qty');
			var cost = edmsEstGridItem.getValue(rowKey, 'cost');
			var supAmt = edmsEstGridItem.getValue(rowKey, 'supAmt');
			var vatAmt = edmsEstGridItem.getValue(rowKey, 'vatAmt');
			var totAmt = edmsEstGridItem.getValue(rowKey, 'totAmt');

			var cost2 = edmsEstGridItem.getValue(rowKey, 'cost2');
			var supAmt2 = edmsEstGridItem.getValue(rowKey, 'supAmt2');
			var vatAmt2 = edmsEstGridItem.getValue(rowKey, 'vatAmt2');
			var totAmt2 = edmsEstGridItem.getValue(rowKey, 'totAmt2');

			var cost3 = edmsEstGridItem.getValue(rowKey, 'cost3');
			var supAmt3 = edmsEstGridItem.getValue(rowKey, 'supAmt3');
			var vatAmt3 = edmsEstGridItem.getValue(rowKey, 'vatAmt3');
			var totAmt3 = edmsEstGridItem.getValue(rowKey, 'totAmt3');

			switch (columnName) {
				case 'qty' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 매입가 */
						if(vatAmt === 0){ // => 우리회사만 이런거니까 다른회사에 팔때는 없애야함
							supAmt = cost * qty; // 공급가액
							vatAmt = 0; // TAX
							totAmt = supAmt; // 합계금액
						}else{
							supAmt = cost * qty; // 공급가액
							vatAmt = supAmt * 0.1; // TAX
							totAmt = supAmt * 1.1 // 합계금액
						}
						// => 우리회사만 이런거니까 다른회사에 팔때는 풀어야함
						/*supAmt = totAmt / 1.1; // 공급가액
						vatAmt = supAmt * 0.1; // TAX
						cost = supAmt /qty; // 단가*/
						/* 견적가 */
						supAmt2 = totAmt2 / 1.1; // 공급가액
						vatAmt2 = supAmt2 * 0.1; // TAX
						cost2 = supAmt2 /qty; // 단가
						/* 계약합계금액 */
						supAmt3 = totAmt3 / 1.1; // 공급가액
						vatAmt3 = supAmt3 * 0.1; // TAX
						cost3 = supAmt3 /qty; // 단가
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = totAmt; // 공급가액
						vatAmt = 0; // TAX
						cost = supAmt /qty; // 단가
						/* 견적가 */
						supAmt2 = totAmt2; // 공급가액
						vatAmt2 = 0; // TAX
						cost2 = supAmt2 /qty; // 단가
						/* 계약합계금액 */
						supAmt3 = totAmt3; // 공급가액
						vatAmt3 = 0; // TAX
						cost3 = supAmt3 /qty; // 단가
					}
					break;
				case 'cost' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 매입가 */
							supAmt = qty * cost; // 공급가액
							vatAmt = supAmt * 0.1; // TAX
						} else {//포함
							/* 매입가 */
							supAmt = qty * cost / 1.1; // 공급가액
							vatAmt = qty * cost - supAmt; // TAX
						}
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = qty * cost; // 공급가액
						vatAmt = 0; // TAX
					}
					break;
				case 'cost2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 견적가 */
							supAmt2 = qty * cost2; // 공급가액
							vatAmt2 = supAmt2 * 0.1; // TAX
						} else {//포함
							/* 견적가 */
							supAmt2 = qty * cost2 / 1.1; // 공급가액
							vatAmt2 = qty * cost2 - supAmt2; // TAX
						}
					} else {// 면세, 영세
						/* 견적가 */
						supAmt2 = qty * cost2; // 공급가액
						vatAmt2 = 0; // TAX
					}
					break;
				case 'cost3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 할인가 */
							supAmt3 = qty * cost3; // 공급가액
							vatAmt3 = supAmt3 * 0.1; // TAX
						} else {//포함
							/* 할인가 */
							supAmt3 = qty * cost3 / 1.1; // 공급가액
							vatAmt3 = qty * cost3 - supAmt3; // TAX
						}
					} else {// 면세, 영세
						/* 할인가 */
						supAmt3 = qty * cost3; // 공급가액
						vatAmt3 = 0; // TAX
					}
					break;
				case 'supAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						// 별도, 포함
						/* 매입가 */
						cost = supAmt/qty; // 단가
						vatAmt = supAmt/10; // TAX
						totAmt = supAmt/1.1; // 공급가액

					} else {// 면세, 영세
						/* 매입가 */
						cost = supAmt/qty; // 단가
						vatAmt = 0; // TAX
						totAmt = supAmt; // 공급가액
					}
					break;
				case 'supAmt2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = supAmt2/10; // TAX
						totAmt2 = supAmt2/1.1; // 공급가액
					} else {// 면세, 영세
						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = 0; // TAX
						totAmt2 = supAmt2; // 공급가액
					}
					break;
				case 'supAmt3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 할인가 */
						cost3 = supAmt3/qty; // 단가
						vatAmt3 = supAmt3/10; // TAX
						totAmt3 = supAmt3/1.1; // 공급가액

					} else {// 면세, 영세
						/* 할인가 */
						cost3 = supAmt3/qty; // 단가
						vatAmt3 = 0; // TAX
						totAmt3 = supAmt3; // 공급가액
					}
					break;
				case 'totAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 매입가 */
						supAmt = totAmt/11*10; // 공급가액
						vatAmt = totAmt/11; // TAX
						cost = supAmt/qty; // 단가
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = totAmt; // 공급가액
						vatAmt = 0; // TAX
						cost = supAmt/qty; // 단가
					}
					break;
				case 'totAmt2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 견적가 */
						supAmt2 = totAmt2/11*10; // 공급가액
						vatAmt2 = totAmt2/11; // TAX
						cost2 = supAmt2/qty; // 단가
					} else {// 면세, 영세
						/* 견적가 */
						supAmt2 = totAmt2; // 공급가액
						vatAmt2 = 0; // TAX
						cost2 = supAmt2/qty; // 단가
					}
					break;
				case 'totAmt3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 할인가 */
						supAmt3 = totAmt3/11*10; // 공급가액
						vatAmt3 = totAmt3/11; // TAX
						cost3 = supAmt3/qty; // 단가

					} else {// 면세, 영세
						/* 할인가 */
						supAmt3 = totAmt3; // 공급가액
						vatAmt3 = 0; // TAX
						cost3 = supAmt3/qty; // 단가
					}
					break;
			}

			/**
			 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
			 * */

			/* 매입가 */
			if(cost < 0||supAmt < 0||vatAmt < 0||totAmt < 0){ // 특별 DC 처리
				cost = cost*(-1);
				supAmt = supAmt*(-1);
				vatAmt = vatAmt*(-1);
				totAmt = totAmt*(-1);
				cost = Math.round(cost)*(-1); // 올림
				supAmt = Math.round(supAmt)*(-1);  // 반올림
				vatAmt = Math.round(vatAmt)*(-1); // 반올림
				totAmt = supAmt + vatAmt; // 합계
			}else{
				cost = Math.round(cost); // 올림
				supAmt = Math.round(supAmt);  // 반올림
				vatAmt = Math.round(vatAmt); // 반올림
				totAmt = supAmt + vatAmt; // 합계
			}
			edmsEstGridItem.setValue(rowKey, "cost", cost);
			edmsEstGridItem.setValue(rowKey, "supAmt", supAmt);
			edmsEstGridItem.setValue(rowKey, "vatAmt", vatAmt);
			edmsEstGridItem.setValue(rowKey, "totAmt", supAmt + vatAmt);

			/* 견적가 */
			cost2 = Math.round(cost2); // 올림
			supAmt2 = Math.round(supAmt2);  // 반올림
			vatAmt2 = Math.round(vatAmt2); // 반올림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			edmsEstGridItem.setValue(rowKey, "cost2", cost2);
			edmsEstGridItem.setValue(rowKey, "supAmt2", supAmt2);
			edmsEstGridItem.setValue(rowKey, "vatAmt2", vatAmt2);
			edmsEstGridItem.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 할인가 */
			cost3 = Math.round(cost3); // 올림
			supAmt3 = Math.round(supAmt3);  // 반올림
			vatAmt3 = Math.round(vatAmt3); // 반올림
			totAmt3 = supAmt3 + vatAmt3; // 합계
			edmsEstGridItem.setValue(rowKey, "cost3", cost3);
			edmsEstGridItem.setValue(rowKey, "supAmt3", supAmt3);
			edmsEstGridItem.setValue(rowKey, "vatAmt3", vatAmt3);
			edmsEstGridItem.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

			/* 매입가+견적가+할인가 합계 적용 */
			await applyTotAmt();
		});
		edmsEstGridItem.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					/*if(colNm ==='itemNm')
					{
						await popupHandler('item','open')
					}else */if(colNm==='standard') {
						await edsUtil.sheetData2Maldal(edmsEstGridItem);
					};
				}
			});
		edmsEstGridItem.on('keydown', async ev => {
			let colNm = ev.columnName;
			let target = ev.keyboardEvent.key;
			if(target === 'Enter')
			{
				/*if(colNm ==='itemNm')
					{
						await popupHandler('item','open')
					};*/
			}
		});
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		var height = window.innerHeight - 40;
		document.getElementById('edmsEstGridItem').style.height = window.innerHeight*(0.6) + 'px';
		
	
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'edmsEstGridItem') {
				switch (sAction) {
					case "search":// 조회
						edmsEstGridItem.refreshLayout(); // 데이터 초기화
						edmsEstGridItem.finishEditing(); // 데이터 마감
						edmsEstGridItem.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#edmsGridItemForm")); //조회조건
						edmsEstGridItem.resetData(edsUtil.getAjax("/EDMS_EST_REPORT/selectEstItemList", param)); // 데이터 set
						if(edmsEstGridItem.getRowCount() > 0 ){
							edmsEstGridItem.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규
						/*var row = edmsEstGridItem.getFocusedCell();
						var appendedData = {};
						appendedData.status = "C";
						appendedData.corpCd = document.getElementById("corpCd").value;
						appendedData.busiCd = document.getElementById("busiCd").value;
						appendedData.vatDivi = '01';
						appendedData.taxDivi = '01';
						appendedData.cost = 0;
						appendedData.qty =1;
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;
						appendedData.cost2 = 0;
						appendedData.supAmt2 = 0;
						appendedData.vatAmt2 = 0;
						appendedData.totAmt2 = 0;
						appendedData.cost3 = 0;
						appendedData.supAmt3 = 0;
						appendedData.vatAmt3 = 0;
						appendedData.totAmt3 = 0;
						appendedData.saleDivi = '01';
						appendedData.saleRate = 0;
						edmsEstGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가*/
						await popupHandler('item','open');
						break;
					case "copy":// 복사
					{
						const rows = edmsEstGridItem.getCheckedRows();
						for(const data of rows)
						{
							data._attributes.checked=false;
							data.seq='';
						}
						let check=false;
						if(rows.length>0)
						{
							await edmsEstGridItem.appendRows(rows);
						}
						else
						{
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '선택된 품목이 없습니다.',
							});
						}
					}
						break;
					case "delete"://삭제
						{
							const rows = edmsEstGridItem.getCheckedRows();
							let check=false;
							if(rows.length>0)
							{

								await edmsEstGridItem.removeCheckedRows(true);
								await applyTotAmt();

							}
							else
							{
								return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '선택된 품목이 없습니다.',
								});
							}

						}
						break;
				}
			}
	}
	/** 버튼이벤트
	 * */
async function btnEvent(name){
		switch (name) {
			case 'cancel':
			{
				let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));
				if(!(await edsEdms.deleteSubmitList([param]))) return;;
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
			}
			break;
			case 'save':
			{
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='01'//저장
				const parentData=data;
				await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
			}
			break;		
			case 'tempSave':
			{
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='02'//임시저장
				const parentData=data;
				await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
				
			}
			break;		
			case 'close':	
			{
				let param = {};
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
			}
			break;
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
			var row = edmsEstGridItem.getFocusedCell();
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
							addUser(callback,'appUsers');
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
						addUser(callback,'ccUsers');
					}
					}
					break;
				case 'item':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ITEMPOPUP',param)
					}else{
						// edmsEstGridItem.focus(row.rowKey,'itemNm',true);
						var rst = callback.param;
						if(rst === undefined) return;
						var rstLen = rst.length;
						// var subRow = edmsEstGridItem.getFocusedCell();
						if(rstLen > 0){
							for(var i=0; i<rstLen; i++){
								var data = edsUtil.cloneObj(edmsEstGridItem.getData());
								var itemRow = edsUtil.getMaxObject(data,'rowKey');
								if(itemRow == undefined) itemRow = 0;
								else if(itemRow.hasOwnProperty('rowKey'))itemRow = edsUtil.getMaxObject(data,'rowKey').rowKey;
								rst[i].rowKey = itemRow+1;
								rst[i].corpCd = document.getElementById("corpCd").value;
								rst[i].busiCd = document.getElementById("busiCd").value;
								rst[i].vatDivi = '01';
								rst[i].taxDivi = '01';
								rst[i].qty = 1;
								rst[i].cost = 0;
								rst[i].supAmt = 0;
								rst[i].vatAmt = 0;
								rst[i].totAmt = 0;
								rst[i].cost2 = 0;
								rst[i].supAmt2 = 0;
								rst[i].vatAmt2 = 0;
								rst[i].totAmt2 = 0;
								rst[i].cost3 = 0;
								rst[i].supAmt3 = 0;		
								rst[i].vatAmt3 = 0;
								rst[i].totAmt3 = 0;
								rst[i].saleDivi = '01';
								rst[i].saleRate = 0;
								rst[i]._attributes.checked = false;
								edmsEstGridItem.appendRow(rst[i])
							}
							edmsEstGridItem.focus(rst[0].rowKey,'itemNm',true);
							// edmsEstGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
						}
					}
					break;
				case 'itemPopup':
					if(divi==='open'){
						document.getElementById('btnItemPopup').click();
						setTimeout(async ev =>{
							await doAction('edmsEstGridItem','search')
						},200)
					}else{

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
		/* 품목 조회 */
		await doAction("edmsEstGridItem", "search");
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

	async function applyTotAmt(){
		/* 매입가+견적가+할인가 합계 적용 */
		var supAmtAll = 0;
		var vatAmtAll = 0;
		var totAmtAll = 0;
		var supAmtAll2 = 0;
		var vatAmtAll2 = 0;
		var totAmtAll2 = 0;
		var supAmtAll3 = 0;
		var vatAmtAll3 = 0;
		var totAmtAll3 = 0;

		var data = edmsEstGridItem.getFilteredData()
		var dataLen = data.length;
		for (let i = 0; i < dataLen; i++) {
			supAmtAll += Number(data[i].supAmt);
			vatAmtAll += Number(data[i].vatAmt);
			totAmtAll += Number(data[i].totAmt);
			supAmtAll2 += Number(data[i].supAmt2);
			vatAmtAll2 += Number(data[i].vatAmt2);
			totAmtAll2 += Number(data[i].totAmt2);
			supAmtAll3 += Number(data[i].supAmt3);
			vatAmtAll3 += Number(data[i].vatAmt3);
			totAmtAll3 += Number(data[i].totAmt3);
		}
		edmsEstGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
		edmsEstGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
		edmsEstGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

		edmsEstGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
		edmsEstGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
		edmsEstGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

		edmsEstGridItem.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmtAll3));
		edmsEstGridItem.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmtAll3));
		edmsEstGridItem.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmtAll3));

		document.getElementById('supAmt2').value=edsUtil.addComma(supAmtAll2);
		document.getElementById('vatAmt2').value=edsUtil.addComma(vatAmtAll2);
		document.getElementById('totAmt2').value=edsUtil.addComma(totAmtAll2);

		document.getElementById('supAmt3').value=edsUtil.addComma(supAmtAll3);
		document.getElementById('vatAmt3').value=edsUtil.addComma(vatAmtAll3);
		document.getElementById('totAmt3').value=edsUtil.addComma(totAmtAll3);

		var profit = document.getElementById('profit');
		var margin = document.getElementById('margin');

		if(!isNaN(Number(edsUtil.removeComma(profit.value)))){

			var value= Math.round(Number(edsUtil.removeComma(profit.value))/totAmtAll2*10000)/100;

			if(totAmtAll2 === 0){
				margin.value = 0+"%"
			}else {
				margin.value = value+"%"
			}
		}

		var profit2 = document.getElementById('profit2');
		var margin2 = document.getElementById('margin2');

		profit2.value = edsUtil.addComma(totAmtAll3 - totAmtAll);

		if(!isNaN(Number(edsUtil.removeComma(profit2.value)))){

			var value= Math.round((totAmtAll3 - totAmtAll)/totAmtAll3*10000)/100;

			if(totAmtAll3 === 0){
				margin2.value = 0+"%"
			}else {
				margin2.value = value+"%"
			}
		}
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>