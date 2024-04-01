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

	<script>
		var baseGridList;
		$(document).ready(function () {
			init();
			

			//	이벤트
			$('#empState, #searchForm #empNm').on('change', function(e) {
				doAction("baseGridList", "search");
			});

			document.getElementById('btnImage').addEventListener('change', (ev)=> {

				var row = baseGridList.getFocusedCell();
				var status = baseGridList.getValue(row.rowKey, 'status');
				if(status === 'I'){
					document.getElementById('btnImage').value = null;
					return toastrmessage("toast-bottom-center", "warning", "사원을 저장 후 사진을 업로드하세요.", "경고", 1500);
				}

				// file set for info
				var files= ev.target.files;

				// file 가져오기
				var file = $('#btnImage'); // input type file tag

				// formData 생성
				var clonFile = file.clone();

				var newForm = $('<form></form>');
				newForm.attr("method", "post");
				newForm.attr("enctype","multipart/form-data");
				newForm.append(clonFile);

				var corpCd = baseGridList.getValue(row.rowKey, 'corpCd');
				var empCd = baseGridList.getValue(row.rowKey, 'empCd');
				var exisOrigNm = baseGridList.getValue(row.rowKey, 'saveNm');
				var exisExt = baseGridList.getValue(row.rowKey, 'ext');

				var filesName= (files[0].name).split('.');
				var filesNameLen = filesName.length -1;

				var origNm = '';

				for (let i = 0; i < filesNameLen; i++) {
					origNm += filesName[i]
				}

				var ext = filesName[filesNameLen];
				var size = files[0].size;

				// 추가적 데이터 입력
				var formData = new FormData(newForm[0]);
				formData.append("corpCd",		corpCd);
				formData.append("empCd",		empCd);
				formData.append("exisOrigNm",	exisOrigNm);
				formData.append("exisExt",		exisExt);
				formData.append("origNm",		origNm);
				formData.append("ext",			ext);
				formData.append("size",			size);

				$.ajax({
					url: "/BASE_USER_MGT_LIST/uploadUserFaceImage",
					type: "POST",
					data: formData,
					enctype: 'multipart/form-data',
					processData: false,
					contentType: false,
					cache: false,
					success: function () {
						// doAction("ADMMA0000Sheet", "search");
						document.getElementById('btnImage').value = null;
						toastrmessage("toast-bottom-center"
								, "success"
								, "파일이 성공적으로 업로드 되었습니다.", "성공", 1500);
					},
					error: function () {
						// toastrmessage("toast-bottom-center"
						//     , "warning"
						//     , "파일을 업로드하고 저장하세요.", "잘못된 저장", 1500);
						// doAction("ADMMA1000Sheet", "search");
					}
				});
			})
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			edsUtil.setForm(document.querySelector("#baseGridListForm"), "basma");
			$('[data-mask]').inputmask();

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseGridListButtonForm"));

			/* 이벤트 셋팅 */
			edsUtil.addChangeEvent("baseGridListForm", fn_CopyForm2baseGridList);

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			baseGridList = new tui.Grid({
				el: document.getElementById('baseGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
				header: {
					height: 40,
					minRowHeight: 40
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});

			baseGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'사원코드',		name:'empCd',		minWidth:100,	align:'center',	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사원명',		name:'empNm',		minWidth:150,	align:'left',	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직위명',		name:'posiDiviNm',	minWidth:100,	align:'center',	filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'사원ID',		name:'empId',		minWidth:150,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:70,	align:'center',	hidden:true },
				{ header:'주민번호',		name:'resiNo',		width:70,	align:'center',	hidden:true },
				{ header:'전화번호',		name:'telNo',		width:70,	align:'center',	hidden:true },
				{ header:'휴대번호',		name:'phnNo',		width:70,	align:'center',	hidden:true },
				{ header:'주소',			name:'addr',		width:70,	align:'center',	hidden:true },
				{ header:'이메일',		name:'email',		width:70,	align:'center',	hidden:true },
				{ header:'이메일',		name:'emailKakaowork',		width:70,	align:'center',	hidden:true },
				{ header:'은행명',		name:'bankCd',		width:70,	align:'center',	hidden:true },
				{ header:'계좌번호',		name:'accoNo',		width:70,	align:'center',	hidden:true },
				{ header:'예금주',		name:'accoNm',		width:70,	align:'center',	hidden:true },
				{ header:'최종학교',		name:'lastSchool',	width:70,	align:'center',	hidden:true },
				{ header:'전공',			name:'major',		width:70,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:70,	align:'center',	hidden:true },
				{ header:'사업장명',		name:'busiNm',		width:70,	align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:70,	align:'center',	hidden:true },
				{ header:'부서명',		name:'depaNm',		width:70,	align:'center',	hidden:true },
				{ header:'입사일자',		name:'ecoDt',		width:70,	align:'center',	hidden:true },
				{ header:'직책구분',		name:'respDivi',	width:70,	align:'center',	hidden:true },
				{ header:'직책명',		name:'respDiviNm',	width:70,	align:'center',	hidden:true },
				{ header:'직위구분',		name:'posiDivi',	width:70,	align:'center',	hidden:true },
				{ header:'퇴사일자',		name:'rcoDt',		width:70,	align:'center',	hidden:true },
				{ header:'퇴사사유',		name:'rcoDet',		width:70,	align:'center',	hidden:true },
				{ header:'비고',			name:'remark',		width:70,	align:'center',	hidden:true },
				{ header:'사원상태',		name:'empState',	width:70,	align:'center',	hidden:true },
				{ header:'접속구분',		name:'accDivi',		width:70,	align:'center',	hidden:true },
				{ header:'권한구분',		name:'authDivi',	width:70,	align:'center',	hidden:true },
				{ header:'비번변경일자',	name:'pwdUpdDt',	width:70,	align:'center',	hidden:true },
				{ header:'저장명',		name:'saveNm',		width:70,	align:'center',	hidden:true },
				{ header:'기존명',		name:'origNm',		width:70,	align:'center',	hidden:true },
				{ header:'확장자',		name:'ext',			width:70,	align:'center',	hidden:true },
				{ header:'사이즈',		name:'size',		width:70,	align:'center',	hidden:true },
				{ header:'그룹아이디',	name:'groupId',		width:70,	align:'center',	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseGridList.on('focusChange', async ev => {

				var targetType = ev.targetType;

				if(ev.rowKey != ev.prevRowKey){
					await fn_CopyForm2baseGridList();
					await fn_CopybaseGridList2Form();

					document.getElementById('empCd').readOnly = true;
					$('#empCdChecked').val('1');//사원코드 체크
					$('#empIdChecked').val('1');//사원아이디 체크

					/* 직원 얼굴 세팅 */
					var rowKey = ev.rowKey;
					var corpCd = baseGridList.getValue(rowKey, "corpCd");//회사코드
					var saveNm = baseGridList.getValue(rowKey, "saveNm");//저장명
					var ext = baseGridList.getValue(rowKey, "ext");//확장자
					var params = corpCd+":"+saveNm+":"+ext;
					$('#userFace').attr("src", "/BASE_USER_MGT_LIST/selectUserFaceImage/" + params);
				}
			});

			baseGridList.on('afterChange', ev => {
				for (var i = 0; i < ev.changes.length; i++) {
					$('#baseGridListForm #' + ev.changes[i].columnName).val(ev.changes[i].value);
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('BASMA3000').style.height = height + 'px';

			/* 사원 사진 프레임 설정 */
			document.getElementById('userFace').style.height = document.getElementById('userFacePlcae').clientHeight + 'px';
			document.getElementById('userFace').style.width = document.getElementById('userFacePlcae').clientWidth + 'px';

			// userFacePlcae
			// userFaceFrame
			var height = window.innerHeight - 90;
			document.getElementById('BASMA3000').style.height = height + 'px';

			/* 조회 */
			doAction("baseGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseGridList') {
				switch (sAction) {
					case "search":// 조회

						baseGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.status = "I";
						appendedData.empState = "01";
						appendedData.accDivi = "02";
						appendedData.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';

						baseGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						await fn_CopybaseGridList2Form();

						setTimeout(function(){
							document.getElementById('empCd').readOnly = false;
							$('#empCdChecked').val('0');//사원코드 체크
							$('#empIdChecked').val('0');//사원아이디 체크
						}, 100);

						break;
					case "save"://저장

						// if($('#empCdChecked').val() != "1"){
						// 	toastrmessage("toast-bottom-center", "warning", "사원코드 중복확인을 해주세요.", "경고", 1500);
						// 	return;
						// }
						//
						// if(!$('#empIdChecked').val() || $('#empIdChecked').val() != "1"){
						// 	toastrmessage("toast-bottom-center", "warning", "사원아이디 중복확인을 해주세요.", "경고", 1500);
						// 	return;
						// }
						//
						// if(!edsUtil.isResiNo($('#resiNo').val())){
						// 	toastrmessage("toast-bottom-center", "warning", "주민번호를 확인을 해주세요.", "경고", 1500);
						// 	return;
						// }

						await edsUtil.doCUD("/BASE_USER_MGT_LIST/cudUserMgtList", "baseGridList", baseGridList);// 저장

						break;
					case "delete"://삭제
						if(fn_userCheckByGroup()){
							await baseGridList.removeCheckedRows(true);
							await edsUtil.doCUD("/BASE_USER_MGT_LIST/cudUserMgtList", "baseGridList", baseGridList);
						}
					case "image"://얼굴 이미지

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
		// 사업장 팝업
		function fn_busiPopup(){
			var param = {
				corpCd: $("#baseGridListForm #corpCd").val(),
				busiCd: ''
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						var row = baseGridList.getFocusedCell();
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
							baseGridList.setValue(row.rowKey, 'busiCd', this.returnValue.busiCd);
							baseGridList.setValue(row.rowKey, 'busiNm', this.returnValue.busiNm);
							// document.getElementById('busiCd').value = this.returnValue.busiCd;
							// document.getElementById('busiNm').value = this.returnValue.busiNm;
						}
					},
					false,
					true
			);
		}
		// 창고 팝업
		function fn_storPopup(){
			var param = {
				corpCd: $("#baseGridListForm #corpCd").val(),
				busiCd: $("#baseGridListForm #busiCd").val(),
				storCd: ''
			};
			edsPopup.util.openPopup(
					"STORPOPUP",
					param,
					function (value) {
						var row = baseGridList.getFocusedCell();
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
							baseGridList.setValue(row.rowKey, 'storCd', this.returnValue.storCd);
							baseGridList.setValue(row.rowKey, 'storNm', this.returnValue.storNm);
							// document.getElementById('storCd').value = this.returnValue.storCd;
							// document.getElementById('storNm').value = this.returnValue.storNm;
						}
					},
					false,
					true
			);
		}
		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/
		async function fn_CopyForm2baseGridList(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopyForm2Sheet(param);// Form -> Sheet복사
			}
		}

		async function fn_CopybaseGridList2Form(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
			}
		}

		function fn_empCdCheck(){
			if ($.trim($("#empCd").val()) == "") {
				alert("사원코드를 입력해 주세요.");
				return;
			}

			var params = {
				empCd  : $("#empCd").val()
			};

			$.ajax({
				url: "/BASE_USER_MGT_LIST/selectEmpCdCheck",
				type: "POST",
				async: false,
				data: params,
				success : function( result ) {
					if (result == '0') {
						toastrmessage("toast-bottom-center", "success", "사용가능한 번호 입니다.", "성공", 1500);
						$('#empCdChecked').val('1');
					} else {
						toastrmessage("toast-bottom-center", "warning", "이미 등록된 번호 입니다.", "경고", 1500);
						$('#empCdChecked').val('0');
					}
				}
			});

			return false;
		}

		function fn_empIdCheck(){
			if ($.trim($("#empId").val()) == "") {
				alert("아이디를 입력해 주세요.");
				return;
			}

			var params = {
				empId  : $("#empId").val()
			};

			$.ajax({
				url: "/BASE_USER_MGT_LIST/selectEmpIdCheck",
				type: "POST",
				async: false,
				data: params,
				success : function( result ) {
					if (result == '0') {
						toastrmessage("toast-bottom-center", "success", "사용가능한 아이디 입니다.", "성공", 1500);
						$('#empIdChecked').val('1');
					} else {
						toastrmessage("toast-bottom-center", "warning", "이미 등록된 아이디 입니다.", "경고", 1500);
						$('#empIdChecked').val('0');
					}
				}
			});

			return false;
		}

		function fn_userCheckByGroup(){
			var chk = baseGridList.getCheckedRows();
			var chkLen = chk.length;
			var params =[];
			for(var i=0; i<chkLen; i++){
				params.push({
					corpCd:chk[i].corpCd,
					empCd:chk[i].empCd,
				})
			}
			var chkParams = 0;
			for(var i=0; i<chkLen; i++) {
				chkParams = edsUtil.getAjax("/BASE_USER_MGT_LIST/userCheckByGroup", params[i])
				if(chkParams.length > 0){
					toastrmessage(	"toast-bottom-center"
							,"warning"
							,"메뉴명 : 그룹별사용자관리<br>"
							+"그룹명 : "+chkParams[0].groupNm+"<br>"
							+"사원코드 : " + chkParams[0].empCd +"<br>"
							+"사원명 : " + chkParams[0].empNm +"<br>"
							+"해당 경로의 데이터를 삭제하세요.<br>"
							,"경고"
							, 4000);
					chkParams += 1;
					return;
				}
			}
			if(chkParams > 0){return false;}
			else{return true;}
		}



		async function popupHandler(name,divi,callback){
			var row = baseGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiNm= baseGridList.getValue(row.rowKey, 'busiNm');
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
					}else{
						baseGridList.setValue(row.rowKey,'busiCd',callback.busiCd);
						baseGridList.setValue(row.rowKey,'busiNm',callback.busiNm);
					}
					break;
			}
		}
		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>
<div class="row">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">

				<!-- ./input hidden -->
				<div class="form-group">
					<label for="empState">재직상태 &nbsp;</label>
					<div class="input-group input-group-sm">
						<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="empState" id="empState" title="재직상태"></select>
					</div>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<label for="empNm">사원명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="empNm" id="empNm" title="사원명">
					</div>
				</div>
			</form>
			<!-- ./form -->
		</div>
	</div>
	<div class="col-md-5">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사용자 목록
				</div>
				<div class="btn-group float-right">

				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="BASMA3000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-md-7">
		<!-- Form 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사용자 상세
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="baseGridListButtonForm" id="baseGridListButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch"	id="btnSearch"	onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput" 	id="btnInput"	onclick="doAction('baseGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave" 	id="btnSave"	onclick="doAction('baseGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete"	id="btnDelete"	onclick="doAction('baseGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
						<label for="btnImage">
							<div class="btn btn-sm btn-primary"><i class="fa fa-user-circle"></i> 이미지</div>
						</label>
						<input type="file" type="file" id="btnImage" name="btnImage" style="display: none;" multiple="multiple" accept="image/*">
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;">
				<!-- form start -->
				<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post">
					<table class="table table-bordered table-sm">
						<tr>
							<td class="table-active" style="width: 15%"><span class="IBRequired">&nbsp;</span>사원코드 &nbsp;<a onclick="fn_empCdCheck(); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td>
								<input type="text" name="empCd" id="empCd" style="width: 100%">
								<input type="hidden" name="empCdChecked" id="empCdChecked" value="1">
							</td>
							<td class="table-active" style="width: 15%"><span class="IBRequired">&nbsp</span>사원명</td>
							<td><input type="text" name="empNm" id="empNm" style="width: 100%"></td>
							<td colspan="2" rowspan="6" name="userFacePlcae" id="userFacePlcae">
									<img style="object-fit: scale-down" id="userFace" name="userFace">
							</td>
						</tr>
						<tr>
							<td class="table-active">ID &nbsp;<a onclick="fn_empIdCheck(); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td>
								<input type="text" name="empId" id="empId" style="width: 100%">
								<input type="hidden" name="empIdChecked" id="empIdChecked" value="1">
							</td>
							<td class="table-active">주민번호</td>
							<td><input type="text" name="resiNo" id="resiNo" style="width: 100%" data-inputmask="'mask': '999999-9999999'" data-mask></td>
						</tr>
						<tr>
							<td class="table-active">전화번호</td>
							<td><input type="text" name="telNo" id="telNo" style="width: 100%;" title="전화번호"/></td>
							<td class="table-active">휴대번호</td>
							<td><input type="text" name="phnNo" id="phnNo" style="width: 100%;" title="휴대번호"/></td>
						</tr>
						<tr>
							<td class="table-active">주소&nbsp;<a onclick="edsUtil.showMapPopup(baseGridList)" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td colspan="3">
								<input type="text" name="addr" id="addr" style="width: 100%">
							</td>
						</tr>
						<tr>
							<td class="table-active">카카오워크email</td>
							<td  colspan="3"><input type="text" name="emailKakaowork" id="emailKakaowork" style="width: 100%;"/></td>
						</tr>
						<tr>
							<td class="table-active">email</td>
							<td><input type="text" name="email" id="email" style="width: 100%;"/></td>
							<td class="table-active">은행명</td>
							<td><input type="text" name="bankCd" id="bankCd" style="width: 100%" title="은행명"></td>
						</tr>
						<tr>
							<td class="table-active">계좌번호</td>
							<td><input type="text" name="accoNo" id="accoNo" style="width: 100%;" title="계좌번호"/></td>
							<td class="table-active">예금주</td>
							<td><input type="text" name="accoNm" id="accoNm" style="width: 100%;" title="예금주"/></td>
						</tr>
						<tr>
							<td class="table-active">최종학교</td>
							<td><input type="text" name="lastSchool" id="lastSchool" style="width: 100%"></td>
							<td class="table-active">전공</td>
							<td><input type="text" name="major" id="major" style="width: 100%;" title="전공"/></td>
							<td class="table-active">접속제한</td>
							<td><select name="accDivi" id="accDivi" title="접속제한" rows="14" cols="33" style="width: 100%;"></select></td>
						</tr>
						<tr>
							<td class="table-active">사업장&nbsp;<a onclick="popupHandler('busi','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td><input type="hidden" name="busiCd" id="busiCd"><input name="busiNm" id="busiNm" ></td>
							<td class="table-active">부서</td>
							<td><select name="depaCd" id="depaCd" title="부서" style="width: 100%"></select></td>
							<td class="table-active">입사일자</td>
							<td><input type="date" name="ecoDt" id="ecoDt" class="form-control" style="width: 100%; border-radius: 3px;" title="입사일자" data-inputmask="'mask': '9999-99-99'" data-mask></td>
						</tr>
						<tr>
							<td class="table-active">직책</td>
							<td><select name="respDivi" id="respDivi" title="직책" style="width: 100%"></select></td>
							<td class="table-active">직위</td>
							<td><select name="posiDivi" id="posiDivi" title="직위" style="width: 100%"></select></td>
							<td class="table-active">퇴사일자</td>
							<td><input type="date" name="rcoDt" id="rcoDt" class="form-control" style="width: 100%; border-radius: 3px;" title="퇴사일자" data-inputmask="'mask': '9999-99-99'" data-mask></td>
						</tr>
						<tr>
							<td class="table-active">비고</td>
							<td colspan="3"><textarea name="remark" id="remark" style="width: 100%;resize: none;"></textarea></td>
							<td class="table-active">퇴사사유</td>
							<td><textarea name="rcoDet" id="rcoDet" style="width: 100%;resize: none;"></textarea></td>
						</tr>
					</table>
				</form>
				<!-- ./form -->
			</div>
		</div>
	</div>
</div>


</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
</html>
<script>

	/**********************************************************************
	 *  START FUNCTION IN JQUERY
	 * ********************************************************************/

	/** table 팝업창
	 * */
	$('#busiNm, #storNm').keyup(function(ev){
		var popDivi = ev.target.id;
		if(ev.which == 13){
			var row = baseGridList.getFocusedCell();
			if(popDivi == 'busiNm'){
				var param = {};
				param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>'; //팝업으로 보낼 파라미터
				param.busiCd = document.getElementById('busiNm').value
				edsPopup.util.openPopup(
						"BUSIPOPUP",
						param,
						function (value) {
							this.returnValue = value||this.returnValue;
							if(this.returnValue){
								baseGridList.setValue(row.rowKey, 'busiCd', this.returnValue.busiCd)
								baseGridList.setValue(row.rowKey, 'busiNm', this.returnValue.busiNm)
							}
						},
						false,
						true
				);
			}
			if(popDivi == 'storNm'){
				var param = {};
				param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>'; //팝업으로 보낼 파라미터
				param.busiCd = '<c:out value="${LoginInfo.busiCd}"/>'; //팝업으로 보낼 파라미터
				param.storCd = document.getElementById('storNm').value
				param.uprTp = "02";	// 매입:01, 매출:02
				edsPopup.util.openPopup(
						"STORPOPUP",
						param,
						function (value) {
							this.returnValue = value||this.returnValue;
							if(this.returnValue){
								baseGridList.setValue(row.rowKey, 'storCd', this.returnValue.storCd)
								baseGridList.setValue(row.rowKey, 'storNm', this.returnValue.storNm)
							}
						},
						false,
						true
				);
			}
		}

		if(ev.which == 8){
			if((document.getElementById('busiNm').value).length == 0){
				$('#baseGridListForm #busiCd').val = '';
			}
			if((document.getElementById('storNm').value).length == 0){
				$('#baseGridListForm #storCd').val = '';
			}
		}
	});

	/**********************************************************************
	 *  END FUNCTION IN JQUERY
	 * ********************************************************************/
</script>