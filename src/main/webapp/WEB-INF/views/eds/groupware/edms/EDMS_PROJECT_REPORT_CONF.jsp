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
				<a class="navbar-brand" href="#"><h3>프로젝트 등록품의</h3></a>
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
								<input type="hidden" name="corpCd" id="corpCd" value="">
								<input type="hidden" name="busiCd" id="busiCd" value="">
								<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
								<input type="hidden" name="name" id="name" title="구분값">
								<input type="hidden" name="custNm" id="custNm" title="고객번호">
								<input type="hidden" id="currApproverCd" >
								<input type="hidden" id="docDivi" >
								<input type="hidden" id="inpId" >
								<input type="hidden" id="estDt">
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
								<label class="card-title" style="">프로젝트 정보</label>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<div class="row">
										<div class="col-sm-12">
											<!-- text input -->
											<div class="form-group" style="text-align: center;">
											<label>아래와 같이 프로젝트 등록을 품의하오니, 재가하여 주시기 바랍니다. </label>
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
												<input type="text" class="form-control" placeholder="Enter ..." name="projNm" id="projNm" required readonly style="background-color: yellow">
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-6">
											<!-- text input -->
											<div class="form-group">
											<label for="projPur">프로젝트목적</label>
											<input type="text" class="form-control" placeholder="Enter ..." name="projPur" id="projPur" required readonly>
											</div>
											<!-- /.form-group -->
										</div>
									</div>
									<div class="row">
										<div class="col-sm-2">
											<div class="form-group">
												<i class="fa-solid fa-circle-check"></i> <label>프로젝트분류</label>
												<select class="form-control select2" style="width: 100%;"name="projDivi" id="projDivi" required disabled>
			
												</select>
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label>업무담당</label>
												<select class="form-control select2" style="width: 100%;"name="empCd" id="empCd" disabled>
		
												</select>
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label>담당부서</label>
												<select class="form-control select2" style="width: 100%;" name="depaCd" id="depaCd" disabled>
		
												</select>
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<i class="fa-solid fa-circle-check"></i><label for="cntDt"> 계약일자</label>
												<input type="date" name="cntDt" id="cntDt" class="form-control" style="width: 100%; border-radius: 3px;" title="계약일자를 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required readonly>
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<i class="fa-solid fa-circle-check"></i><label for="initiateDt"> 착수일자</label>
												<input type="date" name="initiateDt" id="initiateDt" class="form-control" style="width: 100%; border-radius: 3px;" title="착수일자를 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required readonly>
											</div>
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label for="stDt">납기일자</label>
												<input type="date" name="stDt" id="stDt" class="form-control" style="width: 100%; border-radius: 3px;" title="납기일자 입력하세요." data-inputmask="'mask': '9999-99-99'" data-mask required readonly>
											</div>
										</div>							
									</div>
									<div class="row">
										<div class="col-sm-3">
											<div class="form-group">
												<label>거래처</label>
												<input type="text" class="form-control" placeholder="클릭 ..." name="custNm" id="custNm" readonly>
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-3">
											<div class="form-group">
												<label>거래처담당자</label>
												<input type="text" class="form-control" placeholder="입력 ..." name="manager" id="manager" readonly>
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label>품목</label>
												<input type="text" class="form-control" placeholder="입력 ..." name="item" id="item" readonly>
											</div>
											<!-- /.form-group -->
										</div>
										
										<div class="col-sm-2">
											<div class="form-group">
												<label>분류</label>
												<input type="text" class="form-control" placeholder="입력 ..." name="clas" id="clas" readonly>
											</div>
											<!-- /.form-group -->
										</div>
										<div class="col-sm-2">
											<div class="form-group">
												<label>결재조건</label>
												<input type="text" class="form-control" placeholder="입력 ..." name="payTm" id="payTm" readonly >
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
													<input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit" readonly value="0" style="background-color: yellow">
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
							<div class="card card-lightblue card-outline" hidden>
								<div class="card-header">
									<label class="card-title">계약품목</label>
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
							<div class="card card-lightblue card-outline">
								<div class="card-header">
								  <label class="card-title">계약품목</label>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0 overflow-auto">
								  <table class="table table-bordered table-hover">
									<thead class="tableTitle">
									  <tr>
										  <th style="text-align:center;vertical-align:middle;min-width: 100px;width: 15%;">품목명</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 200px;width: 25%;">규격</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 40px; width: 5%;">단위</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 40px; width: 5%;">수량</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">견적합계금액</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">계약합계금액</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">매입단가</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">매입공급가액</th>
										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">매입부가세액</th>
