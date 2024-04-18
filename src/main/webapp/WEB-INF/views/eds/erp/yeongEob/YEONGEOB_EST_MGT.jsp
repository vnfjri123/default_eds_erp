<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>

	<style>
		.form-row label{
			margin-bottom: 0;
		}
		.form-row .mb-3{
			margin-bottom: 0.5rem !important;
		}
	</style>
</head>

<body>
<div class="row" style="position:relative">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group-prepend" style="min-width: 15rem;">
								<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd" >
								</select>
							</div>
<%--							<label for="busiCd">사업장 &nbsp;</label>--%>
<%--							<div class="input-group-prepend">--%>
<%--								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">--%>
<%--							</div>--%>
<%--							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>--%>
<%--							<div class="input-group-append">--%>
<%--								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>--%>
<%--							</div>--%>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="stDt">조회기간 &nbsp;</label>
							<div class="input-group-prepend">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="stDt" id="stDt" title="끝">
							</div>
							<span>&nbsp;~&nbsp;</span>
							<div class="input-group-append">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="edDt" id="edDt" title="끝">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="projNm">프로젝트 &nbsp;</label>
							<input type="text" class="form-control" name="projNm" id="projNm" title="프로젝트명">
							<div class="form-group-append">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('yeongEobGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="yeongEobGridList" style="height: calc(100vh - 6rem); width: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="yeongEobGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="yeongEobGridListButtonForm" id="yeongEobGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnFinish"		id="btnFinish"		onclick="doAction('yeongEobGridList', 'finish')"><i class="fa fa-lock"></i> 마감</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnCancel"		id="btnCancel"		onclick="doAction('yeongEobGridList', 'cancel')"><i class="fa fa-unlock"></i> 마감취소</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"		id="btnSearch"		onclick="doAction('yeongEobGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnInput"		id="btnInput"		onclick="doAction('yeongEobGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnSave"			id="btnSave"		onclick="doAction('yeongEobGridList', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete"		id="btnDelete"		onclick="doAction('yeongEobGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnSubmit"		id="btnSubmit"		onclick="doAction('yeongEobGridList', 'submit')"><i class="fa fa-save"></i> 프로젝트상신</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopEv"	id="btnEmailPopEv"data-toggle="modal" data-target="#modalCart3"style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnItemPopEv"	id="btnItemPopEv"	data-toggle="modal" data-target="#modalCart" style="display: none">item list modal</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color text-white">
				<h4 class="modal-title" style="color: #000">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<style>
					#modalCart #yeongEobGridListForm input::placeholder,
					#modalCart #yeongEobGridListForm textarea::placeholder{
						color: #6c6665;
					}
				</style>
				<div class="col-md-12" style="height: 100%;">
					<form name="yeongEobGridListForm" id="yeongEobGridListForm">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
						<input type="hidden" name="estCd" id="estCd" title="견적코드">
						<input type="hidden" name="deadDivi" id="deadDivi" title="마감구분">
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">프로젝트 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-6 mb-3">
										<label for="projNm"><b>프로젝트</b></label>
										<input type="text" class="form-control" id="projNm" name="projNm" style="background-color: #fff" placeholder="프로젝트.." readonly="readonly" style="background-color: yellow">
									</div>
									<div class="col-md-6 mb-3">
										<label for="custNm"><b>거래처</b></label>
										<input type="hidden" name="custCd" id="custCd" title="거래처코드">
										<input type="text" class="form-control" id="custNm" name="custNm" style="background-color: #fff" placeholder="거래처.." readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-3 mb-3">
										<label for="depaNm"><b>부서</b></label>
										<input type="hidden" name="depaCd" id="depaCd" title="부서코드">
										<input type="text" class="form-control text-center" style="background-color: #fff" id="depaNm" name="depaNm" placeholder="부서.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="manNm"><b>담당자</b></label>
										<input type="hidden" name="manCd" id="manCd" title="담당자코드">
										<input type="text" class="form-control text-center" style="background-color: #fff" id="manNm" name="manNm" placeholder="담당자.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="validDt"><b>분류</b></label>
										<input type="text" class="form-control" style="background-color: #fff" id="clas" name="clas" placeholder="분류.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="validDt"><b>품목</b></label>
										<input type="text" class="form-control" style="background-color: #fff" id="item" name="item" placeholder="품목.." readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-4 mb-3 d-none">
										<label for="supAmt2"><b>공급가액</b></label>
										<input type="hidden" name="supAmt" id="supAmt" title="공급가액">
										<input type="text" class="form-control text-right" id="supAmt2" name="supAmt2" placeholder="공급가액.." readonly="readonly">
									</div>
									<div class="col-md-4 mb-3 d-none">
										<label for="vatAmt2"><b>부가세액</b></label>
										<input type="hidden" name="vatAmt" id="vatAmt" title="부가세액">
										<input type="text" class="form-control text-right" id="vatAmt2" name="vatAmt2" placeholder="부가세액.." readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6 mb-3">
										<label for="note1"><b>적요</b></label>
										<textarea style="resize: none" rows="10" type="text" class="form-control" id="note1" name="note1" placeholder="적요"></textarea>
									</div>
									<div class="col-md-6 mb-3 d-none">
										<label for="note2"><b>결재자보고내용</b></label>
										<textarea style="resize: none" rows="10" type="text" class="form-control" id="note2" name="note2" placeholder="결재자보고내용.."></textarea>
									</div>
									<div class="col-md-6 mb-3">
										<div class="card card card-lightblue card-outline" style="border: none;">
											<label for="note2"><b>결재의견 <small><em>결재의견을 입력하세요.</em></small></b></label>
											<!-- /.card-header -->
											<!-- /.card-body -->
											<div class="card-footer card-comments" id="messageBox" style="position: relative;height: 198px;overflow: auto;">
											</div>
											<!-- /.card-footer -->
											<div class="card-footer">
												<img style="border-radius: 50%;height: 1.875rem;width: 1.875rem;float: left;max-width: 100%;vertical-align: middle;border-style: none;" class="img-fluid img-circle img-sm" src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}" alt="Alt Text" id="messageFace">
												<!-- .img-push is used to add margin to elements next to floating images -->
												<div class="img-push" style="width: calc(100% - 2.5*1.875rem);float: left;">
													<input id="submitInput"type="text" class="form-control form-control-sm" placeholder="엔터..." onkeyup="if(window.event.keyCode==13 && window.event.shiftKey===false){edsEdms.initMessage2(this,yeongEobGridList,${LoginInfo.empCd})}">
												</div>
												<button type="button" class="btn btn-tool float-right" style="font-size: 11px;width: calc(1.5*1.875rem);padding: unset;vertical-align: middle;text-align: center;height: 30px;border: 1px solid #000;" onclick="edsEdms.initMessage2(document.getElementById('submitInput'),yeongEobGridList,${LoginInfo.empCd})">전송</button>
											</div>
											<!-- /.card-footer -->
										</div>
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #fdbf07;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">견적금액</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>합계금액(견적)</b></label>
										<input type="hidden" name="totAmt" id="totAmt" title="합계금액">
										<input type="text" class="form-control text-right" id="totAmt2" style="background-color: yellow" name="totAmt2" placeholder="합계금액.." readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익(예상)</b></label>
										<input type="text" class="form-control text-right" id="profit" style="color: red;font-weight: bold;background-color: yellow" name="profit" placeholder="영업이익.." readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익율(예상)</b></label>
										<input type="text" class="form-control text-right" id="margin" style="color: red;font-weight: bold;background-color: yellow" name="margin" placeholder="영업이익율.." readonly="readonly">
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">계약품목</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body" style="padding: unset;">
								<div class="form-row">
									<div class="col-md-12" id="yeongEobGridItem" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="yeongEobGridItemDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">인쇄 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-3 mb-3">
										<label for="estDt"><b>견적일자</b></label>
										<input type="text" class="form-control text-center" id="estDt" name="estDt" placeholder="견적일자.." aria-label="Date-Time">
										<div id="estDtDIV" style="margin-top: -1px;z-index: 1050;position: absolute"></div>
									</div>
									<div class="col-md-3 mb-3">
										<label for="validDt"><b>유효기간</b></label>
										<input type="text" class="form-control text-center" id="validDt" name="validDt" placeholder="유효기간.." aria-label="Date-Time">
										<div id="validDtDIV" style="margin-top: -1px;z-index: 1050;position: absolute"></div>
									</div>
									<div class="col-md-3 mb-3">
										<label for="payTm"><b>결제조건</b></label>
										<input type="text" class="form-control" id="payTm" name="payTm" placeholder="결제조건..">
									</div>
									<div class="col-md-3 mb-3">
										<label for="manNote"><b>담당</b></label>
										<input type="text" class="form-control" id="manNote" name="manNote" placeholder="담당..">
									</div>
									<div class="col-md-12 mb-3">
										<label for="note3"><b>비고</b></label>
										<textarea rows="10" type="text" class="form-control" id="note3" name="note3" placeholder="비고"></textarea>
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
					</form>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="yeongEobGridItemButtonForm" id="yeongEobGridItemButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch1"	id="btnSearch1"	onclick="doAction('yeongEobGridItem', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--											<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('yeongEobGridItem', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrintSave1"	id="btnPrintSave1"	onclick="doAction('yeongEobGridItem', 'save')"><i class="fa fa-save"></i> 저장</button>
