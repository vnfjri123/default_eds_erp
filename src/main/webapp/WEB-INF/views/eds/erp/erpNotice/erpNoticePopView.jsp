<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
  <title>erpNoticePop</title>
</head>

<link rel="stylesheet" href="/ims/notice/noticePop.css">

<link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css"/>

<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>

<script>
    var dropzone;
    Dropzone.autoDiscover = false;

    var cookieData = document.cookie;
    $(document).ready(async function () {
        dropZoneEvent();
        initPop();
    })

    function initPop() {
        // 쿠키 "popup_secret_coupon=done"이 없는 경우 실행
        if (cookieData.indexOf("erp_popup_secret_coupon=done") < 0) {
            var param = {};
            param.corpCd = '${LoginInfo.corpCd}';
            param.date = edsUtil.getToday("%Y-%m-%d");

            // AJAX를 통해 서버에서 데이터 가져오기
            var noticeData = edsUtil.getAjax("/erpNoticeView/selectERPNoticeByIndex", param);
            var tabHeader = ''; // 반복문 내에서 HTML 코드를 누적할 빈 문자열 변수
            var tabBody = '';

// 가져온 데이터의 길이가 0보다 큰 경우 반복문 실행
            if (noticeData.length > 0) {
                // 데이터를 각각 초기화
                var titleData = '';
                var dateData = '';
                var contentData = '';
                var noticeIndex = '';

                for (let i = 0; i < noticeData.length; i++) {
                    // 데이터 누적
                    titleData = noticeData[i].title;
                    dateData = yyyymmdd(new Date(noticeData[i].inpDttm));
                    contentData = noticeData[i].content;
                    noticeIndex = noticeData[i].index;

                    // 각 데이터에 대한 리스트 아이템과 버튼 생성 및 ttete에 추가
                    tabHeader += `<li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-home-tab\${i}" data-toggle="pill" data-target="#pills-home\${i}" type="button"
                    role="tab" aria-controls="pills-home\${i}" aria-selected="true">\${i + 1}번
            </button>
<div hidden="hidden" id="noticeIndex\${i}">\${noticeIndex}</div>
        </li>`;

                    // 각 데이터에 대한 탭 컨텐츠 생성 및 tttt에 추가
                    tabBody += `
            <div class="tab-pane fade" id="pills-home\${i}" role="tabpanel" aria-labelledby="pills-home-tab\${i}">
                <div class="border-top"></div>
                <div class="pl-2 pr-2">
                    <div id="title\${i}"><b>제목 :</b> \${titleData}</div>
                    <div id="inpDttm\${i}"><b>등록일 :</b> \${dateData}</div>
                </div>
                <div class="border-bottom"></div>
                <div class="pop-content" id="content" style="padding: 0 0.5rem 0 0.5rem"><b>\${contentData}</b></div>
            </div>`;

                }

                // 만들어진 HTML 코드를 'pills-tab' 요소의 innerHTML로 설정
                $('#pills-tab').html(tabHeader);

                // 만들어진 탭 컨텐츠를 'pills-tabContent' 요소의 innerHTML로 설정
                $('#pills-tabContent').html(tabBody);

                // 첫 번째 탭에 'active' 클래스 추가
                $('#pills-home-tab0').addClass('active');
                $("#pills-home-tab0").prepend('<img width="32" height="32" src="https://img.icons8.com/color/48/new--v1.png" alt="new--v1"/>');
                $('#pills-home0').addClass('show active');

                document.getElementById('noticeIndex').value = noticeData[0].index;
                loadFilesForTab(noticeData[0].index);

                // 모달 띄우기
                $('#mainModal').modal('show');

                $('#pills-tab').on('click', (e) => {

                    if (e.target.localName === 'button') {
                        var tabId = e.target.id;
                        // ID에서 숫자만 가져옴
                        var tabIndex = parseInt(tabId.replace('pills-home-tab', ''), 10);
                        var noticeIndex = $('#noticeIndex' + tabIndex).text();

                        document.getElementById('noticeIndex').value = noticeIndex;
                        loadFilesForTab(noticeIndex);
                    }

                });

            }
        } else {
            // 쿠키가 존재하는 경우 모달 숨기기
            $('#mainModal').modal('hide');
        }
    }


    //쿠키데이터 설정 function
    function setCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
    }

    //하루동안 보지 않기 클릭 시
    function closePop() {
        setCookie('erp_popup_secret_coupon', 'done', 1);
        $('#mainModal').modal('hide');
    }

    // yyyy-mm-dd format
    function yyyymmdd(dateIn) {
        var yyyy = dateIn.getFullYear()
        var mm = dateIn.getMonth() + 1 // getMonth() is zero-based
        var dd = dateIn.getDate()
        return String(yyyy + '-' + ('00' + mm).slice(-2) + '-' + ('00' + dd).slice(-2));
    }

    function sendHome(id) {
        const data = {};
        data.messageDivi = 'home';//
        data.id = id;
        window.parent.postMessage(data);
    }

    function loadFilesForTab(noticeIndex) {
        if ($('#dropzone-preview').children().length > 0) {
            $('#dropzone-preview').empty();
        }
        // 현재 탭에 해당하는 파일 로딩
        var param = {};
        param.corpCd = '${LoginInfo.corpCd}';
        param.noticeIndex = noticeIndex;
        var noticeFiles = edsUtil.getAjax("/erpNoticeView/selectERPNoticeFiles", param);
        var fileNameArr = [];
        if (noticeFiles.length > 0) {
            for (file of noticeFiles) {
                const corpCd = file.corpCd;
                const saveNm = file.saveNm;
                const ext = file.ext;
                const params = corpCd + "," + saveNm + "," + ext;
                let mockFile = {
                    index: file.index,
                    name: file.origNm + "." + file.ext,
                    size: file.size,
                    saveRoot: file.saveRoot
                };
                fileNameArr.push(file.origNm + "." + file.ext);
                // Dropzone에 파일 추가
                dropzone.displayExistingFile(mockFile, "/erpNoticeView/erpNoticeFilesLoad/" + params);

            }

            for (let i = 0; i < $('#dropzone-preview').children().length; i++){
                $('#dropzone-preview').children()[i].title = fileNameArr[i];
            }
        }
    }

    function dropZoneEvent() {

        var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
        dropzonePreviewNode.id = '';
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        dropzone = new Dropzone("#dropzone", {
                url: "/erpNoticeView/fileUpload", // 파일을 업로드할 서버 주소 url.
                method: "post", // 기본 post로 request 감. put으로도 할수있음
                autoProcessQueue: false,
                previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                previewsContainer: '#dropzone-preview',

                accept: function (file, done) {
                    done();
                },
                init: function (e) {
                    this.on('downloadedFile', async function (file) {
                        if (document.getElementById('noticeIndex').value) {
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
                }
            }
        )
    }


</script>
<body>

<!--   Modal  -->
<div class="modal fade" data-backdrop="static" id="mainModal" tabindex="-1" role="dialog"
     aria-labelledby="mainModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document" style="margin: 0.5rem auto">
    <div class="modal-content">
      <div class="modal-header" style="padding: 0 5px 0 5px;">
        <span style="font-size: 1.25rem"><b>공지사항</b></span>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="nav-container">
        <ul class="nav nav-pills mb-1" id="pills-tab" role="tablist">

        </ul>
      </div>

      <%-- body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <form id="modalForm" method="post" onsubmit="return false;">
          <span hidden="hidden" id="noticeIndex"></span>
          <div class="tab-content" id="pills-tabContent">

          </div>
        </form>

        <div id="dropzone" class="dropzone"
             style="display: none ;flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">

        </div>
        <div style="display: contents;">
          <div class="border-top"></div>
          <div style="padding: 0 0.5rem 0 0.5rem" id="attachedFile"><i class="fa-regular fa-file"></i> <b>첨부파일</b></div>
          <div class="border-bottom"></div>
          <div class="wrapper" id="dropzone-preview" style="overflow-x: scroll" title="">
            <div class="test border rounded-3" id="dropzone-preview-list"
                 style="width: 100px; min-width: 100px;margin: 5px;text-align: center; border-radius: 12px;">
              <!-- This is used as the file preview template -->
              <div class="" style=" height: 100px; width: inherit;">
                <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#" alt="Dropzone-Image"
                     style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
              </div>
              <div class="" style="margin-top: 2px; height: 50px;">
                <small class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down" style="display: block; height: auto;
    text-overflow: ellipsis !important; white-space: nowrap;">&nbsp;</small>
                <div class="row" style="margin: 0;">
                  <p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
                </div>
                <strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
              </div>
            </div>
          </div>
        </div>

        <a onclick="sendHome('150')" href="#" class="small-box-footer a-link">
          공지사항 바로가기 <i class="fas fa-arrow-circle-right"></i></a>
        <!--Footer-->
        <div class="modal-footer" style="display: block">
          <div class="row">
            <div class="col-md-12" style="padding: 0.5rem 0 0.5rem 0;background-color: #ebe9e4">
              <div class="col text-center">
                <div class="container">
                  <div class="row">
                    <div class="col text-center">
                      <button onclick="closePop();" type="button" class="btn btn-sm btn-danger"
                              style="position: absolute;left: 0" name="btnClose" id="btnClose1"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 오늘 하루 보지 않기
                      </button>
                      <button type="button" class="btn btn-sm btn-secondary" name="btnClose" id="btnClose"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 닫기
                      </button>
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
</body>
</html>
