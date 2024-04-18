<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
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
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('guMaeGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="guMaeGridList" style="height: calc(100vh - 6rem); width: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="guMaeGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="guMaeGridListButtonForm" id="guMaeGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnFinish"		id="btnFinish"		onclick="doAction('guMaeGridList', 'finish')"><i class="fa fa-lock"></i> 마감</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCancel"		id="btnCancel"		onclick="doAction('guMaeGridList', 'cancel')"><i class="fa fa-unlock"></i> 마감취소</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"		id="btnSearch"		onclick="doAction('guMaeGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnInput"		id="btnInput"		onclick="doAction('guMaeGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnSave"			id="btnSave"		onclick="doAction('guMaeGridList', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete"		id="btnDelete"		onclick="doAction('guMaeGridList', 'delete')" style="display: none !important"><i class="fa fa-trash"></i> 삭제</button>

<%--									<button type="button" class="btn btn-sm btn-primary" name="btnPrint"			id="btnPrint"				onclick="doAction('projectGridList', 'print')"><i class="fa fa-print"></i> 인쇄</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopup"		id="btnEmailPopup"			onclick="doAction('projectGridList', 'emailPopup')"><i class="fa fa-envelope"></i> 메일전송</button>--%>

									<button type="button" class="btn btn-sm btn-primary" name="btnApply"		id="btnApply"		onclick="doAction('guMaeGridList', 'apply')"><i class="fa fa-cloud-download"></i> 프로젝트적용</button>

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
		<div class="modal-content" style="height:90vh">
			<!--Header-->
			<div class="modal-header bg-dark font-color text-white">
				<h4 class="modal-title" style="color: #000">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body overflow-auto" >
				<style>
					#modalCart #guMaeGridListForm input::placeholder,
					#modalCart #guMaeGridListForm textarea::placeholder{
						color: #6c6665;
					}
				</style>
				<div class="col-md-12" style="height: 100%;">
					<form name="guMaeGridListForm" id="guMaeGridListForm">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="busiCd" id="busiCd" title="회사코드">
						<input type="hidden" name="estCd" id="estCd" title="회사코드">
						<input type="hidden" name="ordCd" id="ordCd" title="회사코드">
						<input type="hidden" name="sccDivi" id="sccDivi" title="회사코드">
						<input type="hidden" name="deadDivi" id="deadDivi" title="회사코드">
						<input type="hidden" name="estDt" id="estDt" title="회사코드">
						<input type="hidden" name="validDt" id="validDt" title="회사코드">
						<input type="hidden" name="supAmt2" id="supAmt2" title="회사코드">
						<input type="hidden" name="vatAmt2" id="vatAmt2" title="회사코드">
						<input type="hidden" name="totAmt2" id="totAmt2" title="회사코드">
						<input type="hidden" name="supAmt3" id="supAmt3" title="회사코드">
						<input type="hidden" name="vatAmt3" id="vatAmt3" title="회사코드">
						<input type="hidden" name="totAmt3" id="totAmt3" title="회사코드">
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;">
							<div class="card-header">
								<label class="card-title" style="color: #000">프로젝트 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-3 mb-3">
										<label for="clas"><b>분류</b></label>
										<input type="text" class="form-control" id="clas" name="clas" placeholder="분류.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="item"><b>품목</b></label>
										<input type="text" class="form-control" id="item" name="item" placeholder="품목.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="depaNm"><b>부서</b></label>
										<input type="hidden" name="depaCd" id="depaCd" title="부서코드">
										<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서.." readonly="readonly">
									</div>
									<div class="col-md-3 mb-3">
										<label for="manNm"><b>담당자</b></label>
										<input type="hidden" name="manCd" id="manCd" title="담당자코드">
										<input type="text" class="form-control text-center" id="manNm" name="manNm" placeholder="담당자.." readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-12 mb-3">
										<label for="projNm"><b>프로젝트</b></label>
										<input type="hidden" name="projCd" id="projCd" title="프로젝트코드">
										<input type="text" class="form-control" id="projNm" name="projNm" placeholder="프로젝트" readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="supAmt"><b>공급가액</b></label>
										<input type="text" class="form-control text-right" id="supAmt" name="supAmt" placeholder="공급가액3" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="vatAmt"><b>부가세액</b></label>
										<input type="text" class="form-control text-right" id="vatAmt" name="vatAmt" placeholder="부가세액3" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt"><b>합계금액</b></label>
										<input type="text" class="form-control text-right" id="totAmt" name="totAmt" placeholder="합계금액3" readonly="readonly">
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;">
							<div class="card-header">
								<label class="card-title" style="color: #000">인쇄 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-12 mb-3">
										<label for="custNm"><b>거래처</b></label>
										<input type="hidden" name="custCd" id="custCd" title="거래처코드">
										<input type="text" class="form-control" id="custNm" name="custNm" placeholder="거래처" autocomplete='off'>
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-3 mb-3">
										<label for="ordDt"><b>발주일자</b></label>
										<input type="text" class="form-control text-center" id="ordDt" name="ordDt" placeholder="발주일자.." aria-label="Date-Time">
										<div id="ordDtDIV" style="margin-top: -1px;z-index: 1050;position: absolute"></div>
									</div>
									<div class="col-md-3 mb-3">
										<label for="ordDueDt"><b>납품일자</b></label>
										<input type="text" class="form-control text-center" id="ordDueDt" name="ordDueDt" placeholder="납품일자.." aria-label="Date-Time">
										<div id="ordDueDtDIV" style="margin-top: -1px;z-index: 1050;position: absolute"></div>
									</div>
									<div class="col-md-3 mb-3">
										<label for="payTm"><b>결제조건</b></label>
										<input type="text" class="form-control" id="payTm" name="payTm" placeholder="결제조건" autocomplete='off'>
									</div>
									<div class="col-md-3 mb-3">
										<label for="manNote"><b>담당</b></label>
										<input type="text" class="form-control" id="manNote" name="manNote" placeholder="담당..">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-12 mb-3">
										<label for="note2"><b>건명</b></label>
										<input type="text" class="form-control" id="note2" name="note2" placeholder="건명" autocomplete='off'></input>
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-12 mb-3">
										<label for="note1"><b>비고</b></label>
										<textarea rows="10" type="text" class="form-control" id="note1" name="note1" placeholder="비고"></textarea>
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-12" id="guMaeGridItem" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="guMaeGridItemDIV" style="width:100%; height:100%;"></div>
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
							<form class="form-inline" role="form" name="guMaeGridItemButtonForm" id="guMaeGridItemButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch1"	id="btnSearch1"	onclick="doAction('guMaeGridItem', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--											<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('guMaeGridItem', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave1"	id="btnSave1"	onclick="doAction('guMaeGridItem', 'save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('guMaeGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint"	id="btnPrint"	onclick="doAction('guMaeGridList', 'print')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopup"	id="btnEmailPopup"	onclick="doAction('guMaeGridList', 'emailPopup')"><i class="fa fa-envelope"></i> 메일요청</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose1"	id="btnClose1"	onclick="doAction('guMaeGridItem', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
		<div class="modal-content" style="height: 90vh">
			<!--Header-->
			<div class="modal-header">
				<h4 class="modal-title">이메일 전송</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body overflow-auto">
				<div class="row">
					<div class="col-md-5" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" id="guMaeGridEmail" style="height: calc(71vh); width: 100%;">
								<div id="guMaeGridEmailDIV" style="width:100%; height:100%;"></div>
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
													<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" name="btnPrint4" id="btnPrint4" onclick="doAction('guMaeGridEmail', 'print4')" data-target="#modalCart2"><i class="fa fa-print"></i> 발주서</button>
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
							<form class="form-inline" role="form" name="guMaeEmailButtonForm" id="guMaeEmailButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch3"		id="btnSearch3"		onclick="doAction('guMaeGridEmail', 'search')"><i class="fa fa-search"></i> 조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnInput3"		id="btnInput3"		onclick="doAction('guMaeGridEmail', 'reset')" ><i class="fa fa-plus"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('guMaeGridEmail', 'emailSend')"><i class="fa fa-print"></i> 메일요청</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete3"		id="btnDelete3"		onclick="doAction('guMaeGridEmail', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose3"		id="btnClose3"		onclick="doAction('guMaeGridEmail', 'btnClose')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
				<h4 class="modal-title">발주서 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12" style="height: 100%;">
						<!-- form start -->
						<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post" onsubmit="return false;">
							<table class="table table-bordered table-sm">
								<tr>
									<th class="table-active" style="width: 30%; text-align: center">사업장</th>
									<th class="table-active" style="text-align: center">법인대표인감</th>
									<th class="table-active" style="text-align: center">법인사용인감</th>
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
							<form class="form-inline" role="form" name="guMaePrintButtonForm" id="guMaePrintButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnPrint2"		id="btnPrint2"	<%--onclick="doAction('guMaeGridEmail', 'print2')"--%> data-toggle="modal" data-target="#modalCart2" style="display: none !important;"></button>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint3"		id="btnPrint3"	onclick="doAction('guMaeGridList', 'print3')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose2"		id="btnClose2"	onclick="doAction('guMaeGridList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>



<script>
	var guMaeGridList, guMaeGridItem, guMaeGridEmail;
	var ordDt, ordDueDt;
	var guMaeeditor;

	$(document).ready(function () {
		init();
		var params = JSON.parse(sessionStorage.getItem('objmenulist'));

		/**
		 * 조회 엔터 기능
		 * */
		document.getElementById('searchForm').addEventListener('keyup', async ev=>{
			var id = ev.target.id;
			if(ev.keyCode === 13){
				await doAction('guMaeGridList', 'search');
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
				case 'custNm': await popupHandler('cust','open'); break;
				// case 'projNm': await popupHandler('proj','open'); break;
			}
		});

		document.getElementById('modalCart').addEventListener('change', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'supAmt2': case 'vatAmt2': case 'totAmt2':
				case 'supAmt3': case 'vatAmt3': case 'totAmt3':
					/**
					 * 매입가, 견적가 계산
					 * */
					var supAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value);
					var vatAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value);
					var totAmt2 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value);
					var supAmtAll2 = 0;
					var vatAmtAll2 = 0;
					var totAmtAll2 = 0;

					var supAmt3 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="supAmt3"]').value);
					var vatAmt3 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="vatAmt3"]').value);
					var totAmt3 = edsUtil.removeComma(document.querySelector('div[id="modalCart"] input[id="totAmt3"]').value);
					var supAmtAll3 = 0;
					var vatAmtAll3 = 0;
					var totAmtAll3 = 0;

					// 별도, 포함
					switch (id) {
						case 'supAmt2' :
							/* 매입가 */
							vatAmt2 = supAmt2/10; // TAX
							totAmt2 = supAmt2/1.1; // 공급가액
							break;
						case 'supAmt3' :
							/* 견적가 */
							vatAmt3 = supAmt3/10; // TAX
							totAmt3 = supAmt3/1.1; // 공급가액
							break;
						case 'totAmt2' :
							/* 매입가 */
							supAmt2 = totAmt2/11*10; // 공급가액
							vatAmt2 = totAmt2/11; // TAX
							break;
						case 'totAmt3' :
							/* 견적가 */
							supAmt3 = totAmt3/11*10; // 공급가액
							vatAmt3 = totAmt3/11; // TAX
							break;
					}

					/**
					 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
					 * */

					/* 매입가 */
					supAmt2 = Math.ceil(supAmt2);  // 올림
					vatAmt2 = Math.floor(vatAmt2); // 내림
					totAmt2 = supAmt2 + vatAmt2; // 합계

					document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value = edsUtil.addComma(supAmt2);
					document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value = edsUtil.addComma(vatAmt2);
					document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value = edsUtil.addComma(supAmt2 + vatAmt2);

					/* 견적가 */
					supAmt3 = Math.ceil(supAmt3);  // 올림
					vatAmt3 = Math.floor(vatAmt3); // 내림
					totAmt3 = supAmt3 + vatAmt3; // 합계

					document.querySelector('div[id="modalCart"] input[id="supAmt3"]').value = edsUtil.addComma(supAmt3);
					document.querySelector('div[id="modalCart"] input[id="vatAmt3"]').value = edsUtil.addComma(vatAmt3);
					document.querySelector('div[id="modalCart"] input[id="totAmt3"]').value = edsUtil.addComma(supAmt3 + vatAmt3);

					/* 매입가+견적가+계약금액 합계 적용 */
					var data = guMaeGridList.getFilteredData()
					var dataLen = data.length;
					for (let i = 0; i < dataLen; i++) {
						supAmtAll2 += Number(data[i].supAmt2);
						vatAmtAll2 += Number(data[i].vatAmt2);
						totAmtAll2 += Number(data[i].totAmt2);
						supAmtAll3 += Number(data[i].supAmt3);
						vatAmtAll3 += Number(data[i].vatAmt3);
						totAmtAll3 += Number(data[i].totAmt3);
					}
					guMaeGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
					guMaeGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
					guMaeGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

					guMaeGridItem.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmtAll3));
					guMaeGridItem.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmtAll3));
					guMaeGridItem.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmtAll3));
					break;
			}
		});

	});

	/* 초기설정 */
	async function init() {
		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "guMae");

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
		await edsUtil.setButtonForm(document.querySelector("#guMaeGridListButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#guMaeGridItemButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#baseEmailForm"));
		await edsUtil.setButtonForm(document.querySelector("#guMaeEmailButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#guMaePrintButtonForm"));


		class detailButtonRenderer {
			constructor(props) {
				const el = document.createElement('button');
				const text = document.createTextNode('상세목록');

				el.appendChild(text);
				el.setAttribute("class","btn btn-sm btn-primary");
				el.setAttribute("style","width: 78%;" +
						"padding: 0.12rem 0.5rem;");

				el.addEventListener('click', async (ev) => {

					var row = guMaeGridList.getFocusedCell();
					var ordCd = guMaeGridList.getValue(row.rowKey,'ordCd');
					var deadDivi = guMaeGridList.getValue(row.rowKey,'deadDivi');
					if(ordCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '발주서가 없습니다.',
						});
					}else{
						if (deadDivi !=='1'){
							await doAction('guMaeGridList','itemPopup');
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

		/**********************************************************************
		 * editor 영역 START
		 ***********************************************************************/
		guMaeeditor = new toastui.Editor({
			el: document.querySelector('#note'),
			height: '400px',
			language: 'ko',
			initialEditType: 'wysiwyg',
			theme: 'dark',
			hooks: {
				async addImageBlobHook(blob, callback) {
					// console.log(blob)
					await edsUtil.beforeUploadImageFile(blob, callback, 'order')
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
		guMaeGridList = new tui.Grid({
			el: document.getElementById('guMaeGridListDIV'),
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
                        header: '견적가',
                        name: 'amt2',
                        childNames: ['supAmt2','vatAmt2','totAmt2']
                    },
                    {
                        header: '계약금액',
                        name: 'amt3',
                        childNames: ['supAmt3','vatAmt3','totAmt3']
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
					supAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					vatAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					supAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					vatAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		guMaeGridList.setColumns([
			{ header:'발주일자',		name:'ordDt',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'},	sortable: true},
			{ header:'납품일자',		name:'ordDueDt',	width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'},	sortable: true},
			{ header:'사업장',		name:'busiNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'프로젝트명',	name:'projNm',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'}},
			{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'}},
			{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	filter: { type: 'text'},	sortable: true},
			{ header:'분류',			name:'clas',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'품목',			name:'item',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'결제조건',		name:'payTm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'적요',			name:'note1',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'비고',			name:'note2',		width:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'부서',			name:'depaNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'발주담당',		name:'manNote',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'담당자',		name:'manNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
			{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
			{ header:'발주코드',		name:'ordCd',		width:100,	align:'center',	hidden:true },
			{ header:'성공',			name:'sccDivi',		width:40,	align:'center',	hidden:true },
			{ header:'마감',			name:'deadDivi',	width:55,	align:'center',	hidden:true },
			{ header:'거래처코드',	name:'custCd',		width:100,	align:'center',	hidden:true },
			{ header:'부서코드',		name:'depaCd',		width:100,	align:'center',	hidden:true },
			{ header:'담당자코드',	name:'manCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적일자',		name:'estDt',		width:80,	align:'center',	hidden:true },
			{ header:'유효기간',		name:'validDt',		width:80,	align:'center',	hidden:true },
			{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'공급가액',		name:'supAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'부가세액',		name:'vatAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'상세등록',		name:'detail',		width:80,	align:'center',	hidden:true },
		]);

		guMaeGridItem = new tui.Grid({
			el: document.getElementById('guMaeGridItemDIV'),
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
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		guMaeGridItem.setColumns([
			{ header:'품목명',		name:'itemNm',		width:150,	align:'left',	defaultValue: ''	},
			{ header:'규격',			name:'standard',	width:150,	align:'center',	defaultValue: ''	},
			{ header:'단위',			name:'unit',		width:80,	align:'center',	defaultValue: ''	},
			{ header:'수량',			name:'qty',			width:60,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
			{ header:'단가',			name:'cost',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
			{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
			{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
			{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
			{ header:'적요',			name:'note',		width:150,	align:'center',	defaultValue: '',	},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},
			{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	},
			{ header:'과세',			name:'vatDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM006")}},	formatter: 'listItemText'},
			{ header:'TAX',			name:'taxDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM007")}},	formatter: 'listItemText'},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
			{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
			{ header:'발주코드',		name:'ordCd',		width:100,	align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			{ header:'품목코드',		name:'itemCd',		width:100,	align:'center',	hidden:true },
			{ header:'할인',			name:'saleDivi',	width:40,	align:'center',	hidden:true },
			{ header:'할인율',		name:'saleRate',	width:100,	align:'right',	hidden:true },
			{ header:'단가',			name:'cost2',		width:100,	align:'right',	hidden:true },
			{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt2',		width:100,	align:'right',	hidden:true },
			{ header:'단가',			name:'cost3',		width:100,	align:'right',	hidden:true },
			{ header:'공급가액',		name:'supAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'부가세액',		name:'vatAmt3',		width:100,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt3',		width:100,	align:'right',	hidden:true },
		]);

		guMaeGridItem.disableColumn('vatDivi');
		guMaeGridItem.disableColumn('taxDivi');

		guMaeGridEmail = new tui.Grid({
			el: document.getElementById('guMaeGridEmailDIV'),
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

		guMaeGridEmail.setColumns([
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
			{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
			{ header:'발주코드',		name:'ordCd',		width:100,	align:'center',	hidden:true },
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

		/*ordDt*/
		ordDt = new DatePicker(['#ordDtDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#ordDt'],
				format: 'yyyy-MM-dd'
			},
			type: 'date', // Type of picker - 'date', 'month', year'
		});

		ordDueDt = new DatePicker(['#ordDueDtDIV'], {
			language: 'ko',
			showAlways: false,
			autoClose: true,
			date: new Date(),
			input: {
				element: ['#ordDueDt'],
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

		/*필터 이후 포커스*/
		guMaeGridList.on('afterFilter', async ev => {
			if(ev.instance.store.data.filteredIndex.length>0){
				guMaeGridList.focusAt(0,0,true)
			}
		});

		guMaeGridList.on('focusChange', async ev => {
			if(ev.rowKey !== ev.prevRowKey){
				if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
					if (guMaeGridList.getValue(ev.rowKey, "deadDivi") === '1') {
						// document.getElementById('btnSave').disabled = true;
						// document.getElementById('btnDelete').disabled = true;
						// document.getElementById('btnPrint').disabled = true;
						// document.getElementById('btnEmailPopup').disabled = true;
					} else {
						// document.getElementById('btnSave').disabled = false;
						// document.getElementById('btnDelete').disabled = false;
						// document.getElementById('btnPrint').disabled = false;
						// document.getElementById('btnEmailPopup').disabled = false;
					}

					// 메인 시트 마감 처리 : 다른 시트 rawData값 못불러와서 서브 시트는 따로 처리
					await edsUtil.setClosedRow(guMaeGridList)
				}
				await fn_CopyGuMaeGridList2Form();
				await doAction('guMaeGridItem','search')
			}
		});

		/* 더블클릭 시, 상세목록 */
		guMaeGridList.on('click', async ev => {
			if(ev.targetType === 'cell'){
				await doAction('guMaeGridList','itemPopup');
			}
		});

		guMaeGridList.on('editingFinish', ev => {

			var columnName = ev.columnName;
			var rowKey = ev.rowKey;

			/**
			 * 매입가, 견적가 계산
			 * */
			var supAmt2 = guMaeGridList.getValue(rowKey, 'supAmt2');
			var vatAmt2 = guMaeGridList.getValue(rowKey, 'vatAmt2');
			var totAmt2 = guMaeGridList.getValue(rowKey, 'totAmt2');
			var supAmt2All = 0;
			var vatAmt2All = 0;
			var totAmt2All = 0;

			var supAmt3 = guMaeGridList.getValue(rowKey, 'supAmt3');
			var vatAmt3 = guMaeGridList.getValue(rowKey, 'vatAmt3');
			var totAmt3 = guMaeGridList.getValue(rowKey, 'totAmt3');
			var supAmt3All = 0;
			var vatAmt3All = 0;
			var totAmt3All = 0;

			// 별도, 포함
			switch (columnName) {
				case 'supAmt2' :
					/* 매입가 */
					vatAmt2 = supAmt2/10; // TAX
					totAmt2 = supAmt2/1.1; // 공급가액
					break;
				case 'supAmt3' :
					/* 견적가 */
					vatAmt3 = supAmt3/10; // TAX
					totAmt3 = supAmt3/1.1; // 공급가액
					break;
				case 'totAmt2' :
					/* 매입가 */
					supAmt2 = totAmt2/11*10; // 공급가액
					vatAmt2 = totAmt2/11; // TAX
					break;
				case 'totAmt3' :
					/* 견적가 */
					supAmt3 = totAmt3/11*10; // 공급가액
					vatAmt3 = totAmt3/11; // TAX
					break;
			}

			/**
			 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
			 * */

			/* 매입가 */
			supAmt2 = Math.ceil(supAmt2);  // 올림
			vatAmt2 = Math.floor(vatAmt2); // 내림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			guMaeGridList.setValue(rowKey, "supAmt2", supAmt2);
			guMaeGridList.setValue(rowKey, "vatAmt2", vatAmt2);
			guMaeGridList.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 견적가 */
			supAmt3 = Math.ceil(supAmt3);  // 올림
			vatAmt3 = Math.floor(vatAmt3); // 내림
			totAmt3 = supAmt3 + vatAmt3; // 합계
			guMaeGridList.setValue(rowKey, "supAmt3", supAmt3);
			guMaeGridList.setValue(rowKey, "vatAmt3", vatAmt3);
			guMaeGridList.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

			/* 매입가+견적가+계약금액 합계 적용 */
			var data = guMaeGridList.getFilteredData()
			var dataLen = data.length;
			for (let i = 0; i < dataLen; i++) {
				supAmt2All += Number(data[i].supAmt2);
				vatAmt2All += Number(data[i].vatAmt2);
				totAmt2All += Number(data[i].totAmt2);
				supAmt3All += Number(data[i].supAmt3);
				vatAmt3All += Number(data[i].vatAmt3);
				totAmt3All += Number(data[i].totAmt3);
			}
			guMaeGridList.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmt2All));
			guMaeGridList.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmt2All));
			guMaeGridList.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmt2All));

			guMaeGridList.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmt3All));
			guMaeGridList.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmt3All));
			guMaeGridList.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmt3All));
		});

		guMaeGridItem.on('click', async ev => {
			var colNm = ev.columnName;
			var target = ev.targetType;
			if(target === 'cell'){
				// if(colNm ==='itemNm') await popupHandler('item','open');
			}else{
				guMaeGridItem.finishEditing();
			}
		});

		guMaeGridItem.on('editingFinish', ev => {

			var columnName = ev.columnName;
			var rowKey = ev.rowKey;


			var vatDivi = guMaeGridItem.getValue(rowKey, 'vatDivi');
			var taxDivi = guMaeGridItem.getValue(rowKey, 'taxDivi');

			var qty = guMaeGridItem.getValue(rowKey, 'qty');

			var cost2 = guMaeGridItem.getValue(rowKey, 'cost2');
			var supAmt2 = guMaeGridItem.getValue(rowKey, 'supAmt2');
			var vatAmt2 = guMaeGridItem.getValue(rowKey, 'vatAmt2');
			var totAmt2 = guMaeGridItem.getValue(rowKey, 'totAmt2');
			var supAmtAll2 = 0;
			var vatAmtAll2 = 0;
			var totAmtAll2 = 0;

			var cost3 = guMaeGridItem.getValue(rowKey, 'cost3');
			var supAmt3 = guMaeGridItem.getValue(rowKey, 'supAmt3');
			var vatAmt3 = guMaeGridItem.getValue(rowKey, 'vatAmt3');
			var totAmt3 = guMaeGridItem.getValue(rowKey, 'totAmt3');
			var supAmtAll3 = 0;
			var vatAmtAll3 = 0;
			var totAmtAll3 = 0;

			switch (columnName) {
				case 'qty' :
				case 'cost' :
				case 'cost2' :
				case 'cost3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분

							/* 견적가 */
							supAmt2 = qty * cost2; // 공급가액
							vatAmt2 = supAmt2 * 0.1; // TAX

							/* 계약금액 */
							supAmt3 = qty * cost3; // 공급가액
							vatAmt3 = supAmt3 * 0.1; // TAX
						} else {//포함

							/* 견적가 */
							supAmt2 = qty * cost2 / 1.1; // 공급가액
							vatAmt2 = qty * cost2 - supAmt2; // TAX

							/* 계약금액 */
							supAmt3 = qty * cost3 / 1.1; // 공급가액
							vatAmt3 = qty * cost3 - supAmt3; // TAX
						}
					} else {// 면세, 영세

						/* 견적가 */
						supAmt2 = qty * cost2; // 공급가액
						vatAmt2 = 0; // TAX

						/* 계약금액 */
						supAmt3 = qty * cost3; // 공급가액
						vatAmt3 = 0; // TAX
					}
					break;
				case 'supAmt' :
				case 'supAmt2' :
				case 'supAmt3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						// 별도, 포함

						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = supAmt2/10; // TAX
						totAmt2 = supAmt2/1.1; // 공급가액

						/* 계약금액 */
						cost3 = supAmt3/qty; // 단가
						vatAmt3 = supAmt3/10; // TAX
						totAmt3 = supAmt3/1.1; // 공급가액

					} else {// 면세, 영세

						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = 0; // TAX
						totAmt2 = supAmt2; // 공급가액

						/* 계약금액 */
						cost3 = supAmt3/qty; // 단가
						vatAmt3 = 0; // TAX
						totAmt3 = supAmt3; // 공급가액
					}
					break;
				case 'totAmt' :
				case 'totAmt2' :
				case 'totAmt3' :
					if (vatDivi === "01") {// 과세, 면세 구분
						// 별도, 포함
						/* 매입가 */

						/* 견적가 */
						supAmt2 = totAmt2/11*10; // 공급가액
						vatAmt2 = totAmt2/11; // TAX
						cost2 = supAmt2/qty; // 단가

						/* 계약금액 */
						supAmt3 = totAmt3/11*10; // 공급가액
						vatAmt3 = totAmt3/11; // TAX
						cost3 = supAmt3/qty; // 단가

					} else {// 면세, 영세

						/* 견적가 */
						supAmt2 = totAmt2; // 공급가액
						vatAmt2 = 0; // TAX
						cost2 = supAmt2/qty; // 단가

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

			/* 견적가 */
			cost2 = Math.ceil(cost2); // 내림
			supAmt2 = Math.ceil(supAmt2);  // 올림
			vatAmt2 = Math.floor(vatAmt2); // 내림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			guMaeGridItem.setValue(rowKey, "cost2", cost2);
			guMaeGridItem.setValue(rowKey, "supAmt2", supAmt2);
			guMaeGridItem.setValue(rowKey, "vatAmt2", vatAmt2);
			guMaeGridItem.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 계약금액 */
			cost3 = Math.ceil(cost3); // 내림
			supAmt3 = Math.ceil(supAmt3);  // 올림
			vatAmt3 = Math.floor(vatAmt3); // 내림
			totAmt3 = supAmt3 + vatAmt3; // 합계
			guMaeGridItem.setValue(rowKey, "cost3", cost3);
			guMaeGridItem.setValue(rowKey, "supAmt3", supAmt3);
			guMaeGridItem.setValue(rowKey, "vatAmt3", vatAmt3);
			guMaeGridItem.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

			/* 매입가+견적가+계약금액 합계 적용 */
			var data = guMaeGridItem.getFilteredData()
			var dataLen = data.length;
			for (let i = 0; i < dataLen; i++) {
				supAmtAll2 += Number(data[i].supAmt2);
				vatAmtAll2 += Number(data[i].vatAmt2);
				totAmtAll2 += Number(data[i].totAmt2);
				supAmtAll3 += Number(data[i].supAmt3);
				vatAmtAll3 += Number(data[i].vatAmt3);
				totAmtAll3 += Number(data[i].totAmt3);
			}

			guMaeGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
			guMaeGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
			guMaeGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

			guMaeGridItem.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmtAll3));
			guMaeGridItem.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmtAll3));
			guMaeGridItem.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmtAll3));

			document.getElementById('supAmt2').value = edsUtil.addComma(supAmtAll2);
			document.getElementById('vatAmt2').value = edsUtil.addComma(vatAmtAll2);
			document.getElementById('totAmt2').value = edsUtil.addComma(totAmtAll2);

			document.getElementById('supAmt3').value = edsUtil.addComma(supAmtAll3);
			document.getElementById('vatAmt3').value = edsUtil.addComma(vatAmtAll3);
			document.getElementById('totAmt3').value = edsUtil.addComma(totAmtAll3);
		});

		guMaeGridEmail.on('focusChange', async ev => {
			if(ev.rowKey !== ev.prevRowKey){

				var rowKey = ev.rowKey;
				var data = guMaeGridEmail.getRow(rowKey);
				var keys = Object.keys(data);

				/* 이메일 내역 세팅*/
				for (let i = 0; i < keys.length; i++) {
					var key = keys[i];
					var doc = document.getElementById(key);
					if(doc){ // input
						// console.log(key + ' is exist');
						if(key==='note'){
							guMaeeditor.setHTML(data[key], true);
						}else{
							doc.value = data[key];
						}
					}else{ // note
						// console.log(key + ' is not exist');
					}
				}

				/* 이메일 첨부파일 조회 및 세팅*/
				var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
				param.ordCd = guMaeGridEmail.getValue(rowKey, 'ordCd');
				param.emailSeq = guMaeGridEmail.getValue(rowKey, 'seq');
				param.divi = 'order';
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

			if(ev.rowKey !== ev.prevRowKey){
				if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
					if (guMaeGridList.getValue(ev.rowKey, "deadDivi") === '1') {
						// document.getElementById('btnSave').disabled = true;
						// document.getElementById('btnDelete').disabled = true;
						document.getElementById('btnPrint').disabled = true;
						document.getElementById('btnEmailPopup').disabled = true;
					} else {
						// document.getElementById('btnSave').disabled = false;
						// document.getElementById('btnDelete').disabled = false;
						document.getElementById('btnPrint').disabled = false;
						document.getElementById('btnEmailPopup').disabled = false;
					}
				}
			}
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		// document.getElementById('guMaeGridList').style.height = (innerHeight)*(1-0.11) + 'px';
		// document.getElementById('guMaeGridItem').style.height = (innerHeight)*(1-0.6) + 'px';
		// document.getElementById('guMaeGridEmail').style.height = (innerHeight)*(1-0.25) + 'px';
		doAction('guMaeGridList', 'search')
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'guMaeGridList') {
			switch (sAction) {
				case "search":// 조회

					guMaeGridList.finishEditing(); // 데이터 초기화
					guMaeGridList.clear(); // 데이터 초기화
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					guMaeGridList.resetData(edsUtil.getAjax("/GUMAE_ORD_MGT/selectOrdMgtList", param)); // 데이터 set

					// if(guMaeGridList.getRowCount() > 0 ){
					// 	guMaeGridList.focusAt(0, 0, true);
					// }
					break;
				case "input":// 신규

					document.querySelector('div[id="modalCart"] input[id="corpCd"]').value = $("#searchForm #corpCd").val();
					document.querySelector('div[id="modalCart"] input[id="busiCd"]').value = $("#searchForm #busiCd").val();
					document.querySelector('div[id="modalCart"] input[id="ordCd"]').value = '';
					document.querySelector('div[id="modalCart"] input[id="deadDivi"]').value = '0';
					document.querySelector('div[id="modalCart"] input[id="ordDt"]').value = edsUtil.getToday("%Y-%m-%d");
					document.querySelector('div[id="modalCart"] input[id="ordDueDt"]').value = edsUtil.getToday("%Y-%m-%d");

					document.querySelector('div[id="modalCart"] input[id="supAmt2"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="vatAmt2"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="totAmt2"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="supAmt3"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="vatAmt3"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="totAmt3"]').value = 0;
					document.querySelector('div[id="modalCart"] input[id="manNote"]').value = '';

					document.getElementById('btnItemPopEv').click();
					setTimeout(ev=>{
						doAction('guMaeGridItem', 'search');
					}, 300)

					break;
				case "save"://저장
					await edsUtil.doCUD("/GUMAE_ORD_MGT/cudOrdMgtList", "guMaeGridList", guMaeGridList);
					break;
				case "delete"://삭제
					await guMaeGridList.removeCheckedRows(true);
					await edsUtil.doCUD("/GUMAE_ORD_MGT/cudOrdMgtList", "guMaeGridList", guMaeGridList);
					break;
				case "finish"://마감
					await edsUtil.doDeadline(
							"/GUMAE_ORD_MGT/deadLineOrdMgtList",
							"guMaeGridList",
							guMaeGridList,
							'1');
					break;
				case "cancel"://마감취소
					await edsUtil.doDeadline(
							"/GUMAE_ORD_MGT/deadLineOrdMgtList",
							"guMaeGridList",
							guMaeGridList,
							'0');
					break;
				case "print"://인쇄

					document.querySelector('input[value="prints1"]').setAttribute('checked', 'checked');

					document.getElementById('btnPrint3').style.display = 'inline';
					document.getElementById('btnPrint2').click();

					break;
				case "print2":// 발주서 선택

					// document.getElementById('btnPrint3').style.display = 'block';

					break;
				case "print3"://인쇄
					var row = guMaeGridList.getRow(guMaeGridList.getFocusedCell().rowKey)
					var printKind = document.querySelector('input[name="prints"]:checked').value
					var param = new Array();
					var num = document.getElementById('totAmt').value;
					var num2han = await edsUtil.num2han(num);
					var element = {
						corpCd : '<c:out value="${LoginInfo.corpCd}"/>',
						busiCd : '<c:out value="${LoginInfo.busiCd}"/>',
						ordCd : row.ordCd,
						num : edsUtil.addComma(num),
						num2han : num2han,
						printKind : printKind,
					};
					param.push(element)
					if(printKind === "prints2" ||printKind === "prints3"){
						jr.open(param, 'guMae_baljuseo2');
					}else if(printKind === "prints6" ||printKind === "prints7"){
						jr.open(param, 'guMae_baljuseo3');
					}
					else{
						jr.open(param, 'guMae_baljuseo');
					}
					break;
				case "emailPopup":// 이메일 팝업 보기

					var row = guMaeGridList.getFocusedCell();
					var ordCd = guMaeGridList.getValue(row.rowKey,'ordCd');
					doAction('guMaeGridEmail', 'reset');
					if(ordCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '발주서가 없습니다.',
						});
					}else{
						document.getElementById('btnEmailPopEv').click();
						document.getElementById('setFrom').value = '<c:out value="${LoginInfo.empNm}"/>'+' <'+'<c:out value="${LoginInfo.email}"/>'+'>';
						setTimeout(ev=>{
							document.getElementById('btnSearch3').click();
						}, 300)
					}
					break;
				case "itemPopup":// 상세 팝업 보기

					await fn_CopyGuMaeGridList2Form();
					document.getElementById('btnItemPopEv').click();
					setTimeout(ev=>{
						doAction('guMaeGridItem', 'search');
					}, 300)

					var row = guMaeGridList.getFocusedCell();
					var estCd = guMaeGridList.getValue(row.rowKey,'ordCd');
					if(estCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '발주서가 없습니다.',
						});
					}else{
						document.getElementById('btnItemPopEv').click();
						setTimeout(ev=>{
							doAction('guMaeGridItem', 'search');
						}, 300)
					}
					break;
				case "apply"://저장
					await popupHandler('apply_ord','open');
					break;
			}
		}else if (sheetNm == 'guMaeGridItem') {
			switch (sAction) {
				case "search":// 조회

					guMaeGridItem.refreshLayout(); // 데이터 초기화
					guMaeGridItem.finishEditing(); // 데이터 마감
					guMaeGridItem.clear(); // 데이터 초기화

					var row = guMaeGridList.getFocusedCell();
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.estCd = guMaeGridList.getValue(row.rowKey, 'estCd');
					param.projCd = guMaeGridList.getValue(row.rowKey, 'projCd');
					param.ordCd = guMaeGridList.getValue(row.rowKey, 'ordCd');
					guMaeGridItem.resetData(edsUtil.getAjax("/GUMAE_ORD_MGT/selectOrdItemList", param)); // 데이터 set

					if(guMaeGridItem.getRowCount() > 0 ){
						guMaeGridItem.focusAt(0, 0, true);
					}
					setTimeout(async ()=>{
						document.getElementById('supAmt').value = edsUtil.addComma(guMaeGridItem.getSummaryValues('supAmt').filtered.sum);
						document.getElementById('vatAmt').value = edsUtil.addComma(guMaeGridItem.getSummaryValues('vatAmt').filtered.sum);
						document.getElementById('totAmt').value = edsUtil.addComma(guMaeGridItem.getSummaryValues('totAmt').filtered.sum);
					},100)
					break;
				case "input":// 신규

					var row = guMaeGridList.getFocusedCell();

					var appendedData = {};
					appendedData.status = "I";
					appendedData.corpCd = guMaeGridList.getValue(row.rowKey,'corpCd');
					appendedData.busiCd = guMaeGridList.getValue(row.rowKey,'busiCd');
					appendedData.estCd = guMaeGridList.getValue(row.rowKey,'estCd');
					appendedData.projCd = guMaeGridList.getValue(row.rowKey,'projCd');
					appendedData.ordCd = guMaeGridList.getValue(row.rowKey,'ordCd');
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

					guMaeGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

					break;
				case "save"://저장
					await edsUtil.modalCUD("/GUMAE_ORD_MGT/cudOrdList", "guMaeGridItem", guMaeGridItem, 'guMaeGridListForm');
					// await doAction('guMaeGridItem','close')
					break;
				case "delete"://삭제
					await guMaeGridItem.removeCheckedRows(true);
					await edsUtil.doCUD("/GUMAE_ORD_MGT/cudOrdItemList", "guMaeGridItem", guMaeGridItem);
					break;
				case "close"://닫기
					document.getElementById('btnClose1').click();
					await doAction('guMaeGridList','search');
					break;
			}
		}else if (sheetNm == 'guMaeGridEmail') {
			switch (sAction) {
				case "search":// 조회

					guMaeGridEmail.refreshLayout(); // 데이터 초기화
					guMaeGridEmail.finishEditing(); // 데이터 마감
					guMaeGridEmail.clear(); // 데이터 초기화

					/* 이메일 조회 */
					var row = guMaeGridList.getFocusedCell();
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.estCd = guMaeGridList.getValue(row.rowKey, 'estCd');
					param.projCd = guMaeGridList.getValue(row.rowKey, 'projCd');
					param.ordCd = guMaeGridList.getValue(row.rowKey, 'ordCd');
					param.divi = 'order';
					guMaeGridEmail.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailInfo", param)); // 데이터 set

					// if(guMaeGridEmail.getRowCount() > 0 ){
					// 	guMaeGridEmail.focusAt(0, 0, true);
					// }

					break;
				case "reset":// 신규
					guMaeGridEmail.refreshLayout(); // 데이터 초기화
					/**
					 * input 초기화
					 * */
					// document.getElementById('setFrom').value = "";
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
					guMaeeditor.reset();

					break;
				case "delete"://삭제
					await guMaeGridEmail.removeCheckedRows(true);
					await edsUtil.doCUD("/GUMAE_ORD_MGT/cudOrdEmailList", "guMaeGridEmail", guMaeGridEmail);
					break;
				case "print4":// 발주서 선택

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
					formData.append("divi",			'order');
					var row = guMaeGridList.getFocusedCell();
					var estCd = guMaeGridList.getValue(row.rowKey,'estCd');
					var projCd = guMaeGridList.getValue(row.rowKey,'projCd');
					var ordCd = guMaeGridList.getValue(row.rowKey,'ordCd');
					var busiCd = guMaeGridList.getValue(row.rowKey,'busiCd');
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
					formData.append("html",			guMaeeditor.getHTML());

					/* 기존 이메일 순번*/
					var row = guMaeGridEmail.getFocusedCell();
					var beforeEmailSeq = guMaeGridEmail.getValue(row.rowKey,'seq');
					formData.append("beforeEmailSeq",beforeEmailSeq);

					/* 발주서 파라미터*/
					var row = guMaeGridList.getFocusedCell();
					var num = document.getElementById('totAmt').value;
					var num2han = await edsUtil.num2han(num);

					if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("id",		'guMae_baljuseo2');
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("id",		'guMae_baljuseo3');
					}else{
						formData.append("id",		'guMae_baljuseo');
					}

					// 인쇄 파일 명
					if(printKind.value === "prints1"||printKind.value === "prints8"){
						formData.append("nameFormat",	"[이디에스]_발주서_");
					}else if(printKind.value === "prints2" ||printKind.value === "prints3"){
						formData.append("nameFormat",	"[토마토아이엔에스]_발주서_");
					}else if(printKind.value === "prints6" ||printKind.value === "prints7"){
						formData.append("nameFormat",	"[이디에스원]_발주서_");
					}else {
						formData.append("nameFormat",	"[이디에스(청주)]_발주서_");
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
								await doAction("guMaeGridEmail", "search");
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
		var row = guMaeGridList.getFocusedCell();
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
					param.custNm= guMaeGridList.getValue(row.rowKey, 'custNm');
					param.name= name;
					await edsIframe.openPopup('CUSTPOPUP',param)
				}else{

					document.querySelector('div[id="modalCart"] input[id="custCd"]').value = callback.custCd??"";
					document.querySelector('div[id="modalCart"] input[id="custNm"]').value = callback.custNm??"";
				}
				break;
			case 'depa':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
					param.depaNm= guMaeGridList.getValue(row.rowKey, 'depaNm')??'';
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
			case 'apply':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.name= name;
					await edsIframe.openPopup('PROJPOPUP',param);
				}else{
					if(names[1] === 'ord') {
						if(callback.rows === undefined) return;
						await edsUtil.doApply("/GUMAE_ORD_MGT/aProjMgtList", callback.rows);
						await doAction("guMaeGridList", "search");
					}
				}
				break;
			case 'proj':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
					param.name= name;
					await edsIframe.openPopup('PROJPOPUP',param);
				}else{
					if(callback.rows === undefined) return;
					document.querySelector('div[id="modalCart"] input[id="projCd"]').value = callback.rows[0].projCd;
					document.querySelector('div[id="modalCart"] input[id="projNm"]').value = callback.rows[0].projNm;
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
					var maiRow = guMaeGridList.getFocusedCell();
					var subRow = guMaeGridItem.getFocusedCell();
					if(rstLen > 0){
						for(var i=0; i<rstLen; i++){
							var data = edsUtil.cloneObj(guMaeGridItem.getData());
							var itemRow = edsUtil.getMaxObject(data,'rowKey');
							rst[i].rowKey = itemRow.rowKey+i+1;
							rst[i].corpCd = guMaeGridList.getValue(maiRow.rowKey, "corpCd");
							rst[i].busiCd = guMaeGridList.getValue(maiRow.rowKey, "busiCd");
							rst[i].estCd = guMaeGridList.getValue(maiRow.rowKey, "estCd");
							rst[i].projCd = guMaeGridList.getValue(maiRow.rowKey, "projCd");
							rst[i].ordCd = guMaeGridList.getValue(maiRow.rowKey, "ordCd");
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
							guMaeGridItem.appendRow(rst[i])
						}
						guMaeGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
					}else{
						// guMaeGridList.setValue(row.rowKey,'itemCd',callback.itemCd);
						// guMaeGridList.setValue(row.rowKey,'itemNm',callback.itemNm);
					}
				}
				break;
			case 'itemPopup':
				if(divi==='open'){
					document.getElementById('btnItemPopup').click();
					setTimeout(async ev =>{
						await doAction('guMaeGridItem','search')
					},200)
				}else{

				}
				break;
		}
	}

	async function fn_CopyGuMaeGridList2Form(){
		var rows = guMaeGridList.getRowCount();
		if(rows > 0){
			var row = guMaeGridList.getFocusedCell();
			var param = {
				sheet: guMaeGridList,
				form: document.guMaeGridListForm,
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