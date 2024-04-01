<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>

<!DOCTYPE html>
<html>
<head>
  <title>Site</title>
</head>
<%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
<%-- 공통헤드 --%>
<%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
<%-- 공통 스타일시트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
<%-- 공통 스크립트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf" %>
<%-- tui grid --%>
<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

<link rel="stylesheet" href="/ims/site/site.css">

<link rel="stylesheet" href="/tui/tui-pagination/dist/tui-pagination.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">

<link rel="stylesheet" href="/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css"/>

<link rel="stylesheet" href="/css/edms/edms.css">
<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>
<script type="text/javascript" src='/js/com/eds.edms.js'></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js">
</script>
<%--<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">--%>

<%--다음(카카오) 주소찾기 api--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://kit.fontawesome.com/4ac0e9170f.js" crossorigin="anonymous"></script>
<script src="/js/util/eds.ims.js"></script>
<body class="body">
<div style="height: inherit">
  <div style="background-color: #ebe9e4; padding: unset">
    <div style="background-color: #faf9f5;border: 1px solid #dedcd7;">
      <script>
          var mainSheet, siteGridFile, siteGridMemo;
          let dropzone;
          let updateDropzone;
          let dropzoneRemoveArr = new Array;
          Dropzone.autoDiscover = false;//dropzone 정의
          var selectpicker, selectpickerAd, selectpickerAdND;
          var cellData;
          $(document).ready(async function () {
              // $('.modal').css('overflow-y', 'hidden');
              if ('${LoginInfo.depaNm}' === '사회재난팀') {
                  $('#createBtn').attr('id', 'btnSave');
                  $('#updateBtn').attr('id', 'btnSaveUpdate');
              } else if ('${LoginInfo.depaNm}' === '자연재난1팀' || '${LoginInfo.depaNm}' === '자연재난2팀' || '${LoginInfo.empCd}' === '0007') {
                  $('#createBtn').attr('id', 'btnSaveND');
                  $('#updateBtn').attr('id', 'btnSaveUpdateND');
              } else {
                  $('#createBtn').addClass('hide');
                  $('#updateBtn').addClass('hide');
                  $('#confirmDelete').addClass('hide');
              }

              dropZoneEvent();
              dropZoneUpdateEvent();
              setBtn();
              resetModalForm();
              await init();

              //	이벤트

              imsUtil.focusSearch('siteNmSearch');

              $('form input').on('keydown', function (e) {
                  if (e.which == 13) {
                      e.preventDefault();
                      doAction("mainSheet", "search");
                  }
              });

              $(".selectpicker").on('change', async ev => {
                  var id = ev.target.id;
                  switch (id) {
                      case 'adSearch':
                          await doAction('mainSheet', 'search');
                  }
              });

              $(document).on('shown.bs.modal', function (e) {
                  $('input').attr('autocomplete', 'off');
                  $(this).find('[autofocus]').focus();
              });

              document.getElementById('myTab').addEventListener('click', async (ev) => {
                  var id = ev.target.id;
                  var tagName = ev.target.tagName;
                  if (tagName === "A") {
                      switch (id) {
                          case "file-tab":
                              setTimeout(async () => {
                                  await doAction('siteGridFile', 'search');
                              }, 200);
                              $('#memoInput, #memoDelete').css('display', 'none');
                              $('#fileInput, #fileDelete').css('display', 'inline-block');
                              break;
                          case "memo-tab":
                              setTimeout(async () => {
                                  await doAction('siteGridMemo', 'search');
                              }, 200);
                              $('#fileInput, #fileDelete').css('display', 'none');
                              $('#memoInput, #memoDelete').css('display', 'inline-block');
                              break;
                      }
                  }
              });

              document.getElementById('files').addEventListener('change', async (ev) => {

                  // file 가져오기
                  var file = $('#files'); // input type file tag

                  // formData 생성
                  var clonFile = file.clone();

                  var newForm = $('<form></form>');
                  newForm.attr("method", "post");
                  newForm.attr("enctype", "multipart/form-data");
                  newForm.append(clonFile);

                  // 추가적 데이터 입력
                  /* 저장시 필요한 파라미터*/
                  var formData = new FormData(newForm[0]);
                  var row = mainSheet.getFocusedCell();
                  formData.append("siteIndex", mainSheet.getValue(row.rowKey, 'index'));

                  $.ajax({
                      url: "/siteView/insertSiteFileList",
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
                          if (status === 'success') {
                              await doAction('siteGridFile', 'search');
                              Swal.fire({
                                  icon: 'success',
                                  title: '성공',
                                  text: note,
                                  footer: exc
                              })
                          } else {
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

          async function init() {
              $('[data-mask]').inputmask();

              jQuery.validator.addMethod("latitudeCheck", function (value, element) {
                  value = parseInt(value);
                  return this.optional(element) || (value >= 33 && value <= 38);
              }, "33 이상 38 이하만 입력 가능합니다.");
              jQuery.validator.addMethod("longitudeCheck", function (value, element) {
                  value = parseInt(value);
                  return this.optional(element) || (value >= 124 && value <= 131);
              }, "124 이상 131 이하만 입력 가능합니다.");

              var param = {};
              param.corpCd = ${LoginInfo.corpCd};
              if ('${LoginInfo.empCd}' === '0007') {
                  param.depaCd = '1009';
              } else {
                  param.depaCd = '${LoginInfo.depaCd}';
              }
              param.busiCd = "${LoginInfo.busiCd}"
              param.depaNm = "${LoginInfo.depaNm}";
              param.empNm = "${LoginInfo.empNm}";
              // param.year = new Date().getFullYear();

              edsUtil.setForm(document.querySelector("#searchForm"), "basma");
              edsUtil.setForm(document.querySelector("#modalForm"), "basma");
              edsUtil.setForm(document.querySelector("#modalFormND"), "basma");
              edsUtil.setForm(document.querySelector("#updateForm"), "basma");
              edsUtil.setForm(document.querySelector("#updateFormND"), "basma");

              // searchForm "연도" 이번연도 값으로 적용
              var thisYear = new Date().getFullYear();
              $('#yearSearch').val(thisYear);
              param.year = $('#yearSearch').val();

              mainSheet = new tui.Grid({
                  el: document.getElementById('grid'),
                  scrollX: false,
                  scrollY: false,
                  editingEvent: 'click',
                  bodyHeight: 600,
                  rowHeight: 30,
                  minRowHeight: 30,
                  // rowHeaders: ['rowNum', 'checkbox'], // 체크박스 기능
                  // rowHeaders: ['checkbox'], // 체크박스 기능
                  rowHeaders: ['rowNum'], //
                  header: {
                      height: 35,
                      minRowHeight: 35
                  },
                  pageOptions: {
                      useClient: true,
                      perPage: 20
                  },
                  columns: [],
                  columnOptions: {
                      resizable: true,
                  },
                  summary: {
                      height: 40,
                      position: 'bottom',
                      columnContent: {
                          address: {
                              template(valueMap) {
                                  // 필터링된 데이터 가져오기
                                  var filteredData = mainSheet.getFilteredData();

                                  // 부서별 카운트 초기화
                                  var teamOneCnt = 0;
                                  var teamTwoCnt = 0;
                                  var teamSocialCnt = 0;

                                  // 필터링된 데이터에서 각 부서별로 카운트
                                  for (var i = 0; i < filteredData.length; i++) {
                                      if (filteredData[i].depaCd === '1008') {
                                          teamOneCnt += 1;
                                      } else if (filteredData[i].depaCd === '1009') {
                                          teamTwoCnt += 1;
                                      } else if (filteredData[i].depaCd === '1012') {
                                          teamSocialCnt += 1;
                                      }
                                  }

                                  return '1팀(' + teamOneCnt + ')' + '&nbsp;/&nbsp;' + '2팀(' + teamTwoCnt + ')' + '&nbsp;/&nbsp;' + '사회(' + teamSocialCnt + ')';
                              },
                          },
                      }
                  }
              });

              mainSheet.setColumns([
                  {
                      header: '인덱스',
                      name: 'index',
                      width: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '회사코드',
                      name: 'corpCd',
                      width: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '부서명',
                      name: 'depaNm',
                      width: 80,
                      align: 'center',
                      filter: 'select',
                      showClearBtn: true,
                  },
                  {
                      header: '지자체',
                      name: 'ad',
                      width: 60,
                      align: 'center',
                      filter: 'select',
                      editor: {type: 'select', options: {listItems: setCommCode("SYS010")}},
                      formatter: 'listItemText',
                  },
                  {
                      header: '주소',
                      name: 'address',
                      minWidth: 100,
                      align: 'center',
                      filter: {
                          type: 'text',
                          showClearBtn: true
                      }
                  },
                  {
                      header: '구분',
                      name: 'clasifyDivi',
                      width: 80,
                      align: 'center',
                      filter: 'select',
                      editor: {type: 'select', options: {listItems: setCommCode("SYS012")}},
                      formatter: 'listItemText',
                  },
                  {
                      header: '사이트명',
                      name: 'siteNm',
                      width: 150,
                      align: 'center',
                      className: 'highlight-cell',
                      filter: {
                          type: 'text',
                          showClearBtn: true
                      }
                  },
                  {
                      header: '이중화',
                      name: 'dualSt',
                      width: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '모델',
                      name: 'modelDivi',
                      width: 100,
                      align: 'center',
                      filter: 'select',
                      editor: {type: 'select', options: {listItems: setCommCode("SYS013")}},
                      formatter: 'listItemText',
                  },
                  {
                      header: '설치년월',
                      name: 'installDt',
                      width: 80,
                      align: 'center',
                      filter: {
                          type: 'date',
                          options: {
                              format: 'yyyy-MM-dd'
                          },
                          showClearBtn: true,
                      },
                      formatter({value}) {
                          if (value === '') {
                              return '';
                          } else {
                              return yyyymmdd(new Date(value));
                          }
                      }
                  },
                  {
                      header: '제조사',
                      name: 'maker',
                      width: 80,
                      align: 'center',
                      filter: {
                          type: 'text',
                          showClearBtn: true
                      }
                  },
                  {
                      header: '모델명',
                      name: 'modelNm',
                      width: 140,
                      align: 'center',
                      filter: {
                          type: 'text',
                          showClearBtn: true
                      }
                  },
                  {
                      header: '설치유형',
                      name: 'installDivi',
                      minWidth: 60,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '스피커',
                      name: 'speakerSt',
                      minWidth: 60,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '가청거리',
                      name: 'speakerDx',
                      minWidth: 60,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '위성타입',
                      name: 'satellightDivi',
                      minWidth: 60,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '위성아이디',
                      name: 'satellightId',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '통신분류',
                      name: 'commDivi',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '9.6k통신',
                      name: 'comm9k',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: 'TD통신',
                      name: 'commTD',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '전화번호',
                      name: 'telNo',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: 'ip주소',
                      name: 'ipAdr',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: 'MCU버전',
                      name: 'mucV',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '배터리설치일자',
                      name: 'batteryDt',
                      width: 110,
                      align: 'center',
                      filter: {
                          type: 'date',
                          options: {
                              format: 'yyyy-MM-dd'
                          },
                          showClearBtn: true,
                      },
                      formatter({value}) {
                          if (value === '') {
                              return '';
                          } else {
                              return yyyymmdd(new Date(value));
                          }
                      }
                  },
                  {
                      header: '작성자',
                      name: 'empNm',
                      width: 60,
                      align: 'center',
                      filter: 'select',
                  },
                  {
                      header: '작성일자',
                      name: 'inpDttm',
                      width: 80,
                      align: 'center',
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
                      header: '수정자',
                      name: 'updId',
                      width: 60,
                      align: 'center',
                      filter: 'select',
                  },
                  {
                      header: '수정일자',
                      name: 'updDttm',
                      width: 80,
                      align: 'center',
                      filter: {
                          type: 'date',
                          options: {
                              format: 'yyyy-MM-dd'
                          },
                          showClearBtn: true,
                      },
                      formatter({value}) {
                          if (value !== null) {
                              return yyyymmdd(new Date(value));
                          }
                      }
                  },
                  {
                      header: '위도',
                      name: 'latitude',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '경도',
                      name: 'longitude',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '유지보수 유무',
                      name: 'serviceDivi',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '망분류',
                      name: 'networkDivi',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '충전방식',
                      name: 'chargeDivi',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '검정일자',
                      name: 'examDt',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '센서',
                      name: 'sensor',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '측정단위',
                      name: 'measureUnit',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '센서 설치일자',
                      name: 'sensorInstallDt',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  },
                  {
                      header: '센서 검정번호',
                      name: 'sensorExamNo',
                      width: 100,
                      minWidth: 100,
                      align: 'center',
                      hidden: true
                  }
              ]);
              mainSheet.disableColumn('ad');
              mainSheet.disableColumn('clasifyDivi');
              mainSheet.disableColumn('modelDivi');
              mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));
              selectpicker = $('.selectpicker').select2({
                  language: 'ko'
              });
              selectpickerAd = $('.selectpickerAd').select2({
                  language: 'ko'
              });
              selectpickerAdND = $('.selectpickerAdND').select2({
                  language: 'ko'
              });
              //등록 > 셀렉트2 전체 옵션 삭제
              $('#ad, #adND option[value=""]').remove();

              // site file grid
              siteGridFile = new tui.Grid({
                  el: document.getElementById('projectGridFileDIV'),
                  scrollX: true,
                  scrollY: true,
                  editingEvent: 'click',
                  bodyHeight: 'fitToParent',
                  rowHeight: 28,
                  minRowHeight: 28,
                  rowHeaders: [/*'rowNum',*/ 'checkbox'],
                  header: {
                      height: 28,
                      minRowHeight: 28,
                  },
                  columns: [],
                  columnOptions: {
                      resizable: true,
                  },
              });

              siteGridFile.setColumns([
                  {header: '파일명', name: 'origNm', width: 300, align: 'left', defaultValue: ''},
                  {
                      header: '다운로드', name: 'fileDownLoad', width: 60, align: 'Center', formatter: function () {
                          return "<i class='fa fa-download'></i>";
                      },
                  },
                  {header: '적요', name: 'remark', minWidth: 150, align: 'left', defaultValue: ''},
                  {header: '입력자', name: 'empNm', width: 80, align: 'center', defaultValue: ''},
                  {header: '수정자', name: 'updNm', width: 80, align: 'center', defaultValue: ''},

                  // hidden(숨김)
                  {header: '회사코드', name: 'corpCd', width: 100, align: 'center', hidden: true},
                  {header: '인덱스', name: 'index', width: 100, align: 'center', hidden: true},
                  {header: '저장명', name: 'saveNm', width: 100, align: 'center', hidden: true},
                  {header: '원본명', name: 'origNm', width: 100, align: 'center', hidden: true},
                  {header: '저장경로', name: 'saveRoot', width: 100, align: 'center', hidden: true},
                  {header: '확장자', name: 'ext', width: 100, align: 'center', hidden: true},
                  {header: '크기', name: 'size', width: 100, align: 'center', hidden: true},
                  {header: '입력일자', name: 'inpDttm', width: 100, align: 'center', hidden: true},
                  {header: '수정일자', name: 'updDttm', width: 100, align: 'center', hidden: true},
              ]);

              siteGridFile.on('focusChange', (ev) => {
                  const {columnName, rowKey} = ev;
                  if (columnName === 'remark') {
                      $('#fileInputModal').modal('show');
                      $('#fileInputArea').val(siteGridFile.getValue(rowKey, columnName));
                      $('#fileInputAreaSave').off().on('click', (e) => {
                          siteGridFile.setValue(rowKey, columnName, $('#fileInputArea').val());
                          $('#fileInputModal').modal('hide');
                          doAction('siteGridFile', 'save');
                          $('.modal').css('overflow-y', 'hidden');
                      })
                  }
              });

              siteGridFile.on('click', async ev => {
                  var colNm = ev.columnName;
                  var target = ev.targetType;
                  var rowKey = ev.rowKey;
                  if (target === 'cell') {
                      if (colNm === 'fileDownLoad') await fileDownload(siteGridFile);
                  }
              });

              // site memo grid
              siteGridMemo = new tui.Grid({
                  el: document.getElementById('siteGridMemoDIV'),
                  scrollX: true,
                  scrollY: true,
                  editingEvent: 'click',
                  bodyHeight: 'fitToParent',
                  rowHeight: 28,
                  minRowHeight: 28,
                  rowHeaders: [/*'rowNum',*/ 'checkbox'],
                  header: {
                      height: 28,
                      minRowHeight: 28,
                  },
                  columns: [],
                  columnOptions: {
                      resizable: true,
                      /*frozenCount: 1,
                      frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
                  },
              });

              siteGridMemo.setColumns([
                  {header: '입력자', name: 'inpId', width: 80, align: 'center'},
                  {
                      header: '입력일자', name: 'inpDttm', width: 140, align: 'center', defaultValue: '', formatter({value}) {
                          if (value !== null) {
                              return yyyymmdd(new Date(value));
                          }
                      }
                  },
                  {header: '메모', name: 'memo', minWidth: 200, align: 'left', defaultValue: '',},
                  {header: '수정자', name: 'updId', width: 80, align: 'center'},
                  {
                      header: '수정일자', name: 'updDttm', width: 140, align: 'center', formatter({value}) {
                          if (value !== null) {
                              return yyyymmdd(new Date(value));
                          }
                      }
                  },
                  // hidden(숨김)
                  {header: '회사코드', name: 'corpCd', width: 100, align: 'center', hidden: true},
                  {header: 'index', name: 'index', width: 100, align: 'center', hidden: true},
              ]);

              siteGridMemo.on('focusChange', (ev) => {
                  const {columnName, rowKey} = ev;
                  if (columnName === 'memo') {
                      $('#memoInputModal').modal('show');
                      $('#memoInputArea').val(siteGridMemo.getValue(rowKey, columnName));
                      $('#memoInputAreaSave').off().on('click', (e) => {
                          siteGridMemo.setValue(rowKey, columnName, $('#memoInputArea').val());
                          doAction('siteGridMemo', 'save');
                          fileInputClose();
                          $('#memoInputModal').modal('hide');
                          siteGridMemo.blur();
                          $('.modal').css('overflow-y', 'hidden');
                      })
                  }
              });

              /**********************************************************************
               * Grid 이벤트 영역 END
               ***********************************************************************/

              // '사이트 등록' 버튼 노출 부서 구분
              if ('${LoginInfo.depaCd}'.includes('1008') || '${LoginInfo.depaCd}'.includes('1009') || '${LoginInfo.depaCd}'.includes('1012') || '${LoginInfo.empCd}' === '0007') {
                  $('#insertPjBtn').css('display', 'block');
              } else {
                  $('#insertPjBtn').css('display', 'none');
              }

              // 등록 버튼 누를시 지자체 text 중 '전체' option text 삭제
              $('#insertPjBtn').on('click', (e) => {
                  var dddddd = document.querySelector('#select2-ad-results');
                  console.log('보자')
                  console.log(dddddd)

                  var dddddd2 = document.querySelector('#select2-ad-container');
                  console.log('보자2')
                  console.log(dddddd2)

                  var dddddd3 = document.querySelector('.select2-dropdown');
                  console.log('보자3')
                  console.log(dddddd3)

                  var dddddd4 = document.querySelector('#ad');
                  console.log('보자4')
                  console.log(dddddd4)


                  $('select[name = serviceDivi]').on('change', (e) => {
                      if (e.currentTarget.value === 'N') {
                          $('select[name = checkCycle]').val('X');
                          $('select[name = checkCycle]').prop('disabled', true);
                      } else {
                          $('select[name = checkCycle]').val('월');
                          $('select[name = checkCycle]').attr('disabled', false);
                      }
                  })
                  const num = 50;
                  $('#modalBodyUpdate').removeClass('show').addClass('hide');
                  $('#modalBody').removeClass('hide').addClass('show');

                  // $('select[name="ad"] option:contains(' + '전체' + ')').remove();
                  // $('select[name="clasifyDivi"] option:contains(' + '전체' + ')').remove();
                  // $('select[name="modelDivi"] option:contains(' + '전체' + ')').remove();

                  $('.select-container').find('option').map(function () {
                      return $(this).removeClass('hide');
                  })

                  if ('${LoginInfo.depaNm}' === '사회재난팀') {
                      $('#modalForm').removeClass('hide').addClass('show');
                      $('.select-container').find('option').map(function () {
                          if ($(this).val() < num) {
                              return $(this).remove();
                          }
                      })

                      $('label[for="tab-2"]').css('display', 'none');
                      $('#tab-2').attr("checked", false);
                      $('#tab-1').prop('checked', true);

                      // $('#tab-1').attr("checked", true);
                      $('label[for="tab-1"]').css('display', 'inline-block');
                  } else if ('${LoginInfo.depaNm}' === '자연재난1팀' || '${LoginInfo.depaNm}' === '자연재난2팀' || '${LoginInfo.empCd}' === '0007') {
                      $('#modalFormND').removeClass('hide').addClass('show');
                      $('.select-container').find('option').map(function () {
                          if ($(this).val() > num) {
                              return $(this).remove();
                          }
                      })
                      $('label[for="tab-1"]').css('display', 'none');
                      $('#tab-1').attr("checked", false);
                      $('#tab-2').prop("checked", true);
                      $('label[for="tab-2"]').css('display', 'inline-block');
                  }


              })

              /*******************************************************
               사이트 저장, 생성 / create site (사회재난)
               *******************************************************/
              $('#btnSave').on('click', (e) => {
                  validate($('#modalForm'));
                  if (!$('#modalForm').valid()) {
                      return;
                  }

                  var param = ut.serializeObject(document.querySelector("#modalForm"));
                  param.status = 'C';
                  param.corpCd = ${LoginInfo.corpCd};
                  param.depaCd = ${LoginInfo.depaCd};
                  param.busiCd = "${LoginInfo.busiCd}"
                  param.depaNm = "${LoginInfo.depaNm}";
                  param.empNm = "${LoginInfo.empNm}";

                  param.latitude = getValueById('latitude');
                  param.longitude = getValueById('longitude');

                  var year;
                  var projCdLength = 5;
                  if (param.projCd.length === projCdLength) {
                      year = '20' + param.projCd.substring(0, 2);
                  } else if (param.projCd.length >= projCdLength + 1) {
                      year = param.projCd.substring(0, 4);
                  } else {
                      alert('프로젝트 코드 오류. 개발팀에 문의해 주세요.');
                  }

                  if (thisYear == year || thisYear > year) {
                      param.year = String(thisYear);
                  }

                  var newFiles = dropzone.getAcceptedFiles();
                  var formData = new FormData();
                  const params = [param];
                  for (let index in newFiles) {
                      formData.append('file', newFiles[index]);
                  }

                  formData.append("data", JSON.stringify(params));

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
                          $('#exampleModal').modal('hide');
                          await doAction('mainSheet', 'search');
                          // mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));

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
              })
              /*******************************************************
               사이트 저장, 생성 / create site (자연재난)
               *******************************************************/
              $('#btnSaveND').on('click', (e) => {
                  validate($('#modalFormND'));
                  if (!$('#modalFormND').valid()) {
                      return;
                  }

                  var param = ut.serializeObject(document.querySelector("#modalFormND"));

                  param.status = 'C';
                  param.corpCd = ${LoginInfo.corpCd};
                  param.busiCd = "${LoginInfo.busiCd}"
                  if ('${LoginInfo.empCd}' === '0007') {
                      param.depaCd = '1009';
                      param.depaNm = "자연재난2팀";
                  }else {
                      param.depaCd = '${LoginInfo.depaCd}';
                      param.depaNm = "${LoginInfo.depaNm}";
                  }
                  param.empNm = "${LoginInfo.empNm}";
                  param.latitude = getValueById('latitudeND');
                  param.longitude = getValueById('longitudeND');

                  var year;
                  var projCdLength = 5;
                  if (param.projCd.length === projCdLength) {
                      year = '20' + param.projCd.substring(0, 2);
                  } else if (param.projCd.length >= projCdLength + 1) {
                      year = param.projCd.substring(0, 4);
                  } else {
                      alert('프로젝트 코드 오류. 개발팀에 문의해 주세요.');
                  }

                  if (thisYear == year || thisYear > year) {
                      param.year = String(thisYear);
                  }

                  var newFiles = dropzone.getAcceptedFiles();
                  var formData = new FormData();
                  const params = [param];
                  for (let index in newFiles) {
                      formData.append('file', newFiles[index]);
                  }

                  formData.append("data", JSON.stringify(params));

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
                          $('#exampleModal').modal('hide');
                          await doAction('mainSheet', 'search');
                          // mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));

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
              })


              /*******************************************************
               사이트 수정 Modal 호출
               *******************************************************/
              mainSheet.on('click', async (e) => {
                  const num = 50;
                  if (e.targetType === 'cell') {
                      $('#modalBody').removeClass('show').addClass('hide')
                      $('#modalBodyUpdate').removeClass('hide').addClass('show')
                      $('#exampleModal').modal('show');

                      $('select:not(#adSearch)[name="ad"] option:contains(' + '전체' + ')').remove();
                      // $('select[name="clasifyDivi"] option:contains(' + '전체' + ')').remove();
                      // $('select[name="modelDivi"] option:contains(' + '전체' + ')').remove();

                      $('.select-container').find('option').map(function () {
                          return $(this).removeClass('hide');
                      })

                      $('select[name = serviceDivi]').on('change', (e) => {
                          if (e.currentTarget.value === 'N') {
                              $('select[name = checkCycle]').val('X');
                              $('select[name = checkCycle]').prop('disabled', true);
                          } else {
                              $('select[name = checkCycle]').val('월');
                              $('select[name = checkCycle]').attr('disabled', false);
                          }
                      })

                      cellData = mainSheet.getData()[e.rowKey];
                      $('#siteIndex').val(cellData.index);
                      $('#carryOverIndex').val(cellData.carryOverIndex);
                      param.siteIndex = $('#siteIndex').val();
                      var test = edsUtil.getAjax("/siteView/selectSiteImageList", param);
                      for (file of test) {
                          const corpCd = file.corpCd;//회사코드
                          const saveNm = file.saveNm;//저장명
                          const ext = file.ext;//확장자
                          const params = corpCd + "," + saveNm + "," + ext;
                          let mockFile = {
                              index: file.index,
                              name: file.origNm + "." + file.ext,
                              size: file.size,
                              saveRoot: file.saveRoot
                          };
                          updateDropzone.displayExistingFile(mockFile, "/siteView/siteImageload/" + params);
                      }

                      // 이미지 확대 modal 호출
                      $(document).ready(() => {
                          var img = document.getElementsByTagName('img')
                          var imgToArr = Array.from(img);
                          var imageUrl = [];
                          for (let i = 0; i < imgToArr.length; i++) {
                              imgToArr[i].onclick = () => {
                                  imageUrl[i] = test[i].saveNm + '.' + test[i].ext;
                                  $('#expandModal').modal('show');
                                  $('#expandImage').attr('src', '/file/' + '1001/' + 'ims/' + '0001/' + 'images/' + imageUrl[i]);
                              }
                          }
                      })

                      if ($('#file-tab')[0].className.includes('active')) {
                          $('#memoInput, #memoDelete').css('display', 'none');
                          $('#fileInput, #fileDelete').css('display', 'inline-block');
                      }

                      setTimeout(() => {
                          doAction('siteGridFile', 'search');
                          doAction('siteGridMemo', 'search');
                      }, 200);

                      if (cellData.depaNm.includes('사회')) {
                          $('.select-container').find('option').map(function () {
                              if ($(this).val() < num) {
                                  // return $(this).remove();
                                  return $(this).addClass('hide');
                              }
                          })
                          $('#updateForm').removeClass('hide').addClass('show')
                          $('#updateFormND').removeClass('show').addClass('hide')

                          $('label[for="tab-2-update"]').css('display', 'none');
                          $('#tab-2-update').prop("checked", false);
                          $('#tab-1-update').prop("checked", true);
                          $('label[for="tab-1-update"]').css('display', 'inline-block');
                          if (cellData.depaNm !== '${LoginInfo.depaNm}') {
                              $('.btnSaveUpdate').css('display', 'none');
                              $('.btnDeleteUpdate').css('display', 'none');
                          } else {
                              $('.btnSaveUpdate').css('display', 'inline-block');
                              $('.btnDeleteUpdate').css('display', 'inline-block');
                          }

                          param.index = cellData.index;
                          var siteData = edsUtil.getAjax("/siteView/selectSiteByIndex", param);
                          var data = {}
                          data.data = siteData[0]
                          data.form = document.getElementById('updateForm');
                          var dataToForm = await edsUtil.eds_dataToForm(data);
                      }

                      if (cellData.depaNm.includes('자연')) {
                          $('.select-container').find('option').map(function () {
                              if ($(this).val() > num) {
                                  // return $(this).remove();
                                  return $(this).addClass('hide');
                              }
                          })
                          $('#updateForm').removeClass('show').addClass('hide')
                          $('#updateFormND').removeClass('hide').addClass('show')

                          $('label[for="tab-1-update"]').css('display', 'none');
                          $('#tab-1-update').prop("checked", false);
                          $('#tab-2-update').prop("checked", true);
                          $('label[for="tab-2-update"]').css('display', 'inline-block');

                          if ('${LoginInfo.depaCd}' === '1008' || '${LoginInfo.depaCd}' === '1009' || '${LoginInfo.empCd}' === '0007') {
                              $('.btnSaveUpdate').css('display', 'inline-block');
                              $('.btnDeleteUpdate').css('display', 'inline-block');
                          } else {
                              $('.btnSaveUpdate').css('display', 'none');
                              $('.btnDeleteUpdate').css('display', 'none');
                          }

                          <%--if (cellData.depaNm !== '${LoginInfo.depaNm}') {--%>
                          <%--    $('.btnSaveUpdate').css('display', 'none');--%>
                          <%--    $('.btnDeleteUpdate').css('display', 'none');--%>
                          <%--} else {--%>
                          <%--    $('.btnSaveUpdate').css('display', 'inline-block');--%>
                          <%--    $('.btnDeleteUpdate').css('display', 'inline-block');--%>
                          <%--}--%>

                          param.index = cellData.index;
                          var siteData = edsUtil.getAjax("/siteView/selectSiteByIndex", param);

                          var data = {}
                          data.data = siteData[0]
                          data.form = document.getElementById('updateFormND');

                          var dataToForm = await edsUtil.eds_dataToForm(data);
                      }
                  }

              })

              /*******************************************************
               사이트 수정(사회재난) / update site
               *******************************************************/
              $('#btnSaveUpdate').on('click', (e) => {
                  validate($('#updateForm'));
                  if (!$('#updateForm').valid()) {
                      return;
                  }

                  var param = ut.serializeObject(document.querySelector("#updateForm"));
                  param.status = 'U';
                  param.index = $('#siteIndex').val();
                  param.siteIndex = $('#siteIndex').val();
                  param.corpCd = ${LoginInfo.corpCd};
                  param.depaCd = '${LoginInfo.depaCd}';
                  param.busiCd = "${LoginInfo.busiCd}"
                  param.depaNm = "${LoginInfo.depaNm}";
                  param.updId = "${LoginInfo.empNm}";
                  param.latitude = getValueById('latitudeUpdate');
                  param.longitude = getValueById('longitudeUpdate');
                  if (param.checkCycle === cellData.checkCycle) {
                      param.updateFlag = 'true';
                  }
                  var newFiles = updateDropzone.getAcceptedFiles();

                  var formData = new FormData();
                  const params = [param];
                  for (let index in newFiles) {
                      formData.append('file', newFiles[index]);
                  }
                  formData.append("data", JSON.stringify(params));
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
                          $('#exampleModal').modal('hide');
                          var paramData = [];

                          for (const files of dropzoneRemoveArr) {
                              let data = {};
                              data.saveRoot = files.saveRoot;
                              data.index = files.index;
                              data.siteIndex = $('#siteIndex').val();
                              data.corpCd =${LoginInfo.corpCd};
                              data.busiCd = "${LoginInfo.busiCd}";
                              paramData.push(data);
                          }
                          if (paramData.length > 0) await edsUtil.getAjax2("/siteView/siteImageDelete", paramData)
                          dropzoneRemoveArr = [];
                          updateDropzone.removeAllFiles();

                          await doAction('mainSheet', 'search2');
                          // mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));
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
              })

              /*******************************************************
               사이트 수정(자연재난) / update site
               *******************************************************/
              $('#btnSaveUpdateND').on('click', (e) => {
                  validate($('#updateFormND'));
                  if (!$('#updateFormND').valid()) {
                      return;
                  }

                  var param = ut.serializeObject(document.querySelector("#updateFormND"));
                  param.status = 'U';
                  param.index = $('#siteIndex').val();
                  param.siteIndex = $('#siteIndex').val();
                  param.corpCd = ${LoginInfo.corpCd};
                  param.busiCd = "${LoginInfo.busiCd}"
                  if ('${LoginInfo.empCd}' === '0007') {
                      param.depaCd = '1009';
                      param.depaNm = "자연재난2팀";
                  } else {
                      param.depaCd = '${LoginInfo.depaCd}';
                      param.depaNm = "${LoginInfo.depaNm}";
                  }
                  param.updId = "${LoginInfo.empNm}";
                  param.latitude = getValueById('latitudeNDUpdate');
                  param.longitude = getValueById('longitudeNDUpdate');

                  if (param.checkCycle === cellData.checkCycle && param.depaCd === cellData.depaCd) {
                      param.updateFlag = 'true';
                  }

                  var newFiles = updateDropzone.getAcceptedFiles();

                  var formData = new FormData();
                  const params = [param];
                  for (let index in newFiles) {
                      formData.append('file', newFiles[index]);
                  }
                  formData.append("data", JSON.stringify(params));

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
                          $('#exampleModal').modal('hide');
                          var paramData = [];
                          for (const files of dropzoneRemoveArr) {
                              let data = {};
                              data.saveRoot = files.saveRoot;
                              data.index = files.index;
                              data.siteIndex = $('#siteIndex').val();
                              data.corpCd =${LoginInfo.corpCd};
                              data.busiCd = "${LoginInfo.busiCd}";
                              paramData.push(data);
                          }
                          if (paramData.length > 0) await edsUtil.getAjax2("/siteView/siteImageDelete", paramData)

                          dropzoneRemoveArr = [];
                          updateDropzone.removeAllFiles();
                          await doAction('mainSheet', 'search2');
                          // mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));
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
              })

              /*******************************************************
               사이트 삭제 / delte site
               *******************************************************/
              $('#deleteBtn').on('click', (e) => {
                  var param = {};
                  param.corpCd = ${LoginInfo.corpCd};
                  param.siteIndex = $('#siteIndex').val();

                  var test = edsUtil.getAjax("/siteView/selectSiteImageList", param);

                  param.status = "DA";
                  param.busiCd = "${LoginInfo.busiCd}";
                  param.index = $('#siteIndex').val();
                  param.carryOverIndex = $('#carryOverIndex').val();

                  dropzoneRemoveArr.push(test);

                  var formData = new FormData();
                  const params = [param];
                  formData.append("data", JSON.stringify(params));

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
                          var paramData = [];
                          for (const files of test) {
                              let data = {};
                              data.saveRoot = files.saveRoot;
                              data.siteIndex = $('#siteIndex').val();
                              data.corpCd =${LoginInfo.corpCd};
                              data.busiCd = "${LoginInfo.busiCd}";
                              paramData.push(data);
                          }
                          if (paramData.length > 0) await edsUtil.getAjax2("/siteView/siteImageDeleteAll", paramData);

                          var carryOverDataArr = [];
                          let carryOverData = {};
                          carryOverData.corpCd = '${LoginInfo.corpCd}';
                          carryOverData.carryOverIndex = $('#carryOverIndex').val();
                          carryOverData.carryOverDivi = 'N';
                          carryOverDataArr.push(carryOverData)
                          await edsUtil.getAjax2("/siteView/updateCarryOverDivi", carryOverDataArr);

                          await doAction('siteGridFile', 'deleteAll');
                          await doAction('mainSheet', 'search2');
                          // mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));
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
                      }
                  });
                  $('#exampleModal').modal('hide');
              })
          }

          /*******************************************************
           함수 시작
           *******************************************************/
          // 업로드 안된 행의 다운로드 막기
          function preventClick(e) {
              e.preventDefault()
              toastrmessage("toast-bottom-center"
                  , "warning"
                  , "파일 저장 이후 다운로드 가능합니다.", "실패", 1500);
          }

          /* 화면 이벤트 */
          async function doAction(sheetNm, sAction) {
              if (sheetNm == 'mainSheet') {
                  switch (sAction) {
                      case "search":// 조회
                          var param = ut.serializeObject(document.querySelector("#searchForm"));
                          param.corpCd = '${LoginInfo.corpCd}';
                          if ('${LoginInfo.empCd}' === '0007') {
                              param.depaCd = '1009';
                          } else {
                              param.depaCd = '${LoginInfo.depaCd}';
                          }
                          console.log('1 param')
                          console.log(param)
                          mainSheet.resetData(edsUtil.getAjax("/siteView/selectSite", param));
                          break;
                      case "search2":// 조회
                          var param = ut.serializeObject(document.querySelector("#searchForm"));
                          param.corpCd = '${LoginInfo.corpCd}';
                          if ('${LoginInfo.empCd}' === '0007') {
                              param.depaCd = '1009';
                          } else {
                              param.depaCd = '${LoginInfo.depaCd}';
                          }
                          console.log('2 param')
                          console.log(param)
                          mainSheet.resetData2(edsUtil.getAjax("/siteView/selectSite", param));
                          break;
                  }
              }

              if (sheetNm == 'siteGridFile') {
                  switch (sAction) {
                      case "search":// 조회

                          siteGridFile.refreshLayout(); // 데이터 초기화
                          var row = mainSheet.getFocusedCell();
                          var param = {};
                          param.corpCd = '${LoginInfo.corpCd}';
                          param.empNm = '${LoginInfo.empNm}';
                          param.updNm = '${LoginInfo.empNm}';
                          param.siteIndex = mainSheet.getValue(row.rowKey, 'index');

                          siteGridFile.resetData(edsUtil.getAjax("/siteView/selectSiteFileList", param));

                          if (siteGridFile.getRowCount() > 0) {
                              siteGridFile.focusAt(0, 0, true);
                          }

                          break;

                      case "input":// 신규

                          var row = mainSheet.getFocusedCell();

                          var appendedData = {};
                          appendedData.status = "I";
                          appendedData.corpCd = mainSheet.getValue(row.rowKey, 'corpCd');
                          appendedData.siteIndex = mainSheet.getValue(row.rowKey, 'index');

                          siteGridFile.appendRow(appendedData, {focus: true}); // 마지막 ROW 추가

                          break;
                      case "save"://저장
                          await edsUtil.doCUD("/siteView/udSiteFileList", "siteGridFile", siteGridFile);
                          doAction('siteGridFile', 'search');
                          break;
                      case "delete"://삭제
                          await siteGridFile.removeCheckedRows(true);
                          await edsUtil.doCUD("/siteView/udSiteFileList", "siteGridFile", siteGridFile);
                          break;
                      case "deleteAll"://삭제
                          await edsUtil.doCUD("/siteView/udSiteFileList", "siteGridFile", siteGridFile);
                          break;
                      case "close"://삭제
                          await doAction('mainSheet', 'search');
                          break;
                  }
              } else if (sheetNm == 'siteGridMemo') {
                  switch (sAction) {
                      case "search":// 조회

                          siteGridMemo.refreshLayout(); // 데이터 초기화

                          var row = mainSheet.getFocusedCell();
                          var param = {};
                          param.corpCd = '${LoginInfo.corpCd}';
                          param.siteIndex = mainSheet.getValue(row.rowKey, 'index');

                          siteGridMemo.resetData(edsUtil.getAjax("/siteView/selectSiteMemoList", param));

                          if (siteGridMemo.getRowCount() > 0) {
                              siteGridMemo.focusAt(0, 0, true);
                          }
                          break;

                      case "input":// 신규

                          var row = mainSheet.getFocusedCell();

                          var appendedData = {};
                          appendedData.status = "I";
                          appendedData.corpCd = mainSheet.getValue(row.rowKey, 'corpCd');
                          appendedData.siteIndex = mainSheet.getValue(row.rowKey, 'index');
                          appendedData.inpId = '${LoginInfo.empNm}';

                          siteGridMemo.appendRow(appendedData, {focus: true}); // 마지막 ROW 추가
                          await doAction('siteGridMemo', 'save');

                          break;
                      case "save"://저장
                          await edsUtil.doCUD("/siteView/cudSiteMemoList", "siteGridMemo", siteGridMemo);
                          doAction('siteGridMemo', 'search');
                          break;
                      case "delete"://삭제
                          await siteGridMemo.removeCheckedRows(true);
                          await edsUtil.doCUD("/siteView/cudSiteMemoList", "siteGridMemo", siteGridMemo);
                          break;
                  }
              }
          }

          // form input text 초기화
          function resetModalForm() {
              $('#exampleModal').on('hidden.bs.modal', function (e) {
                  $(this).validate().resetForm();
                  $(this).find('.error').removeClass('error');
                  $('select[name=checkCycle]').removeAttr("disabled")
                  $(this).find('form')[0].reset();
                  $(this).find('form')[1].reset();
                  $(this).find('form')[2].reset();
                  $(this).find('form')[3].reset();

                  dropzone.removeAllFiles(true);
                  dropzoneRemoveArr = [];
                  $('#remark').css('height', 38);
                  $('#remarkUpdate').css('height', 38);
                  $('.dz-image-preview').remove();
                  // $('#updateModal').css('overflow-y', 'hidden');
              });
          }

          // yyyy-mm-dd format
          function yyyymmdd(dateIn) {
              var yyyy = dateIn.getFullYear()
              var mm = dateIn.getMonth() + 1 // getMonth() is zero-based
              var dd = dateIn.getDate()
              return String(yyyy + '-' + ('00' + mm).slice(-2) + '-' + ('00' + dd).slice(-2));
          }

          function findAddr(param) {
              switch (param) {
                  case 'SD':
                      new daum.Postcode({
                          oncomplete: function (data) {
                              var roadAddr = data.roadAddress; // 도로명 주소 변수
                              document.getElementById("address").value = roadAddr;
                          }
                      }).open();
                      break;

                  case 'updateSD':
                      new daum.Postcode({
                          oncomplete: function (data) {
                              var roadAddr = data.roadAddress; // 도로명 주소 변수
                              document.getElementById("addressUpdate").value = roadAddr;
                          }
                      }).open();
                      break;

                  case 'ND':
                      new daum.Postcode({
                          oncomplete: function (data) {
                              var roadAddr = data.roadAddress; // 도로명 주소 변수
                              document.getElementById("addressND").value = roadAddr;
                          }
                      }).open();
                      break;

                  case 'updateND':
                      new daum.Postcode({
                          oncomplete: function (data) {
                              var roadAddr = data.roadAddress; // 도로명 주소 변수
                              document.getElementById("addressNDUpdate").value = roadAddr;
                          }
                      }).open();
                      break;
              }
          }

          function setBtn() {
              $('.modal').on('shown.bs.modal', function () {
                  if ($('#tab-1')[0].checked) {
                      $('#btnSave').css('display', 'inline');
                      $('#btnSaveND').css('display', 'none');
                      $('#modalFormND').css('display', 'none');
                  }

                  if ($('#tab-2')[0].checked) {
                      $('#btnSaveND').css('display', 'inline');
                      $('#btnSave').css('display', 'none');
                      $('#modalForm').css('display', 'none');
                  }
              });

              $('#tab-1').on('click', () => {
                  $('#btnSave').css('display', 'inline');
                  $('#btnSaveND').css('display', 'none');
              })

              $('#tab-2').on('click', () => {
                  $('#btnSaveND').css('display', 'inline');
                  $('#btnSave').css('display', 'none');
              })
          }

          function getAjax2(url, param) {
              var data;
              $.ajax({
                  url: url,
                  headers: {
                      'X-Requested-With': 'XMLHttpRequest'
                  },
                  dataType: "json",
                  contentType: "application/json; charset=UTF-8",
                  type: "POST",
                  async: false,
                  data: JSON.stringify(param),
                  success: function (result) {
                      if (!result.sess && typeof result.sess != "undefined") {
                          alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                          return;
                      }
                      data = result;
                  }
              });
              return data;
          }

          function memoInputClose() {
              $('#memoInputModal').modal('hide');
              $('.modal').css('overflow-y', 'hidden');
              siteGridMemo.blur();
          }

          function fileInputClose() {
              $('#fileInputModal').modal('hide');
              $('.modal').css('overflow-y', 'hidden');
              siteGridFile.blur();
          }

          /* dropzone 이벤트 시작*/
          function dropZoneEvent() {
              var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
              dropzonePreviewNode.id = '';
              var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
              dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

              dropzone = new Dropzone(".dropzone", {
                      url: "/siteView/fileUpload", // 파일을 업로드할 서버 주소 url.
                      method: "post", // 기본 post로 request 감. put으로도 할수있음
                      autoProcessQueue: false,
                      previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                      previewsContainer: '#dropzone-preview',
                      acceptedFiles: "application/pdf,image/*",   //이미지 종류
                      maxFilesize: 100,
                      maxFiles: 4,
                      accept: function (file, done) {
                          done();
                      },
                      init: function () {
                          this.on("maxfilesexceeded", function (file) {
                              alert("이미지는 최대 4개까지 첨부할 수 있습니다.");
                              this.removeFile(file);
                              done();
                          });
                      },
                  }
              )
          }

          /* dropzone 이벤트 끝*/

          function dropZoneUpdateEvent() {
              var uploadCount = 0;
              var dropzonePreviewNode = document.querySelector('#dropzone-preview-update-list');
              dropzonePreviewNode.id = '';
              var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
              dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
              updateDropzone = new Dropzone(".dropzone2", {
                      url: "/siteView/fileUpload", // 파일을 업로드할 서버 주소 url.
                      method: "post", // 기본 post로 request 감. put으로도 할수있음
                      autoProcessQueue: false,
                      previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                      previewsContainer: '#dropzone-update-preview',
                      acceptedFiles: "application/pdf,image/*",   //이미지 종류
                      maxFilesize: 100,
                      accept: function (file, done) {
                          done();
                      },
                      init: function (e) {
                          // 파일이 업로드되면 실행
                          this.on('addedfile', function (file) {
                              $('#exampleModal').on('hidden.bs.modal', function (e) {
                                  uploadCount = 0;
                              })
                              uploadCount += $('#dropzone-update-preview').length;
                              if (uploadCount > 4) {
                                  // this.options.dictMaxFilesExceeded = '이미지는 최대 4개까지 첨부할 수 있습니다.';
                                  alert('이미지는 최대 4개까지 첨부할 수 있습니다.')
                                  this.removeFile(file);
                                  done();
                              }
                          });
                          // 업로드 에러 처리
                          this.on('error', function (file, errorMessage) {
                              this.removeFile(file);
                              alert(errorMessage);
                          });

                          this.on('removedfile', function (file) {
                              uploadCount -= 1;
                              // 저장되어 있는 이미지일때만 추가
                              if (file.status != "queued" && file.status != "added") {
                                  dropzoneRemoveArr.push(file);
                              }
                          });

                          this.on('downloadedFile', async function (file) {
                              if (document.getElementById('siteIndex').value) {
                                  if (file) {
                                      let fileInfo = {};
                                      fileInfo.saveRoot = file.saveRoot;
                                      fileInfo.name = file.name;
                                      $.ajax({
                                          type: 'POST',
                                          url: '/siteView/siteImageDownload',
                                          data: JSON.stringify(fileInfo),
                                          contentType: 'application/json',
                                          xhrFields: {
                                              responseType: 'blob' // Set the response type to 'blob'
                                          },
                                          success: function (data) {
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
                                          error: function (xhr, status, error) {
                                              console.error(error);
                                          }
                                      });
                                  }
                              }
                          });
                      },
                  }
              );
          }

          async function fileDownload(sheetObj) {
              const menu1 = window.parent.document.querySelectorAll('.nav-sidebar>.nav-item>.nav-link.active')[0].children[1].innerText;
              const menu2 = window.parent.document.querySelectorAll('.nav-treeview>.nav-item>.nav-link.active')[0].children[0].innerText;
              const menu = menu1 + ' > ' + menu2;
              const row = sheetObj.getRow(sheetObj.getFocusedCell().rowKey);
              // var params = row.saveRoot.replaceAll("/","'").replaceAll("\\","'")
              var params = row.origNm + ':' + row.ext + ':' + row.saveRoot.replaceAll("/", "'").replaceAll("\\", "'") + ':' + menu;

              const a = document.createElement("a");
              const url = '/fileDownLoad/' + params;
              a.setAttribute('href', url);
              a.setAttribute('download', row.origNm + '.' + row.ext);
              document.body.appendChild(a);
              a.click();
              window.URL.revokeObjectURL(url)
              a.remove();
          }

          function validate(form) {
              form.validate({
                  rules: {
                      siteNm: {
                          required: true
                      },
                      ad: {
                          required: true
                      },
                      projNm: {
                          required: function () {
                              if ($('select[name=serviceDivi]').val() === 'Y') {
                                  return true;
                              } else {
                                  return false;
                              }
                          },
                      },
                      latitude: {
                          required: function () {
                              var longitude = document.getElementsByName('longitude');
                              var hasNonEmptyValue = false;

                              for (var i = 0; i < longitude.length; i++) {
                                  var value = longitude[i].value;

                                  if (value !== '') {
                                      hasNonEmptyValue = true;
                                      break;  // 하나라도 빈 값이 아니면 검사 중단
                                  }
                              }
                              // hasNonEmptyValue 변수에 따라 결과 반환
                              return hasNonEmptyValue;
                          },
                          latitudeCheck: true
                      },
                      longitude: {
                          required: function () {
                              var latitude = document.getElementsByName('latitude');
                              var hasNonEmptyValue = false;

                              for (var i = 0; i < latitude.length; i++) {
                                  var value = latitude[i].value;

                                  if (value !== '') {
                                      hasNonEmptyValue = true;
                                      break;  // 하나라도 빈 값이 아니면 검사 중단
                                  }
                              }
                              // hasNonEmptyValue 변수에 따라 결과 반환
                              return hasNonEmptyValue;
                          },
                          longitudeCheck: true
                      },
                      // installDt: {
                      //     required: true
                      // },
                      // batteryDt: {
                      //     required: true
                      // },
                      // examDt: {
                      //     required: true
                      // },
                      // sensorInstallDt: {
                      //     required: true
                      // },
                      // address: {
                      //     required: true
                      // },
                      siteNmND: {
                          required: true
                      },
                      // addressND: {
                      //     required: true
                      // }
                  },
                  messages: {
                      // siteNm: {
                      //     required: '사이트명을 입력해 주세요.'
                      // },
                      // clasifyDivi: {
                      //     required: '구분을 선택해 주세요.'
                      // },
                      // modelDivi: {
                      //     required: '모델을 선택해 주세요.'
                      // },
                      // address: {
                      //     required: '주소를 입력해 주세요.'
                      // },
                      // installDt:{
                      //     required : '날짜를 입력해 주세요.'
                      // },
                      // batteryDt:{
                      //     required : '날짜를 입력해 주세요.'
                      // },
                      // examDt:{
                      //     required : '날짜를 입력해 주세요.'
                      // },
                      // sensorInstallDt:{
                      //     required : '날짜를 입력해 주세요.'
                      // }
                  }
              })
              $.extend($.validator.messages, {
                  required: "필수 항목입니다."    // required 속성의 공동 메세지
              });
          }

          async function popupHandler(name, divi, callback) {
              doAction("mainSheet", "search2");
              // var row = systemGridList.getFocusedCell();
              var names = name.split('_');
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
                      }
                      break;
                  case 'site':
                      if (divi === 'open') {
                          var param = {}
                          param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
                          param.depaCd = "${LoginInfo.depaCd}";
                          param.name = name;
                          param.from = 'ims';

                          await edsIframe.openPopup('SITEPOPUP', param);
                      } else {
                          $('input[name="title"]').focus();
                          if (callback.siteNm === undefined) {
                              return
                          }
                          $('input[name=siteIndex]').val(callback.siteIndex)
                          $('input[name=siteNm]').val(callback.siteNm)
                          $('input[name=projNm]').val(callback.projNm)
                          $('input[name=projCd]').val(callback.projCd)
                          $('input[name=installDt]').val(callback.installDt)
                          $('input[name=batteryDt]').val(callback.batteryDt)
                          $('select:not(#adSearch)[name=ad]').val(callback.ad)
                          $('select[name=clasifyDivi]').val(callback.clasifyDivi)
                          $('select[name=modelDivi]').val(callback.modelDivi)

                          // document.querySelector('input[name="siteIndex"]').value = callback.siteIndex;
                          // document.querySelector('input[name="siteNm"]').value = callback.siteNm;
                          // document.querySelector('input[name="projNm"]').value = callback.projNm;
                          // document.querySelector('input[name="projCd"]').value = callback.projCd;
                          // document.querySelector('input[name="installDt"]').value = callback.installDt;
                          // document.querySelector('input[name="batteryDt"]').value = callback.batteryDt;
                          // document.querySelector('select[name="ad"]').value = callback.ad;
                          // document.querySelector('select[name="clasifyDivi"]').value = callback.clasifyDivi;
                          // document.querySelector('select[name="modelDivi"]').value = callback.modelDivi;
                      }
                      break;
              }
          }

          function getValueById(id) {
              return parseFloat($('#' + id).val());
          }

          // function updateSummary() {
          //     // 필터가 변경된 후에 실행할 summary 업데이트 로직
          //     // 현재 필터링된 데이터를 가져와서 summary를 다시 계산하고 업데이트합니다.
          //     var filteredData = mainSheet.getData(true); // true를 전달하여 현재 필터링된 데이터를 가져옵니다.
          //     var filteredData1 = event.instance.getData('filtered');
          //     console.log(filteredData1)
          //
          // }

          /*******************************************************
           함수 종료
           *******************************************************/
      </script>
      <!-- form start -->
      <form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
        <!-- input hidden -->
        <input type="hidden" name="corpCd" id="corpCd" title="회사코드">
        <input type="hidden" name="year" title="연도">
        <input type="hidden" name="ad" title="지자체">
        <input type="hidden" name="month" title="월">

        <!-- ./input hidden -->
        <div class="form-group col-sm-12">
          <button id="insertPjBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"
                  style="display: none">사이트 등록
          </button>

          <button id="carryOverBtn" type="button" class="btn btn-danger ml-3"
                  onclick="popupHandler('site','open')">데이터 이월
          </button>
          <div class="form-group" style="margin-left: 2.5rem"></div>

          <div class="input-group input-group-sm">
            <label for="yearSearch">연도 &nbsp;</label>
            <input type="text" class="form-control" style="width: 60px; font-size: 15px; text-align: center" name="year"
                   id="yearSearch"
                   title="연도">
          </div>
          <div class="form-group" style="margin-left: 5rem"></div>

          <div class="input-group input-group-sm">
            <label for="siteNmSearch">사이트명 &nbsp;</label>
            <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="siteNm"
                   id="siteNmSearch"
                   title="사이트명">
          </div>
          <div class="form-group" style="margin-left: 5rem"></div>
          <select class="form-control selectpicker" style="width: 150px;" id="adSearch" name="ad"></select>

        </div>
      </form>
      <!-- ./form -->
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <!-- 시트가 될 DIV 객체  -->
      <div id="grid" style="width: 100%;"></div>
    </div>
  </div>
</div>

<!--   Modal  -->
<div class="modal fade" data-backdrop="static" id="exampleModal" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%-- create / 등록 body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <div class="form-group col-md-12">
          <input type="radio" id="tab-1" name="show"/>
          <input type="radio" id="tab-2" name="show"/>
          <div class="tab">
            <label for="tab-1">사회재난</label>
            <label for="tab-2">자연재난</label>
          </div>
          <div class="content">
            <span hidden="hidden" id="siteIndex"></span>
            <span hidden="hidden" id="carryOverIndex"></span>
            <%--사회재난 input form--%>
            <form class="hide" id="modalForm" method="post" onsubmit="return false;">
              <div class="content-dis form-sd">
                <div class="form-row">
                  <div class="col-md-3 mb-3">
                    <label for="siteNm"><b>사이트명</b></label>
                    <input type="text" class="form-control" id="siteNm" name="siteNm" autofocus required>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="projNm"><b>프로젝트</b></label>
                    <button id="findProjBtn" type="button" class="btn btn-primary float-right"
                            onclick="popupHandler('proj','open')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">프로젝트 찾기
                    </button>
                    <input readonly type="text" class="form-control" id="projNm" name="projNm">
                    <input disabled type="text" hidden="hidden" id="projCd" name="projCd">
                  </div>
                  <div class="col-md-1 mb-3 container-ad">
                    <label for="ad"><b>지자체</b></label>
<%--                    <select class="form-control modal-select" id="ad" name="ad"></select>--%>
                    <select class="form-control modal-select selectpickerAd" id="ad" name="ad"></select>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="address"><b>주소</b></label>
                    <button id="baseAdrButtonSD" type="button" class="btn btn-primary float-right"
                            onclick="findAddr('SD')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">주소 찾기
                    </button>
                    <input class="form-control" id="address" name="address" type="text">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="clasifyDivi"><b>구분</b></label>
                    <select class="form-control modal-select select-container" id="clasifyDivi" name="clasifyDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-date"><b>설치년월</b></label>
                    <input id="install-date" class="form-control" name="installDt" type="date" max="9999-12-31">
                    <div id="wrapper" style="margin-top: 5px; z-index: 1"></div>
                  </div>
                </div>

                <div class="form-row">
                  <div class="col-md-1 mb-3">
                    <label for="install-battery"><b>배터리 설치일자</b></label>
                    <input id="install-battery" class="form-control" name="batteryDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelDivi"><b>모델</b></label>
                    <%--                    <input id="modelDivi" class="form-control" name="modelDivi" type="text">--%>
                    <select class="form-control select-container" id="modelDivi" name="modelDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="installDivi"><b>설치유형</b></label>
                    <select class="form-control modal-select" id="installDivi">
                      <option selected>컨테이너</option>
                      <option>폴대</option>
                      <option>분리</option>
                      <option>옥외</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerSt"><b>스피커</b></label>
                    <select class="form-control modal-select" id="speakerSt">
                      <option selected>신형</option>
                      <option>구형</option>
                      <option>주물</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerDx"><b>가청 거리(m)</b></label>
                    <select class="form-control modal-select" id="speakerDx">
                      <option selected>1200</option>
                      <option>1000</option>
                      <option>0</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="commDivi"><b>통신</b></label>
                    <select class="form-control modal-select" id="commDivi">
                      <option selected>광</option>
                      <option>구내</option>
                      <option>동</option>
                      <option>IP</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="satelliteDivi"><b>위성 타입</b></label>
                    <select class="form-control modal-select" id="satelliteDivi">
                      <option selected>F3</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="satelliteId"><b>위성 아이디</b></label>
                    <input type="text" class="form-control" id="satelliteId" name="satelliteId">
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="ipAdr"><b>IP</b></label>
                    <input type="text" class="form-control" id="ipAdr" name="ipAdr">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="comm9k"><b>9.6K</b></label>
                    <input type="text" class="form-control" id="comm9k" name="comm9k">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="commTD"><b>TD</b></label>
                    <input type="text" class="form-control" id="commTD" name="commTD">
                  </div>

                </div>

                <div class="form-row">
                  <div class="col-md-1 mb-3">
                    <label for="telNo"><b>Tel</b></label>
                    <input type="text" class="form-control" id="telNo" name="telNo">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="mcuV"><b>MCU 버전</b></label>
                    <input type="text" class="form-control" id="mcuV" name="mcuV" data-inputmask="'mask': '9.99/9.99'"
                           data-mask>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="dualSt"><b>이중화</b></label>
                    <input type="text" class="form-control" id="dualSt" name="dualSt" data-inputmask="'mask': '9/9'"
                           data-mask>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="serviceDivi"><b>유지보수 유무</b></label>
                    <select class="form-control modal-select" id="serviceDivi" name="serviceDivi">
                      <option selected>Y</option>
                      <option>N</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="checkCycle"><b>점검 주기</b></label>
                    <select class="form-control modal-select" id="checkCycle" name="checkCycle">
                      <option selected>월</option>
                      <option>분기</option>
                      <option disabled>X</option>
                    </select>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="latitude"><b>위도</b></label>
                    <input type="text" class="form-control" id="latitude" name="latitude" placeholder="[도]형식으로 작성해 주세요."
                           data-inputmask="'mask': '99.999999'" data-mask>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="longitude"><b>경도</b></label>
                    <input type="text" class="form-control" id="longitude" name="longitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '999.999999'" data-mask>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="remark"><b>비고</b></label>
                    <textarea class="form-control" id="remark" style="height: 38px"></textarea>
                  </div>
                </div>
              </div>
            </form>

            <%--자연재난(Natural Disaster) input form--%>
            <form class="hide" id="modalFormND" method="post" onsubmit="return false;">
              <div class="content-dis form-nd">
                <div class="form-row">
                  <div class="col-md-3 mb-3">
                    <label for="siteNmND"><b>사이트명</b></label>
                    <input type="text" class="form-control" id="siteNmND" name="siteNm" autofocus required>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="projNmND"><b>프로젝트</b></label>
                    <button id="findProjBtnND" type="button" class="btn btn-primary float-right"
                            onclick="popupHandler('proj','open')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">프로젝트 찾기
                    </button>
                    <input readonly type="text" class="form-control" id="projNmND" name="projNm">
                    <input disabled type="text" hidden="hidden" id="projCdND" name="projCd">
                  </div>
                  <div class="col-md-1 mb-3 container-adND">
                    <label for="adND"><b>지자체</b></label>
<%--                    <select class="form-control modal-select" id="adND" name="ad"></select>--%>
                    <select class="form-control modal-select selectpickerAdND" id="adND" name="ad"></select>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="addressND"><b>주소</b></label>
                    <button id="baseAdrButtonND" type="button" class="btn btn-primary float-right"
                            onclick="findAddr('ND')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">주소 찾기
                    </button>
                    <input class="form-control" id="addressND" name="address" type="text">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="districtDivi"><b>지구</b></label>
                    <input class="form-control" id="districtDivi" name="districtDivi" type="text">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="clasifyDiviND"><b>구분</b></label>
                    <select class="form-control modal-select select-container" id="clasifyDiviND" name="clasifyDivi">

                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-date-ND"><b>설치년월</b></label>
                    <input id="install-date-ND" class="form-control" name="installDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-battery-ND"><b>배터리 설치년월</b></label>
                    <input id="install-battery-ND" class="form-control" name="batteryDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="chargeDivi"><b>충전방식</b></label>
                    <select class="form-control modal-select" id="chargeDivi" name="chargeDivi">
                      <option selected>X</option>
                      <option>태양광</option>
                      <option>상전</option>
                      <option>상용/태양</option>
                      <option>V7.36</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelDiviND"><b>모델</b></label>
                    <%--                    <input id="modelDiviND" class="form-control" name="modelDivi" type="text">--%>
                    <select class="form-control modal-select select-container" id="modelDiviND" name="modelDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelNm"><b>모델명</b></label>
                    <input type="text" class="form-control" id="modelNm" name="modelNm">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="maker"><b>제조사</b></label>
                    <input type="text" class="form-control" id="maker" name="maker">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerDxND"><b>가청 거리(m)</b></label>
                    <select class="form-control modal-select" id="speakerDxND" name="speakerDx">
                      <option selected>0</option>
                      <option>300</option>
                      <option>2000</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="networkDivi"><b>계측(통신)방식</b></label>
                    <input type="text" class="form-control" id="networkDivi" name="networkDivi">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="ipAdrND"><b>IP</b></label>
                    <input type="text" class="form-control" id="ipAdrND" name="ipAdr">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="exam-date"><b>검정일</b></label>
                    <input id="exam-date" class="form-control" name="examDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="sensor"><b>센서</b></label>
                    <input type="text" class="form-control" id="sensor" name="sensor">
                  </div>
                </div>

                <div class="form-row">

                  <div class="col-md-1 mb-3">
                    <label for="measureUnit"><b>측정단위(mm)</b></label>
                    <select class="form-control modal-select" id="measureUnit">
                      <option selected>0</option>
                      <option>0.5</option>
                      <option>1</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-sensor"><b>센서 설치년월</b></label>
                    <input id="install-sensor" class="form-control" name="sensorInstallDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="sensorExamNo"><b>센서 검정번호</b></label>
                    <input type="text" class="form-control" id="sensorExamNo" name="sensorExamNo">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="serviceDiviND"><b>유지보수 유무</b></label>
                    <select class="form-control modal-select" id="serviceDiviND" name="serviceDivi">
                      <option selected>Y</option>
                      <option>N</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="checkCycleND"><b>점검 주기</b></label>
                    <select class="form-control modal-select" id="checkCycleND" name="checkCycle">
                      <option selected>월</option>
                      <option>분기</option>
                      <option disabled>X</option>
                    </select>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="latitudeND"><b>위도</b></label>
                    <input type="text" class="form-control" id="latitudeND" name="latitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '99.999999'" data-mask>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="longitudeND"><b>경도</b></label>
                    <input type="text" class="form-control" id="longitudeND" name="longitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '999.999999'" data-mask>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="remarkND"><b>비고</b></label>
                    <textarea class="form-control" id="remarkND" name="remark" style="height: 38px"></textarea>
                  </div>
                </div>
              </div>
            </form>

          </div>

          <!-- /.row -->
          <div class="row">
            <div class="col-md-12">
              <div class="card card card-lightblue card-outline">
                <div class="card-body card-body-site">
                  <div class="dropzone dropzone-site"
                       style=" min-height: 3rem;height: 3rem;text-align: center;padding: 0;">
                    <div class="dz-message needsclick" style="margin: 0; height: 100%; display: grid">
											<span class="text" style="align-self: center"> <span class="plus"> <b> 이미지 업로드하기<span
                              class="guidanceText">(최대 4개)</span> </b><i
                              class="fa-solid fa-file-circle-plus"></i></span>
											</span>
                    </div>
                  </div>
                  <!-- 포스팅 - 이미지/동영상 dropzone 영역 -->
                  <div>
                    <div class="wrapper" id="dropzone-preview">
                      <div class="test border rounded-3" id="dropzone-preview-list"
                           style="width: 200px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                        <!-- This is used as the file preview template -->
                        <div class="imim" style=" height: 200px; min-height: 120px; width: inherit;">
                          <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                               alt="Dropzone-Image"
                               style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                        </div>
                        <div class="" style="margin-top: 2px; height: 80px;">
                          <h6 class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down">&nbsp;</h6>
                          <div class="row" style="margin: 0;">
                            <p class="col-6" data-dz-size="data-dz-size" style="margin: 0; padding: 0;"></p>
                            <div class="col-6" style="padding: 0;">
                              <button data-dz-remove="data-dz-remove" class="btn btn-sm btn-danger ">삭제</button>
                            </div>
                          </div>
                          <strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- /.card-body card-body-site -->
              </div>
              <!-- /.card -->
            </div>
          </div>

        </div>
        <!--Footer-->
        <div class="modal-footer" style="display: block">
          <div class="row">
            <div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <div class="container">
                  <div class="row">
                    <div class="col text-center">
                      <button type="button" class="btn btn-sm btn-primary" name="btnClose1" id="btnClose1"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 닫기
                      </button>
                      <button type="submit" class="btn btn-sm btn-success" id="createBtn">
                        <i class="fa fa-save"></i> 저장
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <%-- update / 수정 body --%>
      <div class="modal-body hide form-update hide" id="modalBodyUpdate" style="padding: unset;">
        <div class="form-group col-md-12">
          <input type="radio" id="tab-1-update" name="show" checked/>
          <input type="radio" id="tab-2-update" name="show"/>
          <div class="tab">
            <label for="tab-1-update">사회재난</label>
            <label for="tab-2-update">자연재난</label>
          </div>
          <div class="content">
            <%--사회재난 input form--%>
            <form class="hide" id="updateForm" method="post" onsubmit="return false;">
              <div class="content-dis form-sd-update">
                <div class="form-row">
                  <div class="col-md-3 mb-3">
                    <label for="siteNmUpdate"><b>사이트명</b></label>
                    <input type="text" class="form-control siteNmUpdate" id="siteNmUpdate" name="siteNm" autofocus
                           required>
                  </div>
                  <div class="col-md-3 mb-3">
                    <%--                                        <label for="projNmUpdate"><b>프로젝트명</b></label>--%>
                    <%--                                        <input readonly disabled type="text" class="form-control siteNmUpdate" id="projNmUpdate" name="projNm">--%>
                    <%--                                        <input disabled type="text" hidden="hidden" name="projCd">--%>

                    <label for="projNmUpdate"><b>프로젝트</b></label>
                    <button id="findProjBtnUpdate" type="button" class="btn btn-primary float-right"
                            onclick="popupHandler('proj','open')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">프로젝트 찾기
                    </button>
                    <input readonly type="text" class="form-control" id="projNmUpdate" name="projNm">
                    <input disabled type="text" hidden="hidden" name="projCd">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="adUpdate"><b>지자체</b></label>
                    <select class="form-control modal-select adUpdate" id="adUpdate" name="ad"></select>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="addressUpdate"><b>주소</b></label>
                    <button id="updateAdrButtonSD" type="button" class="btn btn-primary float-right"
                            onclick="findAddr('updateSD')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">주소 찾기
                    </button>
                    <input class="form-control addressUpdate" id="addressUpdate" name="address" type="text">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="clasifyDiviUpdate"><b>구분</b></label>
                    <select class="form-control modal-select clasifyDiviUpdate select-container" id="clasifyDiviUpdate"
                            name="clasifyDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-date-update"><b>설치년월</b></label>
                    <input id="install-date-update" class="form-control" name="installDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-battery-update"><b>배터리 설치일자</b></label>
                    <input id="install-battery-update" class="form-control" name="batteryDt" type="date"
                           max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelDiviUpdate"><b>모델</b></label>
                    <%--                    <input id="modelDiviUpdate" class="form-control" name="modelDivi" type="text">--%>
                    <select class="form-control modal-select modelDiviUpdate select-container" id="modelDiviUpdate"
                            name="modelDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="installDiviUpdate"><b>설치유형</b></label>
                    <select class="form-control modal-select installDiviUpdate" id="installDiviUpdate"
                            name="installDivi">
                      <option>컨테이너</option>
                      <option>폴대</option>
                      <option>분리</option>
                      <option>옥외</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerStUpdate"><b>스피커</b></label>
                    <select class="form-control modal-select speakerStUpdate" id="speakerStUpdate" name="speakerSt">
                      <option>신형</option>
                      <option>구형</option>
                      <option>주물</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerDxUpdate"><b>가청 거리(m)</b></label>
                    <select class="form-control modal-select speakerDxUpdate" id="speakerDxUpdate" name="speakerDx">
                      <option>1200</option>
                      <option>1000</option>
                      <option>0</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="commDiviUpdate"><b>통신</b></label>
                    <select class="form-control modal-select commDiviUpdate" id="commDiviUpdate" name="commDivi">
                      <option>광</option>
                      <option>구내</option>
                      <option>동</option>
                      <option>IP</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="satelliteDiviUpdate"><b>위성 타입</b></label>
                    <select class="form-control modal-select satelliteDiviUpdate" id="satelliteDiviUpdate"
                            name="satelliteDivi">
                      <option>F3</option>
                      <option>X</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="satelliteIdUpdate"><b>위성 아이디</b></label>
                    <input type="text" class="form-control satelliteIdUpdate" id="satelliteIdUpdate" name="satelliteId">
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="ipAdrUpdate"><b>IP</b></label>
                    <input type="text" class="form-control ipAdrUpdate" id="ipAdrUpdate" name="ipAdr">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="comm9kUpdate"><b>9.6K</b></label>
                    <input type="text" class="form-control comm9kUpdate" id="comm9kUpdate" name="comm9k">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="commTDUpdate"><b>TD</b></label>
                    <input type="text" class="form-control commTDUpdate" id="commTDUpdate" name="commTD">
                  </div>
                </div>

                <div class="form-row">
                  <div class="col-md-1 mb-3">
                    <label for="telNoUpdate"><b>Tel</b></label>
                    <input type="text" class="form-control telNoUpdate" id="telNoUpdate" name="telNo">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="mcuVUpdate"><b>MCU 버전</b></label>
                    <input type="text" class="form-control mcuVUpdate" id="mcuVUpdate" name="mcuV"
                           data-inputmask="'mask': '9.99/9.99'"
                           data-mask>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="dualStUpdate"><b>이중화</b></label>
                    <input type="text" class="form-control dualStUpdate" id="dualStUpdate" name="dualSt"
                           data-inputmask="'mask': '9/9'"
                           data-mask>
                  </div>
                  <div class="col-md-1 mb-3">
                    <%--                                        <label for="serviceDiviUpdate"><b>유지보수 유무</b></label>--%>
                    <%--                                        <select disabled class="form-control modal-select serviceDiviUpdate" id="serviceDiviUpdate"--%>
                    <%--                                                name="serviceDivi">--%>
                    <%--                                          <option>Y</option>--%>
                    <%--                                          <option>N</option>--%>
                    <%--                                        </select>--%>

                    <label for="serviceDiviUpdate"><b>유지보수 유무</b></label>
                    <select class="form-control modal-select serviceDiviUpdate" id="serviceDiviUpdate"
                            name="serviceDivi">
                      <option>Y</option>
                      <option>N</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <%--                                        <label for="checkCycleUpdate"><b>점검 주기</b></label>--%>
                    <%--                                        <select disabled class="form-control modal-select checkCycleUpdate" id="checkCycleUpdate"--%>
                    <%--                                                name="checkCycle">--%>
                    <%--                                          <option selected>월</option>--%>
                    <%--                                          <option>분기</option>--%>
                    <%--                                          <option disabled>X</option>--%>
                    <%--                                        </select>--%>

                    <label for="checkCycleUpdate"><b>점검 주기</b></label>
                    <select class="form-control modal-select checkCycleUpdate" id="checkCycleUpdate"
                            name="checkCycle">
                      <option selected>월</option>
                      <option>분기</option>
                      <option disabled>X</option>
                    </select>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="latitudeUpdate"><b>위도</b></label>
                    <input type="text" class="form-control latitudeUpdate" id="latitudeUpdate" name="latitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '99.999999'" data-mask>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="longitudeUpdate"><b>경도</b></label>
                    <input type="text" class="form-control longitudeUpdate" id="longitudeUpdate" name="longitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '999.999999'" data-mask>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="remarkUpdate"><b>비고</b></label>
                    <textarea class="form-control remarkUpdate" id="remarkUpdate" name="remark"
                              style="height: 38px"></textarea>
                  </div>
                </div>
              </div>
            </form>

            <%--자연재난 input form--%>
            <form class="hide" id="updateFormND" method="post" onsubmit="return false;">
              <div class="content-dis form-nd-update">
                <div class="form-row">
                  <div class="col-md-3 mb-3">
                    <label for="siteNmNDUpdate"><b>사이트명</b></label>
                    <input type="text" class="form-control siteNmNDUpdate" id="siteNmNDUpdate" name="siteNm" autofocus
                           required>
                  </div>
                  <div class="col-md-3 mb-3">
                    <%--                                        <label for="projNmNDUpdate"><b>프로젝트</b></label>--%>
                    <%--                                        <input readonly disabled type="text" class="form-control" id="projNmNDUpdate" name="projNm">--%>
                    <%--                                        <input disabled type="text" hidden="hidden" id="projCdNDUpdate" name="projCd">--%>

                    <label for="projNmNDUpdate"><b>프로젝트</b></label>
                    <button id="findProjBtnUpdateND" type="button" class="btn btn-primary float-right"
                            onclick="popupHandler('proj','open')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">프로젝트 찾기
                    </button>
                    <input readonly type="text" class="form-control" id="projNmNDUpdate" name="projNm">
                    <input disabled type="text" hidden="hidden" name="projCd">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="adNDUpdate"><b>지자체</b></label>
                    <select class="form-control modal-select adNDUpdate" id="adNDUpdate" name="ad"></select>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="addressNDUpdate"><b>주소</b></label>
                    <button id="updateAdrButtonND" type="button" class="btn btn-primary float-right"
                            onclick="findAddr('updateND')"
                            style="font-size: 15px; padding: unset; white-space: nowrap;">주소 찾기
                    </button>
                    <input class="form-control addressNDUpdate" id="addressNDUpdate" name="address" type="text">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="districtDiviUpdate"><b>지구</b></label>
                    <input class="form-control districtDiviUpdate" type="text" id="districtDiviUpdate"
                           name="districtDivi">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="clasifyDiviNDUpdate"><b>구분</b></label>
                    <select class="form-control modal-select clasifyDiviNDUpdate select-container" name="clasifyDivi"
                            id="clasifyDiviNDUpdate">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-date-update-ND"><b>설치년월</b></label>
                    <input id="install-date-update-ND" class="form-control" name="installDt" type="date"
                           max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-battery-update-ND"><b>배터리 설치년월</b></label>
                    <input id="install-battery-update-ND" class="form-control" name="batteryDt" type="date"
                           max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="chargeDiviNDUpdate"><b>충전방식</b></label>
                    <select class="form-control modal-select chargeDiviUpdate" id="chargeDiviNDUpdate"
                            name="chargeDivi">
                      <option selected>X</option>
                      <option>태양광</option>
                      <option>상전</option>
                      <option>상용/태양</option>
                      <option>V7.36</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelDiviNDUpdate"><b>모델</b></label>
                    <%--                    <input id="modelDiviNDUpdate" class="form-control" name="modelDivi" type="text">--%>
                    <select class="form-control modal-select modelDiviNDUpdate select-container"
                            id="modelDiviNDUpdate" name="modelDivi">
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="modelNmUpdate"><b>모델명</b></label>
                    <input type="text" class="form-control modelNmUpdate" id="modelNmUpdate" name="modelNm">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="makerUpdate"><b>제조사</b></label>
                    <input type="text" class="form-control makerUpdate" id="makerUpdate" name="maker">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="speakerDxNDUpdate"><b>가청 거리(m)</b></label>
                    <select class="form-control modal-select speakerDxNDUpdate" id="speakerDxNDUpdate" name="speakerDx">
                      <option selected>0</option>
                      <option>300</option>
                      <option>2000</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="networkDiviUpdate"><b>계측(통신)방식</b></label>
                    <input type="text" class="form-control networkDiviUpdate" id="networkDiviUpdate" name="networkDivi">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="ipAdrNDUpdate"><b>IP</b></label>
                    <input type="text" class="form-control ipAdrNDUpdate" id="ipAdrNDUpdate" name="ipAdr">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="exam-date-update"><b>검정일</b></label>
                    <input id="exam-date-update" class="form-control" name="examDt" type="date" max="9999-12-31">
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="sensorUpdate"><b>센서</b></label>
                    <input type="text" class="form-control sensorUpdate" name="sensor" id="sensorUpdate">
                  </div>
                </div>

                <div class="form-row">

                  <div class="col-md-1 mb-3">
                    <label for="measureUnitNDUpdate"><b>측정단위(mm)</b></label>
                    <select class="form-control modal-select measureUnitUpdate" id="measureUnitNDUpdate"
                            name="measureUnit">
                      <option selected>0</option>
                      <option>0.5</option>
                      <option>1</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="install-sensor-update"><b>센서 설치년월</b></label>
                    <input id="install-sensor-update" class="form-control" name="sensorInstallDt" type="date"
                           max="9999-12-31">
                  </div>
                  <div class="col-md-1 mb-3">
                    <label for="sensorExamNoUpdate"><b>센서 검정번호</b></label>
                    <input type="text" class="form-control sensorExamNoUpdate" id="sensorExamNoUpdate"
                           name="sensorExamNo">
                  </div>
                  <div class="col-md-1 mb-3">
                    <%--                                        <label for="serviceDiviNDUpdate"><b>유지보수 유무</b></label>--%>
                    <%--                                        <select disabled class="form-control modal-select serviceDiviNDUpdate" id="serviceDiviNDUpdate"--%>
                    <%--                                                name="serviceDivi">--%>
                    <%--                                          <option selected>Y</option>--%>
                    <%--                                          <option>N</option>--%>
                    <%--                                        </select>--%>

                    <label for="serviceDiviNDUpdate"><b>유지보수 유무</b></label>
                    <select class="form-control modal-select serviceDiviNDUpdate" id="serviceDiviNDUpdate"
                            name="serviceDivi">
                      <option selected>Y</option>
                      <option>N</option>
                    </select>
                  </div>
                  <div class="col-md-1 mb-3">
                    <%--                                        <label for="checkCycleNDUpdate"><b>점검 주기</b></label>--%>
                    <%--                                        <select disabled class="form-control modal-select checkCycleNDUpdate" id="checkCycleNDUpdate"--%>
                    <%--                                                name="checkCycle">--%>
                    <%--                                          <option selected>월</option>--%>
                    <%--                                          <option>분기</option>--%>
                    <%--                                          <option disabled>X</option>--%>
                    <%--                                        </select>--%>

                    <label for="checkCycleNDUpdate"><b>점검 주기</b></label>
                    <select class="form-control modal-select checkCycleNDUpdate" id="checkCycleNDUpdate"
                            name="checkCycle">
                      <option selected>월</option>
                      <option>분기</option>
                      <option disabled>X</option>
                    </select>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="latitudeNDUpdate"><b>위도</b></label>
                    <input type="text" class="form-control latitudeNDUpdate" id="latitudeNDUpdate" name="latitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '99.999999'" data-mask>
                  </div>
                  <div class="col-md-2 mb-3">
                    <label for="longitudeNDUpdate"><b>경도</b></label>
                    <input type="text" class="form-control longitudeNDUpdate" id="longitudeNDUpdate" name="longitude"
                           placeholder="[도]형식으로 작성해 주세요." data-inputmask="'mask': '999.999999'" data-mask>
                  </div>
                  <div class="col-md-3 mb-3">
                    <label for="remarkNDUpdate"><b>비고</b></label>
                    <textarea class="form-control remarkNDUpdate" id="remarkNDUpdate" name="remark"
                              style="height: 38px"></textarea>
                  </div>
                </div>
              </div>
            </form>
          </div>

          <!-- /.row -->
          <div class="row">
            <div class="col-md-12">
              <div class="card card-default">
                <div class="card-body card-body-site">
                  <div class="dropzone dropzone2 dropzone-site"
                       style=" min-height: 3rem;height: 3rem;text-align: center;padding: 0;">
                    <div class="dz-message needsclick" style="margin: 0; height: 100%; display: grid">
											<span class="text" style="align-self: center">
                        <span class="plus"><b> 이미지 업로드하기<span class="guidanceText">(최대 4개)</span> </b><i
                                class="fa-solid fa-file-circle-plus"></i></span>
											</span>
                    </div>
                  </div>
                  <!-- 포스팅 - 이미지/동영상 dropzone 영역 -->
                  <div>
                    <div class="wrapper" id="dropzone-update-preview">
                      <div class="test border rounded-3" id="dropzone-preview-update-list"
                           style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                        <!-- This is used as the file preview template -->
                        <div class="" style=" height: 120px; width: inherit;">
                          <img id="dropzone-image" data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block"
                               src="#"
                               alt="Dropzone-Image"
                               style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                        </div>
                        <div class="" style="margin-top: 2px; height: 80px;">
                          <h6 class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down">&nbsp;</h6>
                          <div class="row" style="margin: 0;">
                            <p class="col-6" data-dz-size="data-dz-size" style="margin: 0; padding: 0;"></p>
                            <div class="col-6" style="padding: 0;">
                              <button id="deleteImgBtn" data-dz-remove="data-dz-remove" class="btn btn-sm btn-danger">
                                삭제
                              </button>
                            </div>
                          </div>

                          <strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- /.card-body card-body-site -->
              </div>
              <!-- /.card -->
            </div>
          </div>
        </div>
        <div class="tab-content" id="myTabContent">
          <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
              <a class="nav-link active" id="file-tab" data-toggle="tab" href="#file" role="tab"
                 aria-controls="file"
                 aria-selected="true">파일</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="memo-tab" data-toggle="tab" href="#memo" role="tab" aria-controls="memo"
                 aria-selected="false">메모</a>
            </li>
            <li class="nav-item site-btn-update">
              <input type="file" id="files" name="files" multiple style="display: none">
              <label for="files" type="button" class="btn btn-sm btn-primary" id="fileInput"
                     style="width:fit-content;display: inline;"><i class="fa fa-plus"></i> 파일등록</label>
              <button style="display: none" type="button" class="btn btn-sm btn-primary" id="fileDelete"
                      onclick="doAction('siteGridFile', 'delete')"><i class="fa fa-trash"></i> 파일삭제
              </button>
              <button style="display: none" type="button" class="btn btn-sm btn-primary" id="memoInput"
                      onclick="doAction('siteGridMemo', 'input')"><i class="fa fa-plus"></i> 메모등록
              </button>
              <button style="display: none" type="button" class="btn btn-sm btn-primary" id="memoDelete"
                      onclick="doAction('siteGridMemo', 'delete')"><i class="fa fa-trash"></i> 메모삭제
              </button>
            </li>
          </ul>
          <div class="tab-pane fade show active" id="file" role="tabpanel" aria-labelledby="file-tab">
            <!--Body-->
            <div class="modal-body padding-unset">
              <div class="col-md-12" style="height: 100%;" id="siteGridFile">
                <!-- 시트가 될 DIV 객체 -->
                <div id="projectGridFileDIV" style="width:100%; height:100%;"></div>
              </div>
            </div>
          </div>
          <div class="tab-pane fade" id="memo" role="tabpanel" aria-labelledby="memo-tab">
            <!--Body-->
            <div class="modal-body padding-unset">
              <div class="col-md-12" style="height: 100%;" id="siteGridMemo">
                <!-- 시트가 될 DIV 객체 -->
                <div id="siteGridMemoDIV" style="width:100%; height:100%;"></div>
              </div>
            </div>

          </div>

        </div>
        <!--Footer-->
        <div class="modal-footer" style="display: block; padding-top: 1px">
          <div class="row">
            <div class="col-md-12" style="padding: 0 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <form class="form-inline" role="form" name="siteGridMemoButtonForm"
                      id="siteGridMemoButtonForm" method="post" onsubmit="return false;">
                  <div class="container">
                    <div class="row">
                      <div class="col text-center">
                        <button type="button" class="btn btn-sm btn-primary" name="btnClose7" id="btnClose7"
                                data-dismiss="modal"
                                aria-label="Close"><i class="fa fa-times"></i> 닫기
                        </button>
                        <button type="button" class="btn btn-sm btn-danger btnDeleteUpdate" data-toggle="modal"
                                id="confirmDelete"
                                data-target="#confirmModal">
                          <i class="fa fa-trash"></i> 삭제
                        </button>
                        <button type="submit" class="btn btn-sm btn-success btnSaveUpdate" id="updateBtn"><i
                                class="fa fa-save"></i> 저장
                        </button>
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

<%--          memo text input modal--%>
<div id="memoInputModal" data-backdrop="static" class="modal fade memoInputModal" tabindex="-1"
     role="dialog">
  <div class="modal-dialog" role="document" style="position: relative; top: 35%">
    <div class="modal-content">
      <div class="modal-body">
        <textarea id="memoInputArea" autofocus rows="6" style="width: 100%;"></textarea>
      </div>
      <div class="modal-footer">
        <button id="memoInputAreaClose" type="button" class="btn btn-danger" onclick="memoInputClose()">닫기
        </button>
        <button id="memoInputAreaSave" type="button" class="btn btn-primary">입력</button>
      </div>
    </div>
  </div>
</div>
<%--          file text input modal--%>
<div id="fileInputModal" data-backdrop="static" class="modal fade fileInputModal" tabindex="-1"
     role="dialog">
  <div class="modal-dialog" role="document" style="position: relative; top: 35%">
    <div class="modal-content">
      <div class="modal-body">
        <textarea id="fileInputArea" autofocus rows="6" style="width: 100%;"></textarea>
      </div>
      <div class="modal-footer">
        <button id="fileInputAreaClose" type="button" class="btn btn-danger" onclick="fileInputClose()">닫기
        </button>
        <button id="fileInputAreaSave" type="button" class="btn btn-primary">입력</button>
      </div>
    </div>
  </div>
</div>

<!-- confirm Modal -->
<div class="modal fade" data-backdrop="static" id="confirmModal" tabindex="-1" role="dialog" style="top: 20%">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content" style="background-color: rgba(213, 216, 220, 0.5)">
      <div class="modal-body" style="text-align: center">
        <h4>정말 삭제하시겠습니까?</h4>
      </div>
      <div class="modal-footer" style="justify-content: center">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background-color: #544e4c">취소
        </button>
        <button id="deleteBtn" type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- expand image Modal -->
<div class="modal fade" id="expandModal" tabindex="-1" role="dialog" style="top: -3%; overflow: hidden">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content" style="background-color: rgba(213, 216, 220, 0.5)">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">
        <span><b>이미지 확대</b></span>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="text-align: center; padding: unset">
        <div style="width: 798px; height: 798px">
          <img id="expandImage">
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>