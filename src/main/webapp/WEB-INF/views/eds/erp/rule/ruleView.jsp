<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %><%-- DOCTYPE 및 태그라이브러리정의 --%>
<html>
<head>
  <%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
  <%-- 공통헤드 --%>
  <%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
  <%-- 공통 스타일시트 정의--%>
  <%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
  <%-- 공통 스크립트 정의--%>

  <%-- 드랍존--%>
  <link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css"/>
  <script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>

  <link rel="stylesheet" href="/css/rule/rule.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script type="text/javascript" src='/js/com/twbsPagination.min.js'></script>
  <script src="/js/util/eds.ims.js"></script>
</head>
<script>
    var locList, mainSheet, ruleIndex, ruleData, userData, dropzone, updateDropzone;
    var dropzoneRemoveArr = [];
    Dropzone.autoDiscover = false;
    var currentPage = 1;
    var pageSize = 10;

    var commonInfo = {
        corpCd: '${LoginInfo.corpCd}',
        depaCd: '${LoginInfo.depaCd}',
        depaNm: '${LoginInfo.depaNm}',
        busiCd: '${LoginInfo.busiCd}'
    };
    $(document).ready(async function () {
        dropZoneEvent();
        updateDropZoneEvent();
        await init();
        autoComplete();
        imsUtil.focusSearch('search')
    });

    async function init() {
        mainSheet = document.getElementById('body');

        $('form input').on('keydown', function (e) {
            if (e.which == 13) {
                e.preventDefault();
                doAction("mainSheet", "search");
            }
        });

        await doAction('mainSheet', 'search');

        // 권한에 따라 버튼 보이기
        const allowedGroupIds = ['1', '3', '4'];
        const editBtn = document.getElementById('editBtn');
        editBtn.style.cssText = `display: \${allowedGroupIds.includes('${LoginInfo.groupId}') ? 'inline-block !important' : 'none !important'}`;

        // 모달 열기시
        $(document).on('shown.bs.modal', function (e) {
            $(this).find('[autofocus]').focus();
        });

        // 모달 닫기시
        $(document).on('hidden.bs.modal', function (e) {
            // $(this).find('form:not(#searchForm)').each(function(index, form) {
            //     form.reset();
            // });
            $('form:not(#searchForm)').trigger('reset');
            // dropzone.removeAllFiles(true);
            // updateDropzone.removeAllFiles(true);
            [dropzone, updateDropzone].forEach(dz => dz.removeAllFiles(true));
            dropzoneRemoveArr = [];
            $('.dz-image-preview').remove();
        });

        // CRUD(C)
        $('#btnSave').on('click', function () {
            var form = document.querySelector('#modalForm');
            if (!form.checkValidity()) {
                form.classList.add('was-validated');
                return;
            }

            var param = createParam('C', '#modalForm', commonInfo);
            var title = param.title;
            var formData = new FormData();
            formData.append("data", JSON.stringify([param]));

            var newFiles = dropzone.getAcceptedFiles();
            newFiles.forEach(file => formData.append('attachedFile', file));
            if (newFiles.length === 0) {
                Swal.fire({
                    icon: 'error',
                    title: '실패',
                    text: '파일을 첨부해 주세요.'
                });
                return;
            }

            $.ajax({
                url: "/ruleView/cudRule",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#mainModal').modal('hide');

                    var param = createParam('', '', commonInfo);
                    currentPage = 1;
                    ruleData = await edsUtil.getAjax("/ruleView/selectRule", param);

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

                    var noticeParam = {};
                    noticeParam.corpCd = '${LoginInfo.corpCd}';
                    noticeParam.userEmail = userEmail;
                    noticeParam.writer = '${LoginInfo.empNm}' + '[' + '${LoginInfo.depaNm}' + ']';
                    noticeParam.date = imsUtil.getDate();
                    noticeParam.title = title;
                    noticeParam.postNum = String(ruleData.length);
                    noticeParam.divi = '사규';

                    await edsUtil.getAjax2("/sendController/noticeAllEmployee", noticeParam);

                    initPagination(ruleData);
                    if (!result.sess && typeof result.sess !== "undefined") {
                        alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                        return;
                    }

                    var icon = result.IO.Result === 0 || result.IO.Result === 1 ? 'success' : 'error';
                    Swal.fire({
                        icon: icon,
                        title: result.IO.Result === 0 || result.IO.Result === 1 ? '성공' : '실패',
                        text: result.IO.Message,
                    });
                },
            });
        });

        // CRUD(U)
        $('#btnUpdate').on('click', function () {
            var form = document.querySelector('#modalFormUpdate');
            if (!form.checkValidity()) {
                form.classList.add('was-validated');
                return;
            }

            var param = createParam('U', '#modalFormUpdate', commonInfo);
            param.index = ruleIndex;
            console.log('param : ', param);

            var formData = new FormData();
            formData.append("data", JSON.stringify([param]));

            var newFiles = updateDropzone.getAcceptedFiles();
            newFiles.forEach(file => formData.append('attachedFile', file));
            if (!newFiles.length && !dropzoneRemoveArr.length) {
                if (!confirm('수정할 파일을 찾지 못했습니다.\n제목만 수정하시겠습니까?')) {
                    return;
                }
            }

            if (!newFiles.length && dropzoneRemoveArr.length > 0) {
                Swal.fire({
                    icon: 'error',
                    title: '실패',
                    text: '파일을 첨부해 주세요.'
                });
                return;
            }

            $.ajax({
                url: "/ruleView/cudRule",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#mainModal').modal('hide');

                    if (newFiles.length > 0) {
                        var paramData = [];
                        for (const files of dropzoneRemoveArr) {
                            let data = {};
                            data.saveRoot = files.saveRoot;
                            data.index = files.index;
                            data.ruleIndex = ruleIndex;
                            data.corpCd = '${LoginInfo.corpCd}';
                            data.busiCd = "${LoginInfo.busiCd}";
                            paramData.push(data);
                        }
                        if (paramData.length > 0) await edsUtil.getAjax2("/ruleView/deleteRuleFile", paramData)
                    }

                    await doAction('mainSheet', 'search');

                    if (!result.sess && typeof result.sess !== "undefined") {
                        alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                        return;
                    }

                    var icon = result.IO.Result === 0 || result.IO.Result === 1 ? 'success' : 'error';
                    Swal.fire({
                        icon: icon,
                        title: result.IO.Result === 0 || result.IO.Result === 1 ? '성공' : '실패',
                        text: result.IO.Message,
                    });
                },
            });
        });

        // CRUD(D)
        $('#btnDelete').on('click', (e) => {
            var checked = document.querySelectorAll("[name=check]:checked");

            Swal.fire({
                title: `\${checked.length}건의 데이터를 삭제하시겠습니까?`,
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                cancelButtonText: "취소",
                confirmButtonText: "삭제",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {

                    // ext와 saveNm 값을 추출하는 정규 표현식
                    var regex = /openPdf\((\d+),\s*'([^']*)',\s*'([^']*)',\s*'([^']*)'\)/;

                    var formData = new FormData();

                    var params = [];

                    for (let i = 0; i < checked.length; i++) {
                        var param = createParam('D', '', commonInfo);

                        var index = checked[i].parentElement.parentElement.querySelector('#index').textContent;

                        // 문자열에서 정규 표현식을 사용하여 매치된 부분을 찾음
                        var match = checked[i].parentElement.parentElement.querySelector('.open-pdf-btn').getAttribute('onclick').match(regex);

                        if (match) {
                            // 매치된 부분에서 ext와 fileName 값을 가져옴
                            var ext = match[3];
                            var fileName = match[4];
                            var saveNm = fileName + '.' + ext;
                            param.index = index;
                            param.saveNm = saveNm;
                        }
                        params.push(param)
                    }

                    formData.append("data", JSON.stringify(params));

                    $.ajax({
                        url: "/ruleView/cudRule",
                        type: "POST",
                        data: formData,
                        async: false,
                        enctype: 'multipart/form-data',
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: async function (result) {
                            $('#mainModal').modal('hide');

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

                }
            });

        });
    }

    /* 화면 이벤트 */
    async function doAction(sheetNm, sAction) {
        if (sheetNm === 'mainSheet') {
            switch (sAction) {
                case "search":// 조회
                    document.querySelector('#search').name = document.querySelector('#select').value;
                    var param = createParam('', '#searchForm', commonInfo);

                    ruleData = await edsUtil.getAjax("/ruleView/selectRule", param);
                    userData = edsUtil.getAjax('/ruleView/selectUserInfo', param);

                    initPagination(ruleData);
                    // displayRule(ruleData);
                <%--for (let i = 0; i < ruleData.length; i++) {--%>
                <%--    if (ruleData[i].read?.includes('${LoginInfo.empCd}')) {--%>
                <%--        console.log(ruleData[i])--%>
                <%--        console.log(document.querySelector('#table'));--%>
                <%--        // ruleData[i].classList?.add('read');--%>
                <%--    }--%>
                <%--}--%>
                    break;
            }
        }
    }

    // bootstrap validation 익명함수
    (function () {
        window.addEventListener('load', function () {
            var forms = document.getElementsByClassName('needs-validation');
            Array.from(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);

                $('.modal').on('hidden.bs.modal', function () {
                    form.classList.remove('was-validated');
                });
            });
        }, false);
    })();

    function checkAll() {
        const checkValue = event.target.checked;
        const checkes = document.querySelectorAll("[name=check]");
        if (checkes.length > 0) {
            for (const item of checkes) {
                item.checked = checkValue;
            }
        }
        isChecked();
    }

    function isChecked() {
        const checkes = document.querySelectorAll("[name=check]:checked");
    }

    function showModal(e) {
        const allowedGroupIds = ['1', '3', '4'];
        let groupId = `${LoginInfo.groupId}`;
        if (!allowedGroupIds.includes(groupId)) {
            return;
        }

        var isCreate = e.id === 'create';
        $('#modalTitle').text(isCreate ? '사규등록' : '사규수정');
        $('#modalBody').toggle(isCreate);
        $('#modalBodyUpdate').toggle(!isCreate);
        $('#mainModal').modal('show');

        $('#titleUpdate').val(e.querySelector('#title')?.textContent)
        if (e.id === 'update') {
            var param = createParam('', '#modalFormUpdate', commonInfo);
            param.ruleIndex = e.querySelector('#index')?.textContent;
            ruleIndex = e.querySelector('#index')?.textContent;
            var fileData = edsUtil.getAjax("/ruleView/selectRuleFile", param);
            for (file of fileData) {
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
                updateDropzone.on('thumbnail', function (file) {
                    file.previewElement.querySelector('[data-dz-thumbnail]').src = '/img/fileImage/pdfimg.jpg';
                });
                updateDropzone.displayExistingFile(mockFile, "/ruleView/loadRuleFiles/" + params);

                var tooltipText = mockFile.name;
                $('[data-toggle="tooltip"]').attr('title', tooltipText).tooltip();
            }
        }
    }

    function dropZoneEvent() {
        var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
        dropzonePreviewNode.id = '';
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        dropzone = new Dropzone("#dropzone", {
                url: "/ruleView/fileUpload", // 파일을 업로드할 서버 주소 url.
                method: "post", // 기본 post로 request 감. put으로도 할수있음
                autoProcessQueue: false,
                previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                previewsContainer: '#dropzone-preview',
                acceptedFiles: "application/pdf",   //파일 종류
                maxFilesize: 100,
                maxFiles: 1,
                accept: function (file, done) {
                    done();
                },
                init: function (e) {
                    // 파일이 업로드되면 실행
                    this.on('addedfile', function (file) {
                        var tooltipText = file.name;
                        $('[data-toggle="tooltip"]').attr('title', tooltipText).tooltip();
                        var ext = file.name.split('.').pop();
                        if (ext == "pdf") {
                            this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
                        }
                    });
                    this.on("maxfilesexceeded", function (file) {
                        alert("파일은 하나만 첨부할 수 있습니다.");
                        this.removeFile(file);
                    });
                    // 업로드 에러 처리
                    this.on('error', function (file, errorMessage) {
                        this.removeFile(file);
                    });
                }
            }
        )
    }

    function updateDropZoneEvent() {
        var uploadCount = 0;
        var dropzonePreviewNode = document.querySelector('#dropzone-preview-list-update');
        dropzonePreviewNode.id = '';
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

        updateDropzone = new Dropzone("#dropzoneUpdate", {
                url: "/ruleView/fileUpload", // 파일을 업로드할 서버 주소 url.
                method: "post", // 기본 post로 request 감. put으로도 할수있음
                autoProcessQueue: false,
                previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
                previewsContainer: '#dropzone-preview-update',
                acceptedFiles: "application/pdf",   //파일 종류
                maxFilesize: 100,
                maxFiles: 1,

                init: function (e) {
                    // 파일이 업로드되면 실행
                    this.on('addedfile', function (file) {
                        var ext = file.name.split('.').pop();
                        if (ext == "pdf") {
                            this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
                        }
                        $('#mainModal').on('hidden.bs.modal', function (e) {
                            uploadCount = 0;
                        })
                        uploadCount += $('#dropzone-preview-update').length;
                        if (uploadCount > 1) {
                            // this.options.dictMaxFilesExceeded = '이미지는 최대 4개까지 첨부할 수 있습니다.';
                            alert('파일은 하나만 첨부할 수 있습니다.');
                            this.removeFile(file);
                        }
                    });

                    this.on('removedfile', function (file) {
                        uploadCount -= 1;
                        // 저장되어 있는 이미지일때만 추가
                        if (file.status != "queued" && file.status != "added") {
                            dropzoneRemoveArr.push(file);
                        }
                    });

                    this.on('downloadedFile', async function (file) {
                        if (file) {
                            let fileInfo = {};
                            fileInfo.saveRoot = file.saveRoot;
                            fileInfo.name = file.name;
                            $.ajax({
                                type: 'POST',
                                url: '/ruleView/ruleFileDownload',
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
                    });
                }
            }
        )
    }

    // param 생성
    function createParam(status = '', formSelector = '', customProps) {
        var param = {};
        // if (!form) {
        //     // console.error('Form not found:', formSelector);
        //     return null; // 폼이 없으면 null 또는 다른 적절한 값으로 처리
        // }

        if (formSelector !== '') {
            var form = document.querySelector(formSelector);
            if (form) {
                param = ut.serializeObject(form);
            }
        }

        if (status !== '') {
            param.status = status;
        }
        // 추가적인 속성이 제공된 경우 병합
        if (customProps) {
            param = {...param, ...customProps};
        }

        return param;
    }

    function displayRule(data) {
        var tableContainer = document.getElementById('tableContainer');

        tableContainer.innerHTML = '';

        var table = document.createElement('table');
        table.className = 'table';
        table.id = 'table';

        var thead = document.createElement('thead');
        thead.className = 'thead-dark';
        var headerRow = document.createElement('tr');
        headerRow.innerHTML = `
    <th scope="col"><input type="checkbox" onchange="checkAll();"></th>
    <th scope="col">번호</th>
    <th scope="col">제목</th>
    <th scope="col">작성자</th>
    <th scope="col">조회수</th>
    <th scope="col">첨부파일</th>
`;
        thead.appendChild(headerRow);
        table.appendChild(thead);

        var tbody = document.createElement('tbody');
        tbody.classList.add('tbody');
        var totalItems = ruleData.length;

        data.forEach((item, index) => {
            var serialNumber = totalItems - ((currentPage - 1) * pageSize + index);

            // 마지막 쉼표 제거 후 숫자들을 배열로 만들기
            let readArr = item.read?.replace(/,\s*$/, '').split(',');

            var row = document.createElement('tr');

            row.id = 'update';

            row.innerHTML = `
        <th class="check"><input class="check" type="checkbox" name="check" onchange="isChecked();"></th>
        <th id="rowNum" scope="row">\${serialNumber}</th>
        <td id="title" class="text-truncate" style="max-width: 100px;">\${item.title}</td>
        <td>\${item.inpId}</td>
        <td class="check-read">
            <button type="button" class="btn btn-info" data-html="true" data-toggle="popover" data-trigger="click">
                \${item.hit}
            </button>
        </td>
        <td id="index" data-column-name="index" hidden="hidden" style="display: none;">\${item.index}</td>
        <td class="view-pdf">
            <a onclick="openPdf(\${item.index}, '\${item.origNm}', '\${item.ext}', '\${item.saveNm}')" class="open-pdf-btn btn btn-success">
                보기
            </a>
        </td>
    `;

            // view-pdf, check, check-read 클래스를 포함한 하위 요소 클릭 시 처리
            row.addEventListener('click', function (event) {
                const classNames = ['check', 'check-read', 'view-pdf'];

                if (classNames.some(className => event.target.classList.contains(className))) {
                    event.target.querySelector('input, a, button')?.click();
                }
                if (event.target.className === '' || event.target.className === 'text-truncate') {
                    showModal(this);
                }
            });


            if (item.read?.includes('${LoginInfo.empCd}')) {
                row.classList.add('read');
            }

            if (readArr?.length > 0) {
                displayUserImages(row, readArr);
            }

            tbody.appendChild(row);
        });

        table.appendChild(tbody);

        tableContainer.appendChild(table);

        // 팝오버를 초기화하고 다시 설정합니다.
        $('[data-toggle="popover"]').popover();
    }

    // 이미지를 가져와서 표시하는 함수
    function displayUserImages(row, userCodes) {
        // 모든 이미지를 반복하면서 img 태그를 생성하고 버튼 요소의 팝오버 내용에 추가
        let param = createParam('', '', commonInfo);

        const imageTags = userCodes.map(userCode => {
            const user = userData.find(user => user.empCd === userCode);
            const userInfo = user?.userInfo;

            return `<img class="user-face" src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:\${userCode}" title="\${userInfo}" alt="User Image">`;
        }).join('');

        const button = row.querySelector('.btn-info');
        button.setAttribute('data-content', imageTags);
    }

    function openPdf(index, origNm, ext, pdfFileName) {
        let param = createParam('', '', commonInfo);
        param.index = index;
        var formData = new FormData();
        formData.append("data", JSON.stringify([param]));

        $.ajax({
            url: "/ruleView/updateRead",
            type: "POST",
            data: formData,
            async: false,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            success: async function (result) {
                await edsUtil.getAjax2("/ruleView/readRule", param);

                // 서버로 PDF 파일 요청
                window.open(`/ruleView/ruleFileLoad/\${origNm}.\${ext}?saveNm=\${pdfFileName}`, '', 'toolbar=no, location=no, status=no, scrollbars=yes, resizable=no, width=1200px, height=900px');

                if (!result.sess && typeof result.sess !== "undefined") {
                    alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                    return;
                }

            },
        });

    }

    function initPagination(data) {
        let totalPages = Math.ceil(data.length / pageSize);
        // 데이터가 없으면 페이징을 지우고 데이터만 출력
        if (data.length === 0) {
            $('#pagination').twbsPagination('destroy');
            displayRule(data);
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
                $('[data-toggle="popover"]').popover('hide');
                currentPage = page;
                let startIdx = (page - 1) * pageSize;
                let endIdx = startIdx + pageSize;
                let currentPageData = data.slice(startIdx, endIdx);
                displayRule(currentPageData);
            }
        });
    }

    function autoComplete() {
        // 검색할 데이터 정의
        locList = [];
        for (let i = 0; i < ruleData.length; i++) {
            locList.push(ruleData[i].title);
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

    // Bootstrap 팝오버 활성화
    $(function () {
        $('[data-toggle="popover"]').popover({
            html: true,
            placement: 'right'
        }).on('inserted.bs.popover', function () {
            var popover = $(this);
            if (popover.data('width') > 100) {
                popover.css('max-width', '100px');
            }
        });
    });

</script>

<body id="body" class="body">
<%--헤더 컨테이너--%>
<%--<div class="container-fluid align-items-center" style="display: grid; grid-template-columns: 1fr 5fr;">--%>
<%--  <button class="btn btn-primary" type="button" style="width: 100px">사규 등록</button>--%>
<%--      <form class="form-inline m-0">--%>
<%--        <input class="form-control mr-sm-2" type="search" placeholder="검색" aria-label="Search">--%>
<%--        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>--%>
<%--      </form>--%>
<%--</div>--%>
<div class="container-fluid">
  <div id="editBtn" class="btn-container d-inline-block">
    <button id="create" onclick="showModal(this)" class="btn btn-primary mr-3" type="button" data-toggle="modal">사규등록
    </button>
    <button id="btnDelete" class="btn btn-danger" type="button">삭제</button>
  </div>
  <form id="searchForm" name="searchForm" role="form" class="form-inline float-right m-0 search-form" method="post">
    <div class="input-group">
      <select id="select" class="form-select text-left" aria-label="Default select example">
        <option selected name="title" value="title">제목</option>
      </select>
      <input type="search" class="form-control" id="search" name="search" autocomplete="off">
      <div class="input-group-append">
        <button class="btn btn-outline-success" type="button" onclick="doAction('mainSheet', 'search')">검색</button>
      </div>
    </div>
  </form>
</div>
<div class="border-bottom vw-100"></div>

<%--바디 컨테이너--%>
<div id="tableContainer" class="container-fluid table-responsive">
  <table id="table" class="table table-striped">
    <thead class="thead-dark" style="background-color: rgb(69, 77, 85) !important; width: 100%">
    <tr style="background-color: inherit !important; width: 100%">
      <th scope="col" style="background-color: inherit !important; vertical-align: middle;"><input type="checkbox"
                                                                                                   onchange="checkAll();">
      </th>
      <th scope="col" style="background-color: inherit !important;">번호</th>
      <th scope="col" style="background-color: inherit !important;">제목</th>
      <th scope="col" style="background-color: inherit !important;">작성자</th>
      <th scope="col" style="background-color: inherit !important;">조회수</th>
      <th scope="col" style="background-color: inherit !important;">첨부파일</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th style="vertical-align: middle;"><input type="checkbox" name="check" onchange="isChecked();"></th>
      <th scope="row">1</th>
      <td class="text-truncate" style="max-width: 100px;">ㅁ나어라ㅣ언ㄹ망ㅁ너라ㅣ언말넘라ㅣㅇ;ㅓㄹㅇㄴ마ㅓ림ㅇㄴ
      </td>
      <td>ㅇㅇ</td>
      <td>Otto</td>
      <td>
        <%--        <a onclick="viewPdf(this);">--%>
        <a onclick="window.open('https://www.isdc.co.kr/company/data/%EC%A0%95%EA%B4%80.pdf','','toolbar=no, location=no, status=no, scrollbars=yes, resizable=no, width=1200px, height=900px')">
          <span class="btn btn-success">보기</span>
        </a>
      </td>
    </tr>
    <tr>
      <th><input type="checkbox" name="check" onchange="isChecked();"></th>
      <th scope="row">2</th>
      <td>Jacob</td>
      <td>Thornton</td>
      <td>2</td>
      <td>@fat</td>
    </tr>
    </tbody>
  </table>
</div>

<%--푸터 컨테이너--%>
</body>

<!--   Modal  -->
<div class="modal fade" data-backdrop="static" id="mainModal" tabindex="-1" role="dialog"
     aria-labelledby="mainModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ddd; padding: 5px;">
        <span><b id="modalTitle">사규등록</b></span>
        <button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%-- create / 등록 body --%>
      <div class="modal-body form-input hide" id="modalBody" style="padding: unset;">
        <form id="modalForm" class="m-0 needs-validation" method="post" onsubmit="return false;" novalidate>
          <div class="input-group mb-0">
            <label class="input-group-text" for="title">제목</label>
            <input type="text" maxlength="50" class="form-control" placeholder="제목" aria-label="title"
                   aria-describedby="basic-addon1"
                   id="title" name="title" autofocus required>
            <div class="invalid-feedback">
              제목을 입력해 주세요.
            </div>
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
                <div class="" style="margin-top: 2px; height: 60px;">
                  <span class="dataName d-block text-truncate" data-dz-name="data-dz-name" data-toggle="tooltip"
                        data-placement="top">&nbsp;</span>
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
        <%--        <div id="editor"></div>--%>

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
                      <button form="modalForm" type="submit" class="btn btn-sm btn-success" id="btnSave">
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

      <%-- update modal --%>
      <div class="modal-body form-input hide" id="modalBodyUpdate" style="padding: unset;">
        <form id="modalFormUpdate" class="m-0 needs-validation" method="post" onsubmit="return false;" novalidate>
          <div class="input-group mb-0">
            <label class="input-group-text" for="title">제목</label>
            <input type="text" maxlength="50" class="form-control" placeholder="제목" aria-label="title"
                   aria-describedby="basic-addon1"
                   id="titleUpdate" name="title" autofocus required>
            <div class="invalid-feedback">
              제목을 입력해 주세요.
            </div>
          </div>
        </form>

        <div class="input-group mb-0" style="align-items: center">
          <label class="input-group-text">첨부파일</label>
          <div id="dropzoneUpdate" class="dropzone"
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
            <div class="wrapper" id="dropzone-preview-update" style="overflow-x: scroll">
              <div class="test border rounded-3" id="dropzone-preview-list-update"
                   style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
                <!-- This is used as the file preview template -->
                <div class="" style=" height: 120px; width: inherit;">
                  <img id="updateDropzoneImg" data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#"
                       alt="Dropzone-Image"
                       style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
                </div>
                <div class="" style="margin-top: 2px; height: 60px;">
                  <span class="dataName d-block text-truncate" data-dz-name="data-dz-name" data-dz-down="data-dz-down"
                        data-toggle="tooltip" data-placement="top">&nbsp;</span>
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
        <%--        <div id="editor"></div>--%>

        <!--Footer-->
        <div class="modal-footer" style="display: block">
          <div class="row">
            <div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <div class="container">
                  <div class="row">
                    <div class="col text-center">
                      <button type="button" class="btn btn-sm btn-primary" name="btnClose" id="btnCloseUpdate"
                              data-dismiss="modal"
                              aria-label="Close">
                        <i class="fa fa-times"></i> 닫기
                      </button>
                      <button form="modalFormUpdate" type="submit" class="btn btn-sm btn-success" id="btnUpdate">
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
<div class="container">
  <nav aria-label="Page navigation">
    <ul class="pagination" id="pagination" style="justify-content: center"></ul>
  </nav>
</div>
</html>
