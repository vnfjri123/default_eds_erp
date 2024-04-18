<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
  <%-- 공통헤드 --%>
  <%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
  <%-- 공통 스타일시트 정의--%>
  <%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
  <%-- 공통 스크립트 정의--%>
  <%@ include file="/WEB-INF/views/comm/common-include-grid.jspf" %>
  <%-- tui grid --%>
  <link rel="stylesheet" href="/ims/inspection/inspection.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
  <script src="/js/util/eds.ims.js"></script>

  <script>
      var inspectionGridList, inspectionInfoGrid;
      var selectpicker, selectpickerInfo;
      var chartList;
      var currentMonth = new Date().getMonth() + 1;
      var currentQuarter = getCurrentQuarter();

      Chart.register(ChartDataLabels);

      $(document).ready(function () {

          init();

          $(".selectpicker").on('change', async ev => {
              var id = ev.target.id;
              switch (id) {
                  case 'ad':
                      await doAction('inspectionGridList', 'search');
              }
          });

          $(".selectpickerInfo").on('change', async ev => {
              var id = ev.target.id;
              switch (id) {
                  case 'depaCd':
                      await doAction('inspectionInfoGrid', 'search');
              }
          });

          editChar();

          //	이벤트

          $('form input').on('keydown', function (e) {
              if (e.which == 13) {
                  e.preventDefault();
                  doAction("inspectionGridList", "search");
                  doAction("chartList", "search");
              }
          });
          setTimeout(function () {
              imsUtil.focusSearch('siteNm');
          },100);
      });

      /* 초기설정 */
      function init() {
          /* Form 셋팅 */
          // edsUtil.setForm(document.querySelector("#searchForm"), "ad");
          edsUtil.setForm(document.querySelector("#searchForm"), "basma");

          // searchForm "연도" 이번연도 값으로 적용
          var thisYear = new Date().getFullYear();
          $('#yearSearch').val(thisYear);

          // searchForm "월 선택" 이번달 값으로 적용
          var thisMonth = ('00' + (new Date().getMonth() + 1)).slice(-2);
          $('#month').val(thisMonth).prop('selected', true);
          $('#month').on('change', function () {
              doAction("inspectionGridList", "search");
          });

          // select 구분자 추가
          $('#month option[value="40"]').prop('disabled', true);

          /* 조회옵션 셋팅 */
          document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';

          /* Button 셋팅 */
          edsUtil.setButtonForm(document.querySelector("#inspectionGridListButtonForm"));

          /**********************************************************************
           * Grid Info 영역 START
           ***********************************************************************/
          inspectionGridList = new tui.Grid({
              el: document.getElementById('inspectionGridListDIV'),
              scrollX: true,
              scrollY: true,
              editingEvent: 'click',
              bodyHeight: 'fitToParent',
              rowHeight: 30,
              minRowHeight: 30,
              rowHeaders: ['rowNum', 'checkbox'],
              // rowHeaders: ['checkbox'],
              header: {
                  height: 35,
                  minRowHeight: 35
              },
              columns: [],
              columnOptions: {
                  resizable: true
              },
              summary: {
                  height: 40,
                  position: 'bottom',
                  columnContent: {
                      projNm: {
                          template(valueMap) {
                              var completedCnt = 0;
                              var InCompletedCnt = 0;
                              var monthlyCnt = 0;
                              var quarterlyCnt = 0;
                              for (var i = 0; i < valueMap.cnt; i++) {
                                  if (inspectionGridList.getValue(i, 'inspectDivi') === 'N') {
                                      InCompletedCnt += 1;
                                  } else if (inspectionGridList.getValue(i, 'inspectDivi') === 'Y') {
                                      completedCnt += 1;
                                  }
                                  if (inspectionGridList.getValue(i, 'checkCycle') === '월') {
                                      monthlyCnt += 1;
                                  } else {
                                      quarterlyCnt += 1;
                                  }
                              }

                              return '합계 : ' + inspectionGridList.getFilteredData().length + '(' + '월 ' + monthlyCnt + ' / ' + '분기 ' + quarterlyCnt + ')' + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + '점검(미점검) : ' + completedCnt + '(' + InCompletedCnt + ')';
                          }
                      },
                  }
              }
          });

          inspectionGridList.setColumns([
              // hidden(숨김)
              {header: '프로젝트코드', name: 'projCd', minWidth: 100, align: 'Center', editor: {type: 'text'}, hidden: true},
              {header: '부서명', name: 'depaCd', minWidth: 100, align: 'Center', editor: {type: 'text'}, hidden: true},
              {header: '월', name: 'month', minWidth: 100, align: 'Center', editor: {type: 'text'}, hidden: true},
              {header: '회사코드', name: 'corpCd', minWidth: 100, align: 'Center', hidden: true},
              {header: '점검여부', name: 'inspectDivi', minWidth: 100, align: 'Center', hidden: true},
              {header: '점검주기', name: 'checkCycle', minWidth: 100, align: 'Center', hidden: true},

              // {header: '기간', name: 'period', width: 30, align: 'Center'},
              {
                  header: '프로젝트', name: 'projNm', minWidth: 100, align: 'Center', filter: {
                      type: 'text',
                      showClearBtn: true
                  }
              },
              {
                  header: '지자체',
                  name: 'ad',
                  width: 50,
                  align: 'center',
                  editor: {type: 'select', options: {listItems: setCommCode("SYS010")}},
                  formatter: 'listItemText',
              },
              {
                  header: '사이트명', name: 'siteNm', width: 120, align: 'Center'
              },
              {
                  header: '구분', name: 'clasifyDivi', width: 90, align: 'Center',
                  filter: 'select',
                  editor: {type: 'select', options: {listItems: setCommCode("SYS012")}},
                  formatter: 'listItemText',
              },
              {
                  header: '점검일',
                  name: 'inspectDt',
                  className: 'grid-cell-inspectDt',
                  width: 80,
                  align: 'center',
                  editor: {type: 'datePicker', options: {format: 'yyyy-MM-dd'}},
                  filter: {
                      type: 'date',
                      options: {
                          format: 'yyyy-MM-dd'
                      },
                      showClearBtn: true,
                  },
                  onBeforeChange: function(ev) {
                      const { rowKey, columnName, value, nextValue } = ev;
                      if (nextValue === '') {
                          return ev.stop();
                      }
                  }
              },
              {
                  header: '점검내용', name: 'content', width: 200, align: 'left',
                  // validation: {
                  //     required: true
                  // },
                  defaultValue: '',
                  filter: {
                      type: 'text',
                      showClearBtn: true
                  }
              },
              {
                  header: '점검자', name: 'inpId', width: 60, align: 'Center',
                  filter: 'select',
              },
              {
                  header: '수정자', name: 'updId', width: 60, align: 'Center',
                  filter: 'select',
              },
          ]);

          inspectionGridList.disableColumn('ad');
          inspectionGridList.disableColumn('clasifyDivi');

          inspectionInfoGrid = new tui.Grid({
              el: document.getElementById('inspectionInfoGridDIV'),
              scrollX: true,
              scrollY: true,
              editingEvent: 'click',
              bodyHeight: 'fitToParent',
              rowHeight: 30,
              minRowHeight: 30,
              rowHeaders: ['rowNum'],
              // rowHeaders: ['checkbox'],
              header: {
                  height: 35,
                  minRowHeight: 35
              },
              columns: [],
              columnOptions: {
                  resizable: true
              },
              // summary: {
              //     height: 40,
              //     position: 'bottom',
              //     columnContent: {
              //         projNm: {
              //             template(valueMap) {
              //                 var completedCnt = 0;
              //                 var InCompletedCnt = 0;
              //                 var monthlyCnt = 0;
              //                 var quarterlyCnt = 0;
              //                 for (var i = 0; i < valueMap.cnt; i++) {
              //                     if (inspectionGridList.getValue(i, 'inspectDivi') === 'N') {
              //                         InCompletedCnt += 1;
              //                     } else if (inspectionGridList.getValue(i, 'inspectDivi') === 'Y') {
              //                         completedCnt += 1;
              //                     }
              //                     if (inspectionGridList.getValue(i, 'checkCycle') === '월') {
              //                         monthlyCnt += 1;
              //                     } else {
              //                         quarterlyCnt += 1;
              //                     }
              //                 }
              //
              //                 return '합계 : ' + inspectionGridList.getFilteredData().length + '(' + '월 ' + monthlyCnt + ' / ' + '분기 ' + quarterlyCnt + ')' + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + '점검(미점검) : ' + completedCnt + '(' + InCompletedCnt + ')';
              //             }
              //         },
              //     }
              // }
          });

          inspectionInfoGrid.setColumns([
              {
                  header: '지자체',
                  name: 'ad',
                  minWidth: 100,
                  className: 'highlight-cell',
                  align: 'center',
                  filter: 'select',
                  editor: {type: 'select', options: {listItems: setCommCode("SYS010")}},
                  formatter: 'listItemText',
              },
              {
                  header: '합계',
                  name: 'totNum',
                  width: 70,
                  align: 'center',
              },
              {
                  header: '완료',
                  name: 'completionNum',
                  width: 70,
                  align: 'center',
              },
              {
                  header: '미완료',
                  name: 'incompletionNum',
                  width: 70,
                  align: 'center',
              },
              {
                  header: '점검률',
                  name: 'rate',
                  width: 70,
                  align: 'center',
                  className: 'highlight-cell2',
                  formatter({value}) {
                      return value + '%';
                  }
              },
          ]);
          inspectionInfoGrid.disableColumn('ad');


          selectpicker = $('.selectpicker').select2({
              language: 'ko'
          });
          selectpickerInfo = $('.selectpickerInfo').select2({
              language: 'ko'
          });
          var depaCd = '${LoginInfo.depaCd}';
          if (depaCd === '1008' || depaCd === '1009' || depaCd === '1012') {
              $('#depaCd').val(depaCd).trigger('change');
          }
          /**********************************************************************
           * Grid Info 영역 END
           ***********************************************************************/

          /**********************************************************************
           * Grid 이벤트 영역 START
           ***********************************************************************/
          // 모달 닫기시
          $('#infoModal').on('hidden.bs.modal', function (e) {
              var depaCd = '${LoginInfo.depaCd}';
              if (depaCd === '1008' || depaCd === '1009' || depaCd === '1012') {
                  $('#depaCd').val(depaCd).trigger('change');
              } else {
                  $('#depaCd').val('').trigger('change');
              }
          });

          inspectionGridList.on('click', async ev => {
              var colNm = ev.columnName;
              var target = ev.targetType;
              if (target === 'cell') {
                  if (colNm === 'content') {
                      await edsUtil.sheetData2Maldal(inspectionGridList);
                  }
              }
          })

          $('#btnInfo').on('click', () => {
              doAction('inspectionInfoGrid', 'search');
          });

          /**********************************************************************
           * Grid 이벤트 영역 END
           ***********************************************************************/

          /* 그리드생성 */
          var height = window.innerHeight - 90;
          document.getElementById('inspectionGridList').style.height = height + 'px';
          document.getElementById('inspectionInfoGrid').style.height = height + 'px';

          /* 조회 */
          doAction("inspectionGridList", "search");

      }

      /**********************************************************************
       * 화면 이벤트 영역 START
       ***********************************************************************/
      async function doAction(sheetNm, sAction) {
          if (sheetNm == 'chartList') {
              switch (sAction) {
                  case "search":// 조회
                      progressChart.destroy();
                      quarterlyProgressChart.destroy();
                      editChar();


                  <%--var param = {};--%>
                  <%--param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>'--%>
                  <%--param.year = edsUtil.getToday('%Y');--%>
                  <%--edsUtil.getAjax("/inspection/selectInspectionProgress", param);--%>
                      break;
              }
          }

          if (sheetNm == 'inspectionGridList') {
              switch (sAction) {
                  case "search":// 조회
                      inspectionGridList.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
                      inspectionGridList.clear(); // 데이터 초기화

                      var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
                      if ('${LoginInfo.empCd}' === '0007') {
                          param.depaCd = '1009';
                      } else {
                          param.depaCd = '${LoginInfo.depaCd}';
                      }
                      var inspectionData = edsUtil.getAjax("/inspection/selectInspectionList", param)
                      inspectionGridList.resetData(inspectionData);

                      if (inspectionGridList.getRowCount() > 0) {
                          inspectionGridList.focusAt(0, 1, true);
                      }
                      $('#period').text('점검등록' + '(' + $('#month :selected').text() + ')');
                      for (var i = 0; i < inspectionGridList.getColumnValues('inspectDivi').length; i++) {

                          // inspectionGridList.setColumnValues('period', $('#month :selected').text());

                          inspectionGridList.setValue(i, 'clasifyDivi', inspectionData[i].clasifyDivi);
                          if (inspectionGridList.getColumnValues('checkCycle')[i] === '월' && inspectionGridList.getColumnValues('inspectDivi')[i] !== 'Y') {
                              inspectionGridList.addRowClassName(i, 'monthly');
                          }
                          if (inspectionGridList.getColumnValues('checkCycle')[i] === '분기' && inspectionGridList.getColumnValues('inspectDivi')[i] !== 'Y') {
                              inspectionGridList.addRowClassName(i, 'quarterly');
                          }
                          if (inspectionGridList.getColumnValues('inspectDivi')[i] === 'Y' && inspectionGridList.getColumnValues('checkCycle')[i] === '분기') {
                              inspectionGridList.addRowClassName(i, 'completed');
                          }
                          if (inspectionGridList.getColumnValues('inspectDivi')[i] === 'Y' && inspectionGridList.getColumnValues('checkCycle')[i] === '월') {
                              inspectionGridList.addRowClassName(i, 'completedMon');
                          }
                      }
                      inspectionGridList.clearModifiedData();
                      break;
                  case "save"://저장
                      inspectionGridList.finishEditing()

                      // var rows = await inspectionGridList.getModifiedRows();
                      // 점검일 등록하지 않은 행 추적해주는 기능
                      // if (rows.updatedRows.length > 0) {
                      //     for (var i = 0; i < rows.updatedRows.length; i++) {
                      //         for (var i = rows.updatedRows.length - 1; i >= 0; i--) {
                      //             if (rows.updatedRows[i].inspectDt === null || rows.updatedRows[i].inspectDt === '') {
                      //                 alert('점검일을 입력해 주세요.');
                      //                 inspectionGridList.focusAt(rows.updatedRows[i].rowKey, 4, true);
                      //                 return;
                      //             }
                      //         }
                      //     }
                      // }

                      await edsUtil.doCUD("/inspection/cudInspectionList", "inspectionGridList", inspectionGridList);
                      progressChart.destroy();
                      quarterlyProgressChart.destroy();
                      editChar();
                      break;
                  case "delete"://삭제
                      await inspectionGridList.removeCheckedRows(true);
                      await edsUtil.doCUD("/inspection/cudInspectionList", "inspectionGridList", inspectionGridList);
                      progressChart.destroy();
                      quarterlyProgressChart.destroy();
                      editChar();
                      break;
              }
          }

          if (sheetNm == 'inspectionInfoGrid') {
              // todo : 쿼리 완성 => 서버랑 매핑 => ajax => view set
              switch (sAction) {
                  case "search":// 조회
                      inspectionInfoGrid.refreshLayout();
                      inspectionInfoGrid.clear(); // 데이터 초기화

                      var param = ut.serializeObject(document.querySelector("#searchFormInfo")); //조회조건
                      param.corpCd = '${LoginInfo.corpCd}';
                      param.year = $('#yearSearch').val();
                      param.month = $('#month').val();
                      var infoData = edsUtil.getAjax("/inspection/selectInfo", param);

                      inspectionInfoGrid.resetData(infoData);

                      setTimeout(function (){
                          inspectionInfoGrid.refreshLayout();
                      },200)
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
      function editChar() {
          let param = {};
          param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>'
          param.year = $('#yearSearch').val();
          // param.year = edsUtil.getToday('%Y');

          let data = edsUtil.getAjax("/inspection/selectInspectionProgress", param);

          let scData = {
              "01": "",
              "02": "",
              "03": "",
              "04": "",
              "05": "",
              "06": "",
              "07": "",
              "08": "",
              "09": "",
              "10": "",
              "11": "",
              "12": ""
          };
          let ndOneData = {
              "01": "",
              "02": "",
              "03": "",
              "04": "",
              "05": "",
              "06": "",
              "07": "",
              "08": "",
              "09": "",
              "10": "",
              "11": "",
              "12": ""
          };
          let ndTwoData = {
              "01": "",
              "02": "",
              "03": "",
              "04": "",
              "05": "",
              "06": "",
              "07": "",
              "08": "",
              "09": "",
              "10": "",
              "11": "",
              "12": ""
          };

          // let quarterlyScData = {
          //     "41": "",
          //     "42": "",
          //     "43": "",
          //     "44": ""
          // };
          let quarterlyNdOneData = {
              "41": "",
              "42": "",
              "43": "",
              "44": ""
          };
          let quarterlyNdTwoData = {
              "41": "",
              "42": "",
              "43": "",
              "44": ""
          };

          var scNum = 0;
          var ndOneNum = 0;
          var ndTwoNum = 0;
          var scTooltipData = [];
          var ndOneTooltipData = [];
          var ndTwoTooltipData = [];

          // var quarterlyScNum = 0;
          var quarterlyNdOneNum = 0;
          var quarterlyNdTwoNum = 0;
          // var quarterlyScTooltipData = [];
          var quarterlyNdOneTooltipData = [];
          var quarterlyNdTwoTooltipData = [];

          for (const row of data) {
              if (row.month == null) continue;
              switch (row.depaCd) {
                  case '1012' :
                      if (row.month < '40') {
                          scData[row.month] = row.completionNum / row.totNum * 100;
                          scTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                          scNum = row.totNum;
                      }
                      // if (row.month > '40') {
                      //     quarterlyScData[row.month] = row.completionNum / row.totNum * 100;
                      //     quarterlyScTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                      //     quarterlyScNum = row.totNum;
                      // }
                      break;
                  case '1008' :
                      if (row.month < '40') {
                          ndOneData[row.month] = row.completionNum / row.totNum * 100;
                          ndOneTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                          ndOneNum = row.totNum;
                      }
                      if (row.month > '40') {
                          quarterlyNdOneData[row.month] = row.completionNum / row.totNum * 100;
                          quarterlyNdOneTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                          quarterlyNdOneNum = row.totNum;
                      }
                      break;
                  case '1009' :
                      if (row.month < '40') {
                          ndTwoData[row.month] = row.completionNum / row.totNum * 100;
                          ndTwoTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                          ndTwoNum = row.totNum;
                      }
                      if (row.month > '40') {
                          quarterlyNdTwoData[row.month] = row.completionNum / row.totNum * 100;
                          quarterlyNdTwoTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                          quarterlyNdTwoNum = row.totNum;
                      }
                      break;
              }
          }

          var areaChartData = {
              labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
              datasets: [
                  {
                      categoryPercentage: 0.9,
                      label: '사회재난 ' + '(' + scNum + '개소)',
                      backgroundColor: '#AED6F1',
                      data: [scData["01"], scData["02"], scData["03"], scData["04"], scData["05"], scData["06"], scData["07"], scData["08"], scData["09"], scData["10"], scData["11"], scData["12"]]
                  },
                  {
                      categoryPercentage: 0.9,
                      label: '자연재난 1 ' + '(' + ndOneNum + '개소)',
                      backgroundColor: '#2980B9',
                      data: [ndOneData["01"], ndOneData["02"], ndOneData["03"], ndOneData["04"], ndOneData["05"], ndOneData["06"], ndOneData["07"], ndOneData["08"], ndOneData["09"], ndOneData["10"], ndOneData["11"], ndOneData["12"]]
                  },
                  {
                      categoryPercentage: 0.9,
                      label: '자연재난 2 ' + '(' + ndTwoNum + '개소)',
                      backgroundColor: '#BB8FCE',
                      data: [ndTwoData["01"], ndTwoData["02"], ndTwoData["03"], ndTwoData["04"], ndTwoData["05"], ndTwoData["06"], ndTwoData["07"], ndTwoData["08"], ndTwoData["09"], ndTwoData["10"], ndTwoData["11"], ndTwoData["12"]]
                  },
              ]
          }

          var quarterlyAreaChartData = {
              labels: ['1분기', '2분기', '3분기', '4분기'],
              datasets: [
                  // {
                  //     label: '사회재난 ' + '(' + quarterlyScNum + '개소)',
                  //     backgroundColor: '#AED6F1',
                  //     borderColor: 'rgba(60,141,188,0.8)',
                  //     pointRadius: false,
                  //     pointColor: '#3b8bba',
                  //     pointStrokeColor: 'rgba(60,141,188,1)',
                  //     pointHighlightFill: '#fff',
                  //     pointHighlightStroke: 'rgba(60,141,188,1)',
                  //     data: [quarterlyScData["41"], quarterlyScData["42"], quarterlyScData["43"], quarterlyScData["44"]]
                  // },
                  {
                      label: '자연재난 1 ' + '(' + quarterlyNdOneNum + '개소)',
                      backgroundColor: '#2980B9',
                      borderColor: 'rgba(60,141,188,0.8)',
                      pointRadius: false,
                      pointColor: '#3b8bba',
                      pointStrokeColor: 'rgba(60,141,188,1)',
                      pointHighlightFill: '#fff',
                      pointHighlightStroke: 'rgba(60,141,188,1)',
                      data: [quarterlyNdOneData["41"], quarterlyNdOneData["42"], quarterlyNdOneData["43"], quarterlyNdOneData["44"]]
                  },
                  {
                      label: '자연재난 2 ' + '(' + quarterlyNdTwoNum + '개소)',
                      backgroundColor: '#BB8FCE',
                      borderColor: 'rgba(210, 214, 222, 1)',
                      pointRadius: false,
                      pointColor: 'rgba(210, 214, 222, 1)',
                      pointStrokeColor: '#c1c7d1',
                      pointHighlightFill: '#fff',
                      pointHighlightStroke: 'rgba(220,220,220,1)',
                      data: [quarterlyNdTwoData["41"], quarterlyNdTwoData["42"], quarterlyNdTwoData["43"], quarterlyNdTwoData["44"]]
                  },
              ]
          }


          //-------------
          //- BAR CHART -
          //-------------
          var barChartCanvas = $('#monthlyChart').get(0).getContext('2d')
          var barChartData = $.extend(true, {}, areaChartData)
          var quarterlyBarChartCanvas = $('#quarterlyChart').get(0).getContext('2d')
          var quarterlyBarChartData = $.extend(true, {}, quarterlyAreaChartData)

          var barChartOptions = {
              // series:{
              //     dataLabels: {
              //         visible: true,
              //     },
              // },
              plugins: {
                  datalabels: {
                      display: function (context) {
                          return context.dataset.data[context.dataIndex] && context.dataIndex + 1 === currentMonth;
                      },
                      align: 'center',
                      anchor: 'center',
                      // backgroundColor: 'white', // 라벨 배경색
                      // borderRadius: 4, // 라벨 모서리 둥글기
                      color: '#333', // 라벨 텍스트 색상
                      font: {
                          size: '10px',
                          weight: 'bold'
                      },
                      formatter: function (value, context) {
                          return Math.round(value);
                      }
                  },
                  title: {
                      display: true,
                      text: '월 점검 진행률(%)'
                  },
                  tooltip: {
                      callbacks: {
                          label: function (context) {
                              let label;
                              if (context.datasetIndex === 0) {
                                  label = '사회재난팀(' + scTooltipData[context.dataIndex + 1] + '): ';
                                  if (context.parsed.y !== null) {
                                      label += Math.round(context.parsed.y) + '%';
                                  }
                                  return label;
                              } else if (context.datasetIndex === 1) {
                                  label = '자연재난 1팀(' + ndOneTooltipData[context.dataIndex + 1] + '): ';
                                  if (context.parsed.y !== null) {
                                      label += Math.round(context.parsed.y) + '%';
                                  }
                                  return label;
                              } else if (context.datasetIndex === 2) {
                                  label = '자연재난 2팀(' + ndTwoTooltipData[context.dataIndex + 1] + '): ';
                                  if (context.parsed.y !== null) {
                                      label += Math.round(context.parsed.y) + '%';
                                  }
                                  return label;
                              }
                          }
                      }
                  }
              },
              scales: {
                  y: {
                      max: 100,
                      ticks: {
                          stepSize: 10,
                      },
                  },
              },
              responsive: true,
              maintainAspectRatio: false,
              datasetFill: false,
          }

          var quarterlyBarChartOptions = {
              plugins: {
                  datalabels: {
                      display: function (context) {
                          return context.dataset.data[context.dataIndex] && context.dataIndex + 1 === currentQuarter;
                      },
                      align: 'center',
                      anchor: 'center',
                      // backgroundColor: '#ccc', // 라벨 배경색
                      // borderRadius: 4, // 라벨 모서리 둥글기
                      color: '#333', // 라벨 텍스트 색상
                      font: {
                          size: '13px',
                          weight: 'bold'
                      },
                      formatter: function (value, context) {
                          return Math.round(value);
                      }
                  },
                  title: {
                      display: true,
                      text: '분기 점검 진행률(%)'
                  },
                  tooltip: {
                      callbacks: {
                          label: function (context) {
                              // if (context.datasetIndex === 0) {
                              //     let label = '사회재난팀(' + quarterlyScTooltipData[context.dataIndex + 41] + '): ';
                              //     if (context.parsed.y !== null) {
                              //         label += Math.round(context.parsed.y) + '%';
                              //     }
                              //     return label;
                              // }
                              if (context.datasetIndex === 0) {
                                  let label = '자연재난 1팀(' + quarterlyNdOneTooltipData[context.dataIndex + 41] + '): ';
                                  if (context.parsed.y !== null) {
                                      label += Math.round(context.parsed.y) + '%';
                                  }
                                  return label;
                              }
                              if (context.datasetIndex === 1) {
                                  let label = '자연재난 2팀(' + quarterlyNdTwoTooltipData[context.dataIndex + 41] + '): ';
                                  if (context.parsed.y !== null) {
                                      label += Math.round(context.parsed.y) + '%';
                                  }
                                  return label;
                              }
                          }
                      }
                  }
              },
              scales: {
                  y: {
                      max: 100,
                      ticks: {
                          stepSize: 10,
                      },
                  },
              },
              responsive: true,
              maintainAspectRatio: false,
              datasetFill: false,
          }

          progressChart = new Chart(barChartCanvas, {
              type: 'bar',
              data: barChartData,
              options: barChartOptions
          })

          quarterlyProgressChart = new Chart(quarterlyBarChartCanvas, {
              type: 'bar',
              data: quarterlyBarChartData,
              options: quarterlyBarChartOptions
          })
      }

      function getCurrentQuarter() {
          if (currentMonth >= 1 && currentMonth <= 3) {
              return 1; // 1분기
          } else if (currentMonth >= 4 && currentMonth <= 6) {
              return 2; // 2분기
          } else if (currentMonth >= 7 && currentMonth <= 9) {
              return 3; // 3분기
          } else {
              return 4; // 4분기
          }
      }

      /**********************************************************************
       * 화면 함수 영역 END
       ***********************************************************************/
  </script>
</head>

<body class="body">
<div class="row">
  <div class="col-md-12">
    <!-- 검색조건 영역 -->
    <div class="row">
      <div class="col-md-12" style="background-color: #ebe9e4;">
        <div style="background-color: #faf9f5;border: 1px solid #dedcd7;">
          <!-- form start -->
          <form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
            <!-- input hidden -->
            <input type="hidden" name="corpCd" id="corpCd" title="회사코드">
            <input type="hidden" name="year" title="연도">
            <input type="hidden" name="ad" title="지자체">
            <input type="hidden" name="month" title="월">

            <!-- ./input hidden -->
            <div class="form-group">

              <label for="yearSearch" style="padding-left: 0.5rem">연도 &nbsp;</label>
              <div class="input-group input-group-sm">
                <input type="text" class="form-control" style="width: 60px; font-size: 15px; text-align: center"
                       name="year"
                       id="yearSearch"
                       title="연도">
              </div>
              <div class="form-group" style="margin-left: 0.5rem"></div>

              <div class="form-group">
                <label for="month">월 선택 &nbsp;</label>
                <div class="input-group input-group-sm">
                  <select type="text" class="form-control" style="width: 80px; font-size: 15px;" name="month" id="month"
                          title="월 선택"></select>
                </div>
              </div>
              <div class="form-group" style="margin-left: 5rem"></div>

              <div class="form-group">
                <select class="form-control selectpicker" style="width: 150px;" name="ad" id="ad"></select>
              </div>
              <div class="form-group" style="margin-left: 5rem"></div>

              <label for="siteNm">사이트명 &nbsp;</label>
              <div class="input-group input-group-sm">
                <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="siteNm" id="siteNm"
                       title="사이트명">
              </div>
            </div>

          </form>
          <!-- ./form -->
        </div>
      </div>

      <div class="col-md-4">
        <!-- 그리드 영역 -->
        <div class="card-body" style="padding: unset">
          <div class="chart" style="margin-bottom: 4rem">
            <div class="chartjs-size-monitor">
              <div class="chartjs-size-monitor-expand">
                <div class=""></div>
              </div>
              <div class="chartjs-size-monitor-shrink">
                <div class=""></div>
              </div>
            </div>
            <canvas id="monthlyChart"
                    style="min-height: 300px; height: 300px; max-height: 300px; max-width: 100%; display: block; width: 639px;"
                    width="639" height="300" class="chartjs-render-monitor"></canvas>
          </div>
          <div class="chart">
            <div class="chartjs-size-monitor">
              <div class="chartjs-size-monitor-expand">
                <div class=""></div>
              </div>
              <div class="chartjs-size-monitor-shrink">
                <div class=""></div>
              </div>
            </div>
            <canvas id="quarterlyChart"
                    style="min-height: 300px; height: 300px; max-height: 300px; max-width: 100%; display: block; width: 639px;"
                    width="639" height="300" class="chartjs-render-monitor"></canvas>
          </div>
        </div>
      </div>

      <div class="col-md-8">
        <!-- 그리드 영역 -->
        <div class="row">
          <div class="col-md-12" style="padding: 5px 15px 0 15px;">
            <div id="period" class="float-left" style="padding: 0 0 0 5px">
              <i class="fa fa-file-text-o"></i> 점검등록
            </div>
            <div class="show-status" style="float: left">
              <span class="monthly">월</span>
              <span class="quarterly">분기</span>
              <span class="completedMon">완료</span>
              <span class="completed">분기완료</span>
            </div>
            <div class="btn-group float-right">
              <form class="form-inline" role="form" name="inspectionGridListButtonForm"
                    id="inspectionGridListButtonForm" method="post" onsubmit="return false;">
                <button type="button" class="btn btn-sm btn-primary" name="btnInfo" id="btnInfo" data-toggle="modal" data-target="#infoModal">
                  <i class="fa-regular fa-circle-question"></i>현황
                </button>
                <button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave"
                        onclick="doAction('inspectionGridList', 'save')"><i class="fa fa-save"></i> 저장
                </button>
                <button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete"
                        onclick="doAction('inspectionGridList', 'delete')"><i class="fa fa-trash"></i> 내용삭제
                </button>
              </form>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12" style="height: 100%;" id="inspectionGridList">
            <!-- 시트가 될 DIV 객체 -->
            <div id="inspectionGridListDIV" style="width:100%; height:100%;"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%--Modal--%>
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog"
     aria-labelledby="infoModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-md" role="document" style="margin: auto">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">점검현황
        <form class="form-inline" role="form" name="searchFormInfo" id="searchFormInfo" method="post">
        <select class="form-control selectpickerInfo" style="width: 150px;" name="depaCd" id="depaCd">
          <option value="">전체</option>
          <option value="1012">사회재난팀</option>
          <option value="1008">자연재난1팀</option>
          <option value="1009">자연재난2팀</option>
        </select>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </form>
      </div>

      <%-- create / 등록 body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <div class="form-group col-md-12 mb-0">
          <div class="row">
            <div class="col-md-12" style="height: 100%;" id="inspectionInfoGrid">
              <!-- 시트가 될 DIV 객체 -->
              <div id="inspectionInfoGridDIV" style="width:100%; height:100%;"></div>
            </div>
          </div>
        </div>
        <!--Footer-->
        <div class="modal-footer" style="display: block;padding: unset">
<%--          <div class="row">--%>
<%--            <div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">--%>
<%--              <div class="col text-center" style="padding: unset">--%>
<%--                <div class="container">--%>
<%--                  <div class="row">--%>
<%--                    <div class="col text-center" style="padding: unset;">--%>
<%--                      <button type="button" class="btn btn-sm btn-primary" name="btnClose1" id="btnClose1"--%>
<%--                              data-dismiss="modal"--%>
<%--                              aria-label="Close">--%>
<%--                        <i class="fa fa-times"></i> 닫기--%>
<%--                      </button>--%>
<%--                    </div>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>