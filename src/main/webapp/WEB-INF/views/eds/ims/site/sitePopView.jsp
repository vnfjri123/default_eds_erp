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
  <link rel="stylesheet" href="/ims/site/site-pop.css">

  <script>
      var baseGridList;
      var selectpicker;
      $(document).ready(async function () {
          await init();

          //	이벤트
          $(".selectpicker").on('change', async ev => {
              var id = ev.target.id;
              switch (id) {
                  case 'ad':
                      await doAction('baseGridList', 'search');
              }
          });

          $('body').on('keydown', (e) => {
              if (e.which == 191) {
                  e.preventDefault();
                  document.getElementById('siteNm').focus();
              }
          })

          $('form input').on('keydown', async function (e) {
              if (e.which == 13) {
                  await doAction("baseGridList", "search");

                  if (baseGridList.getRowCount() > 0) {
                      baseGridList.focusAt(0, 2, true);
                  }
              }
          });
          document.getElementById('siteNm').focus();
      });

      /* 초기설정 */
      async function init() {
          edsUtil.setForm(document.querySelector("#searchForm"), "basma");

          /* 조회옵션 셋팅 */
          await edsIframe.setParams();

          // searchForm "연도" 이번연도 값으로 적용
          var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
          var thisYear = new Date().getFullYear();
          if (param.from === 'ims') {
              $('#yearSearch').val(thisYear - 1);
          } else {
              $('#yearSearch').val(thisYear);
          }
          /**********************************************************************
           * Grid Info 영역 START
           ***********************************************************************/
          baseGridList = new tui.Grid({
              el: document.getElementById('baseGridListDIV'),
              scrollX: true,
              scrollY: true,
              editingEvent: 'click',
              bodyHeight: 'fitToParent',
              rowHeight: 30,
              minRowHeight: 30,
              rowHeaders: ['rowNum', 'checkbox'],
              header: {
                  height: 35,
                  minRowHeight: 35
              },
              columns: [],
              columnOptions: {
                  resizable: true
              }
          });

          baseGridList.setColumns([
              {header: '상태', name: 'sStatus', width: 80, align: 'center', hidden: true},

              {header: '인덱스', name: 'index', width: 80, align: 'center', hidden: true},

              // { header:'연도',			name:'year',		width:80,		align:'center',	hidden:true },

              {
                  header: '프로젝트',
                  name: 'projNm',
                  width: 200,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true}
              },
              {
                  header: '행정구역',
                  name: 'ad',
                  width: 80,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true},
                  editor: {type: 'select', options: {listItems: setCommCode("SYS010")}},
                  formatter: 'listItemText'
              },
              {
                  header: '사이트',
                  name: 'siteNm',
                  width: 200,
                  align: 'left',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true}
              },
              {
                  header: '구분',
                  name: 'clasifyDivi',
                  width: 60,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true},
                  editor: {type: 'select', options: {listItems: setCommCode("SYS012")}},
                  formatter: 'listItemText'
              },
              {
                  header: '모델',
                  name: 'modelDivi',
                  width: 60,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true},
                  editor: {type: 'select', options: {listItems: setCommCode("SYS013")}},
                  formatter: 'listItemText'
              },
              // { header:'모델명',name:'modelNm',		width:60,		align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true },
              // },
              {
                  header: '설치년월',
                  name: 'installDt',
                  width: 80,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true}
              },
              {
                  header: '작성일자', name: 'inpDttm', width: 80, align: 'center',
                  filter: {
                      type: 'date',
                      options: {
                          format: 'yyyy-MM-dd'
                      },
                      showClearBtn: true,
                      operator: 'AND'
                  },
                  formatter({value}) {
                      return yyyymmdd(new Date(value));
                  }
              },
              {
                  header: '작성자',
                  name: 'empNm',
                  width: 60,
                  align: 'center',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true}
              },

              {
                  header: '비고',
                  name: 'remark',
                  minWidth: 150,
                  align: 'left',
                  filter: {type: 'text', showApplyBtn: true, showClearBtn: true}
              },

              // hidden(숨김)
              {header: '전화번호', name: 'telNo', minWidth: 150, align: 'left', hidden: true},

          ]);

          baseGridList.disableColumn('ad');
          baseGridList.disableColumn('clasifyDivi');
          baseGridList.disableColumn('modelDivi');


          selectpicker = $('.selectpicker').select2({
              language: 'ko'
          });/**********************************************************************


           * Grid Info 영역 END
           ***********************************************************************/

          /**********************************************************************
           * Grid 이벤트 영역 START
           ***********************************************************************/

          baseGridList.on('dblclick', async ev => {
              await doAction("baseGridList", "apply");
          });

          baseGridList.on('keydown', async ev => {
              if (ev.keyboardEvent.keyCode == "13") {
                  await doAction("baseGridList", "apply");
              }
              if (ev.keyboardEvent.keyCode == "8") {
                  document.getElementById('custCd').focus();
              }
          });
          $(document).keydown(function (e) {
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
                      param.depaCd = "${LoginInfo.depaCd}";
                      baseGridList.resetData(edsUtil.getAjax("/siteView/selectSitePop", param)); // 데이터 set
                      if (param.from === 'error') {
                          $('#btnCarryOver, #projContainer').css('display', 'none');
                          $('#btnApply').css('display', 'block');
                      } else {
                          $('#btnCarryOver').css('display', 'block');
                          $('#projContainer').css('display', 'flex');
                          $('#btnApply').css('display', 'none');
                      }
                      break;
                  case "apply"://선택
                      baseGridList.finishEditing();

                      var rows = baseGridList.getCheckedRows();
                      var param = {};
                      param.siteNm = rows[0].siteNm;
                      param.depaNm = '${LoginInfo.depaNm}';
                      param.siteIndex = rows[0].index;
                      param.projNm = rows[0].projNm;
                      param.projCd = rows[0].projCd;
                      param.ad = rows[0].ad;
                      param.clasifyDivi = rows[0].clasifyDivi;
                      param.modelDivi = rows[0].modelDivi;
                      param.installDt = rows[0].installDt;
                      param.batteryDt = rows[0].batteryDt;
                      param.name = document.getElementById('name').value;

                      // var row = baseGridList.getFocusedCell();
                      // param.siteNm = baseGridList.getValue(row.rowKey, "siteNm");
                      // param.siteIndex = baseGridList.getValue(row.rowKey, "index");
                      // param.projNm = baseGridList.getValue(row.rowKey, "projNm");
                      // param.projCd = baseGridList.getValue(row.rowKey, "projCd");
                      // param.ad = baseGridList.getValue(row.rowKey, "ad");
                      // param.clasifyDivi = baseGridList.getValue(row.rowKey, "clasifyDivi");
                      // param.modelDivi = baseGridList.getValue(row.rowKey, "modelDivi");
                      // param.installDt = baseGridList.getValue(row.rowKey, "installDt");
                      // param.batteryDt = baseGridList.getValue(row.rowKey, "batteryDt");
                      // param.name = document.getElementById('name').value;
                      await edsIframe.closePopup(param);

                      break;
                  case "close":	// 닫기

                      var param = {};
                      param.name = document.getElementById('name').value;
                      await edsIframe.closePopup(param);

                      break;

                  case "carryOver":	// 이월
                      var testAr = [];
                      var param = {};
                      param.name = document.getElementById('name').value;
                      var rows = baseGridList.getCheckedRows();
                      var thisYear = new Date().getFullYear();
                      testAr = [...rows];
                      param.corpCd = ${LoginInfo.corpCd};
                      param.depaCd = '${LoginInfo.depaCd}';
                      param.year = thisYear;

                      var existingData = edsUtil.getAjax("/siteView/selectSite", param);

                      if (rows.length < 1) {
                          alert('선택된 데이터가 없습니다.');
                          return;
                      }

                      if (isDuplicate(existingData, rows)) {
                          // 중복 체크
                          var rowKeyArr = [];
                          for (var i = 0; i < rows.length; i++) {
                              // rows 배열의 길이만큼 반복문 실행
                              if (isDuplicate(existingData, [rows[i]])) {
                                  rowKeyArr.push(Number(rows[i].rowKey) + 1);
                              }
                          }

                          if (rowKeyArr.length > 0) {
                              alert('[데이터 중복] 이미 등록된 데이터가 존재합니다.' + '\n\n' + '중복 데이터 : ' + rowKeyArr.join(', ') + '번');
                          }

                          return;
                      }

                      for (let i = 0; i < rows.length; i++) {
                          rows[i].status = 'C';
                          rows[i].year = Number(rows[i].year) + 1;
                          rows[i].projNm = $('#projNm').val();
                          rows[i].projCd = $('#projCd').val();
                          rows[i].depaCd = '${LoginInfo.depaCd}';
                          rows[i].depaNm = '${LoginInfo.depaNm}';
                          rows[i].serviceDivi = 'Y';
                          rows[i].carryOverIndex = rows[i].index;
                          if (rows[i].year - 1 >= thisYear) {
                              alert('전년도 데이터만 이월이 가능합니다.');
                              return;
                          }
                          if (rows[0].projNm === '') {
                              alert('프로젝트 데이터를 연동해 주세요.');
                              return;
                          }
                          if (rows[i].checkCycle === 'X') {

                              var userSelection = await openCustomDialog();

                              if (userSelection === '취소') {
                                  console.log('취소')
                                  console.log(userSelection)
                                  return; // 사용자가 '취소'를 선택한 경우, 작업 중단
                              } else {
                                  console.log('선택')
                                  console.log(userSelection)
                                  rows[i].checkCycle = userSelection;
                              }
                          }
                      }

                      var formData = new FormData();
                      formData.append("data", JSON.stringify(rows));

                      if (rows.length > 0) {
                          $.ajax({
                              url: "/siteView/cudSite",
                              type: "POST",
                              data: formData,
                              async: false,
                              enctype: 'multipart/form-data',
                              processData: false,
                              contentType: false,
                              cache: false,
                              success: async function (result) {

                                  var checkParam = [];
                                  for (const row of rows){
                                      let data = {};
                                      data.corpCd = '${LoginInfo.corpCd}';
                                      data.busiCd = "${LoginInfo.busiCd}";
                                      data.index = row.index;
                                      data.carryOverDivi = 'Y';
                                      checkParam.push(data);
                                  }
                                  await edsUtil.getAjax2("/siteView/insertCarryOverDivi", checkParam);

                                  await Swal.fire({
                                      icon: 'success',
                                      title: '성공',
                                      text: '데이터 이월이 완료되었습니다.'
                                  });

                                  await edsIframe.closePopup(param);

                                  if (!result.sess && typeof result.sess != "undefined") {
                                      alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                                      return;
                                  }

                                  if (result.IO.Result == 0 || result.IO.Result == 1) {
                                      Swal.fire({
                                          icon: 'success',
                                          title: '성공',
                                          text: result.IO.Message,
                                      });
                                  } else {
                                      Swal.fire({
                                          icon: 'error',
                                          title: '실패',
                                          text: result.IO.Message,
                                      });
                                  }
                              },
                          })
                      }
                      break;
              }
          }
      }

      async function popupHandler(name, divi, callback) {
          console.log('popupHandler 실행')
          // var row = systemGridList.getFocusedCell();
          var names = name.split('_');
          console.log('names')
          console.log(names)
          console.log('names')
          switch (names[0]) {
              case 'proj':
                  if (divi === 'open') {
                      var param = {}
                      param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
                      <%--param.busiCd = '<c:out value="${LoginInfo.busiCd}"/>';--%>
                      param.depaCd = '${LoginInfo.depaCd}';
                      param.name = name;
                      param.from = 'ims';
                      param.projDivi = '02';
                      await edsIframe.openPopup('PROJPOPUP', param);
                  } else {
                      if (callback.rows === undefined) return;
                      // document.querySelector('div[id="modalCart"] input[id="projCd"]').value = callback.rows[0].projCd;
                      // document.querySelector('div[id="modalCart"] input[id="projNm"]').value = callback.rows[0].projNm;
                      $('input[name="projNm"]').val(callback.rows[0].projNm)
                      $('input[name="projCd"]').val(callback.rows[0].projCd)
                      // $('#projNm').val(callback.rows[0].projNm);
                      // $('#projCd').val(callback.rows[0].projCd);
                      // console.log($('#projNm').val())
                      // console.log($('#projCd').val())
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

      /**********************************************************************
       * 화면 팝업 이벤트 영역 END
       ***********************************************************************/

      /**********************************************************************
       * 화면 함수 영역 START
       ***********************************************************************/
      function yyyymmdd(dateIn) {
          var yyyy = dateIn.getFullYear()
          var mm = dateIn.getMonth() + 1 // getMonth() is zero-based
          var dd = dateIn.getDate()
          return String(yyyy + '-' + ('00' + mm).slice(-2) + '-' + ('00' + dd).slice(-2));
      }

      // 이중 for문 사용시
      // function isDuplicate(existingData, rows) {
      //     // 중복 여부를 확인할 함수
      //     function areObjectsEqual(obj1, obj2) {
      //         // 여기에서는 비교에 필요한 속성을 추가하거나 수정하세요
      //         return obj1.siteNm === obj2.siteNm && obj1.clasifyDivi === obj2.clasifyDivi && obj1.modelDivi === obj2.modelDivi
      //     }
      //     // existingData의 각 요소를 기준으로 중복 여부 확인
      //     for (let i = 0; i < existingData.length; i++) {
      //         for (let j = 0; j < rows.length; j++) {
      //             if (areObjectsEqual(existingData[i], rows[j])) {
      //                 // 중복된 데이터가 존재할 경우
      //                 return true;
      //             }
      //         }
      //     }
      //     // 중복된 데이터가 없을 경우
      //     return false;
      // }

      // 해시테이블 사용시
      function isDuplicate(existingData, rows) {
          const existingHash = {};

          for (let i = 0; i < existingData.length; i++) {
              const key = getKey(existingData[i]);
              existingHash[key] = true;
          }

          for (let j = 0; j < rows.length; j++) {
              const key = getKey(rows[j]);
              if (existingHash[key]) {
                  // 중복된 데이터가 존재할 경우
                  return true;
              }
          }

          // 중복된 데이터가 없을 경우
          return false;
      }

      function getKey(obj) {

          const siteNm = obj.siteNm || '';
          const clasifyDivi = obj.clasifyDivi || '';
          const modelDivi = obj.modelDivi || '';

          return `\${siteNm}-\${clasifyDivi}-\${modelDivi}`;
      }

      async function openCustomDialog() {
          return new Promise(resolve => {
              var dialogHTML = '<div id="custom-dialog" title="점검주기를 선택해 주세요">' +
                  '<button id="btnMonth" class="btn btn-primary">월</button>' +
                  '<button id="btnQuarter" class="btn btn-primary">분기</button>' +
                  '<button id="btnCancel" class="btn btn-danger">취소</button>' +
                  '</div>';

              $("body").append(dialogHTML);

              $("#btnMonth").on('click', function () {
                  $("#custom-dialog").dialog('close');
                  resolve('월');
              });

              $("#btnQuarter").on('click', function () {
                  $("#custom-dialog").dialog('close');
                  resolve('분기');
              });

              $("#btnCancel").on('click', function () {
                  $("#custom-dialog").dialog('close');
                  resolve('취소');
              });

              $("#custom-dialog").dialog({
                  autoOpen: true,
                  modal: true,
                  closeOnEscape: false,
                  draggable: false,
                  resizable: false,
                  open: function (event, ui) {
                      $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
                  },
                  close: function (event, ui) {
                      $("#custom-dialog").dialog('destroy').remove();
                  }
              });
          });
      }      /**********************************************************************
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
            <!-- ./input hidden -->
            <div class="form-group" style="margin-left: 20px"></div>
            <div class="form-group">
              <label for="yearSearch">연도 &nbsp;</label>
              <div class="input-group input-group-sm">
                <input type="text" class="form-control" style="width: 60px; font-size: 15px; text-align: center"
                       name="year"
                       id="yearSearch"
                       title="연도">
              </div>
              <div class="form-group" style="margin-left: 5rem"></div>

              <label for="siteNm">사이트명 &nbsp;</label>
              <div class="input-group input-group-sm">
                <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="siteNm" id="siteNm"
                       title="사이트명">
              </div>
              <div class="form-group" style="margin-left: 5rem"></div>
              <label for="siteNm">지자체 &nbsp;</label>
              <select class="form-control selectpicker" style="width: 150px;" name="ad" id="ad"></select>
              <div class="form-group" style="margin-left: 2.5rem"></div>
              <div id="projContainer" style="display: flex">
                <label for="projNm">프로젝트 &nbsp;</label>
                <input readonly type="text" placeholder="프로젝트 찾기(Click)" class="form-control" id="projNm" name="projNm"
                       onclick="popupHandler('proj','open')" style="width: 25rem">
                <input disabled type="text" hidden="hidden" id="projCd" name="projCd">
              </div>
            </div>
            <div style="display: none">
              <div class="form-group" style="margin-left: 50px"></div>
              <div class="form-group">
                <label for="from">from &nbsp;</label>
                <div class="input-group input-group-sm">
                  <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="from"
                         id="from" title="from">
                </div>
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
          <i class="fa fa-file-text-o"></i> 사이트 목록
        </div>
        <div class="btn-group float-right">
          <%--          <button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>--%>
          <button type="button" class="btn btn-sm btn-primary" id="btnApply"
                  onclick="doAction('baseGridList', 'apply')"><i class="fa fa-save"></i> 선택
          </button>
          <button type="button" class="btn btn-sm btn-primary" id="btnClose"
                  onclick="doAction('baseGridList', 'close')"><i class="fa fa-close"></i> 닫기
          </button>
          <button type="button" class="btn btn-sm btn-danger" id="btnCarryOver"
                  onclick="doAction('baseGridList', 'carryOver')" style="margin-left: 0.5rem"><i
                  class="fa-solid fa-file-import"></i> 데이터 이월
          </button>
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
