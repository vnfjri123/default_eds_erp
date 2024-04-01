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
		var projectGridList, projectGridItem, projectGridEmail,
			projectGridPart, projectGridFile, projectGridCost,
			projectGridMemo;
		var projectEditor;
		var endDt;

		$(document).ready(async function () {
			await init();

			/**
			 * 조회 엔터 기능
			 * */
			document.getElementById('searchForm').addEventListener('keyup', async ev=>{
				var id = ev.target.id;
				if(ev.keyCode === 13){
					await doAction('projectGridList', 'search');
				}
			});

			await edsUtil.setColorForSelectedRow(projectGridList);
			await edsUtil.setColorForSelectedRow(projectGridItem);
			await edsUtil.setColorForSelectedRow(projectGridEmail);
			await edsUtil.setColorForSelectedRow(projectGridPart);
			await edsUtil.setColorForSelectedRow(projectGridFile);
			await edsUtil.setColorForSelectedRow(projectGridCost);
			await edsUtil.setColorForSelectedRow(projectGridMemo);

			document.getElementById('myTab').addEventListener('click', async (ev) =>{
				var id = ev.target.id;
				var tagName = ev.target.tagName;
				if(tagName === "A"){
					switch (id) {
						case "items-tab": setTimeout(async ()=>{await doAction('projectGridItem','search'); },200); break;
						case "part-tab": setTimeout(async ()=>{await doAction('projectGridPart','search'); },200); break;
						case "file-tab": setTimeout(async ()=>{await doAction('projectGridFile','search'); },200); break;
						case "cost-tab": setTimeout(async ()=>{await doAction('projectGridCost','search'); },200); break;
						case "memo-tab": setTimeout(async ()=>{await doAction('projectGridMemo','search'); },200); break;
					}
				}
			});

			document.getElementById('files').addEventListener('change', async (ev)=> {

				// file 가져오기
				var file = $('#files'); // input type file tag

				// formData 생성
				var clonFile = file.clone();

				var newForm = $('<form></form>');
				newForm.attr("method", "post");
				newForm.attr("enctype","multipart/form-data");
				newForm.append(clonFile);

				// 추가적 데이터 입력
				/* 저장시 필요한 파라미터*/
				var formData = new FormData(newForm[0]);
				var row = projectGridList.getFocusedCell();
				formData.append("estCd",		projectGridList.getValue(row.rowKey,'estCd'));
				formData.append("projCd",		projectGridList.getValue(row.rowKey,'projCd'));

				$.ajax({
					url: "/PROJECT_MGT/cProjFileList",
					type: "POST",
					data: formData,
					enctype: 'multipart/form-data',
					processData: false,
					contentType: false,
					cache: false,
					success: async function (rst) {
						var status = rst.status;
						var note = rst.note;
						var exc = rst.exc;
						if(status === 'success'){
							await doAction('projectGridFile','search');
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
			})
		});

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

					var row = projectGridList.getFocusedCell();
					var projCd = projectGridList.getValue(row.rowKey,'projCd');
					var deadDivi = projectGridList.getValue(row.rowKey,'deadDivi');
					if(projCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '프로젝트가 없습니다.',
						});
					}else{
						if (deadDivi !=='1'){
							await doAction('projectGridList','itemPopup');
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

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "project");
			edsUtil.setForm(document.querySelector("#projectGridListForm"), "project");

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
			await edsUtil.setButtonForm(document.querySelector("#projectGridListButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridPartButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridItemButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridFileButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridCostButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridMemoButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#baseEmailForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectEmailButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectPrintButtonForm"));

			/**********************************************************************
			 * editor 영역 START
			 ***********************************************************************/
			projectEditor = new toastui.Editor({
				el: document.querySelector('#editor'),
				height: '400px',
				language: 'ko',
				initialEditType: 'wysiwyg',
				theme: 'dark',
				hooks: {
					async addImageBlobHook(blob, callback) {
						// console.log(blob)
						await edsUtil.beforeUploadImageFile(blob, callback, 'project')
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
			projectGridList = new tui.Grid({
				el: document.getElementById('projectGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight: 'auto',
				//minRowHeight:'auto',
				heightResizable:true,
				rowHeaders: [/*'rowNum', */'checkbox'],
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

			projectGridList.setColumns([
				{ header:'프로젝트코드',	name:'projCd',		width:95,		align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true},	sortable: true},
				{ header:'거래처',		name:'custNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'성공',			name:'sccDivi',		width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM026")}},	formatter: 'listItemText',	filter: { type: 'text'},whiteSpace:'pre-wrap'},
				{ header:'구분',			name:'projDivi',	width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM029")}},	formatter: 'listItemText',whiteSpace:'pre-wrap'},
				{ header:'분류',			name:'clas',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'품목',			name:'item',		width:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'사업장',		name:'busiNm',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'프로젝트명',	name:'projNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'},whiteSpace:'pre-wrap'},
				{ header:'계약합계금액',	name:'totAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
				{ header:'준공합계금액',	name:'totAmt5',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
				{ header:'계약일자',		name:'cntDt',		width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'착수일자',		name:'initiateDt',	width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'납기일자',		name:'dueDt',		width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'종료일자',		name:'endDt',		width:80,		align:'center',	defaultValue: '',	editor:{type:'text'},	sortable: true},
				{ header:'결제조건',		name:'payTm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'개요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'계약특기사항',	name:'note1',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'결재자보고내용',name:'note2',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'부서',			name:'depaNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'담당자',		name:'manNm',		width:50,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'걸재코드',		name:'submitCd',	width:100,		align:'center'/*,	hidden:true*/ },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적일자',		name:'estDt',		width:80,		align:'center',	hidden:true },
				{ header:'유효기간',		name:'validDt',		width:80,		align:'center',	hidden:true },
				{ header:'마감',			name:'deadDivi',	width:55,		align:'center', hidden:true, defaultValue: '',formatter: function (value){if(value.value == 1){return 'Y'}else{return 'N'}}},
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'담당자코드',	name:'manCd',		width:100,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt',		width:100,		align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt4',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt4',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt4',		width:100,		align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt5',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt5',		width:100,		align:'right',	hidden:true },
				{ header:'예상영업율',	name:'margin',		width:100,		align:'right',	hidden:true },
				{ header:'예상영업금액',	name:'profit',		width:100,		align:'right',	hidden:true },
				{ header:'영업율',		name:'margin2',		width:100,		align:'right',	hidden:true },
				{ header:'영업금액',		name:'profit2',		width:100,		align:'right',	hidden:true },
				{ header:'준공영업율',	name:'margin3',		width:100,		align:'right',	hidden:true },
				{ header:'준공영업금액',	name:'profit3',		width:100,		align:'right',	hidden:true },
				{ header:'상세등록',		name:'detail',		width:80,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'부가세액',		name:'vatAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
			]);
			projectGridList.on('beforeFilter', async ev => {
				console.log('여기요');
				
			});
			projectGridList.on('afterFilter', async ev => {
				console.log('여기요2222222');

			});
			projectGridList.setFilter('projDivi', 'text')
			projectGridItem = new tui.Grid({
				el: document.getElementById('projectGridItemDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*//* 'checkbox'*/],
				header: {
					height: 40,
					minRowHeight: 40,
					complexColumns: [
						/*{
							header: '매입원가',
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
						{
							header: '최종금액',
							name: 'amt5',
							childNames: ['cost5','supAmt5','vatAmt5','totAmt5']
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
						supAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						supAmt4: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt4: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt4: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						supAmt5: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt5: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt5: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			projectGridItem.setColumns([
				{ header:'품목명',		name:'itemNm',		width:150,	align:'left',	defaultValue: ''	},
				{ header:'규격',			name:'standard',	width:150,	align:'center',	defaultValue: ''	},
				{ header:'단위',			name:'unit',		width:80,	align:'center',	defaultValue: ''	},
				{ header:'계약합계금액',	name:'totAmt3',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
				{ header:'최종합계금액',	name:'totAmt5',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '' 	},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
				{ header:'품목코드',		name:'itemCd',		width:100,	align:'center',	hidden:true },
				{ header:'할인',			name:'saleDivi',	width:40,	align:'center',	hidden:true },
				{ header:'할인율',		name:'saleRate',	width:100,	align:'right',	hidden:true },
				{ header:'단가',			name:'cost',		width:100,	align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	hidden:true },
				{ header:'단가',			name:'cost2',		width:100,	align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,	align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,	align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,	align:'right',	hidden:true },
				{ header:'단가',			name:'cost4',		width:100,	align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt4',		width:100,	align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt4',		width:100,	align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt4',		width:100,	align:'right',	hidden:true },
				{ header:'원가합계',		name:'costTotAmt',	width:100,	align:'right',	hidden:true },
				{ header:'수량',			name:'qty',			width:60,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'단가',			name:'cost3',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'공급가액',		name:'supAmt3',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'부가세액',		name:'vatAmt3',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'단가',			name:'cost5',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'공급가액',		name:'supAmt5',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'부가세액',		name:'vatAmt5',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	hidden:true },
				{ header:'과세',			name:'vatDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM006")}},	formatter: 'listItemText',	hidden:true },
				{ header:'TAX',			name:'taxDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM007")}},	formatter: 'listItemText',	hidden:true },
			]);

			projectGridPart = new tui.Grid({
				el: document.getElementById('projectGridPartDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ /*'checkbox'*/],
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

			projectGridPart.setColumns([
				{ header:'참여자명',		name:'partNm',		width:80,	align:'center',	defaultValue: '',	sortable: true},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor:{type:'text'}},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'참여자코드',	name:'partCd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			]);

			projectGridFile = new tui.Grid({
				el: document.getElementById('projectGridFileDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ 'checkbox'],
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

			projectGridFile.setColumns([
				{ header:'파일명',		name:'origNm',		minWidth:300,	align:'left',	defaultValue: ''},
				{ header:'다운로드',		name:'fileDownLoad',width:60,		align:'Center',	formatter:function(){return "<i class='fa fa-download'></i>";},},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: ''},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: ''},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'품목코드',		name:'itemCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'저장명',		name:'saveNm',		width:100,		align:'center',	hidden:true },
				{ header:'저장경로',		name:'saveRoot',	width:100,		align:'center',	hidden:true },
				{ header:'확장자',		name:'ext',			width:100,		align:'center',	hidden:true },
				{ header:'크기',			name:'size',		width:100,		align:'center',	hidden:true },
				{ header:'입력일자',		name:'inpDttm',		width:100,		align:'center',	hidden:true },
				{ header:'수정일자',		name:'updDttm',		width:100,		align:'center',	hidden:true },
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	hidden:true },
			]);

			projectGridCost = new tui.Grid({
				el: document.getElementById('projectGridCostDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum'*//*, 'checkbox'*/],
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
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			projectGridCost.setColumns([
				{ header:'일자',			name:'costDt',		width:80,		align:'left',	defaultValue: '',	editor:{type:'datePicker',options:{format:'yyyy-MM-dd'}}},
				{ header:'지출유형',		name:'expeDivi',	width:80,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM030")}},	formatter: 'listItemText'},
				{ header:'부서명',		name:'depaNm',		width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'계정과목명',	name:'accountNm',	width:140,		align:'left',	defaultValue: '',	},
				{ header:'거래처명',		name:'custNm',		width:140,		align:'left',	defaultValue: '',	},
				{ header:'공급가액',		name:'supAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'부가세액',		name:'vatAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'합계금액',		name:'totAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	sortable: true},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'입력자',		name:'inpNm',		width:60,		align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:60,		align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'계정과목코드',	name:'accountCd',	width:100,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'카드/계좌',	name:'credCd',		width:150,		align:'left',	hidden:true },
			]);

			projectGridMemo = new tui.Grid({
				el: document.getElementById('projectGridMemoDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*//* 'checkbox'*/],
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

			projectGridMemo.setColumns([
				{ header:'수정일자',		name:'updDttm',		width:140,	align:'center',	defaultValue: ''	},
				{ header:'메모',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			]);

			projectGridEmail = new tui.Grid({
				el: document.getElementById('projectGridEmailDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ 'checkbox'],
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

			projectGridEmail.setColumns([
				{ header:'보낸일시',		name:'inpDttm',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
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
			endDt = new DatePicker(['#endDtDIV'], {
				language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
				showAlways: false, // If true, the datepicker will not close until you call "close()".
				autoClose: true,// If true, Close datepicker when select date
				date: new Date(), // Date instance or Timestamp for initial date
				input: {
					element: ['#endDt'],
					format: 'yyyy-MM-dd'
				},
				type: 'date', // Type of picker - 'date', 'month', year'
			});

			/*********************************************************************
			 * DatePicker Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/* 컬럼 비활성화 */
			projectGridList.disableColumn('sccDivi');
			projectGridList.disableColumn('projDivi');
			projectGridList.disableColumn('endDt');
			projectGridList.disableColumn('note');
			projectGridList.disableColumn('note1');
			projectGridList.disableColumn('note2');
			projectGridItem.disableColumn('vatDivi');
			projectGridItem.disableColumn('taxDivi');
			projectGridMemo.disableColumn('note');



			/* 더블클릭 시, 상세목록 */
			projectGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					await fn_CopyProjectGridList2Form();
					await doAction('projectGridList','itemPopup');
					// await doAction('projectGridItem','search');
					/*if(colNm==='custNm') await popupHandler('cust_list','open');
                    else if(colNm==='manNm') await popupHandler('user_manNm','open');
                    else if(colNm==='depaNm') await popupHandler('depa','open');
                    else */if(colNm==='note' || colNm==='note1' || colNm==='note2') {
						// await edsUtil.sheetData2Maldal(projectGridList);
					}
				}else{
					// projectGridList.finishEditing();
				}
			});
			projectGridPart.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm ==='partNm') await popupHandler('user_partNm','open');
				}else{
					// projectGridPart.finishEditing();
				}
			});

			projectGridItem.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					// if(colNm ==='itemNm') await popupHandler('item','open');
				}else{
					// projectGridItem.finishEditing();
				}
			});

			projectGridItem.on('editingFinish', ev => {

				var columnName = ev.columnName;
				var rowKey = ev.rowKey;


				var vatDivi = projectGridItem.getValue(rowKey, 'vatDivi');
				var taxDivi = projectGridItem.getValue(rowKey, 'taxDivi');

				var qty = projectGridItem.getValue(rowKey, 'qty');
				var cost = projectGridItem.getValue(rowKey, 'cost');
				var supAmt = projectGridItem.getValue(rowKey, 'supAmt');
				var vatAmt = projectGridItem.getValue(rowKey, 'vatAmt');
				var totAmt = projectGridItem.getValue(rowKey, 'totAmt');
				var supAmtAll = 0;
				var vatAmtAll = 0;
				var totAmtAll = 0;

				var cost2 = projectGridItem.getValue(rowKey, 'cost2');
				var supAmt2 = projectGridItem.getValue(rowKey, 'supAmt2');
				var vatAmt2 = projectGridItem.getValue(rowKey, 'vatAmt2');
				var totAmt2 = projectGridItem.getValue(rowKey, 'totAmt2');
				var supAmtAll2 = 0;
				var vatAmtAll2 = 0;
				var totAmtAll2 = 0;

				var cost3 = projectGridItem.getValue(rowKey, 'cost3');
				var supAmt3 = projectGridItem.getValue(rowKey, 'supAmt3');
				var vatAmt3 = projectGridItem.getValue(rowKey, 'vatAmt3');
				var totAmt3 = projectGridItem.getValue(rowKey, 'totAmt3');
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
								/* 매입가 */
								supAmt = qty * cost; // 공급가액
								vatAmt = supAmt * 0.1; // TAX

								/* 견적가 */
								supAmt2 = qty * cost2; // 공급가액
								vatAmt2 = supAmt2 * 0.1; // TAX

								/* 계약금액 */
								supAmt3 = qty * cost3; // 공급가액
								vatAmt3 = supAmt3 * 0.1; // TAX
							} else {//포함
								/* 매입가 */
								supAmt = qty * cost / 1.1; // 공급가액
								vatAmt = qty * cost - supAmt; // TAX

								/* 견적가 */
								supAmt2 = qty * cost2 / 1.1; // 공급가액
								vatAmt2 = qty * cost2 - supAmt2; // TAX

								/* 계약금액 */
								supAmt3 = qty * cost3 / 1.1; // 공급가액
								vatAmt3 = qty * cost3 - supAmt3; // TAX
							}
						} else {// 면세, 영세
							/* 매입가 */
							supAmt = qty * cost; // 공급가액
							vatAmt = 0; // TAX

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
							/* 매입가 */
							cost = supAmt/qty; // 단가
							vatAmt = supAmt/10; // TAX
							totAmt = supAmt/1.1; // 공급가액

							/* 견적가 */
							cost2 = supAmt2/qty; // 단가
							vatAmt2 = supAmt2/10; // TAX
							totAmt2 = supAmt2/1.1; // 공급가액

							/* 계약금액 */
							cost3 = supAmt3/qty; // 단가
							vatAmt3 = supAmt3/10; // TAX
							totAmt3 = supAmt3/1.1; // 공급가액

						} else {// 면세, 영세
							/* 매입가 */
							cost = supAmt/qty; // 단가
							vatAmt = 0; // TAX
							totAmt = supAmt; // 공급가액

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
							supAmt = totAmt/11*10; // 공급가액
							vatAmt = totAmt/11; // TAX
							cost = supAmt/qty; // 단가

							/* 견적가 */
							supAmt2 = totAmt2/11*10; // 공급가액
							vatAmt2 = totAmt2/11; // TAX
							cost2 = supAmt2/qty; // 단가

							/* 계약금액 */
							supAmt3 = totAmt3/11*10; // 공급가액
							vatAmt3 = totAmt3/11; // TAX
							cost3 = supAmt3/qty; // 단가

						} else {// 면세, 영세
							/* 매입가 */
							supAmt = totAmt; // 공급가액
							vatAmt = 0; // TAX
							cost = supAmt/qty; // 단가

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

				/* 매입가 */
				cost = Math.ceil(cost); // 내림
				supAmt = Math.ceil(supAmt);  // 올림
				vatAmt = Math.floor(vatAmt); // 내림
				totAmt = supAmt + vatAmt; // 합계
				projectGridItem.setValue(rowKey, "cost", cost);
				projectGridItem.setValue(rowKey, "supAmt", supAmt);
				projectGridItem.setValue(rowKey, "vatAmt", vatAmt);
				projectGridItem.setValue(rowKey, "totAmt", supAmt + vatAmt);

				/* 견적가 */
				cost2 = Math.ceil(cost2); // 내림
				supAmt2 = Math.ceil(supAmt2);  // 올림
				vatAmt2 = Math.floor(vatAmt2); // 내림
				totAmt2 = supAmt2 + vatAmt2; // 합계
				projectGridItem.setValue(rowKey, "cost2", cost2);
				projectGridItem.setValue(rowKey, "supAmt2", supAmt2);
				projectGridItem.setValue(rowKey, "vatAmt2", vatAmt2);
				projectGridItem.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

				/* 계약금액 */
				cost3 = Math.ceil(cost3); // 내림
				supAmt3 = Math.ceil(supAmt3);  // 올림
				vatAmt3 = Math.floor(vatAmt3); // 내림
				totAmt3 = supAmt3 + vatAmt3; // 합계
				projectGridItem.setValue(rowKey, "cost3", cost3);
				projectGridItem.setValue(rowKey, "supAmt3", supAmt3);
				projectGridItem.setValue(rowKey, "vatAmt3", vatAmt3);
				projectGridItem.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

				/* 매입가+견적가+계약금액 합계 적용 */
				var data = projectGridItem.getFilteredData()
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
				projectGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
				projectGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
				projectGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

				projectGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
				projectGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
				projectGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

				projectGridItem.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmtAll3));
				projectGridItem.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmtAll3));
				projectGridItem.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmtAll3));
			});

			projectGridFile.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				var rowKey = ev.rowKey;
				if(target === 'cell'){
					if(colNm==='fileDownLoad') await edsUtil.fileDownLoad(projectGridFile);
					// else if(colNm==='accountNm') await popupHandler('account','open');
				}else{
					// projectGridCost.finishEditing();
				}
			});
			
			projectGridCost.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					// if(colNm==='custNm') await popupHandler('cust_cost','open');
					// else if(colNm==='depaNm') await popupHandler('depa_cost','open');
					// else if(colNm==='accountNm') await popupHandler('account','open');
					if(colNm==='note') {
						// console.log(colNm)
						// await edsUtil.sheetData2Maldal(projectGridCost);
					}
				}else{
					// projectGridCost.finishEditing();
				}
			});

			projectGridCost.on('editingFinish', ev => {

				var columnName = ev.columnName;
				var rowKey = ev.rowKey;

				var supAmt = projectGridCost.getValue(rowKey, 'supAmt');
				var vatAmt = projectGridCost.getValue(rowKey, 'vatAmt');
				var totAmt = projectGridCost.getValue(rowKey, 'totAmt');
				var supAmtAll = 0;
				var vatAmtAll = 0;
				var totAmtAll = 0;

				// 별도, 포함
				switch (columnName) {
					case 'supAmt' :
						/* 매입가 */
						vatAmt = supAmt/10; // TAX
						totAmt = supAmt/1.1; // 공급가액
						break;
					case 'totAmt' :
						/* 매입가 */
						supAmt = totAmt/11*10; // 공급가액
						vatAmt = totAmt/11; // TAX
						break;
				}

				/**
				 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
				 * */

				/* 매입가 */
				supAmt = Math.ceil(supAmt);  // 올림
				vatAmt = Math.floor(vatAmt); // 내림
				totAmt = supAmt + vatAmt; // 합계
				projectGridCost.setValue(rowKey, "supAmt", supAmt);
				projectGridCost.setValue(rowKey, "vatAmt", vatAmt);
				projectGridCost.setValue(rowKey, "totAmt", supAmt + vatAmt);

				/* 매입가+견적가+계약금액 합계 적용 */
				var data = projectGridCost.getFilteredData()
				var dataLen = data.length;
				for (let i = 0; i < dataLen; i++) {
					supAmtAll += Number(data[i].supAmt);
					vatAmtAll += Number(data[i].vatAmt);
					totAmtAll += Number(data[i].totAmt);
				}
				projectGridCost.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
				projectGridCost.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
				projectGridCost.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));
			});

			projectGridEmail.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){

					var rowKey = ev.rowKey;
					var data = projectGridEmail.getRow(rowKey);
					var keys = Object.keys(data);

					/* 이메일 내역 세팅*/
					for (let i = 0; i < keys.length; i++) {
						var key = keys[i];
						var doc = document.getElementById(key);
						if(doc){ // input
							// console.log(key + ' is exist');
							if(key==='note'){
								projectEditor.setHTML(data[key], true);
							}else{
								doc.value = data[key];
							}
						}else{ // note
							// console.log(key + ' is not exist');
						}
					}

					/* 이메일 첨부파일 조회 및 세팅*/
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.projCd = projectGridEmail.getValue(rowKey, 'projCd');
					param.emailSeq = projectGridEmail.getValue(rowKey, 'seq');
					param.divi = 'project';
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

			projectGridMemo.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='note' || colNm==='note1' || colNm==='note2') {
						await edsUtil.sheetData2Maldal(projectGridMemo);
					}
				}else{
					// projectGridList.finishEditing();
				}
			});
			doAction('projectGridList', 'search');

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			// document.getElementById('projectGridList').style.height = (innerHeight)*(1-0.11) + 'px';
			// document.getElementById('projectGridPart').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridItem').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridFile').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridCost').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridMemo').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridEmail').style.height = (innerHeight)*(1-0.25) + 'px';

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
						var data = edsUtil.getAjax("/PROJECT_MGT/selectProjMgtList", param)
						projectGridList.resetData(data); // 데이터 set

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.busiCd = $("#searchForm #busiCd").val();
						appendedData.estCd = '1234';
						appendedData.closeYn = '0';
						appendedData.estDt = edsUtil.getToday("%Y-%m-%d");
						appendedData.projDt = edsUtil.getToday("%Y-%m-%d");

						/* 견적일자로부터 1달*/
						const newDate = new Date(edsUtil.getToday("%Y-%m-%d"));
						newDate.setMonth(newDate.getMonth() + 1);
						appendedData.validDt = edsUtil.getToday(newDate.toISOString().substring(0,10));

						appendedData.supAmt2 = 0;
						appendedData.vatAmt2 = 0;
						appendedData.totAmt2 = 0;
						appendedData.supAmt3 = 0;
						appendedData.vatAmt3 = 0;
						appendedData.totAmt3 = 0;

						projectGridList.prependRow(appendedData, { focus:true }); // 마지막 ROW 추가

						await doAction('projectGridList', 'save');

						break;
					/*case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjMgtList", "projectGridList", projectGridList);
						break;*/
					case "save"://저장
						await edsUtil.modalCUD("/PROJECT_MGT/cudProjMgtList2", "projectGridList", projectGridList, 'projectGridListForm');
						// await doAction('yeongEobGridItem','close')
						break;
					case "delete"://삭제
						await projectGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjMgtList", "projectGridList", projectGridList);
						break;
					case "finish"://마감
						await edsUtil.doDeadline(
								"/PROJECT_MGT/deadLineProjMgtList",
								"projectGridList",
								projectGridList,
								'1');
						break;
					case "cancel"://마감취소
						await edsUtil.doDeadline(
								"/PROJECT_MGT/deadLineProjMgtList",
								"projectGridList",
								projectGridList,
								'0');
						break;
					case "print"://인쇄
						var chk = projectGridList.getCheckedRows();

						if(chk.length === 0 ){
							Swal.fire({
								icon: 'error',
								title: '실패',
								text: "인쇄할 내용이 없습니다.",
							})
							return;
						}else{
							document.querySelector('input[value="prints1"]').setAttribute('checked', 'checked');
							document.getElementById('btnPrint3').style.display = 'inline';
							document.getElementById('btnPrint2').click();
						}

						break;
					case "print2":// 프로젝트 선택

						document.getElementById('btnPrint3').style.display = 'block';

						break;
					case "print3"://인쇄
						var chk = projectGridList.getCheckedRows();
						var printKind = document.querySelector('input[name="prints"]:checked').value
						var param = new Array();
						for(var i=0;i<chk.length;i++){
							var num = chk[i].totAmt2;
							var num2han = await edsUtil.num2han(num);
							var element = {
								corpCd : '<c:out value="${LoginInfo.corpCd}"/>',
								busiCd : '<c:out value="${LoginInfo.busiCd}"/>',
								projCd : chk[i].projCd,
								num : edsUtil.addComma(num),
								num2han : num2han,
								printKind : printKind,
							};
							param.push(element)
						}
						jr.open(param, 'project_gyeyagseo');
						break;
					case "emailPopup":// 이메일 팝업 보기

						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnEmailPopEv').click();
							document.getElementById('setFrom').value = '<c:out value="${LoginInfo.empNm}"/>'+' <'+'<c:out value="${LoginInfo.email}"/>'+'>';
							setTimeout(ev=>{
								document.getElementById('btnSearch3').click();
							}, 300)
						}
						break;
					case "itemPopup":// 아이템 팝업 보기

						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
								document.getElementById('btnItemPopEv').click();
								document.getElementById('items-tab').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch1').click();
							}, 300)
						}
						break;
					case "partPopup":// 파일업로드 팝업 보기
						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnPartPopEv').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch1').click();
							}, 300)
						}
						break;
					case "fileUploadPopup":// 파일업로드 팝업 보기

						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnFileUploadPopEv').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch5').click();
							}, 300)
						}
						break;
					case "costPopup":// 파일업로드 팝업 보기

						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnCostPopEv').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch6').click();
							}, 300)
						}
						break;
					case "memoPopup":// 파일업로드 팝업 보기

						var row = projectGridList.getFocusedCell();
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						if(projCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnMemoPopEv').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch7').click();
							}, 300)
						}
						break;
					case "apply"://저장
						await popupHandler('apply_est','open');
						break;
				}
			}else if (sheetNm == 'projectGridItem') {
				switch (sAction) {
					case "search":// 조회

						projectGridItem.refreshLayout(); // 데이터 초기화
						projectGridItem.finishEditing(); // 데이터 마감
						projectGridItem.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						var data = edsUtil.getAjax("/PROJECT_MGT/selectProjItemList", param);
						projectGridItem.resetData(data); // 데이터 set

						if(projectGridItem.getRowCount() > 0 ){
							projectGridItem.focusAt(0, 0, true);
						}

						/*var domTotAmt3 = document.getElementById('totAmt3');
						var domProfit3 = document.getElementById('profit3');
						var domMargin3 = document.getElementById('margin3');
						var domTotAmt5 = document.getElementById('totAmt5');
						var domProfit5 = document.getElementById('profit5');
						var domMargin5 = document.getElementById('margin5');
						var domCostTotAmt = document.getElementById('costTotAmt').value;
						console.log(domCostTotAmt)

						var totAmt = 0;
						var totAmt4 = 0;
						var totAmt5 = 0;
						var margin3 = 0;
						var margin5 = 0;

						for (let i = 0, length = data.length; i < length; i++) {
							totAmt += Number(data[i].totAmt); // 품의원가 합계금액
							totAmt5 += Number(data[i].totAmt5); // 준공계약금액 합계금액
						}

						domProfit3.value = edsUtil.addComma(Number(edsUtil.removeComma(domTotAmt3.value)) - Number(totAmt)); // 계약이익금액
						margin3 = (((Number(edsUtil.removeComma(domTotAmt3.value))-Number(totAmt))/Number(edsUtil.removeComma(domTotAmt3.value)))*100) // 계약이익율
						if(isNaN(margin5)){
							domMargin3.value = 0+' %'
						}else{
							domMargin3.value = edsUtil.addComma(Math.round(margin3*100)/100)+' %';
						}

						domTotAmt5.value = edsUtil.addComma(Number(totAmt5)); // 준공합계금액
						domProfit5.value = edsUtil.addComma(Number(totAmt5) - Number(domCostTotAmt)); // 준공이익금액
						margin5 = (((Number(totAmt5)-Number(domCostTotAmt))/Number(totAmt5))*100); // 준공이익율
						if(isNaN(margin5)){
							domMargin5.value = 0+' %'
						}else{
							domMargin5.value = edsUtil.addComma(Math.round(margin5*100)/100)+' %';
						}

						if(Number(domProfit3.value.replace(/\D/g, '')) > Number(domProfit5.value.replace(/\D/g, ''))) {
							domTotAmt5.value = '↓'+ domTotAmt5.value
							domProfit5.value = '↓'+ domProfit5.value
							domMargin5.value = '↓'+ domMargin5.value
							domTotAmt5.style.color = 'blue'
							domProfit5.style.color = 'blue'
							domMargin5.style.color = 'blue'
						}else{
							domTotAmt5.value = '↑'+ domTotAmt5.value
							domProfit5.value = '↑'+ domProfit5.value
							domMargin5.value = '↑'+ domMargin5.value
							domTotAmt5.style.color = 'red'
							domProfit5.style.color = 'red'
							domMargin5.style.color = 'red'
						}*/

						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');
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

						projectGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjItemList", "projectGridItem", projectGridItem);
						break;
					case "delete"://삭제
						await projectGridItem.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjItemList", "projectGridItem", projectGridItem);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridPart') {
				switch (sAction) {
					case "search":// 조회

						projectGridPart.refreshLayout(); // 데이터 초기화
						projectGridPart.finishEditing(); // 데이터 마감
						projectGridPart.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						projectGridPart.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjPartList", param)); // 데이터 set

						if(projectGridPart.getRowCount() > 0 ){
							projectGridPart.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');

						projectGridPart.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					/*case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjPartList", "projectGridPart", projectGridPart);
						break;
					case "delete"://삭제
						await projectGridPart.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjPartList", "projectGridPart", projectGridPart);
						break;*/
					case "save"://저장
						await edsUtil.modalCUD("/PROJECT_MGT/cudProjPartList2", "projectGridPart", projectGridPart, 'projectGridListForm');
						// await doAction('yeongEobGridItem','close')
						break;
					case "delete"://삭제
						await projectGridPart.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjPartList", "projectGridPart", projectGridPart);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridFile') {
				switch (sAction) {
					case "search":// 조회

						projectGridFile.refreshLayout(); // 데이터 초기화
						projectGridFile.finishEditing(); // 데이터 마감
						projectGridFile.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						projectGridFile.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjFileList", param)); // 데이터 set

						if(projectGridFile.getRowCount() > 0 ){
							projectGridFile.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');

						projectGridFile.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/udProjFileList", "projectGridFile", projectGridFile);
						break;
					case "delete"://삭제
						await projectGridFile.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/udProjFileList", "projectGridFile", projectGridFile);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridCost') {
				switch (sAction) {
					case "search":// 조회

						projectGridCost.refreshLayout(); // 데이터 초기화
						projectGridCost.finishEditing(); // 데이터 마감
						projectGridCost.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						projectGridCost.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCostList", param)); // 데이터 set

						if(projectGridCost.getRowCount() > 0 ){
							projectGridCost.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');
						appendedData.costDt =  edsUtil.getToday("%Y-%m-%d");
						appendedData.expeDivi = '01';
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;

						// var testtest = document.getElementById('testtest').value
						// for (let i = 0; i < testtest; i++) {
							projectGridCost.appendRow(appendedData, { focus:false }); // 마지막 ROW 추가
						// }

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCostList", "projectGridCost", projectGridCost);
						break;
					case "delete"://삭제
						await projectGridCost.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCostList", "projectGridCost", projectGridCost);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridMemo') {
				switch (sAction) {
					case "search":// 조회

						projectGridMemo.refreshLayout(); // 데이터 초기화
						projectGridMemo.finishEditing(); // 데이터 마감
						projectGridMemo.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						projectGridMemo.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjMemoList", param)); // 데이터 set

						if(projectGridMemo.getRowCount() > 0 ){
							projectGridMemo.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');

						projectGridMemo.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						/*await doAction('projectGridMemo', 'save');

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjMemoList", "projectGridMemo", projectGridMemo);
						break;
					case "delete"://삭제
						await projectGridMemo.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjMemoList", "projectGridMemo", projectGridMemo);
						break;*/
						break;
					case "save"://저장
						await edsUtil.modalCUD("/PROJECT_MGT/cudProjMemoList2", "projectGridMemo", projectGridMemo, 'projectGridListForm');
						// await doAction('yeongEobGridItem','close')
						break;
					case "delete"://삭제
						await projectGridPart.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjMemoList", "projectGridMemo", projectGridMemo);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridEmail') {
				switch (sAction) {
					case "search":// 조회
						projectGridEmail.refreshLayout(); // 데이터 초기화
						projectGridEmail.finishEditing(); // 데이터 마감
						projectGridEmail.clear(); // 데이터 초기화

						/* 이메일 조회 */
						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						param.divi = 'project';
						projectGridEmail.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailInfo", param)); // 데이터 set

						if(projectGridEmail.getRowCount() > 0 ){
							projectGridEmail.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

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
						projectEditor.reset();

						break;
					case "delete"://삭제
						await projectGridEmail.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjEmailList", "projectGridEmail", projectGridEmail);
						break;
					case "print4":// 프로젝트 선택

							document.getElementById('btnPrint3').style.display = 'none';

						break;
					case "emailSend":// 보내기

						var printKind = document.querySelector('input[name="prints"]:checked')
						if(!printKind){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트 버튼을 누르고 인감 분류를 체크하세요.',
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
						formData.append("divi",			'project');
						formData.append("sendDivi",		'send');
						var row = projectGridList.getFocusedCell();
						var estCd = projectGridList.getValue(row.rowKey,'estCd');
						var projCd = projectGridList.getValue(row.rowKey,'projCd');
						var busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						formData.append("estCd",		estCd);
						formData.append("projCd",		projCd);
						formData.append("setFrom",		document.getElementById('setFrom').value);
						formData.append("toAddr",		document.getElementById('toAddr').value);
						formData.append("ccAddr",		document.getElementById('ccAddr').value);
						formData.append("bccAddr",		document.getElementById('bccAddr').value);
						formData.append("setSubject",	document.getElementById('setSubject').value);
						formData.append("html",			projectEditor.getHTML());

						/* 기존 이메일 순번*/
						var row = projectGridEmail.getFocusedCell();
						var beforeEmailSeq = projectGridEmail.getValue(row.rowKey,'seq');
						formData.append("beforeEmailSeq",beforeEmailSeq);

						/* 프로젝트 파라미터*/
						var row = projectGridList.getFocusedCell();
						var num = projectGridList.getValue(row.rowKey,'totAmt2');
						var num2han = await edsUtil.num2han(num);
						formData.append("id",			'project_gyeyagseo');
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
									await doAction('projectGridEmail','input');
									await doAction('projectGridEmail','search');
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
			var row = projectGridList.getFocusedCell();
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
						param.custNm= projectGridList.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'list') {sheet=projectGridList;col='cust';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'cost'){sheet=projectGridCost;col='cust';row=projectGridCost.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.custCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.custNm);
					}
					break;
				case 'apply':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ESTPOPUP',param);
					}else{
						if(names[1] === 'est') {
							if(callback.rows === undefined) return;
							await edsUtil.doApply("/PROJECT_MGT/aEstMgtList", callback.rows);
							await doAction('projectGridList','search');
						}
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= '';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'list') {sheet=projectGridList;col='cust';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'cost'){sheet=projectGridCost;col='cust';row=projectGridCost.getFocusedCell();}
						sheet.setValue(row.rowKey,'depaCd',callback.depaCd);
						sheet.setValue(row.rowKey,'depaNm',callback.depaNm);
					}
					break;
				case 'account':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ACCOUNTPOPUP',param)
					}else{
						var row = projectGridCost.getFocusedCell();
						projectGridCost.setValue(row.rowKey,'accountCd',callback.accountCd);
						projectGridCost.setValue(row.rowKey,'accountNm',callback.accountNm);
					}
					break;
				case 'user':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.empCd= '';
						param.name= name;
						await edsIframe.openPopup('USERPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'manNm') {sheet=projectGridList;col='man';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'partNm'){sheet=projectGridPart;col='part';row=projectGridPart.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.empCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.empNm);
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
						var maiRow = projectGridList.getFocusedCell();
						var subRow = projectGridItem.getFocusedCell();
						if(rstLen > 0){
							for(var i=0; i<rstLen; i++){
								var data = edsUtil.cloneObj(projectGridItem.getData());
								var itemRow = edsUtil.getMaxObject(data,'rowKey');
								rst[i].rowKey = itemRow.rowKey+i+1;
								rst[i].corpCd = projectGridList.getValue(maiRow.rowKey, "corpCd");
								rst[i].busiCd = projectGridList.getValue(maiRow.rowKey, "busiCd");
								rst[i].estCd = projectGridList.getValue(maiRow.rowKey, "estCd");
								rst[i].projCd = projectGridList.getValue(maiRow.rowKey, "projCd");
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
								projectGridItem.appendRow(rst[i])
							}
							projectGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
						}else{
							// projectGridList.setValue(row.rowKey,'itemCd',callback.itemCd);
							// projectGridList.setValue(row.rowKey,'itemNm',callback.itemNm);
						}
					}
					break;
				case 'itemPopup':
					if(divi==='open'){
						document.getElementById('btnItemPopup').click();
						setTimeout(async ev =>{
							await doAction('projectGridItem','search')
						},200)
					}else{

					}
					break;
				case 'partPopup':
					if(divi==='open'){
						document.getElementById('btnPartPopup').click();
						setTimeout(async ev =>{
							await doAction('projectGridPart','search')
						},200)
					}else{

					}
					break;
			}
		}

		// 업로드 안된 행의 다운로드 막기
		function preventClick(e){
			e.preventDefault()
			toastrmessage("toast-bottom-center"
					, "warning"
					, "파일 저장 이후 다운로드 가능합니다.", "실패", 1500);
		}

		async function fn_CopyProjectGridList2Form(){
			var rows = projectGridList.getRowCount();
			if(rows > 0){
				var row = projectGridList.getFocusedCell();
				var param = {
					sheet: projectGridList,
					form: document.projectGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
			}
		}

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
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group-prepend" style="min-width: 15rem;">
								<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd" >
								</select>
							</div>
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
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('projectGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="projectGridList" style="height: calc(100vh - 6rem); width: 100%;">
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
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnFinish"			id="btnFinish"				onclick="doAction('projectGridList', 'finish')"><i class="fa fa-lock"></i> 마감</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnCancel"			id="btnCancel"				onclick="doAction('projectGridList', 'cancel')"><i class="fa fa-unlock"></i> 마감취소</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				onclick="doAction('projectGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnInput"			id="btnInput"				onclick="doAction('projectGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnSave"				id="btnSave"				onclick="doAction('projectGridList', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete"			id="btnDelete"				onclick="doAction('projectGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnApply"			id="btnApply"				onclick="doAction('projectGridList', 'apply')"><i class="fa fa-cloud-download"></i> 견적서적용</button>--%>
									<button type="button" class="btn btn-sm btn-primary" name="btnItemPopEv"		id="btnItemPopEv"			data-toggle="modal" data-target="#modalCart"  style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopEv"		id="btnEmailPopEv"			data-toggle="modal" data-target="#modalCart3" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnPartPopEv"		id="btnPartPopEv"			data-toggle="modal" data-target="#modalCart4" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnFileUploadPopEv"	id="btnFileUploadPopEv"		data-toggle="modal" data-target="#modalCart5" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCostPopEv"		id="btnCostPopEv"			data-toggle="modal" data-target="#modalCart6" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnMemoPopEv"		id="btnMemoPopEv"			data-toggle="modal" data-target="#modalCart7" style="display: none"></button>
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
			<div class="modal-header bg-dark font-color" name="tabs" id="tabs" style="color: #4d4a41">
				<h4 class="modal-title">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;">
					<form name="projectGridListForm" id="projectGridListForm">
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
							<input type="hidden" name="corpCd" id="corpCd">
							<input type="hidden" name="busiCd" id="busiCd">
							<input type="hidden" name="estCd" id="estCd">
							<input type="hidden" name="projCd" id="projCd">
							<input type="hidden" name="submitCd" id="submitCd">
							<input type="hidden" name="estDt" id="estDt">
							<input type="hidden" name="validDt" id="validDt">
							<input type="hidden" name="deadDivi" id=deadDivi>
							<input type="hidden" name="custCd" id="custCd">
							<input type="hidden" name="depaCd" id="depaCd">
							<input type="hidden" name="manCd" id="manCd">
							<input type="hidden" name="supAmt" id="supAmt">
							<input type="hidden" name="vatAmt" id="vatAmt">
							<input type="hidden" name="totAmt" id="totAmt">
							<input type="hidden" name="supAmt2" id="supAmt2">
							<input type="hidden" name="vatAmt2" id="vatAmt2">
							<input type="hidden" name="supAmt3" id="supAmt3">
							<input type="hidden" name="vatAmt3" id="vatAmt3">
							<input type="hidden" name="supAmt4" id="supAmt4">
							<input type="hidden" name="vatAmt4" id="vatAmt4">
							<input type="hidden" name="totAmt4" id="totAmt4">
							<input type="hidden" name="supAmt5" id="supAmt5">
							<input type="hidden" name="vatAmt5" id="vatAmt5">
							<input type="hidden" name="costTotAmt" id="costTotAmt">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">프로젝트 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">

								<div class="form-row">
									<div class="col-md-6 mb-3">
										<label for="projNm"><b>프로젝트명</b></label>
										<input type="text" class="form-control" id="projNm" name="projNm" placeholder="프로젝트명" readonly="readonly" style="background-color: yellow">
									</div>
									<div class="col-md-6 mb-3">
										<label for="custNm"><b>거래처</b></label>
										<input type="text" class="form-control" id="custNm" name="custNm" placeholder="거래처" readonly="readonly">
									</div>
								</div>
								<%--<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="totAmt3"><b>계약금액</b></label>
										<input type="text" class="form-control text-right" id="totAmt3" name="totAmt3" placeholder="합계금액" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="profit3"><b>이익금액</b></label>
										<input type="text" class="form-control text-right" id="profit3" name="profit3" placeholder="영업이익" readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="margin3"><b>이익율</b></label>
										<input type="text" class="form-control text-right" id="margin3" name="margin3" placeholder="영업이익" readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3 d-none">
										<label for="supAmt3"><b>공급가액</b></label>
										<input type="text" class="form-control text-right" id="supAmt3" name="supAmt3" placeholder="공급가액" readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3 d-none">
										<label for="vatAmt3"><b>부가세액</b></label>
										<input type="text" class="form-control text-right" id="vatAmt3" name="vatAmt3" placeholder="부가세액" readonly="readonly" value="0">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="totAmt5"><b>준공금액</b></label>
										<input type="text" class="form-control text-right font-weight-bold" id="totAmt5" name="totAmt5" placeholder="합계금액" readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt5"><b>이익금액</b></label>
										<input type="text" class="form-control text-right font-weight-bold" id="profit5" name="profit5" placeholder="영업이익" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt5"><b>이익율</b></label>
										<input type="text" class="form-control text-right font-weight-bold" id="margin5" name="margin5" placeholder="영업이익" readonly="readonly">
									</div>
								</div>--%>
								<div class="form-row">
									<div class="col-md-1 mb-3">
										<label for="sccDivi"><b>성공</b></label>
										<select type="text" class="form-control text-center" name="sccDivi" id="sccDivi" title="성공" disabled></select>
									</div>
									<div class="col-md-1 mb-3">
										<label for="projDivi"><b>구분</b></label>
										<select type="text" class="form-control text-center" name="projDivi" id="projDivi" title="구분" disabled></select>
									</div>
									<div class="col-md-2 mb-3">
										<label for="initiateDt"><b>착수일자</b></label>
										<input type="text" class="form-control text-center" id="initiateDt" name="initiateDt" placeholder="착수일자" readonly="readonly">
									</div>
									<div class="col-md-2 mb-3">
										<label for="cntDt"><b>계약일자</b></label>
										<input type="text" class="form-control text-center" id="cntDt" name="cntDt" placeholder="계약일자" readonly="readonly">
									</div>
									<div class="col-md-2 mb-3">
										<label for="dueDt"><b>납기일자</b></label>
										<input type="text" class="form-control text-center" id="dueDt" name="dueDt" placeholder="납기일자" readonly="readonly">
									</div>
									<div class="col-md-2 mb-3">
										<label for="depaNm"><b>부서</b></label>
										<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서" readonly="readonly">
									</div>
									<div class="col-md-2 mb-3">
										<label for="manNm"><b>담당자</b></label>
										<input type="text" class="form-control text-center" id="manNm" name="manNm" placeholder="담당자" readonly="readonly">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="clas"><b>분류</b></label>
										<input type="text" class="form-control" id="clas" name="clas" placeholder="분류" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="item"><b>품목</b></label>
										<input type="text" class="form-control" id="item" name="item" placeholder="품목" readonly="readonly">
									</div>
									<div class="col-md-4 mb-3">
										<label for="payTm"><b>결제조건</b></label>
										<input type="text" class="form-control" id="payTm" name="payTm" placeholder="결제조건" readonly="readonly">
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
										<input type="text" class="form-control text-right" id="totAmt2" style="background-color: yellow" name="totAmt2" placeholder="합계금액.." readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익(예상)</b></label>
										<input type="text" class="form-control text-right" id="profit" style="color: red;font-weight: bold;background-color: yellow" name="profit" placeholder="영업이익.." readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익율(예상)</b></label>
										<input type="text" class="form-control text-right" id="margin" style="color: red;font-weight: bold;background-color: yellow" name="margin" placeholder="영업이익율.." readonly="readonly" value="0">
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #fdbf07;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">계약금액</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>합계금액(계약)</b></label>
										<input type="text" class="form-control text-right" id="totAmt3" style="background-color: yellow" name="totAmt3" placeholder="합계금액.." readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익(계약합계금액-매입금액)</b></label>
										<input type="text" class="form-control text-right" id="profit2" style="color: red;font-weight: bold;background-color: yellow" name="profit2" placeholder="영업이익.." readonly="readonly" value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익율(예상)</b></label>
										<input type="text" class="form-control text-right" id="margin2" style="color: red;font-weight: bold;background-color: yellow" name="margin2" placeholder="영업이익율.." readonly="readonly" value="0">
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #fdbf07;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">준공금액</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>합계금액(준공)</b></label>
										<input type="text" class="form-control text-right" id="totAmt5" style="background-color: yellow" name="totAmt5" placeholder="합계금액.." readonly="readonly"value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익(준공합계금액-준공매입금액)</b></label>
										<input type="text" class="form-control text-right" id="profit3" style="color: red;font-weight: bold;background-color: yellow" name="profit3" placeholder="영업이익.." readonly="readonly"value="0">
									</div>
									<div class="col-md-4 mb-3">
										<label for="totAmt2"><b>영업이익율(예상)</b></label>
										<input type="text" class="form-control text-right" id="margin3" style="color: red;font-weight: bold;background-color: yellow" name="margin3" placeholder="영업이익율.." readonly="readonly"value="0">
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
							<div class="card-header" style="background-color: #fff;">
								<label class="card-title" style="color: #000;font-weight: 700;font-size: 1.1rem;display: contents;">변경가능 정보</label>
								<button type="button" class="btn btn-sm btn-primary float-right" name="btnSave"	id="btnSave"	onclick="doAction('projectGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="form-row">
									<div class="col-md-2 mb-3" style="z-index: 2000">
										<label for="endDt"><b>종료일자</b></label>
										<input type="text" class="form-control text-center" id="endDt" aria-label="Date-Time" placeholder="종료일자" title="종료일자" autocomplete='off'>
										<div id="endDtDIV" style="margin-top: -1px;"></div>
									</div>
									<div class="col-md-10 mb-3">
										<label for="note"><b>개요</b></label>
										<input type="text" class="form-control" id="note" name="note" placeholder="개요" autocomplete='off'></input>
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6 mb-3">
										<label for="note1"><b>계약특기사항</b></label>
										<textarea rows="10" type="text" class="form-control" id="note1" name="note1" style="resize: none" placeholder="계약특기사항"></textarea>
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
													<input id="submitInput"type="text" class="form-control form-control-sm" placeholder="엔터... 입력 , 쉬프트 + 엔터 줄바꿈..." onkeyup="if(window.event.keyCode==13 && window.event.shiftKey===false){edsEdms.initMessage2(this,projectGridList,${LoginInfo.empCd})}">
												</div>
												<button type="button" class="btn btn-tool float-right" style="font-size: 11px;width: calc(1.5*1.875rem);padding: unset;vertical-align: middle;text-align: center;height: 30px;border: 1px solid #000;" onclick="edsEdms.initMessage2(document.getElementById('submitInput'),projectGridList,${LoginInfo.empCd})">전송</button>
											</div>
											<!-- /.card-footer -->
										</div>
									</div>
									<div class="col-md-6 mb-3 d-none">
										<label for="note2"><b>결재자보고내용</b></label>
										<textarea rows="10" type="text" class="form-control" id="note2" name="note2" style="resize: none" placeholder="결재자보고내용"></textarea>
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
					</form>
					<div class="card card-lightblue card-outline" style="box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);margin-bottom: 1rem;    border-top: 3px solid #3c8dbc;">
						<div class="tab-content" id="myTabContent">
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item">
									<a class="nav-link active" id="items-tab" data-toggle="tab" href="#items" role="tab" aria-controls="items" aria-selected="true">품목</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="part-tab" data-toggle="tab" href="#part" role="tab" aria-controls="part" aria-selected="false">참여자</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="file-tab" data-toggle="tab" href="#file" role="tab" aria-controls="file" aria-selected="false">파일</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="cost-tab" data-toggle="tab" href="#cost" role="tab" aria-controls="cost" aria-selected="false">원가</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" id="memo-tab" data-toggle="tab" href="#memo" role="tab" aria-controls="memo" aria-selected="false">메모</a>
								</li>
							</ul>
							<div class="tab-pane fade show active" id="items" role="tabpanel" aria-labelledby="items-tab">
								<!--Body-->
								<div class="modal-body p-0">
									<div class="col-md-12 p-0" id="projectGridItem" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="projectGridItemDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer" style="display: block">
									<div class="row">
										<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
											<div class="col text-center">
												<form class="form-inline" role="form" name="projectGridItemButtonForm" id="projectGridItemButtonForm" method="post" onsubmit="return false;">
													<div class="container">
														<div class="row">
															<div class="col text-center">
																<button type="button" class="btn btn-sm btn-primary" name="btnSearch1"	id="btnSearch1"	onclick="doAction('projectGridItem', 'search')"><i class="fa fa-search"></i> 조회</button>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('projectGridItem', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnSave1"	id="btnSave1"	onclick="doAction('projectGridItem', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('projectGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>--%>
																<button type="button" class="btn btn-sm btn-primary" name="btnClose1"	id="btnClose1"	onclick="doAction('projectGridItem', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="part" role="tabpanel" aria-labelledby="part-tab">
								<!--Body-->
								<div class="modal-body p-0">
									<div class="col-md-12 p-0" id="projectGridPart" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="projectGridPartDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer" style="display: block">
									<div class="row">
										<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
											<div class="col text-center">
												<form class="form-inline" role="form" name="projectGridPartButtonForm" id="projectGridPartButtonForm" method="post" onsubmit="return false;">
													<div class="container">
														<div class="row">
															<div class="col text-center">
																<button type="button" class="btn btn-sm btn-primary" name="btnSearch4"	id="btnSearch4"	onclick="doAction('projectGridPart', 'search')"><i class="fa fa-search"></i> 조회</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnInput4"	id="btnInput4"	onclick="doAction('projectGridPart', 'input')" ><i class="fa fa-plus"></i> 신규</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnSave4"	id="btnSave4"	onclick="doAction('projectGridPart', 'save')"><i class="fa fa-save"></i> 저장</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnDelete4"	id="btnDelete4"	onclick="doAction('projectGridPart', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnClose4"	id="btnClose4"	onclick="doAction('projectGridPart', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="file" role="tabpanel" aria-labelledby="file-tab">
								<!--Body-->
								<div class="modal-body p-0">
									<div class="col-md-12 p-0" id="projectGridFile" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="projectGridFileDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer" style="display: block">
									<div class="row">
										<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
											<div class="col text-center">
												<form class="form-inline" role="form" name="projectGridFileButtonForm" id="projectGridFileButtonForm" method="post" onsubmit="return false;">
													<div class="container">
														<div class="row">
															<div class="col text-center">
																<button type="button" class="btn btn-sm btn-primary" name="btnSearch5"	id="btnSearch5"	onclick="doAction('projectGridFile', 'search')"><i class="fa fa-search"></i> 조회</button>
																<input type="file" id="files" name="files" multiple style="display: none">
																<label for="files" type="button" class="btn btn-sm btn-primary" name="btnInput5"	id="btnInput5"	style="width:fit-content;display: inline;" ><i class="fa fa-plus"></i> 신규</label>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnSave5"	id="btnSave5"	onclick="doAction('projectGridFile', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
																<button type="button" class="btn btn-sm btn-primary" name="btnDelete5"	id="btnDelete5"	onclick="doAction('projectGridFile', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnClose5"	id="btnClose5"	onclick="doAction('projectGridFile', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="cost" role="tabpanel" aria-labelledby="cost-tab">
								<!--Body-->
								<div class="modal-body p-0">
									<%--						<input type="text" id="testtest">--%>
									<div class="col-md-12 p-0" id="projectGridCost" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="projectGridCostDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer" style="display: block">
									<div class="row">
										<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
											<div class="col text-center">
												<form class="form-inline" role="form" name="projectGridCostButtonForm" id="projectGridCostButtonForm" method="post" onsubmit="return false;">
													<div class="container">
														<div class="row">
															<div class="col text-center">
																<button type="button" class="btn btn-sm btn-primary" name="btnSearch6"	id="btnSearch6"	onclick="doAction('projectGridCost', 'search')"><i class="fa fa-search"></i> 조회</button>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnInput6"	id="btnInput6"	onclick="doAction('projectGridCost', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnSave6"	id="btnSave6"	onclick="doAction('projectGridCost', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
																													<button type="button" class="btn btn-sm btn-primary" name="btnDelete6"	id="btnDelete6"	onclick="doAction('projectGridCost', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnClose6"	id="btnClose6"	onclick="doAction('projectGridCost', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="memo" role="tabpanel" aria-labelledby="memo-tab">
								<!--Body-->
								<div class="modal-body p-0">
									<div class="col-md-12 p-0" id="projectGridMemo" style="height: calc(30vh); width: 100%;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="projectGridMemoDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer" style="display: block">
									<div class="row">
										<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
											<div class="col text-center">
												<form class="form-inline" role="form" name="projectGridMemoButtonForm" id="projectGridMemoButtonForm" method="post" onsubmit="return false;">
													<div class="container">
														<div class="row">
															<div class="col text-center">
																<button type="button" class="btn btn-sm btn-primary" name="btnSearch7"	id="btnSearch7"	onclick="doAction('projectGridMemo', 'search')"><i class="fa fa-search"></i> 조회</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnInput7"	id="btnInput7"	onclick="doAction('projectGridMemo', 'input')" ><i class="fa fa-plus"></i> 신규</button>
																<button type="button" class="btn btn-sm btn-primary" name="btnSave7"	id="btnSave7"	onclick="doAction('projectGridMemo', 'save')"><i class="fa fa-save"></i> 저장</button>
																<%--													<button type="button" class="btn btn-sm btn-primary" name="btnDelete7"	id="btnDelete7"	onclick="doAction('projectGridMemo', 'delete')"><i class="fa fa-trash"></i> 삭제</button>--%>
																<button type="button" class="btn btn-sm btn-primary" name="btnClose7"	id="btnClose7"	onclick="doAction('projectGridMemo', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
							<div class="col-md-12" id="projectGridEmail" style="height: calc(71vh); width: 100%;">
								<div id="projectGridEmailDIV" style="width:100%; height:100%;"></div>
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
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_bccAddr','open'); return false;"><i class="fa fa-search"></i></button>
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
													<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" name="btnPrint4" id="btnPrint4" onclick="doAction('projectGridEmail', 'print4')" data-target="#modalCart2"><i class="fa fa-print"></i> 프로젝트</button>
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
								<div id="editor"></div>
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
							<form class="form-inline" role="form" name="projectEmailButtonForm" id="projectEmailButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch3"		id="btnSearch3"		onclick="doAction('projectGridEmail', 'search')"><i class="fa fa-search"></i> 조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnInput3"		id="btnInput3"		onclick="doAction('projectGridEmail', 'input')" ><i class="fa fa-plus"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('projectGridEmail', 'emailSend')"><i class="fa fa-print"></i> 전송</button>
<%--											<button type="button" class="btn btn-sm btn-primary" name="btnDelete3"		id="btnDelete3"		onclick="doAction('projectGridEmail', 'delete')"><i class="fa fa-trash"></i> 삭제</button>--%>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose3"		id="btnClose3"		onclick="doAction('projectGridEmail', 'btnClose')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
				<h4 class="modal-title">프로젝트 목록</h4>
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
								</tr>
								<tr>
									<td class="table-active">이디에스(주)</td>
									<td><input type="radio" name="prints" value="prints1"  style="width: 100%;" ></td>
									<td style="text-align: center">-</td>
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
							<form class="form-inline" role="form" name="projectPrintButtonForm" id="projectPrintButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnPrint2"		id="btnPrint2"	onclick="doAction('projectGridEmail', 'print2')" data-toggle="modal" data-target="#modalCart2" style="display: none"></button>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint3"		id="btnPrint3"	onclick="doAction('projectGridList', 'print3')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose2"		id="btnClose2"	onclick="doAction('projectGridList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
</html>