<%--											<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('yeongEobGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>--%>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint"		id="btnPrint"		onclick="doAction('yeongEobGridList', 'print')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopup"	id="btnEmailPopup"	onclick="doAction('yeongEobGridList', 'emailPopup')"><i class="fa fa-envelope"></i> 메일전송</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose1"	id="btnClose1"	onclick="doAction('yeongEobGridItem', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart3" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header">
				<h4 class="modal-title">이메일 전송</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" id="yeongEobGridEmail" style="height: calc(71vh); width: 100%;">
								<div id="yeongEobGridEmailDIV" style="width:100%; height:100%;"></div>
							</div>
						</div>
					</div>
					<div class="col-md-7" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" style="height: 100%;">
								<!-- form start -->
								<form class="form-inline" role="form" name="baseEmailForm" id="baseEmailForm" method="post" onsubmit="return false;">
									<table class="table table-bordered table-sm">
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">보내는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setFrom" id="setFrom"/>
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button" onclick="popupHandler('adress_setFrom','open'); return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">받는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="toAddr" id="toAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_toAddr','open'); return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="ccAddr" id="ccAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_ccAddr','open');  return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">숨은 참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="bccAddr" id="bccAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_bccAddr','open');  return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">제목</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setSubject" id="setSubject">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">파일 첨부</td>
											<td style="padding: 0">
												<div class="input-group">
													<div class="custom-file">
														<input style="text-align: left" type="file" class="custom-file-input" name="emailFile" id="emailFile" aria-describedby="emailFile" multiple>
														<label class="custom-file-label" for="emailFile">파일을 선택하세요</label>
													</div>
													<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" name="btnPrint4" id="btnPrint4" onclick="doAction('yeongEobGridEmail', 'print4')" data-target="#modalCart2"><i class="fa fa-print"></i> 견적서</button>
													<script>
														document.getElementById('emailFile').addEventListener('change', (ev) =>{
															let files = ev.target.files;
															let filesLength = files.length;
															let filesName = '';
															for (let i = 0; i < filesLength; i++) {
																if(filesLength === 1 || filesLength === i + 1){
																	filesName += files[i].name;
																}else{
																	filesName += (files[i].name + ', ');
																}
															}
															document.querySelector('label[for="emailFile"]').innerText = filesName;
														});
													</script>
												</div>
											</td>
										</tr>
									</table>
								</form>
								<!-- ./form -->
								<div id="note" ></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="yeongEobEmailButtonForm" id="yeongEobEmailButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch3"		id="btnSearch3"		onclick="doAction('yeongEobGridEmail', 'search')"><i class="fa fa-search"></i> 조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnInput3"		id="btnInput3"		onclick="doAction('yeongEobGridEmail', 'reset')" ><i class="fa fa-plus"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('yeongEobGridEmail', 'emailSend')"><i class="fa fa-print"></i> 메일요청</button> <%-- 여기 --%>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete3"		id="btnDelete3"		onclick="doAction('yeongEobGridEmail', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose3"		id="btnClose3"		onclick="doAction('yeongEobGridEmail', 'btnClose')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart2" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header">
				<h4 class="modal-title">견적서 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12" style="height: 100%;">
						<!-- form start -->
						<form class="form-inline" role="form" method="post" onsubmit="return false;">
							<table class="table table-bordered table-sm">
								<tr>
									<th class="table-active" style="width: 30%; text-align: center">사업장</th>
									<th class="table-active" style="text-align: center">법인대표인감</th>
									<th class="table-active" style="text-align: center">법인사용인감</th>
									<th class="table-active" style="text-align: center">인감없음</th>
								</tr>
								<tr>
									<td class="table-active">이디에스(주)</td>
									<td><input type="radio" name="prints" value="prints1"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints8"  style="width: 100%;" ></td>
									<%--									<td style="text-align: center">-</td>--%>
								</tr>
								<tr>
									<td class="table-active">(주)토마토아이앤에스</td>
									<td><input type="radio" name="prints" value="prints2"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints3"  style="width: 100%;" ></td>
								</tr>
								<tr>
									<td class="table-active" title="주식회사 티엠티">이디에스(주) (청주)</td>
									<td><input type="radio" name="prints" value="prints4"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints5"  style="width: 100%;" ></td>
								</tr>
								<tr>
									<td class="table-active" title="주식회사 이디에스원">이디에스원(주) (전주)</td>
									<td><input type="radio" name="prints" value="prints6"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints7"  style="width: 100%;" ></td>
								</tr>
							</table>
						</form>
						<!-- ./form -->
					</div>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="yeongEobPrintButtonForm" id="yeongEobPrintButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnPrint2"		id="btnPrint2"	onclick="doAction('yeongEobGridEmail', 'print2')" data-toggle="modal" data-target="#modalCart2" style="display: none"></button>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint3"		id="btnPrint3"	onclick="doAction('yeongEobGridList', 'print3')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose2"		id="btnClose2"	onclick="doAction('yeongEobGridList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>

<script>
	var yeongEobGridList, yeongEobGridItem, yeongEobGridEmail;
	var yeongEobeditor;
	var estDt, validDt;

	$(document).ready(async function () {
		// document.body.style.zoom = "80%";
		await init();

		/**
		 * 조회 엔터 기능
		 * */
		document.getElementById('searchForm').addEventListener('keyup', async ev=>{
			var id = ev.target.id;
			if(ev.keyCode === 13){
				await doAction('yeongEobGridList', 'search');
			}
		});

		/**
		 * 모달 기준 팝업 이벤트
		 * */
		document.getElementById('modalCart').addEventListener('click', async ev=>{
			var id = ev.target.id;
			switch (id) {
				// case 'depaNm': await popupHandler('depa','open'); break;
				// case 'manNm': await popupHandler('user','open'); break;
				// case 'custNm': await popupHandler('cust','open'); break;
			}
		});

		document.getElementById('modalCart').addEventListener('change', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'supAmt': case 'vatAmt': case 'totAmt':
				case 'supAmt2': case 'vatAmt2': case 'totAmt2':
					/**
					 * 매입가, 견적가 계산
					 * */
					var supAmt = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="supAmt"]').value);
					var vatAmt = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="vatAmt"]').value);
					var totAmt = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="totAmt"]').value);
					var supAmtAll = 0;
					var vatAmtAll = 0;
					var totAmtAll = 0;

					var supAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value);
					var vatAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value);
					var totAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value);
					var supAmtAll2 = 0;
					var vatAmtAll2 = 0;
					var totAmtAll2 = 0;

					// 별도, 포함
					switch (id) {
						case 'supAmt' :
							/* 매입가 */
							vatAmt = supAmt/10; // TAX
							totAmt = supAmt/1.1; // 공급가액
							break;
						case 'supAmt2' :
							/* 견적가 */
							vatAmt2 = supAmt2/10; // TAX
							totAmt2 = supAmt2/1.1; // 공급가액
							break;
						case 'totAmt' :
							/* 매입가 */
							supAmt = totAmt/11*10; // 공급가액
							vatAmt = totAmt/11; // TAX
							break;
						case 'totAmt2' :
							/* 견적가 */
							supAmt2 = totAmt2/11*10; // 공급가액
							vatAmt2 = totAmt2/11; // TAX
							break;
					}

					/**
					 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
					 * */

					/* 매입가 */
					supAmt = Math.ceil(supAmt);  // 올림
					vatAmt = Math.floor(vatAmt); // 내림
					totAmt = supAmt + vatAmt; // 합계

					document.querySelector('div[id="modalCart"] input[id="supAmt"]').value = edsUtil.addComma(supAmt);
					document.querySelector('div[id="modalCart"] input[id="vatAmt"]').value = edsUtil.addComma(vatAmt);
					document.querySelector('div[id="modalCart"] input[id="totAmt"]').value = edsUtil.addComma(supAmt + vatAmt);

					/* 견적가 */
					supAmt2 = Math.ceil(supAmt2);  // 올림
					vatAmt2 = Math.floor(vatAmt2); // 내림
					totAmt2 = supAmt2 + vatAmt2; // 합계

					document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value = edsUtil.addComma(supAmt2);
					document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value = edsUtil.addComma(vatAmt2);
					document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value = edsUtil.addComma(supAmt2 + vatAmt2);

					/* 매입가+견적가+계약금액 합계 적용 */
					var data = yeongEobGridList.getFilteredData()
					var dataLen = data.length;
					for (let i = 0; i < dataLen; i++) {
						supAmtAll += Number(data[i].supAmt);
						vatAmtAll += Number(data[i].vatAmt);
						totAmtAll += Number(data[i].totAmt);
						supAmtAll2 += Number(data[i].supAmt2);
						vatAmtAll2 += Number(data[i].vatAmt2);
						totAmtAll2 += Number(data[i].totAmt2);
					}
					yeongEobGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
					yeongEobGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
					yeongEobGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

					yeongEobGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
					yeongEobGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
					yeongEobGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));
					break;
			}
		});
	});

	/* 초기설정 */
	async function init() {

		class CustomTextEditor {
			constructor(props) {
				const el = document.createElement('textarea');
				el.value = String(props.value).replace(/<br\/>/g, '\n');
				this.el = el;
			}

			getValue() {
				return this.el.value.replace(/\n/g, '<br/>');
			}

			getElement() {
				return this.el;
			}
		}

		class detailButtonRenderer {
			constructor(props) {
				const el = document.createElement('button');
				const text = document.createTextNode('상세목록');

				el.appendChild(text);
				el.setAttribute("class","btn btn-sm btn-primary");
				el.setAttribute("style","width: 78%;" +
						"padding: 0.12rem 0.5rem;");

				el.addEventListener('click', async (ev) => {

					var row = yeongEobGridList.getFocusedCell();
					var estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					var deadDivi = yeongEobGridList.getValue(row.rowKey,'deadDivi');
					if(estCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '견적서가 없습니다.',
						});
					}else{
						if (deadDivi !=='1'){
							await doAction('yeongEobGridList','itemPopup');
						}
					}
				});

				this.el = el;
				this.render(props);
			}

			getElement() {
				return this.el;
			}

			render(props) {
				this.el.value = String(props.value);
			}
		}

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "yeongEob");

		/* 조회옵션 셋팅 */
		document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
		<%--document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';--%>
		<%--document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';--%>

		/* 권한에 따라 회사, 사업장 활성화 */
		var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
		if(authDivi === "03" || authDivi === "04"){
			document.getElementById('busiCd').disabled = true;
			document.getElementById('btnBusiCd').disabled = true;
		}

		/* Button 셋팅 */
		await edsUtil.setButtonForm(document.querySelector("#yeongEobGridListButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#yeongEobGridItemButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#baseEmailForm"));
		await edsUtil.setButtonForm(document.querySelector("#yeongEobEmailButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#yeongEobPrintButtonForm"));

		/**********************************************************************
		 * editor 영역 START
		 ***********************************************************************/
		yeongEobeditor = new toastui.Editor({
			el: document.querySelector('#note'),
			height: '400px',
			language: 'ko',
			initialEditType: 'wysiwyg',
			theme: 'dark',
			hooks: {
				async addImageBlobHook(blob, callback) {
					await edsUtil.beforeUploadImageFile(blob, callback, 'estimate')
				},
			}
		});

		// editor.getMarkdown();
		/**********************************************************************
		 * editor 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		/* 그리드 초기화 속성 설정 */
		yeongEobGridList = new tui.Grid({
			el: document.getElementById('yeongEobGridListDIV'),
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

		yeongEobGridList.setColumns([
			{ header:'성공',			name:'sccDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM026")}},	formatter: 'listItemText',	filter: { type: 'text'}, sortable: true},
			{ header:'견적일자',		name:'estDt',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'유효기간',		name:'validDt',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'사업장',		name:'busiNm',		width:140,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'프로젝트명',	name:'projNm',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'견적합계금액',name:'totAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'}, sortable: true},
			{ header:'분류',			name:'clas',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'품목',			name:'item',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'결제조건',		name:'payTm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'적요',			name:'note1',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'결재자보고내용',name:'note2',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'부서',			name:'depaNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'견적담당',		name:'manNote',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'담당자',		name:'manNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},
			{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}, sortable: true},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
			{ header:'기안코드',		name:'submitCd',	width:100,	align:'center',	hidden:true },
			{ header:'마감',			name:'deadDivi',	width:55,	align:'center',	hidden:true },
			{ header:'거래처코드',	name:'custCd',		width:100,	align:'center',	hidden:true },
			{ header:'부서코드',		name:'depaCd',		width:100,	align:'center',	hidden:true },
			{ header:'담당자코드',	name:'manCd',		width:100,	align:'center',	hidden:true },
			{ header:'비고',			name:'note3',		width:150,	align:'left',	hidden:true },
			{ header:'상세등록',		name:'detail',		width:80,	align:'center',	hidden:true },
			{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'},	hidden:true },
			{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'},	hidden:true },
			{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'}, sortable: true,	hidden:true },
			{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'},	hidden:true },
			{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'},	hidden:true },
		]);

		yeongEobGridItem = new tui.Grid({
			el: document.getElementById('yeongEobGridItemDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight: 'auto',
			minRowHeight:40,
			rowHeaders: ['rowNum', 'checkbox'],
			header: {
				height: 40,
				minRowHeight: 40,
				complexColumns: [

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
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		yeongEobGridItem.setColumns([
			{ header:'품목명',		name:'itemNm',		width:150,	align:'left',	defaultValue: ''	},
			// { header:'규격',			name:'standard',	width:200,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
			{ header:'규격',			name:'standard',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
			{ header:'단위',			name:'unit',		width:80,	align:'center',	defaultValue: ''	},
			{ header:'수량',			name:'qty',			width:60,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
			{ header:'견적합계금액',		name:'totAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	sortable: true},
			{ header:'적요',			name:'note',		width:150,	align:'center',	defaultValue: ''	},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: '', 	sortable: true},
			{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: '', 	sortable: true},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			{ header:'품목코드',		name:'itemCd',		width:100,	align:'center',	hidden:true },
			{ header:'할인',			name:'saleDivi',	width:40,	align:'center',	hidden:true },
			{ header:'할인율',		name:'saleRate',	width:100,	align:'right',	hidden:true },
			{ header:'단가',			name:'cost3',		width:100,	align:'right',	hidden:true },
			{ header:'공급가액',		name:'supAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'부가세액',		name:'vatAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'예상이익금액',	name:'profit',		width:100,	align:'right',	hidden:true },
			{ header:'예상이익율',	name:'margin',		width:100,	align:'right',	hidden:true },
			{ header:'과세',			name:'vatDivi',		width:40,	align:'center',	defaultValue: '', 	sortable: true,	hidden:true },
			{ header:'TAX',			name:'taxDivi',		width:40,	align:'center',	defaultValue: '', 	sortable: true,	hidden:true },
			{ header:'단가',			name:'cost',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	sortable: true,	hidden:true },
			{ header:'단가',			name:'cost2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
		]);

		yeongEobGridEmail = new tui.Grid({
			el: document.getElementById('yeongEobGridEmailDIV'),
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
			},
			columns:[],
			columnOptions: {
				resizable: true,
				/*frozenCount: 1,
                frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
			},
		});

		yeongEobGridEmail.setColumns([
			{ header:'발송여부',		name:'sendDivi',	width:80,		align:'center',
				formatter: function (value) {
					if(value.value === '01') return '미발송';
					else if(value.value === '02') return '발송완료';
					else if(value.value === '03') return '발송반려';
					else return '미발송';
				},
			},
			// { header:'보낸일시',		name:'inpDttm',		width:150,	align:'center',	defaultValue: ''	},
			{ header:'보낸일시',		name:'updDttm',		width:150,	align:'center',	defaultValue: ''	},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			{ header:'구분',			name:'divi',		width:100,	align:'center',	hidden:true },
			{ header:'보내는주소',	name:'setForm',		width:100,	align:'center',	hidden:true },
			{ header:'받는주소',		name:'toAddr',		width:100,	align:'center',	hidden:true },
			{ header:'참조주소',		name:'ccAddr',		width:100,	align:'center',	hidden:true },
			{ header:'숨은참조주소',	name:'bccAddr',		width:100,	align:'center',	hidden:true },
			{ header:'제목',			name:'setSubject',	width:100,	align:'center',	hidden:true },
			{ header:'내용',			name:'note',		width:100,	align:'center',	hidden:true },
			{ header:'수정자',		name:'updNm',		width:100,	align:'center',	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * DatePicker Info 영역 START
		 ***********************************************************************/

		/* 데이트픽커 초기 속성 설정 */
		estDt = new DatePicker(['#estDtDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#estDt'],
				format: 'yyyy-MM-dd'
			},
			type: 'date', // Type of picker - 'date', 'month', year'
		});

		validDt = new DatePicker(['#validDtDIV'], {
			language: 'ko',
			showAlways: false,
			autoClose: true,
			date: new Date(),
			input: {
				element: ['#validDt'],
				format: 'yyyy-MM-dd'
			},
			type: 'date',
		});

		/**********************************************************************
		 * DatePicker Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		yeongEobGridList.disableColumn('sccDivi');
		yeongEobGridItem.disableColumn('standard');
		yeongEobGridItem.disableColumn('vatDivi');
		yeongEobGridItem.disableColumn('taxDivi');

		/*필터 이후 포커스*/
		yeongEobGridList.on('afterFilter', async ev => {
			if(ev.instance.store.data.filteredIndex.length>0){
				yeongEobGridList.focusAt(0,0,true)
			}
		});

		/* 더블클릭 시, 상세목록 */
		yeongEobGridList.on('click', async ev => {
			if(ev.targetType === 'cell'){
				await doAction('yeongEobGridList','itemPopup');
			}
		});

		yeongEobGridList.on('focusChange', async ev => {
			if(ev.rowKey !== ev.prevRowKey){
				if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
					if (yeongEobGridList.getValue(ev.rowKey, "deadDivi") === '1') {

						// document.getElementById('btnDelete').disabled = true;
						document.getElementById('btnPrint').disabled = true;
						document.getElementById('btnEmailPopup').disabled = true;
					} else {

						// document.getElementById('btnDelete').disabled = false;
						document.getElementById('btnPrint').disabled = false;
						document.getElementById('btnEmailPopup').disabled = false;
					}

					// 메인 시트 마감 처리 : 다른 시트 rawData값 못불러와서 서브 시트는 따로 처리
					await edsUtil.setClosedRow(yeongEobGridList)
				}
			}
		});

		yeongEobGridList.on('editingFinish', ev => {

			var columnName = ev.columnName;
			var rowKey = ev.rowKey;

			/**
			 * 견적일자, 유효기간 날짜 계산
			 * */

			if(columnName === 'estDt'){
				const validDt = new Date(yeongEobGridList.getValue(rowKey,'estDt'));
				validDt.setMonth(validDt.getMonth() + 1);
				yeongEobGridList.setValue(rowKey,'validDt',validDt.toISOString().substring(0,10));
			}else if(columnName === 'validDt'){
				const estDt = new Date(yeongEobGridList.getValue(rowKey,'validDt'));
				estDt.setMonth(estDt.getMonth() - 1);
				yeongEobGridList.setValue(rowKey,'estDt',estDt.toISOString().substring(0,10));
			}

			/**
			 * 매입가, 견적가 계산
			 * */
			var supAmt = yeongEobGridList.getValue(rowKey, 'supAmt');
			var vatAmt = yeongEobGridList.getValue(rowKey, 'vatAmt');
			var totAmt = yeongEobGridList.getValue(rowKey, 'totAmt');
			var supAmtAll = 0;
			var vatAmtAll = 0;
			var totAmtAll = 0;

			var supAmt2 = yeongEobGridList.getValue(rowKey, 'supAmt2');
			var vatAmt2 = yeongEobGridList.getValue(rowKey, 'vatAmt2');
			var totAmt2 = yeongEobGridList.getValue(rowKey, 'totAmt2');
			var supAmtAll2 = 0;
			var vatAmtAll2 = 0;
			var totAmtAll2 = 0;

			// 별도, 포함
			switch (columnName) {
				case 'supAmt' :
					/* 매입가 */
					vatAmt = supAmt/10; // TAX
					totAmt = supAmt/1.1; // 공급가액
					break;
				case 'supAmt2' :
					/* 견적가 */
					vatAmt2 = supAmt2/10; // TAX
					totAmt2 = supAmt2/1.1; // 공급가액
					break;
				case 'totAmt' :
					/* 매입가 */
					supAmt = totAmt/11*10; // 공급가액
					vatAmt = totAmt/11; // TAX
					break;
				case 'totAmt2' :
					/* 견적가 */
					supAmt2 = totAmt2/11*10; // 공급가액
					vatAmt2 = totAmt2/11; // TAX
					break;
			}

			/**
			 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
			 * */

			/* 매입가 */
			supAmt = Math.ceil(supAmt);  // 올림
			vatAmt = Math.floor(vatAmt); // 내림
			totAmt = supAmt + vatAmt; // 합계
			yeongEobGridList.setValue(rowKey, "supAmt", supAmt);
			yeongEobGridList.setValue(rowKey, "vatAmt", vatAmt);
			yeongEobGridList.setValue(rowKey, "totAmt", supAmt + vatAmt);

			/* 견적가 */
			supAmt2 = Math.ceil(supAmt2);  // 올림
			vatAmt2 = Math.floor(vatAmt2); // 내림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			yeongEobGridList.setValue(rowKey, "supAmt2", supAmt2);
			yeongEobGridList.setValue(rowKey, "vatAmt2", vatAmt2);
			yeongEobGridList.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 매입가+견적가+계약금액 합계 적용 */
			var data = yeongEobGridList.getFilteredData()
			var dataLen = data.length;
			for (let i = 0; i < dataLen; i++) {
				supAmtAll += Number(data[i].supAmt);
				vatAmtAll += Number(data[i].vatAmt);
				totAmtAll += Number(data[i].totAmt);
				supAmtAll2 += Number(data[i].supAmt2);
				vatAmtAll2 += Number(data[i].vatAmt2);
				totAmtAll2 += Number(data[i].totAmt2);
			}
			yeongEobGridList.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
			yeongEobGridList.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
			yeongEobGridList.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

			yeongEobGridList.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
			yeongEobGridList.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
			yeongEobGridList.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));
		});

		yeongEobGridItem.on('click', async ev => {
			var colNm = ev.columnName;
			var target = ev.targetType;
			if(target === 'cell'){
				if(colNm==='standard') {
					await edsUtil.sheetData2Maldal(yeongEobGridItem);
				}
			}else{
				// projectGridList.finishEditing();
			}
		});

		yeongEobGridItem.on('click', async ev => {
			var colNm = ev.columnName;
			var target = ev.targetType;
			if(target === 'cell'){
				// if(colNm ==='itemNm') await popupHandler('item','open');
			}else{
				// yeongEobGridItem.finishEditing();
			}
		});

		yeongEobGridItem.on('editingFinish', ev => {

			var columnName = ev.columnName;
			var rowKey = ev.rowKey;


			var vatDivi = yeongEobGridItem.getValue(rowKey, 'vatDivi');
			var taxDivi = yeongEobGridItem.getValue(rowKey, 'taxDivi');

			var qty = yeongEobGridItem.getValue(rowKey, 'qty');
			var cost = yeongEobGridItem.getValue(rowKey, 'cost');
			var supAmt = yeongEobGridItem.getValue(rowKey, 'supAmt');
			var vatAmt = yeongEobGridItem.getValue(rowKey, 'vatAmt');
			var totAmt = yeongEobGridItem.getValue(rowKey, 'totAmt');
			var supAmtAll = 0;
			var vatAmtAll = 0;
			var totAmtAll = 0;

			var cost2 = yeongEobGridItem.getValue(rowKey, 'cost2');
			var supAmt2 = yeongEobGridItem.getValue(rowKey, 'supAmt2');
			var vatAmt2 = yeongEobGridItem.getValue(rowKey, 'vatAmt2');
			var totAmt2 = yeongEobGridItem.getValue(rowKey, 'totAmt2');
			var supAmtAll2 = 0;
			var vatAmtAll2 = 0;
			var totAmtAll2 = 0;

			var cost3 = yeongEobGridItem.getValue(rowKey, 'cost3');
			var supAmt3 = yeongEobGridItem.getValue(rowKey, 'supAmt3');
			var vatAmt3 = yeongEobGridItem.getValue(rowKey, 'vatAmt3');
			var totAmt3 = yeongEobGridItem.getValue(rowKey, 'totAmt3');
			var supAmtAll3 = 0;
			var vatAmtAll3 = 0;
			var totAmtAll3 = 0;

			switch (columnName) {
				case 'qty' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 매입가 */
							supAmt = qty * cost; // 공급가액
							vatAmt = supAmt * 0.1; // TAX
							/* 견적가 */
							supAmt2 = qty * cost2; // 공급가액
							vatAmt2 = supAmt2 * 0.1; // TAX
						} else {//포함
							/* 매입가 */
							supAmt = qty * cost / 1.1; // 공급가액
							vatAmt = qty * cost - supAmt; // TAX
							/* 견적가 */
							supAmt2 = qty * cost2 / 1.1; // 공급가액
							vatAmt2 = qty * cost2 - supAmt2; // TAX
						}
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = qty * cost; // 공급가액
						vatAmt = 0; // TAX
						/* 견적가 */
						supAmt2 = qty * cost2; // 공급가액
						vatAmt2 = 0; // TAX
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
							/* 계약금액 */
							supAmt3 = qty * cost3; // 공급가액
							vatAmt3 = supAmt3 * 0.1; // TAX
						} else {//포함
							/* 계약금액 */
							supAmt3 = qty * cost3 / 1.1; // 공급가액
							vatAmt3 = qty * cost3 - supAmt3; // TAX
						}
					} else {// 면세, 영세
						/* 계약금액 */
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
						/* 계약금액 */
						cost3 = supAmt3/qty; // 단가
						vatAmt3 = supAmt3/10; // TAX
						totAmt3 = supAmt3/1.1; // 공급가액

					} else {// 면세, 영세
						/* 계약금액 */
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
						/* 계약금액 */
						supAmt3 = totAmt3/11*10; // 공급가액
						vatAmt3 = totAmt3/11; // TAX
						cost3 = supAmt3/qty; // 단가

					} else {// 면세, 영세
						/* 계약금액 */
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
			cost = Math.ceil(cost); // 내림
			supAmt = Math.ceil(supAmt);  // 올림
			vatAmt = Math.floor(vatAmt); // 내림
			totAmt = supAmt + vatAmt; // 합계
			yeongEobGridItem.setValue(rowKey, "cost", cost);
			yeongEobGridItem.setValue(rowKey, "supAmt", supAmt);
			yeongEobGridItem.setValue(rowKey, "vatAmt", vatAmt);
			yeongEobGridItem.setValue(rowKey, "totAmt", supAmt + vatAmt);

			/* 견적가 */
			cost2 = Math.ceil(cost2); // 내림
			supAmt2 = Math.ceil(supAmt2);  // 올림
			vatAmt2 = Math.floor(vatAmt2); // 내림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			yeongEobGridItem.setValue(rowKey, "cost2", cost2);
			yeongEobGridItem.setValue(rowKey, "supAmt2", supAmt2);
			yeongEobGridItem.setValue(rowKey, "vatAmt2", vatAmt2);
			yeongEobGridItem.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 계약금액 */
			cost3 = Math.ceil(cost3); // 내림
			supAmt3 = Math.ceil(supAmt3);  // 올림
			vatAmt3 = Math.floor(vatAmt3); // 내림
			totAmt3 = supAmt3 + vatAmt3; // 합계
			yeongEobGridItem.setValue(rowKey, "cost3", cost3);
			yeongEobGridItem.setValue(rowKey, "supAmt3", supAmt3);
			yeongEobGridItem.setValue(rowKey, "vatAmt3", vatAmt3);
			yeongEobGridItem.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

			/* 매입가+견적가+계약금액 합계 적용 */
			var data = yeongEobGridItem.getFilteredData()
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
			yeongEobGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
			yeongEobGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
			yeongEobGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

			yeongEobGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
			yeongEobGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
			yeongEobGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

			yeongEobGridItem.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmtAll3));
			yeongEobGridItem.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmtAll3));
			yeongEobGridItem.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmtAll3));

			document.getElementById('supAmt').value = edsUtil.addComma(supAmtAll);
			document.getElementById('vatAmt').value = edsUtil.addComma(vatAmtAll);
			document.getElementById('totAmt').value = edsUtil.addComma(totAmtAll);

			document.getElementById('supAmt2').value = edsUtil.addComma(supAmtAll2);
			document.getElementById('vatAmt2').value = edsUtil.addComma(vatAmtAll2);
			document.getElementById('totAmt2').value = edsUtil.addComma(totAmtAll2);

		});

		yeongEobGridEmail.on('focusChange', async ev => {
			if(ev.rowKey !== ev.prevRowKey){

				var rowKey = ev.rowKey;
				var data = yeongEobGridEmail.getRow(rowKey);
				var keys = Object.keys(data);

				/* 이메일 내역 세팅*/
				for (let i = 0; i < keys.length; i++) {
					var key = keys[i];
					var doc = document.getElementById(key);
					if(doc){ // input
						// console.log(key + ' is exist');
						if(key==='note'){
							yeongEobeditor.setHTML(data[key], true);
						}else{
							doc.value = data[key];
						}
					}else{ // note
						// console.log(key + ' is not exist');
					}
				}

				/* 이메일 첨부파일 조회 및 세팅*/
				var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
				param.estCd = yeongEobGridEmail.getValue(rowKey, 'estCd');
				param.emailSeq = yeongEobGridEmail.getValue(rowKey, 'seq');
				param.divi = 'estimate';
				var emailFileInfo = edsUtil.getAjax("/EMAIL_MGT/selectSendEmailFileInfo", param); // 데이터 set

				let files = emailFileInfo;
				let filesLength = files.length;
				let filesName = '';
				for (let i = 0; i < filesLength; i++) {
					if(filesLength === 1 || filesLength === i + 1){
						filesName += (files[i].origNm+'.'+files[i].ext);
					}else{
						filesName += ((files[i].origNm+'.'+files[i].ext) + ', ');
					}
				}
				/**
				 * 파일 초기화
				 * */
				await edsUtil.resetFileForm(document.getElementById('emailFile'));
				document.querySelector('label[for="emailFile"]').innerText = filesName;

			}
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Datepicker 이벤트 영역 START
		 ***********************************************************************/

		estDt.on('change', () => {
			const validDtRst = new Date(estDt.getDate());
			validDt.setMonth(validDtRst.getMonth() + 1);
			validDt.setDate(new Date()); // Set today
		});

		/**********************************************************************
		 * Datepicker 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		// document.getElementById('yeongEobGridList').style.height = (innerHeight)*(1-0.11) + 'px';
		// document.getElementById('yeongEobGridItem').style.height = (innerHeight)*(1-0.6) + 'px';
		// document.getElementById('yeongEobGridEmail').style.height = (innerHeight)*(1-0.25) + 'px';
		doAction('yeongEobGridList', 'search')
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'yeongEobGridList') {
			switch (sAction) {
				case "search":// 조회

					yeongEobGridList.finishEditing(); // 데이터 초기화
					yeongEobGridList.clear(); // 데이터 초기화
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					yeongEobGridList.resetData(edsUtil.getAjax("/YEONGEOB_EST_MGT/selectEstMgtList", param)); // 데이터 set

					break;
				case "input":// 신규

					document.querySelector('div[id="modalCart"] input[id="corpCd"]').value = $("#searchForm #corpCd").val();
					document.querySelector('div[id="modalCart"] input[id="busiCd"]').value = $("#searchForm #busiCd").val();
					document.querySelector('div[id="modalCart"] input[id="estCd"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="projNm"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="custCd"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="custNm"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="depaCd"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="depaNm"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="manCd"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="manNm"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="clas"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="item"]').value = '';
					document.querySelector('div[id="modalCart"] textarea[id="note1"]').value = '';
					document.querySelector('div[id="modalCart"] textarea[id="note2"]').value = '';
					document.querySelector('div[id="modalCart"] textarea[id="note3"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="deadDivi"]').value = '0';
					document.querySelector('div[id="modalCart"] input[id="estDt"]').value = edsUtil.getToday("%Y-%m-%d");

					/* 견적일자로부터 1달*/
					const newDate = new Date(edsUtil.getToday("%Y-%m-%d"));
					newDate.setMonth(newDate.getMonth() + 1);
					document.querySelector('div[id="modalCart"] input[id="validDt"]').value = edsUtil.getToday(newDate.toISOString().substring(0,10));

					document.querySelector('div[id="modalCart"] input[id="supAmt"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="vatAmt"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="totAmt"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value = 0;

					document.getElementById('btnItemPopEv').click();
					setTimeout(ev=>{
						doAction('yeongEobGridItem', 'search');
					}, 300)

					break;
				case "delete"://삭제
					await yeongEobGridList.removeCheckedRows(true);
					await edsUtil.doCUD("/YEONGEOB_EST_MGT/cudEstMgtList", "yeongEobGridList", yeongEobGridList);
					break;
				case "finish"://마감
					await edsUtil.doDeadline(
							"/YEONGEOB_EST_MGT/deadLineEstMgtList",
							"yeongEobGridList",
							yeongEobGridList,
							'1');
					break;
				case "cancel"://마감취소
					await edsUtil.doDeadline(
							"/YEONGEOB_EST_MGT/deadLineEstMgtList",
							"yeongEobGridList",
							yeongEobGridList,
							'0');
					break;
				case "print"://인쇄
					document.querySelector('input[value="prints1"]').setAttribute('checked', 'checked');

					document.getElementById('btnPrint3').style.display = 'inline';
					document.getElementById('btnPrint2').click();
					break;
				case "print2":// 견적서 선택

					// document.getElementById('btnPrint3').style.display = 'block';

					break;


				case "print3"://인쇄
					var row = yeongEobGridList.getRow(yeongEobGridList.getFocusedCell().rowKey)
					console.log(row)
					var printKind = document.querySelector('input[name="prints"]:checked').value
					var param = new Array();
					var num = document.getElementById('totAmt2').value;
					var num2han = await edsUtil.num2han(num);
					var element = {
						corpCd : '<c:out value="${LoginInfo.corpCd}"/>',
						busiCd : '<c:out value="${LoginInfo.busiCd}"/>',
						estCd : row.estCd,
						num : edsUtil.addComma(num),
						num2han : num2han,
						printKind : printKind,
					};
					param.push(element)
					if(printKind === "prints2" ||printKind === "prints3"){
						jr.open(param, 'yeongEob_gyeonjeogseo2');
					}else if(printKind === "prints6" ||printKind === "prints7"){
						jr.open(param, 'yeongEob_gyeonjeogseo3');
					}
					else{
						jr.open(param, 'yeongEob_gyeonjeogseo');
					}
					break;
				case "emailPopup":// 이메일 팝업 보기

					var row = yeongEobGridList.getFocusedCell();
					var estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					doAction('yeongEobGridEmail', 'reset');
					if(estCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '견적서가 없습니다.',
						});
					}else{
						document.getElementById('btnEmailPopEv').click();
						document.getElementById('setFrom').value = '<c:out value="${LoginInfo.empNm}"/>'+' <'+'<c:out value="${LoginInfo.email}"/>'+'>';
						setTimeout(ev=>{
							document.getElementById('btnSearch3').click();
						}, 300)
					}

					break;
				case "submit":

					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					yeongEobGridList.resetData(edsUtil.getAjax("/YEONGEOB_EST_MGT/selectEstMgtList", param)); // 데이터 set
					let data={};
					data.submitApprover=$("#appUsers").val();
					data.submitCcUser=$("#ccUsers").val();
					data.busiCd=document.getElementById("busiCd").value;
					data.docDivi=document.getElementById("docDivi").value;
					data.submitDt=document.getElementById("submitDt").value;
					data.submitCd=document.getElementById("submitCd").value;
					data.submitDivi='02'//임시저장
					const parentData=data;
					await edsEdms.insertSubmit(edmsEstGridItem,document.edmsEstGridItemForm,parentData,dropzeneRemoveFile);

					break;
				case "itemPopup":// 상세 팝업 보기

					await fn_CopyYeongEobGridList2Form();
					document.getElementById('btnItemPopEv').click();
					setTimeout(async ev=>{
						var row = yeongEobGridList.getFocusedCell();
						var param = {
							corpCd: yeongEobGridList.getValue(row.rowKey,'corpCd'),
							submitCd: yeongEobGridList.getValue(row.rowKey,'submitCd'),
						}
						await edsEdms.selectMessageData2(param);
					}, 150)
					setTimeout(ev=>{
						doAction('yeongEobGridItem', 'search');
					}, 300)

					var row = yeongEobGridList.getFocusedCell();
					var estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					if(estCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '견적서가 없습니다.',
						});
					}else{
						document.getElementById('btnItemPopEv').click();
						setTimeout(ev=>{
							doAction('yeongEobGridItem', 'search');
						}, 300)
					}
					break;
			}
		}else if (sheetNm == 'yeongEobGridItem') {
			switch (sAction) {
				case "search":// 조회

					yeongEobGridItem.refreshLayout(); // 데이터 초기화
					yeongEobGridItem.finishEditing(); // 데이터 마감
					yeongEobGridItem.clear(); // 데이터 초기화

					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.corpCd = document.querySelector('div[id="modalCart"] input[id="corpCd"]').value
					param.estCd = document.querySelector('div[id="modalCart"] input[id="estCd"]').value
					var data = edsUtil.getAjax("/YEONGEOB_EST_MGT/selectEstItemList", param);
					yeongEobGridItem.resetData(data); // 데이터 set

					if(yeongEobGridItem.getRowCount() > 0 ){
						yeongEobGridItem.focusAt(0, 0, true);
					}

					/* 매입가+견적가+계약금액 합계 적용 */
					var dataLen = data.length;
					var supAmtAll  = 0;
					var vatAmtAll  = 0;
					var totAmtAll  = 0;
					var supAmtAll2  = 0;
					var vatAmtAll2  = 0;
					var totAmtAll2  = 0;
					for (let i = 0; i < dataLen; i++) {
						supAmtAll += data[i].supAmt;
						vatAmtAll += data[i].vatAmt;
						totAmtAll += data[i].totAmt;
						supAmtAll2 += data[i].supAmt2;
						vatAmtAll2 += data[i].vatAmt2;
						totAmtAll2 += data[i].totAmt2;
					}
					yeongEobGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
					yeongEobGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
					yeongEobGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

					yeongEobGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
					yeongEobGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
					yeongEobGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

					document.getElementById('supAmt2').value = edsUtil.addComma(supAmtAll2);
					document.getElementById('vatAmt2').value = edsUtil.addComma(vatAmtAll2);
					document.getElementById('totAmt2').value = edsUtil.addComma(totAmtAll2);

					break;
				case "input":// 신규

					var row = yeongEobGridList.getFocusedCell();

					var appendedData = {};
					appendedData.status = "I";
					appendedData.corpCd = yeongEobGridList.getValue(row.rowKey,'corpCd');
					appendedData.busiCd = yeongEobGridList.getValue(row.rowKey,'busiCd');
					appendedData.estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					appendedData.vatDivi = '01';
					appendedData.taxDivi = '01';
					appendedData.qty = 0;
					appendedData.cost = 0;
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

					yeongEobGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

					break;
				case "save"://저장
					await edsUtil.modalCUD("/YEONGEOB_EST_MGT/cudEstList", "yeongEobGridItem", yeongEobGridItem, 'yeongEobGridListForm');
					// await doAction('yeongEobGridItem','close');
					break;
				case "delete"://삭제
					await yeongEobGridItem.removeCheckedRows(true);
					await edsUtil.doCUD("/YEONGEOB_EST_MGT/cudEstItemList", "yeongEobGridItem", yeongEobGridItem);
					break;
				case "close"://삭제
					document.getElementById('btnClose1').click();
					await doAction('yeongEobGridList','search');
					break;
			}
		}else if (sheetNm == 'yeongEobGridEmail') {
			switch (sAction) {
				case "search":// 조회

					yeongEobGridEmail.refreshLayout(); // 데이터 초기화
					yeongEobGridEmail.finishEditing(); // 데이터 마감
					yeongEobGridEmail.clear(); // 데이터 초기화

					/* 이메일 조회 */
					var row = yeongEobGridList.getFocusedCell();
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.estCd = yeongEobGridList.getValue(row.rowKey, 'estCd');
					param.divi = 'estimate';
					yeongEobGridEmail.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailInfo", param)); // 데이터 set

					// if(yeongEobGridEmail.getRowCount() > 0 ){
					// 	yeongEobGridEmail.focusAt(0, 0, true);
					// }

					break;
				case "reset":// 신규

					await doAction('yeongEobGridEmail','search');
					/**
					 * input 초기화
					 * */
					document.getElementById('toAddr').value = "";
					document.getElementById('ccAddr').value = "";
					document.getElementById('bccAddr').value = "";
					document.getElementById('setSubject').value = "";
					/**
					 * 파일 초기화
					 * */
					await edsUtil.resetFileForm(document.getElementById('emailFile'));
					document.querySelector('label[for="emailFile"]').innerText = "";
					/**
					 * 에디터 초기화
					 * */
					yeongEobeditor.reset();

					break;
				case "delete"://삭제
					await yeongEobGridEmail.removeCheckedRows(true);
					await edsUtil.doCUD("/YEONGEOB_EST_MGT/cudEstEmailList", "yeongEobGridEmail", yeongEobGridEmail);
					break;
				case "print4":// 견적서 선택

					// document.getElementById('btnPrint3').style.display = 'none';

					break;
				case "emailSend":// 보내기

					var printKind = document.querySelector('input[name="prints"]:checked')
					if(!printKind){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '발주서 버튼을 누르고 인감 분류를 체크하세요.',
						});
					}

					await edsUtil.toggleLoadingScreen('on');

					// file 가져오기
					var file = $('#emailFile'); // input type file tag

					// formData 생성
					var clonFile = file.clone();

					var newForm = $('<form></form>');
					newForm.attr("method", "post");
					newForm.attr("enctype","multipart/form-data");
					newForm.append(clonFile);

					// 추가적 데이터 입력
					/* 메세지 파라미터*/
					var formData = new FormData(newForm[0]);
					formData.append("divi",			'estimate');
					var row = yeongEobGridList.getFocusedCell();
					var estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					var projCd = yeongEobGridList.getValue(row.rowKey,'projCd');
					var ordCd = yeongEobGridList.getValue(row.rowKey,'ordCd');
					var busiCd = yeongEobGridList.getValue(row.rowKey,'busiCd');
					formData.append("sendDivi",		"save");
					formData.append("estCd",		estCd);
					formData.append("projCd",		projCd);
					formData.append("ordCd",		ordCd);
					formData.append("emailSeq",		"");
					formData.append("setFrom",		document.getElementById('setFrom').value);
					formData.append("toAddr",		document.getElementById('toAddr').value);
					formData.append("ccAddr",		document.getElementById('ccAddr').value);
					formData.append("bccAddr",		document.getElementById('bccAddr').value);
					formData.append("setSubject",	document.getElementById('setSubject').value);
					formData.append("html",			yeongEobeditor.getHTML());

					/* 기존 이메일 순번*/
					var row = yeongEobGridEmail.getFocusedCell();
					var beforeEmailSeq = yeongEobGridEmail.getValue(row.rowKey,'seq');
					formData.append("beforeEmailSeq",beforeEmailSeq);

					/* 발주서 파라미터*/
					var num = document.getElementById('totAmt2').value;
					var num2han = await edsUtil.num2han(num);

					if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("id",		'yeongEob_gyeonjeogseo2');
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("id",		'yeongEob_gyeonjeogseo3');
					}else{
						formData.append("id",		'yeongEob_gyeonjeogseo');
					}

					// 인쇄 파일 명
					if(printKind.value === "prints1"||printKind.value === "prints8"){
						formData.append("nameFormat",	"[이디에스]_견적서_");
					}else if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("nameFormat",	"[토마토아이엔에스]_견적서_");
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("nameFormat",	"[이디에스원]_견적서_");
					}else {
						formData.append("nameFormat",	"[이디에스(청주)]_견적서_");
					}

					formData.append("busiCd",		busiCd);
					formData.append("num",			edsUtil.addComma(num));
					formData.append("num2han",		num2han);
					formData.append("printKind",	printKind.value);

					$.ajax({
						url: "/EMAIL_MGT/sendEmail",
						type: "POST",
						data: formData,
						enctype: 'multipart/form-data',
						processData: false,
						contentType: false,
						cache: false,
						success: async function (rst) {

							await edsUtil.toggleLoadingScreen('off');

							var status = rst.status;
							var note = rst.note;
							var exc = rst.exc;
							if(status === 'success'){
								await doAction("yeongEobGridEmail", "search");
								Swal.fire({
									icon: 'success',
									title: '성공',
									text: note,
									footer: exc
								})
							}else{
								console.log(exc);
								Swal.fire({
									icon: 'error',
									title: '실패',
									text: note,
									footer: exc
								})
							}
						},
					});
					break;
				/*case "emailSend":// 보내기

					var printKind = document.querySelector('input[name="prints"]:checked')
					if(!printKind){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '견적서 버튼을 누르고 인감 분류를 체크하세요.',
						});
					}

					await edsUtil.toggleLoadingScreen('on');
					// file 가져오기
					var file = $('#emailFile'); // input type file tag

					// formData 생성
					var clonFile = file.clone();

					var newForm = $('<form></form>');
					newForm.attr("method", "post");
					newForm.attr("enctype","multipart/form-data");
					newForm.append(clonFile);

					// 추가적 데이터 입력
					/!* 메세지 파라미터*!/
					var formData = new FormData(newForm[0]);
					formData.append("divi",			'estimate');
					formData.append("sendDivi",		'send');
					var row = yeongEobGridList.getFocusedCell();
					var estCd = yeongEobGridList.getValue(row.rowKey,'estCd');
					var busiCd = yeongEobGridList.getValue(row.rowKey,'busiCd');
					formData.append("estCd",		estCd);
					formData.append("setFrom",		document.getElementById('setFrom').value);
					formData.append("toAddr",		document.getElementById('toAddr').value);
					formData.append("ccAddr",		document.getElementById('ccAddr').value);
					formData.append("bccAddr",		document.getElementById('bccAddr').value);
					formData.append("setSubject",	document.getElementById('setSubject').value);
					formData.append("html",			yeongEobeditor.getHTML());

					/!* 기존 이메일 순번*!/
					var row = yeongEobGridEmail.getFocusedCell();
					var beforeEmailSeq = yeongEobGridEmail.getValue(row.rowKey,'seq');
					formData.append("beforeEmailSeq",beforeEmailSeq);

					/!* 견적서 파라미터*!/
					var row = yeongEobGridList.getFocusedCell();
					var num = yeongEobGridList.getValue(row.rowKey,'totAmt2');
					var num2han = await edsUtil.num2han(num);

					// 인쇄 파일
					if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("id",		'yeongEob_gyeonjeogseo2');
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("id",		'yeongEob_gyeonjeogseo3');
					}else{
						formData.append("id",		'yeongEob_gyeonjeogseo');
					}

					// 인쇄 파일 명
					if(printKind.value === "prints1"||printKind.value === "prints8"){
						formData.append("nameFormat",	"[이디에스]_견적서_");
					}else if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("nameFormat",	"[토마토아이엔에스]_견적서_");
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("nameFormat",	"[이디에스원]_견적서_");
					}else {
						formData.append("nameFormat",	"[이디에스(청주)]_견적서_");
					}

					formData.append("num",			edsUtil.addComma(num));
					formData.append("num2han",		num2han);
					formData.append("printKind",	printKind.value);

					$.ajax({
						url: "/EMAIL_MGT/sendEmail",
						type: "POST",
						data: formData,
						enctype: 'multipart/form-data',
						processData: false,
						contentType: false,
						cache: false,
						success: async function (rst) {

							await edsUtil.toggleLoadingScreen('off');

							var status = rst.status;
							var note = rst.note;
							var exc = rst.exc;
							if(status === 'success'){
								await doAction("yeongEobGridEmail", "input");
								await doAction("yeongEobGridEmail", "search");
								Swal.fire({
									icon: 'success',
									title: '성공',
									text: note,
									footer: exc
								})
							}else{
								console.log(exc);
								Swal.fire({
									icon: 'error',
									title: '실패',
									text: note,
									footer: exc
								})
							}
						},
					});
					break;*/
			}
		}
	}

	/**********************************************************************
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 START
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	async function popupHandler(name,divi,callback){
		var row = yeongEobGridList.getFocusedCell();
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
			case 'busi':
				if(divi==='open'){
					var param={}
					param.corpCd= $("#searchForm #corpCd").val(),
					param.busiCd= document.getElementById('busiCd').value
					param.name= name;
					await edsIframe.openPopup('BUSIPOPUP',param)
					document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = '';
					document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = '';
				}else{
					document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = callback.busiCd;
					document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = callback.busiNm;
				}
				break;
			case 'cust':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.custNm= yeongEobGridList.getValue(row.rowKey, 'custNm');
					param.name= name;
					await edsIframe.openPopup('CUSTPOPUP',param)
				}else{
					document.querySelector('div[id="modalCart"] input[id="custCd"]').value = callback.custCd;
					document.querySelector('div[id="modalCart"] input[id="custNm"]').value = callback.custNm;
				}
				break;
			case 'depa':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
					param.depaNm= yeongEobGridList.getValue(row.rowKey, 'depaNm')??'';
					param.name= name;
					await edsIframe.openPopup('DEPAPOPUP',param)
				}else{
					document.querySelector('div[id="modalCart"] input[id="depaCd"]').value = callback.depaCd;
					document.querySelector('div[id="modalCart"] input[id="depaNm"]').value = callback.depaNm;
				}
				break;
			case 'user':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
					param.name= name;
					await edsIframe.openPopup('USERPOPUP',param)
				}else{
					document.querySelector('div[id="modalCart"] input[id="manCd"]').value = callback.empCd;
					document.querySelector('div[id="modalCart"] input[id="manNm"]').value = callback.empNm;
				}
				break;
			case 'item':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.name= name;
					await edsIframe.openPopup('ITEMPOPUP',param)
				}else{

					var rst = callback.param;
					if(rst === undefined) return;
					var rstLen = rst.length;
					var maiRow = yeongEobGridList.getFocusedCell();
					var subRow = yeongEobGridItem.getFocusedCell();
					if(rstLen > 0){
						for(var i=0; i<rstLen; i++){
							var data = edsUtil.cloneObj(yeongEobGridItem.getData());
							var itemRow = edsUtil.getMaxObject(data,'rowKey');
							rst[i].rowKey = itemRow.rowKey+i+1;
							rst[i].corpCd = yeongEobGridList.getValue(maiRow.rowKey, "corpCd");
							rst[i].busiCd = yeongEobGridList.getValue(maiRow.rowKey, "busiCd");
							rst[i].estCd = yeongEobGridList.getValue(maiRow.rowKey, "estCd");
							rst[i].vatDivi = '01';
							rst[i].taxDivi = '01';
							rst[i].qty = 0;
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
							yeongEobGridItem.appendRow(rst[i])
						}
						yeongEobGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
					}else{
						// yeongEobGridList.setValue(row.rowKey,'itemCd',callback.itemCd);
						// yeongEobGridList.setValue(row.rowKey,'itemNm',callback.itemNm);
					}
				}
				break;
			case 'itemPopup':
				if(divi==='open'){
					document.getElementById('btnItemPopEv').click();
					setTimeout(async ev =>{
						await doAction('yeongEobGridItem','search')
					},200)
				}else{

				}
				break;
		}
	}

	async function fn_CopyYeongEobGridList2Form(){
		var rows = yeongEobGridList.getRowCount();
		if(rows > 0){
			var row = yeongEobGridList.getFocusedCell();
			var param = {
				sheet: yeongEobGridList,
				form: document.yeongEobGridListForm,
				rowKey: row.rowKey
			};
			edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
		}
	}
	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>

</html>