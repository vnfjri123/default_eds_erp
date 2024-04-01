<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>

<!DOCTYPE html>
<html>
<head>
  <title>Error</title>
</head>

<%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
<%-- 공통헤드 --%>
<%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
<%-- 공통 스타일시트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
<%-- 공통 스크립트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf" %>
<%-- tui grid --%>

<link rel="stylesheet" href="/ims/error/error.css">

<link rel="stylesheet" href="/tui/tui-pagination/dist/tui-pagination.css">
<link rel="stylesheet" href="/css/edms/edms.css">
<script src="https://kit.fontawesome.com/4ac0e9170f.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<script src="/js/util/eds.ims.js"></script>

<%--에디터 테이블 병합 플러그인--%>
<%--<link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-table-merged-cell/latest/toastui-editor-plugin-table-merged-cell.min.css"/>--%>
<%--<script src="https://uicdn.toast.com/editor-plugin-table-merged-cell/latest/toastui-editor-plugin-table-merged-cell.min.js"></script>--%>

<%--<link rel="stylesheet"--%>
<%--      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">--%>


<%--<script type="text/javascript" src='/js/com/eds.edms.js'></script>--%>

<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js">--%>
<%--</script>--%>
<%--<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">--%>

<%--다음(카카오) 주소찾기 api--%>
<%--<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>--%>

