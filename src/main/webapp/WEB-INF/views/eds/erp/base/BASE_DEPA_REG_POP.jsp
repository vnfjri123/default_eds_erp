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
		$(document).ready(async function () {
			await init();

			//	이벤트
			$('#searchForm #depaNm').on('keydown', async function(e) {
				if (e.which == 13) {
					await doAction("baseGridList", "search");

					if(baseGridList.getRowCount() > 0 ){
						baseGridList.focusAt(0, 0, true);
					}
				}
			});

			document.getElementById('depaNm').focus();
		});

		/* 초기설정 */
		async function init() {

			/* 조회옵션 셋팅 */
			await edsIframe.setParams();

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
				rowHeaders: ['rowNum'],
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
				{ header:'상태',			name:'sStatus',		width:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'회사코드',		name:'corpCd',		width:80,	align:'center',	},
				{ header:'회사명',		name:'corpNm',		width:150,	align:'left',	},
				{ header:'사업장코드',	name:'busiCd',		width:80,	align:'center',	},
				{ header:'사업장명',		name:'busiNm',		width:150,	align:'left',	},
				{ header:'부서코드',		name:'depaCd',		width:80,	align:'center',	},
				{ header:'부서명',		name:'depaNm',		width:150,	align:'left',	},
				{ header:'부서설명',		name:'depaExp',		minWidth:150,	align:'left',	},

				// hidden(숨김)
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseGridList.on('dblclick', async ev => {
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					await doAction("baseGridList", "apply");
				}
				if(ev.keyboardEvent.keyCode == "8"){
				    document.getElementById('depaNm').focus();
				}
			});
			$(document).keydown(function(e) {
			if (e.key == 'Escape') {
				doAction("baseGridList", "close")
				}
			})


			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('baseGridList').style.height = height + 'px';

			/* 조회 */
			await doAction("baseGridList", "search");
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
						baseGridList.resetData(edsUtil.getAjax("/BASE_DEPA_REG/selectDepaPopList", param)); // 데이터 set

						break;
					case "apply"://선택

						var row = baseGridList.getFocusedCell();
						var param = {};
						param.busiNm = baseGridList.getValue(row.rowKey, "busiNm");
						param.busiCd = baseGridList.getValue(row.rowKey, "busiCd");
						param.depaCd = baseGridList.getValue(row.rowKey, "depaCd");
						param.depaNm = baseGridList.getValue(row.rowKey, "depaNm");
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

<div class="row">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="depaNm">부서 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" style="display:none;">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="depaNm" id="depaNm" title="부서">
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>

		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 부서 목록
				</div>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('baseGridList', 'apply')"><i class="fa fa-save"></i> 선택</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('baseGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="baseGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>