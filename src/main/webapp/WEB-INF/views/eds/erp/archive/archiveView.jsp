<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>

<!DOCTYPE html>
<html>
<head>
  <title>archive</title>
</head>
<%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
<%-- 공통헤드 --%>
<%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
<%-- 공통 스타일시트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
<%-- 공통 스크립트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf" %>
<%-- tui grid --%>
<link rel="stylesheet" href="/css/archive/archive.css">
<link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css"/>
<link rel="stylesheet" href="/css/edms/edms.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>
<script type="text/javascript" src='/js/com/eds.edms.js'></script>
<script type="text/javascript" src='/js/com/twbsPagination.min.js'></script>
<script src="/js/util/eds.ims.js"></script>
<body id="body" class="body" style="height: 100%">
<div class="d-flex justify-content-center">
  <div id="div_load_image" style="position:absolute; top:30%; z-index:9999; display: none">
    <script>
        var body, selectpicker, dropzone, updateDropzone, fileDropzone, updateFileDropzone;
        var dropzoneRemoveArr = [];
        var fileDropzoneRemoveArr = [];
        Dropzone.autoDiscover = false;
        var archiveData, removedFile, videoData, thumbData, filesData;
        var uploadCount = 0;
        var currentPage = 1;

        var existingVideo = [];
        var existingThumbnail = [];
        var existingFiles = [];

        $(document).ready(async () => {
            dropZoneEvent();
            updateDropZoneEvent();
            fileDropZoneEvent();
            updateFileDropZoneEvent();
            await init();
            resetModalForm();
            autoComplete();
            imsUtil.focusSearch('search')
            // $('.collapse').on('show.bs.collapse', function () {
            //
            //     // hide all accordion except the clicked one
            //     $('.collapse').not(this).collapse('hide');
            //
            // });
        });

        function init() {

            body = document.getElementById('body');
            edsUtil.setForm(document.querySelector("#searchForm"), "basma");

            selectpicker = $('.selectpicker').select2({
                language: 'ko'
            });

            $('form input').on('keydown', function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    doAction("body", "search");
                }
            });

            $(".selectpicker").on('change', async ev => {
                var id = ev.target.id;
                switch (id) {
                    case 'depaDiviSearch':
                        await doAction('body', 'search');
                }
            });

            /* 1년 날짜 셋팅 */
            let today = edsUtil.getFirstday();
            let stDt = today.substr(0, 4) + "-01-01";
            let edDt = today.substr(0, 4) + "-12-31";
            // document.getElementById('stDt').value = stDt;
            // document.getElementById('edDt').value = edDt;

            var param = {};
            param.corpCd = '${LoginInfo.corpCd}';
            archiveData = edsUtil.getAjax('/archiveView/selectArchive', param);
            // console.log('불러온 데이터:', archiveData);

            if (archiveData.length > 0) {
                var bodyContent = '';
                var archiveIndex = '';
                var archivetitle = '';
                var src = '';
                var videoSrc = '';
                var archiveOrigNm = '';
                var videoName = '';
                // for (let i = 0; i < archiveData.length; i++) {
                //     archiveIndex = archiveData[i].index;
                //     archivetitle = archiveData[i].title;
                //     archiveOrigNm = archiveData[i].origNm;
                //     // videoName = `\${archiveData[i].videoSaveNm} + '.' + \${archiveData[i].videoExt}`;
                //     // console.log('데이터 보자')
                //     // console.log(archiveData[i])
                //     // src = archiveData[i].saveNm + '.' + archiveData[i].ext;
                //     src = `/archiveView/archiveFilesLoad/\${archiveData[i].corpCd},\${archiveData[i].saveNm},\${archiveData[i].ext}`;
                //
                //     videoSrc = `/archiveView/archiveVideoLoad/\${archiveData[i].corpCd},\${archiveData[i].videoSaveNm},\${archiveData[i].videoExt}`;
                //
                //     bodyContent += `<div id="\${archiveIndex}" class="filter-item col-sm-2" data-category="1" data-sort="white sample">
                //       <a href="#" data-toggle="lightbox" class="open-video-modal" data-toggle="modal" data-target="#mainModal" data-src="\${src}" data-video-src="\${videoSrc}" data-title="\${archivetitle}" data-video-name="\${videoName}">
                //         <img src="\${src}" class="img-fluid mb-2" alt="white sample"/>
                //       </a>
                //     </div>`;
                // }

                $('#bodyContent').html(bodyContent);

                // 모달 열기 이벤트
//             $(document).on('click', '.open-video-modal', function (e) {
//                 console.log('클릭')
//                 console.log($(this))
//                 var content = $(this).data('content');
// // 큰따옴표 이스케이프 처리
//                 console.log('Content:', content);
//                 // $('#videoModal').modal('show');
//
//                 var newFile = document.getElementById('updateFile');
//                 var oldFile = document.getElementById('updateFile2');
//
//                 const myFile = new File([''], $(this).data('video-orignm'), {
//                     type: 'video/mp4',
//                     lastModified: new Date()
//                 });
//
//                 const myFile2 = new File([''], $(this).data('video-name'), {
//                     type: 'video/mp4',
//                     lastModified: new Date()
//                 });
//
//                 function setFiles(fileInput, file) {
//                     const dataTransfer = new DataTransfer();
//                     dataTransfer.items.add(file);
//                     fileInput.files = dataTransfer.files;
//                 }
//
//                 setFiles(newFile, myFile);
//                 setFiles(oldFile, myFile2);
//
//                 removedFile = oldFile.files[0];
//
//                 $('#modalBody').css('display', 'none');
//                 $('#modalBodyUpdate').css('display', 'inline-block');
//                 $('#mainModal').modal('show');
//
//                 var videoSrc = $(this).data('video-src');
//                 var src = $(this).data('src');
//                 var videoTitle = $(this).data('title');
//                 var videoContent = $(this).data('content');
//                 var videoName = $(this).data('video-name');
//                 var videoOrigNm = $(this).data('video-orignm');
//
//                 $('#archiveIndex2').val(e.currentTarget.parentElement.id);
//
//                 $('#titleUpdate').val(videoTitle);
//                 $('#contentUpdate').val(videoContent);
//
//                 $('#videoUpdate').attr('src', videoSrc);
//
//                 param.archiveIndex = $('#archiveIndex2').val();
//
//                 var thumbData = edsUtil.getAjax("/archiveView/selectArchiveThum", param);
//                 // $('#testImg').css('object-fit', 'contain');
//                 // $('#testImg').css('overflow', 'scroll');
//                 for (file of thumbData) {
//                     const corpCd = file.corpCd;//회사코드
//                     const saveNm = file.saveNm;//저장명
//                     const ext = file.ext;//확장자
//                     const params = corpCd + "," + saveNm + "," + ext;
//                     let mockFile = {
//                         index: file.index,
//                         name: file.origNm + "." + file.ext,
//                         size: file.size,
//                         saveRoot: file.saveRoot
//                     };
//                     updateDropzone.displayExistingFile(mockFile, "/archiveView/archiveFilesLoad/" + params);
//                 }
//
//                 document.getElementById('videoUpdate').poster = src;
//             });

                const updateFile = document.getElementById("updateFile");
                const video = document.getElementById("videoUpdate");
                const updateElements = document.querySelectorAll('#btnClearInputUpdate, #videoUpdate');

                updateFile.addEventListener("change", function () {
                    if (updateFile.value !== '') {
                        const file = updateFile.files[0];
                        const videourl = URL.createObjectURL(file);
                        video.setAttribute("src", videourl);
                        updateElements.forEach(item => {
                            item.classList.remove('d-none');
                            item.classList.add('d-block');
                        });
                    } else {
                        updateElements.forEach(item => {
                            item.classList.remove('d-block');
                            item.classList.add('d-none');
                        });
                    }
                })
                initPagination(archiveData);
            }

            const inputFile = document.getElementById("file");
            const video = document.getElementById("video");
            const elements = document.querySelectorAll('#btnClearInput, #video');
            video.preload = "auto"

            inputFile.addEventListener("change", function (e) {
                if (inputFile.value !== '') {
                    const file = inputFile.files[0];
                    const videourl = URL.createObjectURL(file);
                    video.setAttribute("src", videourl);
                    elements.forEach(item => {
                      item.classList.remove('d-none');
                      item.classList.add('d-block');
                    });
                } else {
                    elements.forEach(item => {
                        item.classList.remove('d-block');
                        item.classList.add('d-none');
                    });
                }
            })

            // dropzone.on('addedfile', file => {
            //
            // });

            $('#insertBtn').on('click', () => {
                $('#modalBody').css('display', 'inline-block');
                $('#modalBodyUpdate').css('display', 'none');
            });

            $('#btnSave').on('click', () => {
                validate($('#modalForm'));
                if (!$('#modalForm').valid()) {
                    return;
                }
                // else if ($('#dropzone-preview').children().length < 1) {
                //     alert('썸네일을 첨부해 주세요.')
                //     return;
                // }

                var param = ut.serializeObject(document.querySelector("#modalForm"));
                param.status = 'C';
                param.corpCd = '${LoginInfo.corpCd}';
                param.depaCd = '${LoginInfo.depaCd}';
                param.depaNm = "${LoginInfo.depaNm}";
                param.busiCd = "${LoginInfo.busiCd}"
                var formData = new FormData();
                const params = [param];
                formData.append("data", JSON.stringify(params));

                if (dropzone.getAcceptedFiles()) {
                    var thumbnail = dropzone.getAcceptedFiles();
                    for (let index in thumbnail) {
                        formData.append('thumbnail', thumbnail[index]);
                    }
                }

                if (fileDropzone.getAcceptedFiles()) {
                    var files = fileDropzone.getAcceptedFiles();
                    for (let index in files) {
                        formData.append('files', files[index]);
                    }
                }

                if (inputFile.files[0]) {
                    var video = inputFile.files[0];
                    formData.append('video', video);
                }

                formData.append('divi', 'archive');
                formData.append('moduleDivi', 'erp');

                $.ajax({
                    url: "/archiveView/cudArchive",
                    type: "POST",
                    data: formData,
                    // async: false,
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    cache: false,
                    beforeSend: function () {
                        $('#div_load_image').show();
                    },
                    complete: function () {
                        $('#div_load_image').hide();
                    },
                    success: async function (result) {
                        $('#mainModal').modal('hide');

                        var param = {};
                        param.corpCd = '${LoginInfo.corpCd}';
                        var data = await edsUtil.getAjax("/archiveView/selectArchive", param);

                        // 페이징을 초기화합니다.
                        currentPage = 1;
                        initPagination(data);
                        if (!result.sess && typeof result.sess != "undefined") {
                            alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                            return;
                        }

                        if (result.IO.Result == 0 || result.IO.Result == 1) {
                            Swal.fire({
                                icon: 'success',
                                title: '성공',
                                text: result.IO.Message,
                            })
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: '실패',
                                text: result.IO.Message,
                            });
                        }
                    },
                })
            });

            $('#btnUpdate').on('click', () => {
                const inputFile = document.getElementById("updateFile");

                validate($('#modalFormUpdate'));
                if (!$('#modalFormUpdate').valid()) {
                    return;
                }

                var param = ut.serializeObject(document.querySelector("#modalFormUpdate"));
                param.status = 'U';
                param.index = $('#archiveIndex2').val();
                param.archiveIndex = $('#archiveIndex2').val();
                param.corpCd = ${LoginInfo.corpCd};
                param.depaCd = ${LoginInfo.depaCd};
                param.busiCd = "${LoginInfo.busiCd}"
                param.depaNm = "${LoginInfo.depaNm}";
                param.updId = "${LoginInfo.empNm}";

                var video = inputFile.files[0];
                var newThumbnail = updateDropzone.getAcceptedFiles();
                var newFiles = updateFileDropzone.getAcceptedFiles();

                var formData = new FormData();
                formData.append('divi', 'archive');
                formData.append('moduleDivi', 'erp');

                if (video !== undefined && video.size > 0) {
                    formData.append('video', video);
                }
                if (newThumbnail.length) {
                    for (let index in newThumbnail) {
                        formData.append('thumbnail', newThumbnail[index]);
                    }
                }
                if (newFiles.length) {
                    for (let index in newFiles) {
                        formData.append('files', newFiles[index]);
                    }
                }

                const params = [param];
                formData.append("data", JSON.stringify(params));

                $.ajax({
                    url: "/archiveView/cudArchive",
                    type: "POST",
                    data: formData,
                    async: false,
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    cache: false,
                    success: async function (result) {
                        $('#mainModal').modal('hide');

                        var param = {};
                        if ((video?.size && existingVideo !== 'undefined') || (video === undefined && existingVideo !== 'undefined')) {
                            param.removedVideo = existingVideo;
                        }
                        if ((dropzoneRemoveArr.length && existingThumbnail !== undefined)) {
                            param.removedTumbnail = existingThumbnail;
                        }
                        if (fileDropzoneRemoveArr.length) {
                            let fileParam = [];
                            var fileIndex = [];
                            for (const item of fileDropzoneRemoveArr) {
                                fileParam.push(item.saveRoot);
                                fileIndex.push(String(item.index));
                            }
                            param.removedFiles = fileParam;
                        }
                        param.archiveIndex = $('#archiveIndex2').val();
                        param.index = fileIndex;

                        await edsUtil.getAjax2("/archiveView/deleteFiles", param);




                        <%--if (formData.get('file') !== null) {--%>
                        <%--    var corpCd = '${LoginInfo.corpCd}';--%>
                        <%--    var moduleDivi = 'erp';--%>
                        <%--    var fileName = removedFile.name;--%>

                        <%--    var saveRoot = `src/main/resources/file/\${corpCd}/\${moduleDivi}/0001/archive/\${fileName}`;--%>

                        <%--    var paramData2 = [];--%>
                        <%--    let data2 = {};--%>
                        <%--    data2.saveRoot = saveRoot;--%>
                        <%--    paramData2.push(data2);--%>
                        <%--    await edsUtil.getAjax2("/archiveView/deleteArchiveFile", paramData2);--%>
                        <%--}--%>

                        <%--var paramData = [];--%>
                        <%--for (const files of dropzoneRemoveArr) {--%>
                        <%--    let data = {};--%>
                        <%--    if (dropzoneRemoveArr.length > 0 && newThumbnail.length > 0) {--%>
                        <%--        data.updateFlag = 'true';--%>
                        <%--    }--%>
                        <%--    data.saveRoot = files.saveRoot;--%>
                        <%--    data.index = files.index;--%>
                        <%--    data.archiveIndex = $('#archiveIndex2').val();--%>
                        <%--    data.corpCd =${LoginInfo.corpCd};--%>
                        <%--    data.busiCd = "${LoginInfo.busiCd}";--%>
                        <%--    paramData.push(data);--%>
                        <%--}--%>
                        <%--if (paramData.length > 0) await edsUtil.getAjax2("/archiveView/deleteArchiveImageList", paramData)--%>

                        // dropzoneRemoveArr = [];
                        // updateDropzone.removeAllFiles();

                        var selectParam = {};
                        selectParam.corpCd = '${LoginInfo.corpCd}';
                        var selectData = await edsUtil.getAjax("/archiveView/selectArchive", selectParam);

                        // 페이징을 초기화합니다.
                        initPagination(selectData);

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
            });

            $('#btnDelete').on('click', ()=>{
                var param = {};
                param.corpCd = '${LoginInfo.corpCd}';
                param.index = $('#archiveIndex2').val();
                param.archiveIndex = $('#archiveIndex2').val();
                param.status = "D";
                param.busiCd = "${LoginInfo.busiCd}";

                var formData = new FormData();
                const params = [param];
                formData.append("data", JSON.stringify(params));

                $.ajax({
                    url: "/archiveView/cudArchive",
                    type: "POST",
                    data: formData,
                    async: false,
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    cache: false,
                    success: async function (result) {

                        var fileParam = {};
                        fileParam.removedVideo = existingVideo;
                        fileParam.removedTumbnail = existingThumbnail;
                        fileParam.removedFiles = existingFiles;
                        fileParam.archiveIndex = $('#archiveIndex2').val();
                        await edsUtil.getAjax2("/archiveView/deleteFiles", fileParam);

                        <%--var corpCd = '${LoginInfo.corpCd}';--%>
                        <%--var moduleDivi = 'erp';--%>
                        <%--var fileName = removedFile.name;--%>

                        <%--var saveRoot = `src/main/resources/file/\${corpCd}/\${moduleDivi}/0001/archive/\${fileName}`;--%>

                        <%--var paramData2 = [];--%>
                        <%--let data2 = {};--%>
                        <%--data2.saveRoot = saveRoot;--%>
                        <%--paramData2.push(data2)--%>
                        <%--await edsUtil.getAjax2("/archiveView/deleteArchiveFile", paramData2);--%>
                        <%--if (thumbData.length > 0) {--%>
                        <%--    var imageName = thumbData[0].saveNm;--%>
                        <%--    var imageExt = thumbData[0].ext;--%>
                        <%--    var imageSaveRoot = `src/main/resources/file/\${corpCd}/\${moduleDivi}/0001/archiveThum/\${imageName}.\${imageExt}`;--%>
                        <%--    var paramData = [];--%>
                        <%--    let data = {};--%>
                        <%--    data.saveRoot = imageSaveRoot;--%>
                        <%--    paramData.push(data);--%>
                        <%--    await edsUtil.getAjax2("/archiveView/deleteArchiveImageList", paramData);--%>
                        <%--}--%>

                        var param = {};
                        param.corpCd = '${LoginInfo.corpCd}';
                        var selectData = await edsUtil.getAjax("/archiveView/selectArchive", param);

                        // 페이징을 초기화합니다.
                        initPagination(selectData);

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
                $('#mainModal').modal('hide');
            });
        }

        function initPagination(data) {
            let pageSize = 15;
            let totalPages = Math.ceil(data.length / pageSize);

            // 데이터가 없으면 페이징을 지우고 데이터만 출력
            if (data.length === 0) {
                $('#pagination').twbsPagination('destroy');
                displayDataOnPage(data);
                return;
            }

            // 현재 페이지가 총 페이지 수보다 크면 현재 페이지를 마지막 페이지로 설정
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // 기존 페이징 제거
            $('#pagination').twbsPagination('destroy');

            $('#pagination').twbsPagination({
                totalPages: totalPages,
                visiblePages: 10,
                first: '<span sris-hidden="true">«</span>',
                last: '<span sris-hidden="true">»</span>',
                prev: "이전",
                next: "다음",
                startPage: currentPage,

                onPageClick: function (event, page) {
                    currentPage = page;
                    let startIdx = (page - 1) * pageSize;
                    let endIdx = startIdx + pageSize;
                    let currentPageData = data.slice(startIdx, endIdx);
                    displayDataOnPage(currentPageData);
                }
            });
        }

        function formatDateAsNumber(dateString) {
            const date = new Date(dateString);
            const year = date.getFullYear().toString().slice(2); // 뒤에서 두 자리만 가져옴
            const month = (date.getMonth() + 1).toString().padStart(2, '0'); // Month is zero-based
            const day = date.getDate().toString().padStart(2, '0');

            return `\${year}\${month}\${day}`;
        }


        function openModal(e) {
            let elements = document.querySelectorAll('#videoUpdate, #btnClearInputUpdate');
            if (e.getAttribute('data-video-name') !== 'undefined') {
                elements.forEach(item => {
                   item.classList.remove("d-none");
                   item.classList.add("d-block");
                });
            }

            var newFile = document.getElementById('updateFile');
            var oldFile = document.getElementById('updateFile2');
            const video = document.getElementById("videoUpdate");
            const myFile = new File([''], e.getAttribute('data-video-orignm'), {
                type: 'video/mp4',
                lastModified: new Date()
            });

            const myFile2 = new File([''], e.getAttribute('data-video-name'), {
                type: 'video/mp4',
                lastModified: new Date()
            });

            function setFiles(fileInput, file) {
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(file);
                fileInput.files = dataTransfer.files;
            }

            if (e.getAttribute('data-video-name') !== 'undefined') {
                setFiles(newFile, myFile);
                setFiles(oldFile, myFile2);
            }

            removedFile = oldFile.files[0];

            $('#modalBody').css('display', 'none');
            $('#modalBodyUpdate').css('display', 'inline-block');
            $('#mainModal').modal('show');

            $('#archiveIndex2').val(e.parentElement.id);
            $('#titleUpdate').val(e.getAttribute('data-title'));
            $('#contentUpdate').val(e.getAttribute('data-content'));
            $('#videoUpdate').attr('src', e.getAttribute('data-video-src'));

            var param = {};
            param.corpCd = '${LoginInfo.corpCd}';
            param.archiveIndex = $('#archiveIndex2').val();

            edsUtil.getAjax2("/archiveView/readArchive", param);

            videoData = edsUtil.getAjax("/archiveView/selectArchiveVideo", param);

            thumbData = edsUtil.getAjax("/archiveView/selectArchiveThum", param);
            // $('#testImg').css('object-fit', 'contain');
            // $('#testImg').css('overflow', 'scroll');
            for (file of thumbData) {
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
                updateDropzone.displayExistingFile(mockFile, "/archiveView/archiveThumbLoad/" + params);
            }

            filesData = edsUtil.getAjax("/archiveView/selectArchiveFiles", param);
            for (file of filesData) {
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
                updateFileDropzone.displayExistingFile(mockFile, "/archiveView/archiveFilesLoad/" + params);
            }
            if (thumbData.length > 0) {
                document.getElementById('videoUpdate').poster = e.getAttribute('data-src');
            }
            existingVideo.push(String(videoData[0]?.index));
            existingVideo.push(videoData[0]?.saveRoot);
            existingThumbnail.push(String(thumbData[0]?.index));
            existingThumbnail.push(thumbData[0]?.saveRoot);
            for (let i = 0; i < filesData.length; i++){
                // existingFiles.push(String(filesData[i]?.index));
                existingFiles.push(filesData[i]?.saveRoot);
            }

        }

        // 데이터를 페이지에 추가하는 함수
        function displayDataOnPage(data) {
            let contentContainer = $('#bodyContent');

            contentContainer.empty();

            data.forEach(item => {
                // console.log(item.saveNm === null)
                // console.log(item.saveNm != null)
                let src,videoSrc,videoOrigNm,videoName,videoSaveRoot;
                if (item.thumbSaveNm === null ||item.thumbSaveNm === undefined) {
                    src = `/img/logo/edsLogo.png`;
                } else {
                    src = `/archiveView/archiveThumbLoad/\${item.corpCd},\${item.thumbSaveNm},\${item.thumbExt}`;
                }

                // if (item.saveNm !== null) {
                //     let src = `/archiveView/archiveFilesLoad/\${item.corpCd},\${item.saveNm},\${item.ext}`;
                // } else {
                //     let src = `/img/logo/desLogo.png`;
                // }

                if (item.videoOrigNm) {
                    videoSrc = `/archiveView/archiveVideoLoad/\${item.corpCd},\${item.videoSaveNm},\${item.videoExt}`;
                    videoName = `\${item.videoSaveNm}.\${item.videoExt}`;
                    videoOrigNm = `\${item.videoOrigNm}.\${item.videoExt}`;
                    videoSaveRoot = `\${item.videoSaveRoot}`;
                } else {
                    videoSrc = '';
                    videoOrigNm = '';
                }

                // itemInpDt의 값을 yyyy-mm-dd 형태로 변환
                let formattedDate = formatDateAsNumber(item.inpDttm);
                let itemHtml = `
            <div id="\${item.index}" class="filter-item custom-col-lg-5" data-category="\${item.category}" data-sort="\${item.sort}">
                <a href="#" data-toggle="lightbox" class="open-video-modal" onclick="openModal(this);" data-target="#videoModal" data-src="\${src}" data-video-src="\${videoSrc}" data-title="\${item.title.replace(/"/g, '&quot;')}" data-content="\${item.content.replace(/"/g, '&quot;')}" data-video-orignm="\${videoOrigNm}" data-video-name="\${videoName}" data-video-save-root="\${videoSaveRoot}" data-index="\${item.index}">
                    <img class="img-thumbnail" src="\${src}" alt="\${item.sort}">
                </a>
                <div class="accordion" id="accordion">
                    <div class="card">
                        <div class="card-header d-flex p-0" id="heading\${item.index}" style="white-space: nowrap" onclick="toggleIcon(this);">
                         <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse\${item.index}" aria-expanded="false" aria-controls="collapse\${item.index}" style="color: black">
                         <span class="text-truncate d-block" id="itemTitle">\${item.title}</span>
                        </button>
                        <button class="btn toggle-btn p-0 position-absolute" style="right: 0" type="button" data-toggle="collapse" data-target="#collapse\${item.index}" aria-expanded="false" aria-controls="collapse\${item.index}"><i class="fas fa-plus"></i></button>
                    </div>
                <div id="collapse\${item.index}" class="collapse" aria-labelledby="heading\${item.index}">
                 <div class="card-body">
                    <span id="itemWriter">작성자 : \${item.inpId}[\${item.depaNm}]</span>
                        <br>
                        <span id="itemInpDt">일자 : \${formattedDate}</span>
                        <br>
                        <span id="itemHit">조회수 : \${item.hit}회</span>
                </div>
             </div>
            </div>
        </div>

<!--                <div class="item-footer">-->
<!--                        <span id="itemInpDt">\${formattedDate}</span>-->
<!--                        <span>_</span>-->
<!--                        <span id="itemTitle">\${item.title}</span>-->
<!--                        <br>-->
<!--                        <span id="itemWriter">\${item.inpId}[\${item.depaNm}]</span>-->
<!--                        <span>_</span>-->
<!--                        <span id="itemHit">\${item.hit}회</span>-->
<!--                </div>-->
            </div>
        `;

                var itemFooter = document.querySelector('.item-footer');
                // var parentElementLength = itemFooter.parentElement.offsetWidth; // 부모 요소의 너비
                // itemFooter.style.width = parentElementLength + 'px'; // 길이를 부모 요소의 너비로 설정

                contentContainer.append(itemHtml);
            });
          document.querySelectorAll('.img-thumbnail').forEach(function(image) {
            image.onload = function() {
              console.log(image.naturalHeight)
              if (image.naturalHeight > 190) {
                image.style.objectFit = 'cover';
              } else {
                image.style.objectFit = 'contain';
              }
            };
          });
        }

        <%--async function reloadPageAndData() {--%>
        <%--    $('#mainModal').modal('hide');--%>

        <%--    var param = {};--%>
        <%--    param.corpCd = '${LoginInfo.corpCd}';--%>

        <%--    var data = await edsUtil.getAjax("/archiveView/selectArchive", param);--%>

        <%--    $('#pagination').twbsPagination('destroy'); // 기존 페이징 제거--%>
        <%--    initPagination(); // 첫 페이지로 초기화--%>

        <%--    displayDataOnPage(data);--%>
        <%--}--%>

        function dropZoneEvent() {
            var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
            dropzonePreviewNode.id = '';
            var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
            dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

            dropzone = new Dropzone("#dropzone", {
                    url: "/noticeView/fileUpload", // 파일을 업로드할 서버 주소 url.
                    thumbnailWidth: null,
                    method: "post", // 기본 post로 request 감. put으로도 할수있음
                    autoProcessQueue: false,
                    previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                    previewsContainer: '#dropzone-preview',
                    acceptedFiles: "application/pdf,image/*",   //파일 종류
                    maxFilesize: 100,
                    maxFiles: 1,
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
                        this.on("maxfilesexceeded", function (file) {
                            alert("썸네일은 한 장만 첨부할 수 있습니다.");
                            this.removeFile(file);
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

        function updateDropZoneEvent() {
            var dropzonePreviewNode = document.querySelector('#update-dropzone-preview-list');
            dropzonePreviewNode.id = '';
            var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
            dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
            updateDropzone = new Dropzone("#updateDropzone", {
                    url: "/noticeView/fileUpload", // 파일을 업로드할 서버 주소 url.
                    thumbnailWidth: null,
                    method: "post", // 기본 post로 request 감. put으로도 할수있음
                    autoProcessQueue: false,
                    previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                    previewsContainer: '#update-dropzone-preview',
                    acceptedFiles: "application/pdf,image/*",   //파일 종류
                    maxFilesize: 100,
                    maxFiles: 1,
                    // accept: function (file, done) {
                    //     done();
                    // },
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
                            // console.log('this?')
                            // console.log($(this))
                            // console.log($('.open-video-modal:eq(0)').data('src'));
                            // console.log('이미지 등록')
                            // var src1 = $(document.getElementById('videoUpdate')).data('src');
                            // console.log('src 1 ?')
                            // console.log(src1)
                            // var src2 = $('.open-video-modal:eq(1)').data('src')
                            // console.log('src 2 ?')
                            // console.log(src2)

                            // var src = `/archiveView/archiveFilesLoad/\${archiveData[i].corpCd},\${archiveData[i].saveNm},\${archiveData[i].ext}`;
                            // console.log(src)

                            // document.getElementById('videoUpdate').poster = src2;
                            // console.log(document.getElementById('videoUpdate'))

                            uploadCount += $('#update-dropzone-preview').length;
                            if (uploadCount > 1) {
                                // this.options.dictMaxFilesExceeded = '이미지는 최대 4개까지 첨부할 수 있습니다.';
                                alert('썸네일은 한 장만 첨부할 수 있습니다.');
                                this.removeFile(file);
                            }
                        });

                        // this.on("maxfilesexceeded", function (file) {
                        //         alert("썸네일은 한 장만 첨부할 수 있습니다.");
                        //         this.removeFile(file);
                        // });

                        this.on('removedfile', function (file) {
                            uploadCount -= 1;
                            // document.getElementById('videoUpdate').poster = '';
                            // 저장되어 있는 이미지일때만 추가
                            if (file.status != "queued" && file.status != "added") {
                                dropzoneRemoveArr.push(file);
                            }
                        });

                        this.on('downloadedFile', async function (file) {
                            if (document.getElementById('archiveIndex2').value) {
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

                        // 업로드 에러 처리
                        this.on('error', function (file, errorMessage) {
                            this.removeFile(file);
                            alert(errorMessage);
                        });
                    }
                }
            )
        }

        function fileDropZoneEvent() {
            var dropzonePreviewNode = document.querySelector('#file-dropzone-preview-list');
            dropzonePreviewNode.id = '';
            var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
            dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

            fileDropzone = new Dropzone("#fileDropzone", {
                    url: "/archiveView/fileUpload", // 파일을 업로드할 서버 주소 url.
                    method: "post", // 기본 post로 request 감. put으로도 할수있음
                    autoProcessQueue: false,
                    previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                    previewsContainer: '#file-dropzone-preview',
                acceptedFiles: "application/pdf,image/*,application/vnd.openxmlformats-officedocument.presentationml.presentation",   //파일 종류
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
                            } else if (ext.indexOf("pptx") != -1) {
                                this.emit("thumbnail", file, "/img/fileImage/pptimg.jpg");
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

        function updateFileDropZoneEvent() {
            var dropzonePreviewNode = document.querySelector('#update-file-dropzone-preview-list');
            dropzonePreviewNode.id = '';
            var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
            dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

            updateFileDropzone = new Dropzone("#updateFileDropzone", {
                    url: "/archiveView/fileUpload", // 파일을 업로드할 서버 주소 url.
                    method: "post", // 기본 post로 request 감. put으로도 할수있음
                    autoProcessQueue: false,
                    previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                    previewsContainer: '#update-file-dropzone-preview',
              acceptedFiles: "application/pdf,image/*,application/vnd.openxmlformats-officedocument.presentationml.presentation",
                    maxFilesize: 100,
                    accept: function (file, done) {
                        done();
                    },
                    init: function (e) {
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
                            } else if (ext.indexOf("pptx") != -1) {
                                this.emit("thumbnail", file, "/img/fileImage/pptimg.jpg");
                            }
                        });
                        this.on('removedfile', function (file) {
                            // 저장되어 있는 이미지일때만 추가
                            if (file.status != "queued" && file.status != "added") {
                                fileDropzoneRemoveArr.push(file);
                            }
                        });
                        this.on('downloadedFile', async function (file) {
                            if (document.getElementById('archiveIndex2').value) {
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
                        // 업로드 에러 처리
                        this.on('error', function (file, errorMessage) {
                            this.removeFile(file);
                            alert(errorMessage);
                        });
                    }
                }
            )
        }

        function validate(form) {
            form.validate({
                rules: {
                    title: {
                        required: true
                    },
                    // file: {
                    //     required: true
                    // },
                },
                messages: {}
            })
            $.extend($.validator.messages, {
                required: "필수 항목입니다."    // required 속성의 공동 메세지
            });
        }

        function resetModalForm() {
            $('#mainModal').on('hidden.bs.modal', function (e) {
                uploadCount = 0;
                $(this).validate().resetForm();
                $(this).find('.error').removeClass('error');
                $(this).find('form')[0].reset();
                $(this).find('form')[1].reset();
                $('textarea[name="content"]').css('height', 'auto');
                $('#video')[0].src = '';
                $('#videoUpdate').removeAttr('poster');

                let elements = document.querySelectorAll('#video, #videoUpdate, #btnClearInput, #btnClearInputUpdate');
                elements.forEach(item => {
                   item.classList.remove('d-block');
                   item.classList.add('d-none');
                });


                // dropzone.removeAllFiles(true);
                // updateDropzone.removeAllFiles(true);
                // fileDropzone.removeAllFiles(true);
                // updateFileDropzone.removeAllFiles(true);

                const dropzones = [dropzone, updateDropzone, fileDropzone, updateFileDropzone];
                dropzones.forEach(dropzone => dropzone.removeAllFiles(true));

                existingVideo = [];
                existingThumbnail = [];
                existingFiles = [];
                dropzoneRemoveArr = [];
                fileDropzoneRemoveArr = [];
                $('.dz-image-preview').remove();
            });
        }

        /* 화면 이벤트 */
        async function doAction(sheetNm, sAction) {
            if (sheetNm == 'body') {
                switch (sAction) {
                    case "search":// 조회
                        document.querySelector('#search').name = document.querySelector('#select').value;
                        var param = ut.serializeObject(document.querySelector("#searchForm"));
                        param.corpCd = '${LoginInfo.corpCd}';
                        param.depaCd = '${LoginInfo.depaCd}';
                        archiveData = await edsUtil.getAjax("/archiveView/selectArchive", param);
                        initPagination(archiveData);
                        // document.getElementById('titleSearch').focus();
                        break;
                }
            }
        }

        function deletePoster(e) {
            var video = document.getElementById('videoUpdate');
            video.removeAttribute('poster')
            video.currentTime = 0;
        }

        function toggleIcon(e) {
            const icon = e.querySelector('i');
            // 아이콘 토글
            icon.classList.toggle('fa-plus');
            icon.classList.toggle('fa-minus');
        }

        function clearInput(e) {
            if (e.parentElement.querySelector('#file, #updateFile').value !== null) {
                e.parentElement.querySelector('#file, #updateFile').value = null;
            }

            const elements = document.querySelectorAll('#btnClearInput, #btnClearInputUpdate, #video, #videoUpdate');
            elements.forEach(item => {
                item.classList.remove('d-block');
                item.classList.add('d-none');
            });
        }

        function autoComplete() {
            // 검색할 데이터 정의
            locList = [];
            for (let i = 0; i < archiveData.length; i++) {
                locList.push(archiveData[i].title);
            }

            $('#search').autocomplete({
                source: locList,
                focus: function (event, ui) {
                    return false;
                },
                select: function (event, ui) {
                    // 선택 시 동작 정의
                },
                minLength: 1,
                delay: 100,
                autoFocus: true,
            });
        }

        function checkFileType(e) {
            var file = e.files[0];
            if (file) {
                var fileType = file.type;
                if (fileType !== 'video/mp4') {
                    alert('mp4 형식만 업로드 가능합니다.');
                    e.value = null;
                }
            }
            return true;
        }

    </script>
    <img src="/img/loading/archiveLoading.gif" style="width:200px; height:200px;">
  </div>
</div>

<div class="container-fluid p-0">
  <div id="editBtn" class="btn-container d-inline-block">
    <button id="insertBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mainModal">등록
    </button>
  </div>
  <form id="searchForm" name="searchForm" role="form" class="form-inline float-right m-0 search-form" method="post">
    <div class="input-group">
        <select class="form-select selectpicker" style="width: 150px;" id="depaDiviSearch" name="depaDivi">
        </select>
      <select id="select" class="form-select text-left" aria-label="Default select example">
        <option selected name="title" value="title">제목</option>
      </select>
      <input type="search" class="form-control" id="search" name="search" autocomplete="off">
      <div class="input-group-append">
        <button class="btn btn-outline-success" type="button" onclick="doAction('body', 'search')">검색</button>
      </div>
    </div>
  </form>
</div>

<%--<div style="background-color: #ebe9e4; padding: unset">--%>
<%--  <div style="background-color: #faf9f5;border: 1px solid #dedcd7;">--%>
<%--    <!-- form start -->--%>
<%--    <form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">--%>
<%--      <!-- input hidden -->--%>
<%--      <input type="hidden" name="corpCd" id="corpCd" title="회사코드">--%>

<%--      <!-- ./input hidden -->--%>
<%--      <div class="form-group col-sm-12">--%>
<%--        <button id="insertBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mainModal">등록--%>
<%--        </button>--%>

<%--        <div class="form-group" style="margin-left: 5rem"></div>--%>

<%--        <div class="form-group">--%>
<%--          <label for="stDt">조회기간 &nbsp;</label>--%>
<%--          <div class="input-group-prepend">--%>
<%--            <input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;"--%>
<%--                   name="stDt" id="stDt" title="끝">--%>
<%--          </div>--%>
<%--          <span>&nbsp;~&nbsp;</span>--%>
<%--          <div class="input-group-append">--%>
<%--            <input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;"--%>
<%--                   name="edDt" id="edDt" title="끝">--%>
<%--          </div>--%>
<%--        </div>--%>

<%--      </div>--%>
<%--    </form>--%>
<%--    <!-- ./form -->--%>
<%--  </div>--%>
<%--</div>--%>

<div class="modal fade" data-backdrop="static" id="mainModal" tabindex="-1" role="dialog"
     aria-labelledby="mainModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl m-auto" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">
        <span><b>컬처북</b></span>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%-- create / 등록 body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <form id="modalForm" method="post" onsubmit="return false;">
          <span hidden="hidden" id="archiveIndex"></span>
          <div class="input-group mb-0">
            <label class="input-group-text" for="title"><i class="fa-sharp fa-solid fa-star fa-2xs" style="color: #f20202;"></i>제목</label>
            <input id="title" name="title" class="form-control" type="text" style="flex-grow: 1; border: none">
          </div>
          <div class="border-bottom" style="width: 100%"></div>

          <div class="input-group mb-0">
            <label class="input-group-text" for="file">영상</label>
            <input onchange="checkFileType(this);" id="file" name="file" type="file" accept="video/mp4"
                   style="flex-grow: 1; align-self: stretch; align-content: center">
            <button id="btnClearInput" class="btn btn-danger d-none" onclick="clearInput(this);">삭제</button>
          </div>

          <div class="input-group mb-0">
            <div class="col-md-4 p-0">
            <label class="input-group-text" for="dropzone">썸네일</label>
            <div id="dropzone" class="dropzone"
                 style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
              <div class="border-top"></div>
              <div class="dz-message needsclick" style="margin: 0;">
                <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png"
                     alt="Camera"
                     style="width: 35px;"/>
                클릭 또는 드래그하여 파일을 첨부해 주세요.
              </div>
              <div class="border-bottom"></div>
            </div>
            <div style="display: contents;">
              <div class="wrapper" id="dropzone-preview">
                <div class="test border rounded-3" id="dropzone-preview-list"
                     style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                  <!-- This is used as the file preview template -->
                  <div class="" style=" height: 120px; width: inherit;">
                    <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                         alt="Dropzone-Image"
                         style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                  </div>
                  <div class="" style="margin-top: 2px; height: 60px;">
                    <small class="dataName main" data-dz-name="data-dz-name" data-dz-down="data-dz-down"
                           style="height: 28px">&nbsp;</small>
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
            <div class="col-md-8 p-0 border-left">
              <label class="input-group-text" for="dropzone">첨부파일</label>
              <div id="fileDropzone" class="dropzone"
                   style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
                <div class="border-top"></div>
                <div class="dz-message needsclick" style="margin: 0;">
                  <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png"
                       alt="Camera"
                       style="width: 35px;"/>
                  클릭 또는 드래그하여 파일을 첨부해 주세요.
                </div>
                <div class="border-bottom"></div>
              </div>
              <div style="display: contents;">
                <div class="wrapper" id="file-dropzone-preview">
                  <div class="test border rounded-3" id="file-dropzone-preview-list"
                       style="width: 130px; min-width: 130px;margin: 5px;text-align: center; border-radius: 12px;">
                    <!-- This is used as the file preview template -->
                    <div class="" style=" height: 130px; width: inherit;">
                      <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                           alt="Dropzone-Image"
                           style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                    </div>
                    <div class="" style="margin-top: 2px; height: 60px;">
                      <small class="dataName main" data-dz-name="data-dz-name" data-dz-down="data-dz-down"
                             style="height: 28px">&nbsp;</small>
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
          </div>

          <div class="input-group mb-0">
            <label class="input-group-text" for="content">내용</label>
            <textarea id="content" class="form-control" name="content" style="flex-grow: 1"></textarea>
          </div>
          <div class="input-group mb-0">
            <video class="d-none" controls id="video"></video>
          </div>

        </form>

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
          <input hidden="hidden" name="fileFlag">
          <div class="input-group mb-0">
            <label class="input-group-text" for="title"><i class="fa-sharp fa-solid fa-star fa-2xs" style="color: #f20202;"></i>제목</label>
            <input type="text" maxlength="50" class="form-control" placeholder="제목" aria-label="title"
                   aria-describedby="basic-addon1"
                   id="titleUpdate" name="title">
          </div>
          <div class="input-group mb-0">
            <label id="updateFileLabel" class="input-group-text" for="updateFile">영상</label>
            <input onchange="checkFileType(this);" id="updateFile" name="updateFilefile" type="file" accept="video/mp4"
                   style="flex-grow: 1; align-self: stretch; align-content: center">
            <input hidden="" id="updateFile2" name="updateFile2" type="file" accept="video/mp4"
                   style="flex-grow: 1">
            <button id="btnClearInputUpdate" class="btn btn-danger d-none" onclick="clearInput(this);">삭제</button>
          </div>

          <div class="input-group mb-0">
            <div class="col-md-4 p-0">
            <label class="input-group-text" for="updateDropzone">썸네일</label>
            <div id="updateDropzone" class="dropzone"
                 style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
              <div class="border-top"></div>
              <div class="dz-message needsclick" style="margin: 0;">
                <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png"
                     alt="Camera"
                     style="width: 35px;"/>
                클릭 또는 드래그하여 파일을 첨부해 주세요.
              </div>
              <div class="border-bottom"></div>
            </div>
            <div style="display: contents;">
              <div class="wrapper" id="update-dropzone-preview">
                <div class="test border rounded-3" id="update-dropzone-preview-list"
                     style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                  <!-- This is used as the file preview template -->
                  <div class="" style=" height: 120px; width: inherit;">
                    <img id="testImg" data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                         alt="Dropzone-Image"
                    />
                  </div>
                  <div class="" style="margin-top: 2px; height: 60px;">
                    <small class="dataName main" data-dz-name="data-dz-name" data-dz-down="data-dz-down"
                           style="height: 28px">&nbsp;</small>
                    <div class="row" style="margin: 0;">
                      <p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
                      <div class="col-6" style="padding: 0;">
                        <button data-dz-remove="data-dz-remove" onclick="deletePoster(this);" class="btn btn-sm btn-danger ">삭제</button>
                      </div>
                    </div>
                    <strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
                  </div>
                </div>
              </div>
            </div>
          </div>
            <div class="col-md-8 p-0 border-left">
              <label class="input-group-text" for="updateFileDropzone">첨부파일</label>
              <div id="updateFileDropzone" class="dropzone"
                   style="flex-grow: 1; text-align: center; padding: unset; min-height: inherit; border: none;">
                <div class="border-top"></div>
                <div class="dz-message needsclick" style="margin: 0;">
                  <img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png"
                       alt="Camera"
                       style="width: 35px;"/>
                  클릭 또는 드래그하여 파일을 첨부해 주세요.
                </div>
                <div class="border-bottom"></div>
              </div>
              <div style="display: contents;">
                <div class="wrapper" id="update-file-dropzone-preview">
                  <div class="test border rounded-3" id="update-file-dropzone-preview-list"
                       style="width: 130px; min-width: 130px;margin: 5px;text-align: center; border-radius: 12px;">
                    <!-- This is used as the file preview template -->
                    <div class="" style=" height: 130px; width: inherit;">
                      <img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                           alt="Dropzone-Image"
                           style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                    </div>
                    <div class="" style="margin-top: 2px; height: 60px;">
                      <small class="dataName main" data-dz-name="data-dz-name" data-dz-down="data-dz-down"
                             style="height: 28px">&nbsp;</small>
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
          </div>

          <div class="input-group mb-0">
            <label class="input-group-text" for="contentUpdate">내용</label>
            <textarea id="contentUpdate" class="form-control" name="content" style="flex-grow: 1"></textarea>
          </div>
          <div class="input-group mb-0">
            <span hidden="hidden" id="archiveIndex2"></span>
            <video class="d-none" id="videoUpdate" controls style="width: 100%;">
            </video>
          </div>
        </form>

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
</div>

<!-- confirm Modal -->
<div class="modal fade" data-backdrop="static" id="confirmModal" tabindex="-1" role="dialog" style="top: 20%">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content" style="background-color: rgba(213, 216, 220, 0.7)">
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

<div class="content-wrapper">

  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-0">
        <div class="col-sm-6">

        </div>
      </div>
    </div>
  </section>

  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12" style="padding-left: unset">
          <div class="card card-primary">
            <%--            <div class="card-header">--%>

            <%--            </div>--%>
            <div class="card-body">
              <%--              <div>--%>
              <%--                <div class="btn-group w-100 mb-2">--%>
              <%--                  <a class="btn btn-info active" href="javascript:void(0)" data-filter="all"> 전체 </a>--%>
              <%--                  <a class="btn btn-info" href="javascript:void(0)" data-filter="1"> Category 1 (WHITE) </a>--%>
              <%--                  <a class="btn btn-info" href="javascript:void(0)" data-filter="2"> Category 2 (BLACK) </a>--%>
              <%--                  <a class="btn btn-info" href="javascript:void(0)" data-filter="3"> Category 3 (COLORED) </a>--%>
              <%--                  <a class="btn btn-info" href="javascript:void(0)" data-filter="4"> Category 4 (COLORED, BLACK) </a>--%>
              <%--                </div>--%>
              <%--                <div class="mb-2">--%>
              <%--                  <a class="btn btn-secondary" href="javascript:void(0)" data-shuffle> Shuffle items </a>--%>
              <%--                  <div class="float-right">--%>
              <%--                    <select class="custom-select" style="width: auto;" data-sortOrder>--%>
              <%--                      <option value="index"> Sort by Position </option>--%>
              <%--                      <option value="sortData"> Sort by Custom Data </option>--%>
              <%--                    </select>--%>
              <%--                    <div class="btn-group">--%>
              <%--                      <a class="btn btn-default" href="javascript:void(0)" data-sortAsc> Ascending </a>--%>
              <%--                      <a class="btn btn-default" href="javascript:void(0)" data-sortDesc> Descending </a>--%>
              <%--                    </div>--%>
              <%--                  </div>--%>
              <%--                </div>--%>
              <%--              </div>--%>
              <div>
                <div id="bodyContent" class="filter-container p-0 row">
                  <%--                  <div class="filtr-item col-sm-2" data-category="1" data-sort="white sample">--%>
                  <%--                    <a href="https://via.placeholder.com/1200/FFFFFF.png?text=1" data-toggle="lightbox" data-title="sample 1 - white">--%>
                  <%--                      <img src="https://via.placeholder.com/300/FFFFFF?text=1" class="img-fluid mb-2" alt="white sample" />--%>
                  <%--                    </a>--%>
                  <%--                  </div>--%>
                  <%--                  <div class="filtr-item col-sm-2" data-category="2, 4" data-sort="black sample">--%>
                  <%--                    <a href="https://via.placeholder.com/1200/000000.png?text=2" data-toggle="lightbox" data-title="sample 2 - black">--%>
                  <%--                      <img src="https://via.placeholder.com/300/000000?text=2" class="img-fluid mb-2" alt="black sample" />--%>
                  <%--                    </a>--%>
                  <%--                  </div>--%>
                </div>
              </div>
            </div>
          </div>
          <div class="container">
            <nav aria-label="Page navigation">
              <ul class="pagination" id="pagination" style="justify-content: center"></ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </section>

</div>

<%--<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModalLabel"--%>
<%--     aria-hidden="true">--%>
<%--  <div class="modal-dialog" role="document">--%>
<%--    <div class="modal-content">--%>
<%--      <div class="modal-header">--%>
<%--        <h5 class="modal-title" id="videoModalLabel">동영상 재생</h5>--%>
<%--        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--          <span aria-hidden="true">&times;</span>--%>
<%--        </button>--%>
<%--      </div>--%>
<%--      <div class="modal-body">--%>
<%--        <span hidden="hidden" id="archiveIndex3"></span>--%>
<%--        <video id="videoUpdate3" controls style="width: 100%;">--%>

<%--        </video>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>
<div hidden="" class="open-video-modal"></div>
</body>
</html>
