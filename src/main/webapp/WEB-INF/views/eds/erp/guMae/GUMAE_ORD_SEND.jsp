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
							<div class="input-group-prepend">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
							</div>
							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>
							<div class="input-group-append">
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
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
			<div class="col-md-12" id="guMaeGridEmail" style="height: calc(100vh - 6rem); width: 100%;">
				<div id="guMaeGridEmailDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="guMaeGridEmailButtonForm" id="guMaeGridEmailButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"		id="btnSearch"		onclick="doAction('guMaeGridEmail', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary d-none" name="btnEmailPopup"	id="btnEmailPopup"	onclick="doAction('guMaeGridEmail', 'emailPopup')"><i class="fa fa-envelope"></i> 메일승인</button>

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
					<div class="col-md-12" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" style="height: 100%;">
								<!-- form start -->
								<form class="form-inline" role="form" name="baseEmailForm" id="baseEmailForm" method="post" onsubmit="return false;">
									<table class="table table-bordered table-sm">
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">보내는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setForm" id="setForm" readonly="readonly">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">받는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="toAddr" id="toAddr" readonly="readonly">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="ccAddr" id="ccAddr" readonly="readonly">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">숨은 참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="bccAddr" id="bccAddr" readonly="readonly">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">제목</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setSubject" id="setSubject" readonly="readonly">
													<input style="text-align: left" type="file" class="custom-file-input d-none" name="emailFile" id="emailFile" aria-describedby="emailFile" multiple>
												</div>
											</td>
										</tr>
									</table>
								</form>
								<!-- ./form -->
								<div id="guMaeGridEmailFile" style="height: calc(30vh); width: 100%;">
									<!-- 시트가 될 DIV 객체 -->
									<div id="guMaeGridEmailFileDIV" style="width:100%; height:100%;"></div>
								</div>
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
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('guMaeGridEmail', 'emailSend')"><i class="fa fa-print"></i> 메일승인</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailBack"	id="btnEmailBack"	onclick="doAction('guMaeGridEmail', 'emailBack')"><i class="fa fa-print"></i> 메일반려</button>
<%--											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('guMaeGridEmail', 'apply')"><i class="fa fa-print"></i> 메일승인</button>--%>
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnEmailFileSearch"	id="btnEmailFileSearch"	onclick="doAction('guMaeGridEmailFile', 'search')"><i class="fa fa-print"></i> 조회</button>
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
</body>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>



<script>
	var guMaeGridEmail, guMaeGridItem, guMaeGridEmail;
	var ordDt, ordDueDt;
	var guMaeeditor;

	$(document).ready(function () {
		init();

		/**
		 * 조회 엔터 기능
		 * */
		document.getElementById('searchForm').addEventListener('keyup', async ev=>{
			var id = ev.target.id;
			if(ev.keyCode === 13){
				await doAction('guMaeGridEmail', 'search');
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
		await edsUtil.setButtonForm(document.querySelector("#guMaeGridEmailButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#guMaeEmailButtonForm"));

		/*********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		guMaeGridEmail = new tui.Grid({
			el: document.getElementById('guMaeGridEmailDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum','checkbox'],
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
			{ header:'발송여부',		name:'sendDivi',	width:100,		align:'center',
			  formatter: function (value) {
				if(value.value === '01') return '미발송';
				else if(value.value === '02') return '발송완료';
				else if(value.value === '03') return '발송반려';
				else return '미발송';
			  },
			},
			// { header:'보낸일시',		name:'inpDttm',		width:150,	align:'center',	defaultValue: ''	},
			{ header:'보낸일시',		name:'updDttm',		width:150,	align:'center',	defaultValue: ''	},
			{ header:'제목',			name:'setSubject',	minWidth:100,	align:'left',	defaultValue: ''	},
			{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},
			{ header:'수정자',		name:'updNm',		width:100,	align:'center',	defaultValue: ''	},

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
			{ header:'내용',			name:'note',		width:100,	align:'center',	hidden:true },
		]);

		guMaeGridEmailFile = new tui.Grid({
			el: document.getElementById('guMaeGridEmailFileDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'/*, 'checkbox'*/],
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

		guMaeGridEmailFile.setColumns([
			{ header:'파일명',		name:'origNm',		minWidth:300,		align:'left',	defaultValue: ''	},
			{ header:'다운로드',		name:'fileDownLoad',width:60,		align:'Center',	formatter:function(){return "<i class='fa fa-download'></i>";},},
			{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: ''	},
			{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: ''	},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
			{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
			{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
			{ header:'품목코드',		name:'itemCd',		width:100,		align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
			{ header:'저장명',		name:'saveNm',		width:100,		align:'center',	hidden:true },
			{ header:'원본명',		name:'origNm',		width:100,		align:'center',	hidden:true },
			{ header:'저장경로',		name:'saveRoot',	width:100,		align:'center',	hidden:true },
			{ header:'확장자',		name:'ext',			width:100,		align:'center',	hidden:true },
			{ header:'크기',			name:'size',		width:100,		align:'center',	hidden:true },
			{ header:'입력일자',		name:'inpDttm',		width:100,		align:'center',	hidden:true },
			{ header:'수정일자',		name:'updDttm',		width:100,		align:'center',	hidden:true },
			{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor:{type:'text'},	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

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

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/

		/* 더블클릭 시, 상세목록 */
		guMaeGridEmail.on('click', async ev => {
			if(ev.targetType === 'cell'){
				await doAction('guMaeGridEmail','emailPopup');
				setTimeout(async ev =>{
					await doAction('guMaeGridEmailFile', 'search')
				},200);

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
			}
		});

		guMaeGridEmailFile.on('click', async ev => {
			var colNm = ev.columnName;
			var target = ev.targetType;
			var rowKey = ev.rowKey;
			if(target === 'cell'){
				if(colNm==='fileDownLoad') await edsUtil.fileDownLoad(guMaeGridEmailFile);
				// else if(colNm==='accountNm') await popupHandler('account','open');
			}else{
				// projectGridCost.finishEditing();
			}
		});



		await doAction('guMaeGridEmail', 'search')
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'guMaeGridEmail') {
			switch (sAction) {
				case "search":// 조회

					guMaeGridEmail.refreshLayout(); // 데이터 초기화
					guMaeGridEmail.finishEditing(); // 데이터 마감
					guMaeGridEmail.clear(); // 데이터 초기화

					/* 이메일 조회 */
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.divi = 'order';
					guMaeGridEmail.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailInfo2", param)); // 데이터 set

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
					 * 에디터 초기화
					 * */
					guMaeeditor.reset();

					break;
				case "delete"://삭제
					await guMaeGridEmail.removeCheckedRows(true);
					await edsUtil.doCUD("/GUMAE_ORD_MGT/cudOrdEmailList", "guMaeGridEmail", guMaeGridEmail);
					break;
				case "apply"://전송 적용
						var cell = guMaeGridEmail.getFocusedCell();
						var params = [{
							corpCd: guMaeGridEmail.getValue(cell.rowKey,'corpCd'),
							ordCd: guMaeGridEmail.getValue(cell.rowKey,'ordCd'),
							seq: guMaeGridEmail.getValue(cell.rowKey,'seq'),
							sendDivi: '02',
							divi: 'order',
						}];
					await edsUtil.doApply("/EMAIL_MGT/applySendEmail", params);
					break;
				case "print4":// 발주서 선택

					document.getElementById('btnPrint3').style.display = 'none';

					break;
				case "emailSend":// 보내기

					await edsUtil.toggleLoadingScreen('on');

					// file 가져오기
					var file = guMaeGridEmailFile.getData();
					var files = [];
					for (let i = 0, length=file.length; i < length; i++) {
						files.push({
							saveRoot: file[i].saveRoot,
							origNm: file[i].origNm+'.'+file[i].ext
						});
					}

					// formData 생성
					var newForm = $('<form></form>');
					newForm.attr("method", "post");
					newForm.attr("enctype","multipart/form-data");

					// 추가적 데이터 입력
					/* 메세지 파라미터*/
					var formData = new FormData(newForm[0]);
					formData.append("divi",			'order');
					formData.append("sendDivi",		'send');
					var row = guMaeGridEmail.getFocusedCell();
					var estCd = guMaeGridEmail.getValue(row.rowKey,'estCd');
					var projCd = guMaeGridEmail.getValue(row.rowKey,'projCd');
					var ordCd = guMaeGridEmail.getValue(row.rowKey,'ordCd');
					var busiCd = guMaeGridEmail.getValue(row.rowKey,'busiCd');
					var emailSeq = guMaeGridEmail.getValue(row.rowKey,'emailSeq');
					formData.append("emailFile",	JSON.stringify({data:files}));
					formData.append("estCd",		estCd);
					formData.append("projCd",		projCd);
					formData.append("ordCd",		ordCd);
					formData.append("setFrom",		document.getElementById('setForm').value);
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
					var row = guMaeGridEmail.getFocusedCell();
					var num = guMaeGridEmail.getValue(row.rowKey,'totAmt');
					var num2han = await edsUtil.num2han(num);

					formData.append("busiCd",		busiCd);
					formData.append("num",			edsUtil.addComma(num));
					formData.append("num2han",		num2han);

					$.ajax({
						url: "/EMAIL_MGT/onlySendEmail",
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
								await doAction("guMaeGridEmail", "apply");
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
				case "emailPopup":// 이메일 팝업 보기

					var row = guMaeGridEmail.getFocusedCell();
					var ordCd = guMaeGridEmail.getValue(row.rowKey,'ordCd');
					if(ordCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '프로젝트가 없습니다.',
						});
					}else{
						document.getElementById('btnEmailPopEv').click();

						setTimeout(async ev=>{
							await fn_CopyGuMaeGridEmail2Form();
						}, 300)
					}
					break;
				case "emailBack":// 이메일 반려 보내기
					var cell = guMaeGridEmail.getFocusedCell();
					var params = [{
						corpCd: guMaeGridEmail.getValue(cell.rowKey,'corpCd'),
						ordCd: guMaeGridEmail.getValue(cell.rowKey,'ordCd'),
						seq: guMaeGridEmail.getValue(cell.rowKey,'seq'),
						sendDivi: '03',
						divi: 'order',
					}];
					await edsUtil.doApply("/EMAIL_MGT/applySendEmail", params);
					await doAction("guMaeGridEmail", "search");
					break;
			}
		}if (sheetNm == 'guMaeGridEmailFile') {
			switch (sAction) {
				case "search":// 조회

					guMaeGridEmailFile.refreshLayout(); // 데이터 초기화
					guMaeGridEmailFile.finishEditing(); // 데이터 마감
					guMaeGridEmailFile.clear(); // 데이터 초기화

					var row = guMaeGridEmail.getFocusedCell();
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.divi = 'order';
					param.ordCd = guMaeGridEmail.getValue(row.rowKey, 'ordCd');
					param.emailSeq = guMaeGridEmail.getValue(row.rowKey, 'seq');
					guMaeGridEmailFile.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailFileInfoAll", param)); // 데이터 set

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
		var row = guMaeGridEmail.getFocusedCell();
		var names = name.split('_');
		switch (names[0]) {
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
		}
	}

	async function fn_CopyGuMaeGridEmail2Form(){
		var rows = guMaeGridEmail.getRowCount();
		if(rows > 0){
			var row = guMaeGridEmail.getFocusedCell();
			var param = {
				sheet: guMaeGridEmail,
				form: document.baseEmailForm,
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