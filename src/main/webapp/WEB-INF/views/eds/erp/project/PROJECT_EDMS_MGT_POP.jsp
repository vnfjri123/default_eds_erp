<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>

	<script>
		var projectGridList;
		let select;
		$(document).ready(async function () {
			select =$('.select2').select2();
			await init();
			//	이벤트
			$('#searchForm #projNm').on('keydown', async function(e) {
			if (e.which == 13) {
				await doAction("projectGridList", "search");
				if(projectGridList.getRowCount() > 0 ){
					projectGridList.focusAt(0, 0, true);
				}
			}
			});
			document.getElementById('projNm').focus();
		});

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			//edsUtil.setForm(document.querySelector("#searchForm"), "project");
			//edsUtil.setForm(document.querySelector("#searchForm"), "edms");
			edsUtil.setForm(document.querySelector("#searchForm"), "edms");
			/* 1년 날짜 셋팅 */
			let today=edsUtil.getFirstday();
			let stDt=today.substr(0,4)+"-01-01";
			let edDt=today.substr(0,4)+"-12-31";
			document.getElementById('stDt').value=stDt;
			document.getElementById('edDt').value=edDt;
			/* 조회옵션 셋팅 */
			await edsIframe.setParams();


			/**********************************************************************
			 * editor 영역 START
			 ***********************************************************************/

			/**********************************************************************
			 * editor 영역 END
			 ***********************************************************************/

			/*********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/

			/* 그리드 초기화 속성 설정 */
			projectGridList = new tui.Grid({
				el: document.getElementById('projectGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum', */'checkbox'],
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
			});

			projectGridList.setColumns([
				{ header:'착수일자',		name:'initiateDt',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'계약일자',		name:'cntDt',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'사업장',		name:'busiNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'프로젝트명',	name:'projNm',		minWidth:140,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'거래처',		name:'custNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'합계금액',		name:'totAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적일자',		name:'estDt',		width:80,		align:'center',	hidden:true },
				{ header:'유효기간',		name:'validDt',		width:80,		align:'center',	hidden:true },
				{ header:'마감',			name:'deadDivi',	width:55,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'담당자코드',	name:'manCd',		width:100,		align:'center',	hidden:true },
				{ header:'성공',			name:'sccDivi',		width:40,		align:'center',	hidden:true },
				{ header:'구분',			name:'projDivi',	width:40,		align:'center',	hidden:true },
				{ header:'납기일자',		name:'dueDt',		width:80,		align:'center',	hidden:true },
				{ header:'종료일자',		name:'endDt',		width:80,		align:'center',	hidden:true },
				{ header:'부서',			name:'depaNm',		width:80,		align:'center',	hidden:true },
				{ header:'담당자',		name:'manNm',		width:50,		align:'center',	hidden:true },
				{ header:'분류',			name:'clas',		width:80,		align:'center',	hidden:true },
				{ header:'품목',			name:'item',		width:80,		align:'center',	hidden:true },
				{ header:'결제조건',		name:'payTm',		width:80,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt3',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt3',		width:100,		align:'right',	hidden:true },
				{ header:'비고',			name:'note1',		minWidth:150,	align:'left',	hidden:true },
				{ header:'결재자보고내용',	name:'note2',		minWidth:150,	align:'left',	hidden:true },
				{ header:'저장문서번호',	name:'submitCd',		minWidth:150,	align:'left',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			projectGridList.on('click', async ev => {
				var target = ev.targetType;
				var rowKey = ev.rowKey;
				var row = projectGridList.getRow(rowKey)._attributes.checked;
				if(target === 'cell'){
					if(row === false) projectGridList.check(rowKey);
					else  projectGridList.uncheck(rowKey);
				}
			});
			projectGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
				    await projectGridList.check(ev.rowKey);
					await doAction("projectGridList", "apply");
				}
				if(ev.keyboardEvent.keyCode == "8"){
				    document.getElementById('projNm').focus();
				}
			});
			$(document).keydown(function(e) {
			if ( e.key == 'Escape') {
				doAction("projectGridList", "close")
				}
			})
			$('#searchForm #busiCd').on('change', async function(e)
			{
				await doAction("projectGridList", "search");
				if(projectGridList.getRowCount() > 0 ){
					projectGridList.focusAt(0, 0, true);
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/
			await doAction('projectGridList', 'search');
			/* 그리드생성 */
			document.getElementById('projectGridList').style.height = (innerHeight)*(1-0.18) + 'px';
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'projectGridList') {
				switch (sAction) {
					case "search":// 조회

						projectGridList.finishEditing(); // 데이터 초기화
						projectGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						projectGridList.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjMgtList", param)); // 데이터 set
						break;
					case "apply"://선택

						projectGridList.finishEditing();

						var param = {};
						param.rows = projectGridList.getCheckedRows();
						param.name = document.getElementById('name').value;

						await edsIframe.closePopup(param);

						break;
					case "close":	// 닫기

						var param = {};
						param.name = document.getElementById('name').value;

						await edsIframe.closePopup(param);

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

		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
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
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="projDivi" id="projDivi" title="프로젝트구분">
						<div class="form-group mr-1">
							<div class="input-group-prepend">
								<label >사업장 &nbsp;</label>
								<div class="input-group-prepend" style="min-width: 15rem;">
									<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd" disabled>
									</select>
								</div>
							</div>
							<div class="input-group-append" hidden>
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
						</div>
						<div class="form-group mr-1">
							<label for="projNm">프로젝트명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="projNm" id="projNm" title="프로젝트명">
							</div>
						</div>
						<!-- ./input hidden -->
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
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="projectGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="projectGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="projectGridListButtonForm" id="projectGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('projectGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('projectGridList', 'apply')"><i class="fa fa-save"></i> 선택</button>
									<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('projectGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>