<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>
<html>
<head>
  <title>Calendar</title>
  <%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
  <%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
  <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
  <link rel="stylesheet" type="text/css" href="/tui/tui-calendar/dist/toastui-calendar.css">
  <link rel="stylesheet" type="text/css" href="/tui/tui-calendar/dist/calendar.css">
  <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css"/>
  <script src="https://kit.fontawesome.com/4ac0e9170f.js" crossorigin="anonymous"></script>
  <script type="text/javascript" src="/tui/tui-calendar/dist/toastui-calendar.js"></script>
  <script type="text/javascript" src="/tui/tui-calendar/dist/toastui-calendar.ie11.js"></script>

  <script>
      $(document).ready(function () {
          init();
      });

      /*******************************************************
       초기 설정
       *******************************************************/
      function init() {
          removeAutocomplete();
          // TOAST UI Calendar는 생성자 함수를 통해 인스턴스를 생성할 수 있다.
          const Calendar = tui.Calendar;

          /*******************************************************
           생성자 함수에 필요한 인스턴스(container, options)
           *******************************************************/
          const container = document.getElementById('calendar');
          const options = {
              defaultView: 'month',
              timezone: {
                  zones: [
                      {
                          timezoneName: 'Asia/Seoul',
                          displayLabel: 'Seoul',
                      },
                  ],
              },
              calendars: [
                  {
                      id: '1001',
                      name: '경영',
                      backgroundColor: '#EC7063',
                  },
                  {
                      id: '1003',
                      name: '기획',
                      backgroundColor: '#F39C12',
                  },
                  {
                      id: '1011',
                      name: '개발',
                      backgroundColor: '#F7DC6F',
                  },
                  {
                      id: '1006',
                      name: '사업수행',
                      backgroundColor: '#58D68D',
                  },
                  {
                      id: '1012',
                      name: '사회재난',
                      backgroundColor: '#AED6F1',
                  },
                  {
                      id: '1008',
                      name: '자연재난 1',
                      backgroundColor: '#5499C7',
                  },
                  {
                      id: '1009',
                      name: '자연재난 2',
                      backgroundColor: '#BB8FCE'
                  },
              ],
          };

          // 생성자 함수
          const calendar = new Calendar(container, options);

          /*******************************************************
           calendar 옵션 설정
           *******************************************************/
          calendar.setOptions({
              isReadOnly: true,
              useFormPopup: false,
              useDetailPopup: false,
              month: {
                  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                  narrowWeekend: true,
                  // isAlways6Weeks: false,
                  visibleEventCount : 6,
                  // visibleWeeksCount: 6,
              },
              gridSelection: {
                  enableDblClick: false,
                  enableClick: false,
              },
              template: {
                  monthMoreClose() {
                      return '닫기';
                  },
                  monthMoreTitleDate(moreTitle) {
                      switch (moreTitle.day) {
                          case 0:
                              moreTitle.day = '일';
                              break;
                          case 1:
                              moreTitle.day = '월';
                              break;
                          case 2:
                              moreTitle.day = '화';
                              break;
                          case 3:
                              moreTitle.day = '수';
                              break;
                          case 4:
                              moreTitle.day = '목';
                              break;
                          case 5:
                              moreTitle.day = '금';
                              break;
                          case 6:
                              moreTitle.day = '토';
                              break;
                      }

                      const moreDate = moreTitle.date;
                      const moreDay = moreTitle.day;

                      return '<b>' + moreDate + '</b>' + '&nbsp' + moreDay;
                  },
                  monthGridHeaderExceed(hiddenEvents) {
                      return `<span>${hiddenEvents} more +</span>`;
                  },
                  titlePlaceholder() {
                      return '제목';
                  },
                  locationPlaceholder() {
                      return '장소';
                  }, startDatePlaceholder() {
                      return '시작일';
                  },
                  endDatePlaceholder() {
                      return '종료일';
                  },
                  popupSave() {
                      return '저장';
                  },
                  popupUpdate() {
                      return '저장';
                  },
                  popupEdit() {
                      return '수정';
                  },
                  popupDelete() {
                      return '삭제';
                  },
                  <%--popupDetailDate({ start, end }) {--%>
                  <%--    return `${start.toString()} - ${end.toString()}`;--%>
                  <%--},--%>
              },
          });

          /*******************************************************
           calendar 테마 설정
           *******************************************************/
          calendar.setTheme({
              common: {
                  // gridSelection: {
                  //     backgroundColor: 'rgba(81, 230, 92, 0.05)',
                  //     border: '1px dotted #515ce6',
                  // },
                  saturday: {
                      color: 'rgba(64, 64, 255, 0.8)',
                  },
                  holiday: {
                      color: 'rgba(255, 64, 64, 0.8)',
                  },
              },
              month: {
                  moreViewTitle: {
                      backgroundColor: 'rgb(194, 199, 208)',
                  },
                  moreView: {
                      border: '1px solid grey',
                      boxShadow: '0 2px 6px 0 grey',
                      backgroundColor: 'white',
                      width: 350,
                      height: 500,
                  },
                  gridCell: {
                      headerHeight:26.5,
                      footerHeight: null
                  },
                  dayName: {
                      backgroundColor: '#c2c7d0',
                  },
                  weekend: {
                      backgroundColor: 'rgba(255, 64, 64, 0.1)',
                  },
                  dayExceptThisMonth: {
                      color: '#D5D8DC',
                      // color: 'gray',
                  },
                  holidayExceptThisMonth: {
                      color: '#D5D8DC',
                      // color: 'gray',
                  },
              },
          });

          /*******************************************************
           일정 전체 출력
           *******************************************************/
          recreateCalendar();

          getDate();

          /*******************************************************
           api 호출 딜레이에 맞추기 위해서 setTimeout 사용
           *******************************************************/
          setTimeout(function () {
              //todo : 공백
              /*******************************************************
               일정 제목 앞 자동으로 붙는 공백 제거
               *******************************************************/
              // function removeNbsp () {
              //     var beforeRemoveNbsp = $('.toastui-calendar-template-time');
              //     var beforeRemoveNbspToArray = Array.from(beforeRemoveNbsp);
              //     for (var i = 0; i < beforeRemoveNbsp.length; i++) {
              //         beforeRemoveNbspToArray[i].innerText = beforeRemoveNbspToArray[i].innerText.trim();
              //     }
              // }

              /*******************************************************
               달력 일자 클릭
               *******************************************************/
              $('.toastui-calendar-daygrid-cell').on('click', function (e) {
                  removeStyle();
                  $('#input-writer').val('${LoginInfo.empNm}');
                  // console.log(e.currentTarget.children[0].children[0].style.cssText)
                  // console.log(e.currentTarget.children[0].children[0].style.color)
                  $('.modal-footer').css('display', 'flex');
                  $("#department").append("<option value='1' selected>${LoginInfo.depaCd}</option>");

                  // form input text 초기화
                  $('#staticBackdrop').on('hidden.bs.modal', function (e) {
                      $(this).find('form')[0].reset();
                  });

                  /*******************************************************
                   달력 이전달 / 다음달 구분 시작
                   *******************************************************/
                  // // 이전달 클릭
                  if (e.currentTarget.children[0].children[0].style.color === 'rgb(213, 216, 220)' && e.currentTarget.children[0].children[0].children[0].textContent > 15) {
                      // 1월에서 지난 연도의 날짜 클릭시
                      if (calendar.getDate().getMonth() + 1 === 1) {
                          var calendarDate = (calendar.getDate().getFullYear() - 1) + '-' + ('00' + (calendar.getDate().getMonth() + 12)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                      } else {
                          var calendarDate = calendar.getDate().getFullYear() + '-' + ('00' + (calendar.getDate().getMonth())).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                      }
                  }
                  // 다음달 클릭
                  else if ((e.currentTarget.children[0].children[0].style.color === 'rgb(213, 216, 220)' && e.currentTarget.children[0].children[0].children[0].textContent < 15)) {
                      // 12월에서 다음 연도의 날짜 클릭시
                      if (calendar.getDate().getMonth() + 1 === 12) {
                          // console.log((calendar.getDate().getFullYear() + 1) + '-' + ('00' + (calendar.getDate().getMonth() - 10)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2))
                          var calendarDate = (calendar.getDate().getFullYear() + 1) + '-' + ('00' + (calendar.getDate().getMonth() - 10)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                      } else {
                          var calendarDate = calendar.getDate().getFullYear() + '-' + ('00' + (calendar.getDate().getMonth() + 2)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                      }
                  }
                  // 기본
                  else {
                      var calendarDate = calendar.getDate().getFullYear() + '-' + ('00' + (calendar.getDate().getMonth() + 1)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                  }

                  // 이전 달에서 오늘 날짜 클릭시
                  var date = new Date();
                  if ((e.currentTarget.children[0].children[0].style.color === 'rgb(255, 255, 255)') && calendar.getDate().getMonth() + 1 < date.getMonth() + 1) {
                      var calendarDate = calendar.getDate().getFullYear() + '-' + ('00' + (calendar.getDate().getMonth() + 2)).slice(-2) + '-' + ('00' + e.target.textContent).slice(-2);
                  }

                  // 일정에서 more 텍스트 발생시 처리
                  if (e.target.textContent.includes('more +')) {
                      var calendarDate = calendar.getDate().getFullYear() + '-' + ('00' + (calendar.getDate().getMonth() + 1)).slice(-2) + '-' + ('00' + e.target.textContent.replace('more +', '').trim()).slice(-2);
                  }

                  /*******************************************************
                   달력 이전달 / 다음달 구분 끝
                   *******************************************************/

                  var day = new Date(calendarDate);
                  var picker = tui.DatePicker.createRangePicker({
                      startpicker: {
                          date: day,
                          input: '#startpicker-input',
                          container: '#startpicker-container'
                      },
                      endpicker: {
                          date: day,
                          input: '#endpicker-input',
                          container: '#endpicker-container'
                      },
                      selectableRanges: [
                          [day, new Date(day.getFullYear() + 1, day.getMonth(), day.getDate())]
                      ],
                      language: 'ko',
                      format: 'YYYY-MM-dd',
                  });
                  $('#staticBackdrop').modal('show')
                  // modal input autofocus
                  $('.modal').on('shown.bs.modal', function () {
                      $(this).find('[autofocus]').focus();
                  });
              })

              /*******************************************************
               일정 생성 / create calendar
               *******************************************************/
              $('#calendar-create-save').on('click', function (e) {
                  // 제목이 공백일 때 경고
                  if ($('#input-title').val().trim() == '') {
                      warningInputTitle();
                  } else if ($('#input-content').val().trim() == '') {
                      warningInputContent();
                  } else {
                      var depaCdValue = '${LoginInfo.empCd}' === '0007' ? '1009' : '${LoginInfo.depaCd}';
                      console.log('부서')
                      console.log(depaCdValue)
                      $.ajax({
                          url: "/calendarView/cudCalendar",
                          headers: {
                              'X-Requested-With': 'XMLHttpRequest'
                          },
                          datatype: "json",
                          contentType: "application/json; charset=UTF-8",
                          type: "POST",
                          async: false,
                          // data: JSON.stringify({data:param}),
                          data: JSON.stringify({
                              data: [{
                                  status: "C",
                                  corpCd: ${LoginInfo.corpCd},
                                  depaCd: depaCdValue,
                                  title: $('#input-title').val(),
                                  content: $('#input-content').val(),
                                  startCalDt: $('#startpicker-input').val(),
                                  endCalDt: $('#endpicker-input').val(),
                                  empNm: "${LoginInfo.empCd}",
                                  remark: $('#input-remark').val(),
                              }]
                          }),
                          success: async function (result) {
                              var param = {};
                              param.corpCd = '${LoginInfo.corpCd}';
                              var calendarData = getAjaxt2("/calendarView/selectCalendar", param);
                              calendar.createEvents([
                                  {
                                      id: calendarData.data[calendarData.data.length - 1].index,
                                      calendarId: depaCdValue,
                                      title: $('#input-title').val(),
                                      body: $('#input-content').val(),
                                      start: $('#startpicker-input').val(),
                                      end: $('#endpicker-input').val(),
                                  }
                              ]);
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
                      $('#staticBackdrop').modal('hide');
                  }
              })
          }, 100)

          /*******************************************************
           일정 수정 / update calendar
           *******************************************************/
          $('#calendar-update-save').on('click', (e) => {
              if ($('#input-title-update').val().trim() == '') {
                  warningInputTitleUpd();
                  return false;
              } else if ($('#input-content-update').val().trim() == '') {
                  warningInputContentUpd();
                  return false;
              } else {
                  var depaCdValue = '${LoginInfo.empCd}' === '0007' ? '1009' : ${LoginInfo.depaCd};
                  $.ajax({
                      url: "/calendarView/cudCalendar",
                      headers: {
                          'X-Requested-With': 'XMLHttpRequest'
                      },
                      datatype: "json",
                      contentType: "application/json; charset=UTF-8",
                      type: "POST",
                      async: false,
                      data: JSON.stringify({
                          data: [{
                              status: "U",
                              index: $('#input-index-update').val(),
                              corpCd: ${LoginInfo.corpCd},
                              depaCd: depaCdValue,
                              title: $('#input-title-update').val(),
                              content: $('#input-content-update').val(),
                              startCalDt: $('#startpicker-input-update').val(),
                              endCalDt: $('#endpicker-input-update').val(),
                              remark: $('#input-remark-update').val(),
                              updId: "${LoginInfo.empCd}"
                          }]
                      }),
                      success: async function (result) {
                          $('.toastui-calendar-see-more-container').css('display', 'none');
                          recreateCalendar();

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
              }
              $('#staticBackdropToUpdate').modal('hide');
          })

          /*******************************************************
           일정 삭제 / delete calendar
           *******************************************************/
          $('#modal-confirm-delete').on('click', () => {
              var depaCdValue = '${LoginInfo.empCd}' === '0007' ? '1009' : ${LoginInfo.depaCd};
              $.ajax({
                  url: "/calendarView/cudCalendar",
                  headers: {
                      'X-Requested-With': 'XMLHttpRequest'
                  },
                  datatype: "json",
                  contentType: "application/json; charset=UTF-8",
                  type: "POST",
                  async: false,
                  data: JSON.stringify({
                      data: [{
                          status: "D",
                          index: $('#input-index-update').val(),
                          corpCd: ${LoginInfo.corpCd},
                          depaCd: depaCdValue,
                      }]
                  }),
                  success: async function (result) {
                      recreateCalendar();

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
              $('.modal').modal('hide');
          })

          /*******************************************************
           생성된 일정 클릭
           *******************************************************/
          calendar.on('clickEvent', function (e) {
              removeStyle();
              // yyyy-mm-dd format
              var calendarStartDate = e.event.start.getFullYear() + '-' + ('00' + (e.event.start.getMonth() + 1)).slice(-2) + '-' + ('00' + e.event.start.getDate()).slice(-2);
              var calendarEndDate = e.event.end.getFullYear() + '-' + ('00' + (e.event.end.getMonth() + 1)).slice(-2) + '-' + ('00' + e.event.end.getDate()).slice(-2);

              var day = new Date(calendarStartDate);
              var dayEnd = new Date(calendarEndDate);
              var picker = tui.DatePicker.createRangePicker({
                  startpicker: {
                      date: day,
                      input: '#startpicker-input-update',
                      container: '#startpicker-container-update'
                  },
                  endpicker: {
                      date: dayEnd,
                      input: '#endpicker-input-update',
                      container: '#endpicker-container-update'
                  },
                  selectableRanges: [
                      [new Date(day.getFullYear(), day.getMonth() - 1, day.getDate()), new Date(day.getFullYear() + 1, day.getMonth(), day.getDate())]
                  ],
                  language: 'ko',
                  format: 'YYYY-MM-dd',
              });

              var param = {};
              param.corpCd = '${LoginInfo.corpCd}';
              param.index = e.event.id;
              var calendarPopupData = getAjaxt2("/calendarView/selectCalendarOnPopup", param);

              $('#input-writer-update').val(calendarPopupData.data[0].empNm);
              $('#input-index-update').val(e.event.id);
              $('#input-calendarId-update').val(e.event.calendarId);
              $('#input-title-update').val(e.event.title);
              $('#input-content-update').val(e.event.body);
              $('#startpicker-input-update').val(calendarStartDate);
              $('#endpicker-input-update').val(calendarEndDate);
              $('#input-remark-update').val(calendarPopupData.data[0].remark);

              // 수정, 삭제 버튼 부서 구분
              if ('${LoginInfo.depaCd}' != calendarPopupData.data[0].depaCd) {
                  $('.modal-footer').css('display', 'none');
              } else {
                  $('.modal-footer').css('display', 'flex');
              }
              if ('${LoginInfo.empCd}' === '0007' && calendarPopupData.data[0].depaCd === '1009') {
                  $('.modal-footer').css('display', 'flex');
              }

              $('#staticBackdropToUpdate').modal('show');
          });

          /*******************************************************
           기능 시작
           *******************************************************/
          // 다음달로 이동
          $('.button.is-rounded.next').on('click', function () {
              // $('.navbar--range').text(calendar.getDate().getFullYear() + '년' + (calendar.getDate().getMonth() + 1) + '월');
              calendar.next();
              getDate();
          });

          // 이전 달로 이동
          $('.button.is-rounded.prev').on('click', function () {
              // $('.navbar--range').text(calendar.getDate().getFullYear() + '년' + (calendar.getDate().getMonth() + 1) + '월');
              calendar.prev();
              getDate();
          });

          // 오늘로 이동
          $('.button.is-rounded.today').on('click', function () {
              calendar.today();
              getDate();
          });

          // 부서 체크박스 - 개별
          $('input[type="checkbox"]').change(function () {
              console.log('개별')
              for (var i = 0; i < $('input[type="checkbox"]').length; i++) {
                  console.log($('input[type="checkbox"]')[i].checked)
                  if ($('input[type="checkbox"]')[i].checked) {
                      showCalendar($('input[type="checkbox"]')[i].value);
                  } else {
                      hideCalendar($('input[type="checkbox"]')[i].value);
                  }
              }
          });

          // 부서 체크박스 - 전체
          $('#all').change(function () {
              console.log('전체')
              $('input[name="check-DEPTS"]').prop('checked', this.checked);
              var calendarId = [];
              for (var i = 0; i < $('input[type="checkbox"]').length; i++) {
                  calendarId.push($('input[type="checkbox"]')[i].value);
                  console.log(calendarId)
              }
              if ($('#all').prop('checked')) {
                  // calendar.setCalendarVisibility(calendarId, true);
                  showCalendar(calendarId);
              } else {
                  // calendar.setCalendarVisibility(calendarId, false);
                  hideCalendar(calendarId);
              }
          });

          /*******************************************************
           기능 끝
           *******************************************************/

          // 달력 날짜 구하기
          function getDate() {
              var date = calendar.getDate().getFullYear() + '년 ' + (calendar.getDate().getMonth() + 1) + '월';
              $('.navbar--range').text(date);
          }

          /*******************************************************
           부서별 일정 show / hide
           *******************************************************/
          function showCalendar(param) {
              calendar.setCalendarVisibility(param, true);
          }

          function hideCalendar(param) {
              calendar.setCalendarVisibility(param, false);
          }

          // 일정 초기화(calendar.clear()) 후 재생성
          function recreateCalendar() {
              calendar.clear();
              var param = {};
              param.corpCd = '${LoginInfo.corpCd}';
              var calendarData = getAjaxt2("/calendarView/selectCalendar", param);
              for (var i = 0; i < calendarData.data.length; i++) {
                  calendar.createEvents([
                      {
                          id: calendarData.data[i].index,
                          calendarId: calendarData.data[i].depaCd,
                          title: calendarData.data[i].title,
                          body: calendarData.data[i].content,
                          start: calendarData.data[i].startCalDt,
                          end: calendarData.data[i].endCalDt,
                      }
                  ]);
              }
          }

      }

      /*******************************************************
       함수 시작
       *******************************************************/

      /*******************************************************
       일정 생성 / 수정창 input 검증
       *******************************************************/
      function warningInputTitle() {
          $('.required-text').css('color', 'red').css('text-decoration', 'underline');
          $('.required-content').css('color', 'black').css('text-decoration', 'unset');
          $('#input-title').val('');
          $('#input-title').focus();
      }

      function warningInputTitleUpd() {
          $('.required-text-update').css('color', 'red').css('text-decoration', 'underline');
          $('.required-content-update').css('color', 'black').css('text-decoration', 'unset');
          $('#input-title-update').val('');
          $('#input-title-update').focus();
      }

      function warningInputContent() {
          $('.required-content').css('color', 'red').css('text-decoration', 'underline');
          $('.required-text').css('color', 'black').css('text-decoration', 'unset');
          $('#input-content').val('');
          $('#input-content').focus();
      }

      function warningInputContentUpd() {
          $('.required-content-update').css('color', 'red').css('text-decoration', 'underline');
          $('.required-text-update').css('color', 'black').css('text-decoration', 'unset');
          $('#input-content-update').val('');
          $('#input-content-update').focus();
      }

      // 생성, 수정 input css 제거
      function removeStyle() {
          $('.required-content, .required-text, .required-content-update, .required-text-update').removeAttr('style');
      }

      // input 자동완성 제거
      function removeAutocomplete() {
          $('input').attr('autocomplete', 'off');
      }

      function getAjaxt2 (url, param){
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
              success: function(result){
                  // console.log(result.ajax);
                  if (!result.sess && typeof result.sess != "undefined") {
                      alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                      return;
                  }
                  data = result;
              }
          });
          return data;
      }

      /*******************************************************
       함수 끝
       *******************************************************/

  </script>
</head>
<body>
<header class="header">
  <nav class="navbar" style="display: inline-block; padding: 0.15rem 0 0 0">
    <button class="button is-rounded today">오늘</button>
    <button class="button is-rounded prev">
      <%--      <img alt="prev" src="./images/ic-arrow-line-left.jpg">--%>
      <i class="fa-solid fa-chevron-left"></i>
    </button>
    <span class="navbar--range"></span>
    <button class="button is-rounded next">
      <%--      <img alt="next" src="images/ic-arrow-line-right.jpg">--%>
      <i class="fa-solid fa-chevron-right"></i>
    </button>
  </nav>
</header>
<aside class="sidebar">
  <div class="sidebar-item all">
    <div>
      <input class="checkbox-all" type="checkbox" id="all" value="all" checked="">
      <label class="checkbox checkbox-all" for="all">전체</label>
    </div>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-management" type="checkbox" id="checkbox-management" value="1001" name="check-DEPTS"
           checked="">
    <label class="checkbox checkbox-calendar checkbox-1" for="checkbox-management">경영</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-planning" type="checkbox" id="checkbox-planning" value="1003" name="check-DEPTS" checked="">
    <label class="checkbox checkbox-calendar checkbox-2" for="checkbox-planning">기획</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-development" type="checkbox" id="checkbox-development" value="1011" name="check-DEPTS"
           checked="">
    <label class="checkbox checkbox-calendar checkbox-3" for="checkbox-development">개발</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-performance" type="checkbox" id="checkbox-performance" value="1006" name="check-DEPTS"
           checked="">
    <label class="checkbox checkbox-calendar checkbox-4" for="checkbox-performance">수행</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-social" type="checkbox" id="checkbox-social" value="1012" name="check-DEPTS" checked="">
    <label class="checkbox checkbox-calendar checkbox-5" for="checkbox-social">사회</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-natural1st" type="checkbox" id="checkbox-natural1st" value="1008" name="check-DEPTS"
           checked="">
    <label class="checkbox checkbox-calendar checkbox-6" for="checkbox-natural1st">자연 1</label>
  </div>
  <div class="sidebar-item">
    <input class="checkbox-natural2nd" type="checkbox" id="checkbox-natural2nd" value="1009" name="check-DEPTS"
           checked="">
    <label class="checkbox checkbox-calendar checkbox-7" for="checkbox-natural2nd">자연 2</label>
  </div>
</aside>
<%--calendar container *높이 최소 600px 이상* --%>
<div id="calendar" style="height: 95.5%;"></div>

<!--primary Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">일정 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="modal-form">
        <div class="modal-body">
          <table>
            <tbody>
            <tr hidden="hidden">
              <td>부서</td>
              <td>
                <select id="department">
                  <%--                  <option value="management">경영</option>--%>
                  <%--                  <option value="planning">기획</option>--%>
                  <%--                  <option value="development">개발</option>--%>
                  <%--                  <option value="performance">사업수행</option>--%>
                  <%--                  <option value="social">사회재난</option>--%>
                  <%--                  <option value="natural1st">자연재난 1</option>--%>
                  <%--                  <option value="natural2nd">자연재난 2</option>--%>
                </select>
              </td>
            </tr>
            <tr>
              <td>작성자</td>
              <td>
                <input readonly id="input-writer" type="text">
              </td>
            </tr>
            <tr>
              <td class="required-text">제목</td>
              <td>
                <input id="input-title" autofocus type="text" placeholder="제목(필수)">
              </td>
            </tr>
            <tr>
              <td class="required-content">내용</td>
              <td>
                <textarea id="input-content" placeholder="내용(필수)"></textarea>
              </td>
            </tr>
            <tr>
              <td>일자</td>
              <td>
                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                  <input id="startpicker-input" type="text" aria-label="Date">
                  <label for="startpicker-input" class="tui-ico-date"></label>
                  <div id="startpicker-container" style="margin-left: -1px;"></div>
                </div>
                <span class="tui-datepicker-span">-</span>
                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                  <input id="endpicker-input" type="text" aria-label="Date">
                  <label for="endpicker-input" class="tui-ico-date"></label>
                  <div id="endpicker-container" style="margin-left: -1px;"></div>
                </div>
              </td>
            </tr>
            <tr>
              <td>비고</td>
              <td>
                <input id="input-remark" type="text" placeholder="비고(선택)">
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </form>
      <div class="modal-footer">
        <button id="calendar-create-cancel" type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        <button id="calendar-create-save" type="button" class="btn btn-primary">등록</button>
      </div>
    </div>
  </div>
</div>

<%--update Modal--%>
<div class="modal fade" id="staticBackdropToUpdate" data-backdrop="static" data-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabelToUpdate" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabelToUpdate">일정 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="modal-form-update">
        <div class="modal-body">
          <table>
            <tbody>
            <tr>
              <td>작성자</td>
              <td>
                <input readonly id="input-writer-update" type="text">
              </td>
            </tr>
            <tr hidden="hidden">
              <td>
                <input id="input-index-update">
              </td>
            </tr>
            <tr hidden="hidden">
              <td>
                <input id="input-calendarId-update">
              </td>
            </tr>
            <tr hidden="hidden">
              <td>부서</td>
              <td>
                <select id="department-update">
                  <%--                  <option value="management">경영</option>--%>
                  <%--                  <option value="planning">기획</option>--%>
                  <%--                  <option value="development">개발</option>--%>
                  <%--                  <option value="performance">사업수행</option>--%>
                  <%--                  <option value="social">사회재난</option>--%>
                  <%--                  <option value="natural1st">자연재난 1</option>--%>
                  <%--                  <option value="natural2nd">자연재난 2</option>--%>
                </select>
              </td>
            </tr>
            <tr>
              <td class="required-text-update">제목</td>
              <td>
                <input id="input-title-update" autofocus type="text" placeholder="제목(필수)">
              </td>
            </tr>
            <tr>
              <td class="required-content-update">내용</td>
              <td>
                <textarea id="input-content-update" placeholder="내용(필수)"></textarea>
              </td>
            </tr>
            <tr>
              <td>일자</td>
              <td>
                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                  <input id="startpicker-input-update" type="text" aria-label="Date">
                  <label for="startpicker-input-update" class="tui-ico-date"></label>
                  <div id="startpicker-container-update" style="margin-left: -1px;"></div>
                </div>
                <span class="tui-datepicker-span">-</span>
                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                  <input id="endpicker-input-update" type="text" aria-label="Date">
                  <label for="endpicker-input-update" class="tui-ico-date"></label>
                  <div id="endpicker-container-update" style="margin-left: -1px;"></div>
                </div>
              </td>
            </tr>
            <tr>
              <td>비고</td>
              <td>
                <input id="input-remark-update" type="text" placeholder="비고(선택)">
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </form>
      <div class="modal-footer">
        <button id="calendar-delete" type="button" class="btn btn-danger" data-toggle="modal" data-target="#modal2">
          삭제
        </button>
        <button id="calendar-update-save" type="button" class="btn btn-primary">수정</button>
      </div>
    </div>
  </div>
</div>

<!-- confirm Modal -->
<div class="modal fade" data-backdrop="static" id="modal2" tabindex="-1" role="dialog" style="top: 20%">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content" style="background-color: rgba(213, 216, 220, 0.5)">
      <div class="modal-body" style="text-align: center">
        <h4>정말 삭제하시겠습니까?</h4>
      </div>
      <div class="modal-footer" style="justify-content: center">
        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
        <button id="modal-confirm-delete" type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>