<%--										  <th style="text-align:center;vertical-align:middle;min-width: 120px; width: 10%;">매입합계금액</th>--%>
										  <th style="text-align:center;vertical-align:middle;min-width: 150px;width: 35%;">비고</th>
									  </tr>
									</thead>
									<tbody  class="tableBodys" id="tableBody">
									</tbody>
								  </table>
								</div>
								<!-- /.card-body -->
							</div>
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
							<!-- /.row -->						
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
	let edmsEstGridItem;
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
					height: 56,
					minRowHeight: 56,
					complexColumns: [
						{
							header: '매입가',
							name: 'amt',
							childNames: ['cost','supAmt','vatAmt','totAmt']
						},
						{
							header: '견적가',
							name: 'amt2',
							childNames: ['cost2','supAmt2','vatAmt2','totAmt2']
						},
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
				{ header:'품목명',		name:'itemNm',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'과세',		name:'vatDivi',		minWidth:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM006")}},	formatter: 'listItemText'},
				{ header:'TAX',			name:'taxDivi',		minWidth:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM007")}},	formatter: 'listItemText'},
				{ header:'규격',		name:'standard',	minWidth:150,	align:'center',	defaultValue: ''	,editor:{type:'text'}},
				{ header:'수량',		name:'qty',			minWidth:60,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'단가',		name:'cost3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'공급가액',	name:'supAmt3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'부가세액',	name:'vatAmt3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'합계금액',	name:'totAmt3',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'적요',		name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor:{type:'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
				{ header:'품목코드',		name:'itemCd',		width:100,	align:'center',	hidden:true },
				{ header:'할인',			name:'saleDivi',	width:40,	align:'center',	hidden:true },
				{ header:'할인율',		name:'saleRate',	width:100,	align:'right',	hidden:true },
				{ header:'단가',			name:'cost',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'단가',			name:'cost2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	hidden:true },
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	,	hidden:true },
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	,	hidden:true },

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
	

		if(parent) {//부모 iframe 과통신
			//수신 이벤트 발생 
			window.addEventListener("message", async function(message) {
				if(message.data.messageDivi=='save')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='tempSave')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
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
						let param = ut.serializeObject(document.querySelector("#edmsGridItemForm")); //조회조건
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
					case "delete"://삭제
						{
							const rows = edmsEstGridItem.getCheckedRows();
							let check=false;
							if(rows.length>0)
							{

								await edmsEstGridItem.removeCheckedRows(true);

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
			case 'approve':
			{
				let Edmsdata = ut.serializeObject(document.querySelector("#edmsGridItemForm"));
				let param={};
				param.data=Edmsdata;
				param.form=document.querySelector("#edmsGridItemForm");
				param.select=select;
				await edsUtil.eds_FormToData(param);//param에 폼데이터 입력
				let itemList = await edsUtil.getAjax("/EDMS_EST_REPORT/selectEstItemList", Edmsdata);
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
	 async function popupHandler(name,divi,callback){
			let row = edmsEstGridItem.getFocusedCell();
			let names = name.split('_');
			switch (names[0]) {
				case 'adress':
					if(divi==='open'){
						let param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('EMAILADRESSPOPUP',param);
					}else{
						/**
						 * name = adress_documentId => documentId setting
						 * */
						let returnName = name.split('_');
						let input = document.getElementById(returnName[1]);

						/**
						 * inputArr + callbackArr and remove duplicates
						 * */
						let inputArr = [...new Set(input.value.split(',').concat(callback.adress))]

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
						let param={}
						param.corpCd= edmsEstGridItem.getValue(row.rowKey, 'corpCd');
						param.custNm= edmsEstGridItem.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						edmsEstGridItem.setValue(row.rowKey,'custCd',callback.custCd);
						edmsEstGridItem.setValue(row.rowKey,'custNm',callback.custNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						let param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= edmsEstGridItem.getValue(row.rowKey, 'depaNm')??'';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						edmsEstGridItem.setValue(row.rowKey,'depaCd',callback.depaCd);
						edmsEstGridItem.setValue(row.rowKey,'depaNm',callback.depaNm);
					}
					break;
				case 'user':
					if(divi==='open'){
						let param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
						param.name= name;
						await edsIframe.openPopup('USERPOPUP',param)
					}else{
						edmsEstGridItem.setValue(row.rowKey,'manCd',callback.empCd);
						edmsEstGridItem.setValue(row.rowKey,'manNm',callback.empNm);
					}
					break;
				case 'item':
					if(divi==='open'){
						let param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ITEMPOPUP',param)
					}else{

						let rst = callback.param;
						if(rst === undefined) return;
						let rstLen = rst.length;
						// let subRow = edmsEstGridItem.getFocusedCell();
						if(rstLen > 0){
							for(let i=0; i<rstLen; i++){
								let data = edsUtil.cloneObj(edmsEstGridItem.getData());
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
		let reqData = await edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitTempList", params); // 데이터 set
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
		//await doAction("edmsEstGridItem", "search");
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
		let data = edsUtil.getAjax("/EDMS_EST_REPORT/selectEstItemList", param);
		  // Create table data rowsitemAlign
		  const table = document.getElementById('tableBody');
		  for (const obj of data) {
			  const dataRow = document.createElement('tr');
			  const itemNmCell = document.createElement('td');
			  itemNmCell.textContent = obj['itemNm'];
			  dataRow.appendChild(itemNmCell);
			  const itemStand = document.createElement('td');
			  itemStand.textContent = obj['standard'];
			  dataRow.appendChild(itemStand);
			  const itemUnit = document.createElement('td');
			  itemUnit.setAttribute("class","itemAlign");
			  itemUnit.textContent = obj['unit'];
			  dataRow.appendChild(itemUnit);
			  const qtyCell = document.createElement('td');
			  qtyCell.setAttribute("class","numberAlign");
			  qtyCell.textContent = obj['qty'];
			  dataRow.appendChild(qtyCell);
			  const totAmt2Cell = document.createElement('td');
			  totAmt2Cell.setAttribute("class","numberAlign");
			  totAmt2Cell.textContent = edsUtil.addComma(obj['totAmt2'])+'원';
			  dataRow.appendChild(totAmt2Cell);
			  const totAmt3Cell = document.createElement('td');
			  totAmt3Cell.setAttribute("class","numberAlign");
			  totAmt3Cell.textContent = edsUtil.addComma(obj['totAmt3'])+'원';
			  dataRow.appendChild(totAmt3Cell);
			  const costCell = document.createElement('td');
			  costCell.setAttribute("class","numberAlign");
			  costCell.textContent = edsUtil.addComma(obj['cost'])+'원';
			  dataRow.appendChild(costCell);
			  const supAmtCell = document.createElement('td');
			  supAmtCell.setAttribute("class","numberAlign");
			  supAmtCell.textContent = edsUtil.addComma(obj['supAmt'])+'원';
			  dataRow.appendChild(supAmtCell);
			  const vatAmtCell = document.createElement('td');
			  vatAmtCell.setAttribute("class","numberAlign");
			  vatAmtCell.textContent = edsUtil.addComma(obj['vatAmt'])+'원';
			  dataRow.appendChild(vatAmtCell);

			  /*const totAmtCell = document.createElement('td'); // 매입합계금액값
			  totAmtCell.setAttribute("class","numberAlign");
			  totAmtCell.textContent = edsUtil.addComma(obj['totAmt'])+'원';
			  dataRow.appendChild(totAmtCell);*/

			  const noteCell = document.createElement('td');
			  noteCell.textContent = obj['note'];
			  dataRow.appendChild(noteCell);
			  table.appendChild(dataRow);
		}
	
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