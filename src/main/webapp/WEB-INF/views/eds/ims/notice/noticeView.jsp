<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>

<!DOCTYPE html>
<html>
<head>
  <title>Notice</title>
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

<link rel="stylesheet" href="/ims/notice/notice.css">

<link rel="stylesheet" href="/tui/tui-pagination/dist/tui-pagination.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">

<link rel="stylesheet" href="/css/edms/edms.css">

<link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css"/>

<script type="text/javascript" src='/js/com/eds.edms.js'></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js">
</script>

<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>
<script src="/js/util/eds.ims.js"></script>

<script>
    var mainSheet, noticeEditor, updateNoticeEditor, dropzone, updateDropzone, isChecked;
    var postNum;
    var dropzoneRemoveArr = new Array;
    Dropzone.autoDiscover = false;

    $(document).ready(async function () {
        dropZoneEvent();
        updateDropzoneEvent();
        await init();
        resetModalForm();
        imsUtil.focusSearch('titleSearch');
    });

    async function init() {

        $('#stDt').val(edsUtil.getFirstYear());
        $('#edDt').val(edsUtil.getLastYear);

        // 팝업 알림 옵션 체크 여부에 따라 처리
        $('#popUpOpt, #popUpOptUpdate').change(function () {
            isChecked = $(this).prop('checked');
            $('#endDt, #endDtUpdate').prop('readonly', !isChecked).val(isChecked ? '' : null);
            if (isChecked) setEndDate();
        });

        var noticeImages = [];
        var imageNames = [];
        var currentImageNames = [];

        noticeEditor = new toastui.Editor({
            el: document.querySelector('#editor'),
            height: '400px',
            language: 'ko',
            initialEditType: 'wysiwyg',
            theme: 'dark',
            hooks: {
                async addImageBlobHook(blob, callback) {
                    var divi = 'notice';
                    var moduleDivi = 'ims';
                    data = new FormData();
                    data.append('file', blob);
                    data.append('divi', divi);
                    data.append('moduleDivi', moduleDivi);

                    $.ajax({
                        data: data,
                        type: 'POST',
                        url: '/errorView/beforeUploadImageFile',
                        contentType: false,
                        async: false,
                        enctype: 'multipart/form-data',
                        processData: false,
                        success: async function (data) {
                            // 이미지를 에디터에 추가하는 콜백
                            callback(JSON.parse(data).url, 'image alt attribute');

                            // blob 객체에 URL 속성 추가
                            blob.urlData = JSON.parse(data).url;

                            // blob URL에서 파일 이름 추출
                            var fileName = extractFileName(blob.urlData);
                            imageNames.push(fileName);

                            // imageNames와 currentImageNames 간의 공통 데이터 찾기
                            var commonData = imageNames.filter(value => currentImageNames.includes(value));

                            // 공통 데이터가 있으면 blob을 noticeImages에 추가
                            if (commonData.length > 0) {
                                noticeImages.push(blob);
                            }

                            // noticeImages에서 현재 이미지 이름에 해당하지 않는 blob 제거
                            noticeImages = noticeImages.filter(existingBlob => {
                                const existingFileName = extractFileName(existingBlob.urlData);
                                return currentImageNames.includes(existingFileName);
                            });
                        },
                    });
                },
            },
        });
        updateNoticeEditor = new toastui.Editor({
            el: document.querySelector('#editorUpdate'),
            height: '400px',
            language: 'ko',
            initialEditType: 'wysiwyg',
            theme: 'dark',
            hooks: {
                async addImageBlobHook(blob, callback) {
                    var divi = 'notice';
                    var moduleDivi = 'ims';
                    data = new FormData()
                    data.append('file', blob)
                    data.append('divi', divi)
                    data.append('moduleDivi', moduleDivi)
                    $.ajax({
                        data: data,
                        type: 'POST',
                        url: '/errorView/beforeUploadImageFile',
                        contentType: false,
                        async: false,
                        enctype: 'multipart/form-data',
                        processData: false,
                        success: async function (data) {
                            callback(JSON.parse(data).url, 'image alt attribute');

                            // blob 객체에 URL 속성 추가
                            blob.urlData = JSON.parse(data).url;

                            // blob URL에서 파일 이름 추출
                            var fileName = extractFileName(blob.urlData);
                            imageNames.push(fileName);

                            // imageNames와 currentImageNames 간의 공통 데이터 찾기
                            var commonData = imageNames.filter(value => currentImageNames.includes(value));

                            // 공통 데이터가 있으면 blob을 noticeImages에 추가
                            if (commonData.length > 0) {
                                noticeImages.push(blob);
                            }

                            // noticeImages에서 현재 이미지 이름에 해당하지 않는 blob 제거
                            noticeImages = noticeImages.filter(existingBlob => {
                                const existingFileName = extractFileName(existingBlob.urlData);
                                return currentImageNames.includes(existingFileName);
                            });

                        },
                    })
                },
            }
        });

        noticeEditor.on('change', function () {
            // 현재 이미지 이름을 업데이트
            currentImageNames = extractImageFileNames(noticeEditor.getHTML());

            // noticeImages 업데이트
            noticeImages = noticeImages.filter(existingBlob => {
                const existingFileName = extractFileName(existingBlob.urlData);
                return currentImageNames.includes(existingFileName);
            });
        });
        updateNoticeEditor.on('change', function () {
            // 현재 이미지 이름을 업데이트
            currentImageNames = extractImageFileNames(updateNoticeEditor.getHTML());

            // noticeImages 업데이트
            noticeImages = noticeImages.filter(existingBlob => {
                const existingFileName = extractFileName(existingBlob.urlData);
                return currentImageNames.includes(existingFileName);
            });
        });

        function extractFileName(imagePath) {
            // 파일 이름 추출을 위한 정규식 사용
            const fileNameRegex = /\\([^\\]+)$/; // 마지막 \\ 이후의 모든 것을 추출
            const match = imagePath.match(fileNameRegex);
            if (match) {
                return match[1]; // 배열의 두 번째 요소에 추출된 파일 이름이 들어 있음
            }

            return null; // 일치하는 파일 이름이 없는 경우 null 반환
        }

        function extractImageFileNames(htmlString) {
            // HTML에서 이미지 파일 이름을 추출하기 위해 정규식 사용
            const imgSrcPattern = /<img[^>]*src\s*=\s*["']?([^>"']+)[^>]*>/g;
            const matches = htmlString.matchAll(imgSrcPattern);

            const imageNames = [];

            // 일치하는 결과에서 이미지 파일 이름 추출
            for (const match of matches) {
                const imgSrc = match[1].trim();
                const imgSrcArr = imgSrc.split('\\');
                const fileName = imgSrcArr[imgSrcArr.length - 1];
                imageNames.push(fileName);
            }

            return imageNames;
        }

        var param = {};
        param.corpCd = '${LoginInfo.corpCd}';
        param.stDt = document.getElementById('stDt').value;
        param.edDt = document.getElementById('edDt').value;

        $('form input').on('keydown', function (e) {
            if (e.which == 13) {
                e.preventDefault();
                doAction("mainSheet", "search");
            }
        });

        var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
        if (authDivi !== "01" && authDivi !== "03") {
            document.getElementById('callModal').disabled = true;
        }

        mainSheet = new tui.Grid({
            el: document.getElementById('grid'),
            scrollX: false,
            scrollY: false,
            editingEvent: 'click',
            bodyHeight: 600,
            rowHeight: 30,
            minRowHeight: 30,
            // rowHeaders: ['rowNum'],
            // rowHeaders: ['checkbox'], // 체크박스 기능
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
                header: '번호',
                name: 'rowNum',
                width: 60,
                align: 'center',
            },
            {
                header: '제목',
                name: 'title',
                minWidth: 100,
                align: 'center',
            },
            {
                header: '작성자',
                name: 'inpId',
                width: 100,
                align: 'center',
            },
            {
                header: '작성일',
                name: 'inpDttm',
                width: 100,
                align: 'center',
                formatter({value}) {
                    if (value !== null) {
                        return yyyymmdd(new Date(value));
                    }
                }
            },
            {
                header: '수정자',
                name: 'updId',
                width: 100,
                align: 'center',
            },
            {
                header: '수정일',
                name: 'updDttm',
                width: 100,
                align: 'center',
                formatter({value}) {
                    if (value !== null) {
                        return yyyymmdd(new Date(value));
                    }
                }
            },
            {
                header: '조회수',
                name: 'hit',
                width: 100,
                align: 'center',
            },
        ])

        // 글 번호 부여
        mainSheet.on('onGridMounted', ({instance}) => {
            const sortedData = instance.getData().sort((a, b) => a.rowNum - b.rowNum);

            sortedData.forEach(({rowKey}, index) => {
                instance.setValue(rowKey, 'rowNum', instance.getData().length - index);
            });
        });

        mainSheet.resetData(edsUtil.getAjax("/noticeView/selectNotice", param));

        $('#callModal').on('click', (e) => {
            $('#modalBodyUpdate').removeClass('show').addClass('hide');
            $('#modalBody').removeClass('hide').addClass('show');
        })

        $('#btnSave').on('click', (e) => {
            validate($('#modalForm'));
            if (!$('#modalForm').valid()) {
                return;
            }

            $('#modalBody').removeClass('hide').addClass('show');
            $('#modalBodyUpdate').removeClass('show').addClass('hide');

            var param = ut.serializeObject(document.querySelector("#modalForm"));
            param.status = 'C';
            param.corpCd = '${LoginInfo.corpCd}';
            param.depaCd = '${LoginInfo.depaCd}';
            param.depaNm = "${LoginInfo.depaNm}";
            param.busiCd = "${LoginInfo.busiCd}"
            param.content = noticeEditor.getHTML();

            var formData = new FormData();
            const params = [param];

            formData.append("html", noticeEditor.getHTML());
            formData.append("divi", 'notice');
            formData.append("moduleDivi", 'ims');
            formData.append("data", JSON.stringify(params));

            var files = [];
            noticeImages.forEach((blob) => {
                const fileName = blob.name;
                const fileType = blob.type;
                const file = new File([blob], fileName, {type: fileType});
                files.push(file);
            });

            // 각 파일을 FormData에 추가
            files.forEach((file) => {
                formData.append('file', file);
            });
            // 앱 키 445c8fb1.7962b3737a9f4f1f95820e1caac2c49f
            var newFiles = dropzone.getAcceptedFiles();
            for (let index in newFiles) {
                formData.append('attachedFile', newFiles[index]);
            }

            $.ajax({
                url: "/noticeView/cudNotice",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#mainModal').modal('hide');

                    if (isChecked) {
                        setCookie('popup_secret_coupon_ims', 'done', -1);
                    }

                    var userParam = {};
                    userParam.corpCd = '${LoginInfo.corpCd}';
                    userParam.useYn = '01';
                    var userInfo = await edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", userParam);
                    var userEmail = [];
                    for (let i = 0; i < userInfo.length; i++) {
                        if (userInfo[i].emailKakaowork !== '' && userInfo[i].emailKakaowork !== null) {
                            userEmail.push(userInfo[i].emailKakaowork);
                        }
                    }

                    postNum = mainSheet.getData().length + 1;
                    var param = {};
                    param.corpCd = '${LoginInfo.corpCd}';
                    param.userEmail = userEmail;
                    param.writer = '${LoginInfo.empNm}' + '[' + '${LoginInfo.depaNm}' + ']';
                    param.date = imsUtil.getDate();
                    param.title = $('#title').val();
                    param.postNum = String(postNum);
                    param.divi = 'IMS';

                    await edsUtil.getAjax2("/sendController/noticeAllEmployee", param);
                    doAction('mainSheet', 'search');

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

        var imageList = [];
        mainSheet.on('click', async (e) => {

            if (e.targetType === 'cell') {
                $('#modalBody').removeClass('show').addClass('hide')
                $('#modalBodyUpdate').removeClass('hide').addClass('show')
                $('#mainModal').modal('show');

                var cellData = mainSheet.getData()[e.rowKey];
                $('#noticeIndex').val(cellData.index);
                param.noticeIndex = $('#noticeIndex').val();

                var imageData = edsUtil.getAjax("/noticeView/selectNoticeImageList", param);
                imageList.push(imageData);


                <%--if (cellData.depaCd !== '${LoginInfo.depaCd}') {--%>
                <%--    $('.btnUpdate').css('display', 'none');--%>
                <%--    $('.btnDelete').css('display', 'none');--%>
                <%--} else {--%>
                <%--    $('.btnUpdate').css('display', 'inline-block');--%>
                <%--    $('.btnDelete').css('display', 'inline-block');--%>
                <%--}--%>

                var isSameDepaCd = cellData.depaCd === '${LoginInfo.depaCd}';
                $('.btnUpdate, .btnDelete').css('display', isSameDepaCd ? 'inline-block' : 'none');

                param.index = cellData.index;
                var siteData = edsUtil.getAjax("/noticeView/selectNoticeByIndex", param);

                var data = {}
                data.data = siteData[0]
                data.form = document.getElementById('modalFormUpdate');

                $('#endDtUpdate').prop('readonly', data.data.endDt === '');
                $('#popUpOptUpdate').prop('checked', data.data.endDt !== '');

                if (data.data.content != null) {
                    await updateNoticeEditor.setHTML(data.data.content);
                }

                imageList.data = updateNoticeEditor.getHTML();

                var noticeFiles = edsUtil.getAjax("/noticeView/selectNoticeFiles", param);
                for (file of noticeFiles) {
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
                    updateDropzone.displayExistingFile(mockFile, "/noticeView/noticeFilesLoad/" + params);
                }

                var dataToForm = await edsUtil.eds_dataToForm(data);
            }
        })

        /*******************************************************
         수정 / update
         *******************************************************/
        $('#btnUpdate').on('click', (e) => {
            validate($('#modalFormUpdate'));
            if (!$('#modalFormUpdate').valid()) {
                return;
            }

            var param = ut.serializeObject(document.querySelector("#modalFormUpdate"));

            param.status = 'U';
            param.corpCd = ${LoginInfo.corpCd};
            param.depaCd = ${LoginInfo.depaCd};
            param.busiCd = "${LoginInfo.busiCd}"
            param.depaNm = "${LoginInfo.depaNm}";
            param.updId = "${LoginInfo.empCd}";
            param.noticeIndex = $('#noticeIndex').val();
            param.content = updateNoticeEditor.getHTML();

            var formData = new FormData();

            var newFiles = updateDropzone.getAcceptedFiles();
            for (let index in newFiles) {
                formData.append('attachedFile', newFiles[index]);
            }

            const params = [param];
            var files = [];
            noticeImages.forEach((blob) => {
                const fileName = blob.name;
                const fileType = blob.type;
                const file = new File([blob], fileName, {type: fileType});
                files.push(file);
            });

            // 각 파일을 FormData에 추가
            files.forEach((file) => {
                formData.append('file', file);
            });
            formData.append("html", updateNoticeEditor.getHTML());
            formData.append("divi", 'notice');
            formData.append("moduleDivi", 'ims');
            formData.append("images", imageList.data);

            formData.append("data", JSON.stringify(params));

            // 현재 파일
            var currentFile = updateNoticeEditor.getHTML();
// HTML 문자열을 DOM으로 변환
            var parser = new DOMParser();
            var doc = parser.parseFromString(currentFile, 'text/html');

// <img> 태그를 추출하여 배열로 저장
            var imgElements = doc.querySelectorAll('img');
            var imgArray = Array.from(imgElements).map(function (img) {
                return img.src;
            });

// 원래 파일
            var originalFile = imageList;

// 삭제된 파일 배열
            var deletedFiles = [];

// originalFile에는 있었으나 imgArray에 없는 파일들을 deletedFiles에 추가
            originalFile[0].forEach(obj => {
                let value = obj.saveNm;
                if (!imgArray.some(url => url.includes(value))) {
                    deletedFiles.push(value);
                }
            });

            $.ajax({
                url: "/noticeView/cudNotice",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#mainModal').modal('hide');

                    if (isChecked) {
                        setCookie('popup_secret_coupon_ims', 'done', -1);
                    }

                    var paramData = [];
                    for (const files of dropzoneRemoveArr) {
                        let data = {};
                        data.saveRoot = files.saveRoot;
                        data.index = files.index;
                        data.noticeIndex = $('#noticeIndex').val();
                        data.corpCd =${LoginInfo.corpCd};
                        data.busiCd = "${LoginInfo.busiCd}";
                        paramData.push(data);
                    }
                    if (paramData.length > 0) await edsUtil.getAjax2("/noticeView/deleteNoticeFile", paramData)
                    dropzoneRemoveArr = [];
                    updateDropzone.removeAllFiles();

                    var removeImage = [];
                    for (const images of deletedFiles) {
                        let data = {};
                        data.saveNm = images;
                        data.noticeIndex = $('#noticeIndex').val();
                        data.corpCd = '${LoginInfo.corpCd}';
                        data.busiCd = "${LoginInfo.busiCd}";
                        removeImage.push(data);
                    }
                    if (removeImage.length > 0) await edsUtil.getAjax2("/noticeView/noticeImageDelete", removeImage)

                    await doAction('mainSheet', 'search');
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
         삭제 / delete
         *******************************************************/
        $('#btnDelete').on('click', (e) => {
            var param = {};
            param.corpCd = '${LoginInfo.corpCd}';
            param.noticeIndex = $('#noticeIndex').val();
            param.busiCd = "${LoginInfo.busiCd}";
            param.status = "D";
            param.content = updateNoticeEditor.getHTML();

            var noticeFiles = edsUtil.getAjax("/noticeView/selectNoticeFiles", param);
            dropzoneRemoveArr.push(noticeFiles);

            var formData = new FormData();
            const params = [param];
            formData.append("html", updateNoticeEditor.getHTML());
            formData.append("divi", 'notice');
            formData.append("moduleDivi", 'ims');
            formData.append("data", JSON.stringify(params));

            $.ajax({
                url: "/noticeView/cudNotice",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#mainModal').modal('hide');

                    var paramData = [];
                    for (const files of noticeFiles) {
                        let data = {};
                        data.saveRoot = files.saveRoot;
                        data.noticeIndex = $('#noticeIndex').val();
                        data.corpCd =${LoginInfo.corpCd};
                        data.busiCd = "${LoginInfo.busiCd}";
                        paramData.push(data);
                    }
                    if (paramData.length > 0) await edsUtil.getAjax2("/noticeView/deleteNoticeFilesAll", paramData)

                    // await edsUtil.getAjax2("/noticeView/noticeImageDeleteAll", param);

                    await doAction('mainSheet', 'search');
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

    }

    function dropZoneEvent() {
        var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
        dropzonePreviewNode.id = '';
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        dropzone = new Dropzone("#dropzone", {
                url: "/noticeView/fileUpload", // 파일을 업로드할 서버 주소 url.
                method: "post", // 기본 post로 request 감. put으로도 할수있음
                autoProcessQueue: false,
                previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                previewsContainer: '#dropzone-preview',
                acceptedFiles: ".xlsx,.xls,application/pdf,image/*,.hwp",   //파일 종류
                maxFilesize: 100,
                accept: function (file, done) {
                    done();
                },
                init: function (e) {
                    // 파일이 업로드되면 실행
                    this.on('addedfile', function (file) {
                        var ext = file.name.split('.').pop();
                        if (ext == "pdf") {
                            this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
                        } else if (ext.indexOf("doc") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/wordimg.jpg");
                        } else if (ext.indexOf("xls") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/exclimg.jpg");
                        } else if (ext.indexOf("hwp") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/hwpimg.jpg");
                        }
                    });
                    // 업로드 에러 처리
                    this.on('error', function (file, errorMessage) {
                        this.removeFile(file);
                        alert(errorMessage);
                    });
                }
            }
        )
    }

    function updateDropzoneEvent() {
        var dropzonePreviewNode = document.querySelector('#update-dropzone-preview-list');
        dropzonePreviewNode.id = '';
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
        updateDropzone = new Dropzone("#updateDropzone", {
                url: "/noticeView/fileUpload", // 파일을 업로드할 서버 주소 url.
                method: "post", // 기본 post로 request 감. put으로도 할수있음
                autoProcessQueue: false,
                previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                previewsContainer: '#update-dropzone-preview',
                acceptedFiles: ".xlsx,.xls,application/pdf,image/*,.hwp",   //파일 종류
                maxFilesize: 100,
                accept: function (file, done) {
                    done();
                },
                init: function (e) {
                    // 파일이 업로드되면 실행
                    this.on('addedfile', function (file) {
                        var ext = file.name.split('.').pop();
                        if (ext == "pdf") {
                            this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
                        } else if (ext.indexOf("doc") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/wordimg.jpg");
                        } else if (ext.indexOf("xls") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/exclimg.jpg");
                        } else if (ext.indexOf("hwp") != -1) {
                            this.emit("thumbnail", file, "/img/fileImage/hwpimg.jpg");
                        }
                    });
                    // 업로드 에러 처리
                    this.on('error', function (file, errorMessage) {
                        this.removeFile(file);
                        alert(errorMessage);
                    });

                    this.on('removedfile', function (file) {
                        // 저장되어 있는 이미지일때만 추가
                        if (file.status != "queued" && file.status != "added") {
                            dropzoneRemoveArr.push(file);
                        }
                    });

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
                },
            }
        );
    }


    // yyyy-mm-dd format
    function yyyymmdd(dateIn) {
        var yyyy = dateIn.getFullYear()
        var mm = dateIn.getMonth() + 1 // getMonth() is zero-based
        var dd = dateIn.getDate()
        return String(yyyy + '-' + ('00' + mm).slice(-2) + '-' + ('00' + dd).slice(-2));
    }

    /* 화면 이벤트 */
    async function doAction(sheetNm, sAction) {
        if (sheetNm == 'mainSheet') {
            switch (sAction) {
                case "search":// 조회
                    var param = ut.serializeObject(document.querySelector("#searchForm"));
                    param.corpCd = '${LoginInfo.corpCd}';
                    param.depaCd = '${LoginInfo.depaCd}';

                    mainSheet.resetData(edsUtil.getAjax("/noticeView/selectNotice", param));

                    // 게시글 번호 정렬
                    const sortedData = mainSheet.getData().sort((a, b) => a.rowNum - b.rowNum);
                    sortedData.forEach(({rowKey}, index) => {
                        mainSheet.setValue(rowKey, 'rowNum', mainSheet.getData().length - index);
                    });
                    break;
            }
        }
    }

    // 현재 날짜로 값을 설정하는 함수
    function setEndDate() {
        var currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + 5);
        var formattedDate = currentDate.toISOString().split('T')[0];
        $('#endDt, #endDtUpdate').val(formattedDate);
    }

    function validate(form) {
        form.validate({
            rules: {
                title: {
                    required: true
                },
            },
            messages: {}
        })
        $.extend($.validator.messages, {
            required: "필수 항목입니다."    // required 속성의 공동 메세지
        });
    }

    function resetModalForm() {
        $('#mainModal').on('hidden.bs.modal', function (e) {
            $(this).validate().resetForm();
            $(this).find('.error').removeClass('error');
            $(this).find('form')[0].reset();
            $(this).find('form')[1].reset();
            noticeEditor.reset();
            updateNoticeEditor.reset();
            dropzone.removeAllFiles(true);
            updateDropzone.removeAllFiles(true);
            dropzoneRemoveArr = [];
            $('.dz-image-preview').remove();
        });
    }

    //쿠키데이터 설정 function
    function setCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
    }

</script>
<body class="body">
<div style="background-color: #ebe9e4; padding: unset">
  <div style="background-color: #faf9f5;border: 1px solid #dedcd7;">
    <!-- form start -->
    <form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
      <!-- input hidden -->
      <input type="hidden" name="corpCd" id="corpCd" title="회사코드">
      <!-- ./input hidden -->

      <div class="form-group col-sm-12">
        <button id="callModal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mainModal">공지사항
          등록
        </button>
        <div class="form-group" style="margin-left: 5rem"></div>

        <div class="input-group mr-3">
          <label for="stDt">조회기간 &nbsp;</label>
          <div class="input-group-prepend">
            <input type="date" class="form-control"
                   style="width: 150px; font-size: 15px;border-radius: 3px; text-align: center" name="stDt" id="stDt"
                   title="시작">
          </div>
          <span style="align-self: center">&nbsp;~&nbsp;</span>
          <div class="input-group-append">
            <input type="date" class="form-control"
                   style="width: 150px; font-size: 15px;border-radius: 3px;text-align: center" name="edDt" id="edDt"
                   title="끝">
          </div>
        </div>

        <div class="input-group input-group-sm">
          <label for="titleSearch">제목 &nbsp;</label>
          <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="title"
                 id="titleSearch"
                 title="제목">
          <input type="button" class="btn btn-sm btn-primary" value="검색" onclick="doAction('mainSheet', 'search')">
        </div>
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
<!--   Modal  -->
<div class="modal fade" data-backdrop="static" id="mainModal" tabindex="-1" role="dialog"
     aria-labelledby="mainModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">
        <span><b>공지사항</b></span>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%-- create / 등록 body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <form id="modalForm" method="post" onsubmit="return false;">
          <span hidden="hidden" id="noticeIndex"></span>
          <div class="input-group mb-0">
            <label class="input-group-text" for="title">제목</label>
            <input type="text" maxlength="50" class="form-control" placeholder="제목" aria-label="title"
                   aria-describedby="basic-addon1"
                   id="title" name="title">
          </div>
          <div class="input-group mb-0">
            <label class="input-group-text">옵션</label>
            <div class="custom-control custom-switch d-flex align-items-center ml-3">
              <input type="checkbox" class="custom-control-input" id="popUpOpt">
              <label class="custom-control-label" for="popUpOpt">팝업 알림</label>
            </div>
            <input readonly id="endDt" class="form-control text-center col-lg-1 ml-3" name="endDt" type="date"
                   max="9999-12-31">
            <label class="align-self-center m-0" for="endDt">까지</label>
          </div>
        </form>

        <div class="input-group mb-0" style="align-items: center">
          <label class="input-group-text">첨부파일</label>
          <div id="dropzone" class="dropzone"
               style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
            <div class="border-top"></div>
            <div class="dz-message needsclick" style="margin: 0;">
              <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png" alt="Camera"
                   style="width: 35px;"/>
              클릭 또는 드래그하여 파일을 첨부해 주세요.
            </div>
            <div class="border-bottom"></div>
          </div>
          <div style="display: contents;">
            <div class="wrapper" id="dropzone-preview" style="overflow-x: scroll">
              <div class="test border rounded-3" id="dropzone-preview-list"
                   style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                <!-- This is used as the file preview template -->
                <div class="" style=" height: 120px; width: inherit;">
                  <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#" alt="Dropzone-Image"
                       style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                </div>
                <div class="" style="margin-top: 2px; height: 80px;">
                  <small class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down">&nbsp;</small>
                  <div class="row" style="margin: 0;">
                    <p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
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

        <%--        에디터--%>
        <div id="editor"></div>

        <!--Footer-->
        <div class="modal-footer" style="display: block">
          <div class="row">
            <div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <div class="container">
                  <div class="row">
                    <div class="col text-center">
                      <button type="button" class="btn btn-sm btn-primary" name="btnClose" id="btnClose"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 닫기
                      </button>
                      <button type="submit" class="btn btn-sm btn-success" id="btnSave">
                        <i class="fa fa-save"></i> 등록
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
        <form id="modalFormUpdate" method="post" onsubmit="return false;">
          <div class="input-group mb-0">
            <label class="input-group-text" for="title">제목</label>
            <input type="text" maxlength="50" class="form-control" placeholder="제목" aria-label="title"
                   aria-describedby="basic-addon1"
                   id="titleUpdate" name="title">
          </div>
          <div class="input-group mb-0">
            <label class="input-group-text">옵션</label>
            <div class="custom-control custom-switch d-flex align-items-center ml-3">
              <input type="checkbox" class="custom-control-input" id="popUpOptUpdate">
              <label class="custom-control-label" for="popUpOptUpdate">팝업 알림</label>
            </div>
            <input readonly id="endDtUpdate" class="form-control text-center col-lg-1 ml-3" name="endDt" type="date"
                   max="9999-12-31">
            <label class="align-self-center m-0" for="endDtUpdate">까지</label>
          </div>
        </form>

        <div class="input-group mb-0" style="align-items: center">
          <label class="input-group-text">파일첨부</label>
          <div id="updateDropzone" class="dropzone"
               style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
            <div class="border-top"></div>
            <div class="dz-message needsclick" style="margin: 0;">
              <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png" alt="Camera"
                   style="width: 35px;"/>
              클릭 또는 드래그하여 파일을 첨부해 주세요.
            </div>
            <div class="border-bottom"></div>
          </div>
          <div style="display: contents;">
            <div class="wrapper" id="update-dropzone-preview" style="overflow-x: scroll">
              <div class="test border rounded-3" id="update-dropzone-preview-list"
                   style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                <!-- This is used as the file preview template -->
                <div class="" style=" height: 120px; width: inherit;">
                  <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#" alt="Dropzone-Image"
                       style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                </div>
                <div class="" style="margin-top: 2px; height: 80px;">
                  <small class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down">&nbsp;</small>
                  <div class="row" style="margin: 0;">
                    <p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
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

        <div id="editorUpdate"></div>

        <!--Footer-->
        <div class="modal-footer" style="display: block">
          <div class="row">
            <div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <div class="container">
                  <div class="row">
                    <div class="col text-center">
                      <button type="button" class="btn btn-sm btn-primary" name="btnClose"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 닫기
                      </button>
                      <button type="button" class="btn btn-sm btn-danger btnDelete" data-toggle="modal"
                              id="confirmDelete"
                              data-target="#confirmModal">
                        <i class="fa fa-trash"></i> 삭제
                      </button>
                      <button type="submit" class="btn btn-sm btn-success btnUpdate" id="btnUpdate">
                        <i class="fa fa-save"></i> 수정
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
        <button id="btnDelete" type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