<script>

    var mainSheet;
    var errorEditor, updateErrorEditor;
    var selectpicker;
    var today = getCurrentDateYYMMDD();

    // const { Editor } = toastui;
    // const { tableMergedCell } = Editor.plugin;

    $(document).ready(async function () {
        // $('.modal').css('overflow-y', 'hidden');

        resetModalForm();
        await init();

        //	이벤트

        // Alt + enter => 에디터 테이블 행 추가
        $(document).on('keydown', (event) => {
            if (event.altKey && event.keyCode === 13) {
                event.preventDefault();
                errorEditor.exec('addRowToDown');
                updateErrorEditor.exec('addRowToDown');
                ['#editor', '#updateEditor'].forEach(function(editorId) {
                    var table = $(editorId + ' table tbody');
                    table.find('tr').each(function() {
                        var firstPElement = $(this).find('td:first-child p');
                        if (firstPElement.length && !firstPElement.text().trim()) {
                            firstPElement.text(today);
                        }
                    });
                });
            }
        });

        imsUtil.focusSearch('siteNmSearch');

        // 검색
        // $(parent.document).on('keydown', (e) => {
        //     if (e.which === 191) {
        //         e.preventDefault();
        //         document.getElementById('siteNmSearch').focus();
        //     }
        // });
        //
        // $(document).on('keydown', (e) => {
        //     const targetTag = e.target.tagName;
        //     const targetClass = e.currentTarget.body.className;
        //     const keyCode = e.which || e.keyCode;
        //
        //     // '/' 키를 눌렀고, 대상 요소가 'body'일 경우
        //     if (keyCode === 191 && targetClass === 'body' && targetTag !== 'INPUT') {
        //         e.preventDefault();
        //         document.getElementById('siteNmSearch').focus();
        //     }
        // });

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

    });

    async function init() {
        // $('[data-mask]').inputmask();
        var param = {};
        param.corpCd = '${LoginInfo.corpCd}';
        param.depaCd = '${LoginInfo.depaCd}';
        param.busiCd = "${LoginInfo.busiCd}"

        edsUtil.setForm(document.querySelector("#searchForm"), "basma");
        edsUtil.setForm(document.querySelector("#modalForm"), "basma");
        // edsUtil.setForm(document.querySelector("#modalFormND"), "basma");
        edsUtil.setForm(document.querySelector("#updateForm"), "basma");
        // edsUtil.setForm(document.querySelector("#updateFormND"), "basma");

        var errorImages = [];
        var imageNames = [];
        var currentImageNames = [];

        errorEditor = new toastui.Editor({
            el: document.querySelector('#editor'),
            height: '400px',
            language: 'ko',
            initialEditType: 'wysiwyg',
            theme: 'dark',
            // plugins: [tableMergedCell],
            hooks: {
                async addImageBlobHook(blob, callback) {
                    var divi = 'errors';
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

                            // 공통 데이터가 있으면 blob을 errorImages에 추가
                            if (commonData.length > 0) {
                                errorImages.push(blob);
                            }

                            // errorImages에서 현재 이미지 이름에 해당하지 않는 blob 제거
                            errorImages = errorImages.filter(existingBlob => {
                                const existingFileName = extractFileName(existingBlob.urlData);
                                return currentImageNames.includes(existingFileName);
                            });
                        },
                    })
                },
            }
        });
        updateErrorEditor = new toastui.Editor({
            el: document.querySelector('#updateEditor'),
            height: '400px',
            language: 'ko',
            initialEditType: 'wysiwyg',
            theme: 'dark',
            hooks: {
                async addImageBlobHook(blob, callback) {
                    var divi = 'errors';
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

                            // 공통 데이터가 있으면 blob을 errorImages에 추가
                            if (commonData.length > 0) {
                                errorImages.push(blob);
                            }

                            // errorImages에서 현재 이미지 이름에 해당하지 않는 blob 제거
                            errorImages = errorImages.filter(existingBlob => {
                                const existingFileName = extractFileName(existingBlob.urlData);
                                return currentImageNames.includes(existingFileName);
                            });
                        },
                    })
                },
            }
        });

        errorEditor.on('change', function () {
            // 현재 이미지 이름을 업데이트
            currentImageNames = extractImageFileNames(errorEditor.getHTML());

            // errorImages 업데이트
            errorImages = errorImages.filter(existingBlob => {
                const existingFileName = extractFileName(existingBlob.urlData);
                return currentImageNames.includes(existingFileName);
            });
        });
        updateErrorEditor.on('change', function () {
            // 현재 이미지 이름을 업데이트
            currentImageNames = extractImageFileNames(updateErrorEditor.getHTML());

            // errorImages 업데이트
            errorImages = errorImages.filter(existingBlob => {
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

        mainSheet = new tui.Grid({
            el: document.getElementById('grid'),
            scrollX: false,
            scrollY: false,
            editingEvent: 'click',
            bodyHeight: 600,
            rowHeight: 30,
            minRowHeight: 30,
            // rowHeaders: ['rowNum', 'checkbox'], // 체크박스 기능
            rowHeaders: ['rowNum'], // 체크박스 기능
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
                    siteNm: {
                        template(valueMap) {
                            return '장애건수 : ' + mainSheet.getFilteredData().length + '개';
                        }
                    },
                    progressDivi: {
                        template: function (valueMap) {
                            // 필터링된 데이터 가져오기
                            var filteredData = mainSheet.getFilteredData();

                            // 진행 상태별 카운트 초기화
                            var completedCnt = 0;
                            var inCompletedCnt = 0;

                            // 필터링된 데이터에서 진행 상태별로 카운트
                            for (var i = 0; i < filteredData.length; i++) {
                                if (filteredData[i].progressDivi === '01') {
                                    inCompletedCnt += 1;
                                } else if (filteredData[i].progressDivi === '02') {
                                    completedCnt += 1;
                                }
                            }

                            return '미결 : ' + inCompletedCnt + '개';
                        }
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
                header: '완료여부',
                name: 'progressDivi',
                width: 100,
                align: 'center',
                hidden: true
            },
            {
                header: '부서명',
                name: 'depaNm',
                minWidth: 60,
                align: 'center',
                filter: 'select',
                showClearBtn: true,
            },
            {
                header: '지자체',
                name: 'ad',
                minWidth: 60,
                align: 'center',
                filter: 'select',
                editor: {type: 'select', options: {listItems: setCommCode("SYS010")}},
                formatter: 'listItemText',
            },
            {
                header: '사이트명',
                name: 'siteNm',
                minWidth: 60,
                align: 'center',
                className: 'highlight-cell',
                filter: {
                    type: 'text',
                    showClearBtn: true
                }
            },
            {
                header: '구분',
                name: 'clasifyDivi',
                minWidth: 60,
                align: 'center',
                filter: 'select',
                editor: {type: 'select', options: {listItems: setCommCode("SYS012")}},
                formatter: 'listItemText',
            },
            {
                header: '제목',
                name: 'title',
                minWidth: 60,
                align: 'center',
                filter: 'select',
            },
            // {
            //     header: '내용',
            //     name: 'content',
            //     width: 100,
            //     align: 'center',
            //     filter: {
            //         type: 'text',
            //         showClearBtn: true
            //     }
            // },
            {
                header: '접수일',
                name: 'receiptDt',
                minWidth: 60,
                align: 'center',
                filter: {
                    type: 'date',
                    options: {
                        format: 'yyyy-MM-dd'
                    },
                    showClearBtn: true,
                },
                formatter({value}) {
                    return yyyymmdd(new Date(value));
                }
            },
            {
                header: '진행상태',
                name: 'progressDivi',
                minWidth: 60,
                align: 'center',
                filter: 'select',
                editor: {
                    type: 'select', options: {
                        listItems: [
                            {text: '진행중', value: '01'},
                            {text: '완료', value: '02'}
                        ]
                    }
                },
                formatter: 'listItemText',
            },
            {
                header: '작성자',
                name: 'inpId',
                minWidth: 60,
                align: 'center',
                filter: 'select',
            },
            {
                header: '작성일자',
                name: 'inpDttm',
                minWidth: 60,
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
                header: '처리자',
                name: 'handler',
                minWidth: 60,
                align: 'center',
                filter: 'select',
            },
            {
                header: '처리일자',
                name: 'completionDt',
                minWidth: 60,
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
                header: '수정자',
                name: 'updId',
                minWidth: 60,
                align: 'center',
                filter: 'select',
            },
            {
                header: '수정일자',
                name: 'updDttm',
                minWidth: 60,
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
        ]);
        mainSheet.disableColumn('ad');
        mainSheet.disableColumn('clasifyDivi');
        selectpicker = $('.selectpicker').select2({
            language: 'ko'
        });
        // mainSheet.disableColumn('progressDivi');
        doAction('mainSheet', 'search');

        /**********************************************************************
         * Grid 이벤트 영역 END
         ***********************************************************************/

        // '사이트 등록' 버튼 노출 부서 구분
        if ('${LoginInfo.depaCd}'.includes('1008') || '${LoginInfo.depaCd}'.includes('1009') || '${LoginInfo.depaCd}'.includes('1012') || '${LoginInfo.empCd}' === '0007') {
            $('#insertPjBtn').css('display', 'block');
        } else {
            $('#insertPjBtn').css('display', 'none');
        }

        $('#insertPjBtn').on('click', (e) => {
            $('#modalBody').removeClass('hide').addClass('show')
            $('#modalBodyUpdate').removeClass('show').addClass('hide')
            changeOptColor('insert');
            document.querySelector('input[name="inpId"]').value = "${LoginInfo.empNm}";
            document.querySelector('input[name="receiptDt"]').value = edsUtil.getToday('%Y-%m-%d');

            // 기본 HTML 틀 생성
            var defaultHTML = `
    <div>* 단축키 Alt + Enter = 테이블 행 추가, 외 옵션 = 마우스 우클릭
        <table>
    <thead>
        <tr>
            <th>일자</th>
            <th>증상</th>
            <th>조치사항</th>
            <th>비고</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>\${today}</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </tbody>
</table>
    </div>
`;
            errorEditor.setHTML(defaultHTML);
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
            param.corpCd = '${LoginInfo.corpCd}';
            if ('${LoginInfo.empCd}' === '0007') {
                param.depaCd = '1009';
                param.depaNm = "자연재난2팀";
            } else {
                param.depaCd = '${LoginInfo.depaCd}';
                param.depaNm = "${LoginInfo.depaNm}";
            }
            param.busiCd = "${LoginInfo.busiCd}"
            param.content = errorEditor.getHTML();

            var formData = new FormData();
            const params = [param];

            formData.append("html", errorEditor.getHTML());
            formData.append("divi", 'errors');
            formData.append("moduleDivi", 'ims');
            formData.append("data", JSON.stringify(params));

            var files = [];
            errorImages.forEach((blob) => {
                const fileName = blob.name;
                const fileType = blob.type;
                const file = new File([blob], fileName, {type: fileType});
                files.push(file);
            });

            // 각 파일을 FormData에 추가
            files.forEach((file) => {
                formData.append('file', file);
            });

            console.log('formData')
            console.log(formData)

            $.ajax({
                url: "/errorView/cudError",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#exampleModal').modal('hide');
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

        /*******************************************************
         사이트 수정 Modal 호출
         *******************************************************/

        var imageList = [];
        mainSheet.on('click', async (e) => {
            if (e.targetType === 'cell') {
                $('#modalBody').removeClass('show').addClass('hide')
                $('#modalBodyUpdate').removeClass('hide').addClass('show')
                $('#exampleModal').modal('show');

                var cellData = mainSheet.getData()[e.rowKey];

                <%--if (cellData.depaCd !== '${LoginInfo.depaCd}') {--%>
                <%--    $('.btnSaveUpdate').css('display', 'none');--%>
                <%--    $('.btnDeleteUpdate').css('display', 'none');--%>
                <%--} else {--%>
                <%--    $('.btnSaveUpdate').css('display', 'inline-block');--%>
                <%--    $('.btnDeleteUpdate').css('display', 'inline-block');--%>
                <%--}--%>
                <%--if ('${LoginInfo.empCd}' === '0003' && cellData.depaCd === '1009') {--%>
                <%--    $('.btnSaveUpdate').css('display', 'inline-block');--%>
                <%--    $('.btnDeleteUpdate').css('display', 'inline-block');--%>
                <%--}--%>
                var btnSaveUpdateDisplay = cellData.depaCd !== '${LoginInfo.depaCd}' ? 'none' : 'inline-block';
                var btnDeleteUpdateDisplay = cellData.depaCd !== '${LoginInfo.depaCd}' ? 'none' : 'inline-block';

                if ('${LoginInfo.empCd}' === '0007' && cellData.depaCd === '1009') {
                    btnSaveUpdateDisplay = 'inline-block';
                    btnDeleteUpdateDisplay = 'inline-block';
                }

                $('.btnSaveUpdate').css('display', btnSaveUpdateDisplay);
                $('.btnDeleteUpdate').css('display', btnDeleteUpdateDisplay);

                $('#errorIndex').val(cellData.index);
                param.errorIndex = $('#errorIndex').val();

                var imageData = edsUtil.getAjax("/errorView/selectErrorImageList", param);

                imageList.push(imageData);

                param.index = cellData.index;
                var siteData = edsUtil.getAjax("/errorView/selectErrorByIndex", param);

                var data = {}
                data.data = siteData[0]
                data.form = document.getElementById('updateForm');
                if (data.data.content != null) {
                    await updateErrorEditor.setHTML(data.data.content);
                }

                imageList.data = updateErrorEditor.getHTML();

                var dataToForm = await edsUtil.eds_dataToForm(data);
            }
        })

        /*******************************************************
         수정 / update
         *******************************************************/
        $('#btnUpdate').on('click', (e) => {
            validate($('#updateForm'));
            if (!$('#updateForm').valid()) {
                return;
            }

            var param = ut.serializeObject(document.querySelector("#updateForm"));
            param.status = 'U';
            param.corpCd = '${LoginInfo.corpCd}';
            param.depaCd = '${LoginInfo.depaCd}';
            param.busiCd = "${LoginInfo.busiCd}"
            param.depaNm = "${LoginInfo.depaNm}";
            param.updId = "${LoginInfo.empCd}";
            param.errorIndex = $('#errorIndex').val();
            param.content = updateErrorEditor.getHTML();

            var formData = new FormData();
            const params = [param];
            var files = [];
            errorImages.forEach((blob) => {
                const fileName = blob.name;
                const fileType = blob.type;
                const file = new File([blob], fileName, {type: fileType});
                files.push(file);
            });

            // 각 파일을 FormData에 추가
            files.forEach((file) => {
                formData.append('file', file);
            });
            formData.append("html", updateErrorEditor.getHTML());
            formData.append("divi", 'errors');
            formData.append("moduleDivi", 'ims');
            formData.append("images", imageList.data);

            formData.append("data", JSON.stringify(params));

            // 현재 파일
            var currentFile = updateErrorEditor.getHTML();
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
                url: "/errorView/cudError",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {
                    $('#exampleModal').modal('hide');

                    var removeImage = [];
                    for (const images of deletedFiles) {
                        let data = {};
                        data.saveNm = images;
                        data.errorIndex = $('#errorIndex').val();
                        data.corpCd = '${LoginInfo.corpCd}';
                        data.busiCd = "${LoginInfo.busiCd}";
                        removeImage.push(data);
                    }
                    if (removeImage.length > 0) await edsUtil.getAjax2("/errorView/errorImageDelete", removeImage)

                    doAction('mainSheet', 'search2');
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
            param.corpCd = ${LoginInfo.corpCd};
            param.index = $('#index').val();
            param.errorIndex = $('#errorIndex').val();
            param.busiCd = "${LoginInfo.busiCd}";
            param.status = "D";
            param.content = updateErrorEditor.getHTML();

            var formData = new FormData();
            const params = [param];

            formData.append("html", updateErrorEditor.getHTML());
            formData.append("divi", 'errors');
            formData.append("moduleDivi", 'ims');
            formData.append("data", JSON.stringify(params));

            $.ajax({
                url: "/errorView/cudError",
                type: "POST",
                data: formData,
                async: false,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: async function (result) {

                    $('#exampleModal').modal('hide');

                    doAction('mainSheet', 'search2');
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

    /*******************************************************
     함수 시작
     *******************************************************/

    /* 화면 이벤트 */
    async function doAction(sheetNm, sAction) {
        if (sheetNm === 'mainSheet') {
            switch (sAction) {
                case "search":
                    var param = ut.serializeObject(document.querySelector("#searchForm"));
                    // var param = {};
                    param.corpCd = ${LoginInfo.corpCd};
                    //param.depaCd = ${LoginInfo.depaCd};
                    param.busiCd = "${LoginInfo.busiCd}"
                    mainSheet.resetData(edsUtil.getAjax("/errorView/selectError", param));
                    for (var i = 0; i < mainSheet.getColumnValues('progressDivi').length; i++) {
                        if (mainSheet.getColumnValues('progressDivi')[i] === '02') {
                            mainSheet.addCellClassName(i, 'progressDivi', 'completed')
                        } else if (mainSheet.getColumnValues('progressDivi')[i] === '01') {
                            mainSheet.addCellClassName(i, 'progressDivi', 'inCompleted')
                        }
                    }
                    break;
                case "search2":
                    var param = ut.serializeObject(document.querySelector("#searchForm"));
                    // var param = {};
                    param.corpCd = ${LoginInfo.corpCd};
                    //param.depaCd = ${LoginInfo.depaCd};
                    param.busiCd = "${LoginInfo.busiCd}"
                    mainSheet.resetData2(edsUtil.getAjax("/errorView/selectError", param));
                    for (var i = 0; i < mainSheet.getColumnValues('progressDivi').length; i++) {
                        if (mainSheet.getColumnValues('progressDivi')[i] === '02') {
                            mainSheet.addCellClassName(i, 'progressDivi', 'completed')
                        } else if (mainSheet.getColumnValues('progressDivi')[i] === '01') {
                            mainSheet.addCellClassName(i, 'progressDivi', 'inCompleted')
                        }
                    }
                    break;
            }
        }
    }

    // form input text 초기화
    function resetModalForm() {
        $('#exampleModal').on('hidden.bs.modal', function (e) {
            $(this).validate().resetForm();
            $(this).find('.error').removeClass('error');
            $(this).find('form')[0].reset();
            $(this).find('form')[1].reset();
            errorEditor.reset();
            updateErrorEditor.reset();
        });
    }

    // yyyy-mm-dd format
    function yyyymmdd(dateIn) {
        var yyyy = dateIn.getFullYear()
        var mm = dateIn.getMonth() + 1 // getMonth() is zero-based
        var dd = dateIn.getDate()
        return String(yyyy + '-' + ('00' + mm).slice(-2) + '-' + ('00' + dd).slice(-2));
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

    function validate(form) {
        form.validate({
            rules: {
                siteNm: {
                    required: true
                },
                title: {
                    required: true
                },
                completionDt: {
                    required: function () {
                        if ($('select[name=progressDivi]').val() === '02') {
                            return true;
                        } else {
                            return false;
                        }
                    },
                },
            },
            messages: {}
        })
        $.extend($.validator.messages, {
            required: "필수 항목입니다."    // required 속성의 공동 메세지
        });
    }

    async function popupHandler(name, divi, callback) {
        // var row = systemGridList.getFocusedCell();
        var names = name.split('_');
        switch (names[0]) {
            case 'site':
                if (divi === 'open') {
                    var param = {}
                    param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
                    param.depaCd = "${LoginInfo.depaCd}";
                    param.name = name;

                    param.from = 'error';

                    $('#btnCarryOver').remove();
                    await edsIframe.openPopup('SITEPOPUP', param);
                } else {
                    $('input[name="title"]').focus();
                    if (callback.siteNm === undefined) {
                        return
                    }
                    $('input[name=siteIndex]').val(callback.siteIndex)
                    // $('input[name=depaNm]').val(callback.depaNm)
                    $('input[name=siteNm]').not($('#siteNmSearch')).val(callback.siteNm)
                    $('input[name=projNm]').val(callback.projNm)
                    $('input[name=projCd]').val(callback.projCd)
                    $('input[name=installDt]').val(callback.installDt)
                    $('input[name=batteryDt]').val(callback.batteryDt)
                    $('select:not(#adSearch)[name=ad]').val(callback.ad)
                    $('select[name=clasifyDivi]').val(callback.clasifyDivi)
                    $('select[name=modelDivi]').val(callback.modelDivi)

                    // $('input[name=siteIndex]').val(callback.siteIndex)
                    // $('input[name=siteNm]').val(callback.siteNm)
                    // $('input[name=projNm]').val(callback.projNm)
                    // $('input[name=projCd]').val(callback.projCd)
                    // $('input[name=installDt]').val(callback.installDt)
                    // $('input[name=batteryDt]').val(callback.batteryDt)
                    // $('select:not(#adSearch)[name=ad]').val(callback.ad)
                    // $('select[name=clasifyDivi]').val(callback.clasifyDivi)
                    // $('select[name=modelDivi]').val(callback.modelDivi)

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

    function changeOptColor(form) {
        if (form === 'insert' && $("select[name=progressDivi]")[0].value === '01') {
            $("select[name=progressDivi]").css("color", 'red');
        } else if (form === 'insert' && $("select[name=progressDivi]")[0].value === '02') {
            $("select[name=progressDivi]").css("color", 'blue');
        }

        if (form === 'update' && $("select[name=progressDivi]")[1].value === '01') {
            $("select[name=progressDivi]").css("color", 'red');
        } else if (form === 'update' && $("select[name=progressDivi]")[1].value === '02') {
            $("select[name=progressDivi]").css("color", 'blue');
        }
    }

    // YYMMDD
    function getCurrentDateYYMMDD() {
        const now = new Date();
        const year = now.getFullYear().toString().slice(-2); // 뒤에서 2자리만 가져옴
        const month = ('0' + (now.getMonth() + 1)).slice(-2); // 뒤에서 2자리만 가져옴
        const day = ('0' + now.getDate()).slice(-2); // 뒤에서 2자리만 가져옴
        return year + month + day;
    }

    /*******************************************************
     함수 종료
     *******************************************************/
</script>
<body class="body">
<div style="height: inherit">
  <div class="col-md-12" style="background-color: #ebe9e4; padding: unset">
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
          <button id="insertPjBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"
                  style="display: none">장애처리 등록
          </button>
          <div class="form-group" style="margin-left: 4rem"></div>

          <label for="siteNm">사이트명 &nbsp;</label>
          <div class="input-group input-group-sm">
            <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="siteNm"
                   id="siteNmSearch"
                   title="사이트명">
          </div>
          <div class="form-group" style="margin-left: 4rem"></div>

          <label for="titleSearch">제목 &nbsp;</label>
          <div class="input-group input-group-sm">
            <input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="title"
                   id="titleSearch"
                   title="사이트명">
          </div>
        </div>

        <div class="form-group" style="margin-left: 5rem"></div>

        <div class="form-group">
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
      <div class="modal-body form-input" id="modalBody" style="padding: unset;">
        <div class="form-group col-md-12">
          <%--사회재난 input form--%>
          <form id="modalForm" method="post" onsubmit="return false;">
            <input hidden="hidden" id="siteIndex" name="siteIndex">
            <input hidden="hidden" id="errorIndex" name="errorIndex">
            <div class="content-dis">
              <div class="form-row">
                <div class="col-md-4 mb-3">
                  <label for="siteNm"><b>사이트명</b></label>
                  <button id="findProjBtn" type="button" class="btn btn-primary float-right"
                          onclick="popupHandler('site','open')"
                          style="font-size: 15px; padding: unset; white-space: nowrap;">사이트 찾기
                  </button>
                  <input readonly placeholder="&quot;사이트 찾기&quot; 버튼을 눌러 입력해 주세요." type="text" class="form-control"
                         id="siteNm" name="siteNm" autofocus>
                </div>
                <div class="col-md-3 mb-3">
                  <label for="projNm"><b>프로젝트명</b></label>
                  <input readonly disabled type="text" class="form-control" id="projNm" name="projNm" required>
                  <input type="text" hidden="hidden" id="projCd" name="projCd">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="ad"><b>지자체</b></label>
                  <select disabled class="form-control modal-select ad" id="ad" name="ad"></select>
                </div>
                <div class="col-md-1 mb-3">
                  <label for="clasifyDivi"><b>구분</b></label>
                  <select disabled class="form-control modal-select select-container" id="clasifyDivi"
                          name="clasifyDivi">
                  </select>
                </div>
                <div class="col-md-1 mb-3">
                  <label for="install-date"><b>설치년월</b></label>
                  <input readonly disabled id="install-date" class="form-control" name="installDt" type="date"
                         max="9999-12-31">
                  <div id="wrapper" style="margin-top: 5px; z-index: 1"></div>
                </div>
                <div class="col-md-1 mb-3">
                  <label for="install-battery"><b>배터리 설치일자</b></label>
                  <input readonly disabled id="install-battery" class="form-control" name="batteryDt" type="date"
                         max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="modelDivi"><b>모델</b></label>
                  <select disabled class="form-control modal-select select-container" id="modelDivi" name="modelDivi">
                  </select>
                </div>
              </div>

              <div class="form-row">
                <div class="col-md-3 mb-3">
                  <label for="title"><b>제목</b></label>
                  <input type="text" class="form-control" id="title" name="title">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="receiptDt"><b>장애 접수일자</b></label>
                  <input id="receiptDt" class="form-control" name="receiptDt" type="date" max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="inpId"><b>작성자</b></label>
                  <input type="text" class="form-control" id="inpId" name="inpId">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="completionDt"><b>처리 완료일자</b></label>
                  <input id="completionDt" class="form-control" name="completionDt" type="date" max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="handler"><b>처리자</b></label>
                  <input disabled placeholder="자동기입" type="text" class="form-control" id="handler" name="handler">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="progressDivi"><b>진행상태</b></label>
                  <select onchange="changeOptColor('insert')" class="form-control modal-select" id="progressDivi"
                          name="progressDivi">
                    <option selected value="01">진행중</option>
                    <option value="02">완료</option>
                  </select>
                </div>
              </div>
            </div>
          </form>
          <div class="content-dis">
            <label for="editor"><b>내용</b></label>
            <div id="editor"></div>
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
                      <button type="submit" class="btn btn-sm btn-success" id="btnSave">
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
          <%--사회재난 input form--%>
          <form id="updateForm" method="post" onsubmit="return false;">
            <input hidden="hidden" id="index" name="index">
            <%--            <input hidden="hidden" id="siteIndex" name="siteIndex">--%>
            <div class="content-dis">
              <div class="form-row">
                <div class="col-md-4 mb-3">
                  <label for="siteNmUpdate"><b>사이트명</b></label>
                  <%--                  <button id="findProjBtnUpdate" type="button" class="btn btn-primary float-right"--%>
                  <%--                          onclick="popupHandler('site','open')"--%>
                  <%--                          style="font-size: 15px; padding: unset; white-space: nowrap;">사이트 찾기--%>
                  <%--                  </button>--%>
                  <input readonly disabled type="text" class="form-control" id="siteNmUpdate" name="siteNm" autofocus>
                </div>
                <div class="col-md-3 mb-3">
                  <label for="projNmUpdate"><b>프로젝트명</b></label>
                  <input readonly disabled type="text" class="form-control" id="projNmUpdate" name="projNm" required>
                  <input type="text" hidden="hidden" id="projCdUpdate" name="projCd">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="adUpdate"><b>지자체</b></label>
                  <select disabled class="form-control modal-select ad" id="adUpdate" name="ad"></select>
                </div>
                <div class="col-md-1 mb-3">
                  <label for="clasifyDiviUpdate"><b>구분</b></label>
                  <select disabled class="form-control modal-select select-container" id="clasifyDiviUpdate"
                          name="clasifyDivi">
                  </select>
                </div>
                <div class="col-md-1 mb-3">
                  <label for="install-date"><b>설치년월</b></label>
                  <input readonly disabled id="install-dateUpdate" class="form-control" name="installDt" type="date"
                         max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="install-battery"><b>배터리 설치일자</b></label>
                  <input readonly disabled id="install-batteryUpdate" class="form-control" name="batteryDt" type="date"
                         max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="modelDiviUpdate"><b>모델</b></label>
                  <select disabled class="form-control modal-select select-container" id="modelDiviUpdate"
                          name="modelDivi">
                  </select>
                </div>
              </div>

              <div class="form-row">
                <div class="col-md-3 mb-3">
                  <label for="titleUpdate"><b>제목</b></label>
                  <input type="text" class="form-control" id="titleUpdate" name="title">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="receiptDtUpdate"><b>장애 접수일자</b></label>
                  <input id="receiptDtUpdate" class="form-control" name="receiptDt" type="date" max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="inpIdUpdate"><b>작성자</b></label>
                  <input type="text" class="form-control" id="inpIdUpdate" name="inpId">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="completionDtUpdate"><b>처리 완료일자</b></label>
                  <input id="completionDtUpdate" class="form-control" name="completionDt" type="date" max="9999-12-31">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="handlerUpdate"><b>처리자</b></label>
                  <input disabled placeholder="자동기입" type="text" class="form-control" id="handlerUpdate" name="handler">
                </div>
                <div class="col-md-1 mb-3">
                  <label for="progressDiviUpdate"><b>진행상태</b></label>
                  <select onchange="changeOptColor('update')" class="form-control modal-select" id="progressDiviUpdate"
                          name="progressDivi">
                    <option selected value="01">진행중</option>
                    <option value="02">완료</option>
                  </select>
                </div>
              </div>
            </div>
          </form>
          <div class="content-dis">
            <label for="updateEditor"><b>내용</b></label>
            <div id="updateEditor"></div>
          </div>
        </div>
        <!--Footer-->
        <div class="modal-footer" style="display: block; padding-top: 1px">
          <div class="row">
            <div class="col-md-12" style="padding: 0 15px 0 15px; background-color: #ebe9e4">
              <div class="col text-center">
                <form class="form-inline" role="form" name=""
                      id="" method="post" onsubmit="return false;">
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
                        <button type="submit" class="btn btn-sm btn-success btnSaveUpdate" id="btnUpdate"><i
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
