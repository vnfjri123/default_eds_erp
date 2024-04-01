<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf" %>

<%--<jsp:include page="/WEB-INF/views/eds/ims/notice/erpNoticePopView.jsp" flush="true" />--%>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard</title>
</head>
<%@ include file="/WEB-INF/views/comm/common-include-head.jspf" %>
<%-- 공통헤드 --%>
<%@ include file="/WEB-INF/views/comm/common-include-css.jspf" %>
<%-- 공통 스타일시트 정의--%>
<%@ include file="/WEB-INF/views/comm/common-include-js.jspf" %>
<%-- 공통 스크립트 정의--%>
<%--<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf" %>--%>
<%-- tui grid --%>

<%@ include file="/WEB-INF/views/eds/ims/notice/noticePopView.jsp" %>

<link rel="stylesheet" href="/ims/dashboard/dashboard.css">
<link rel="stylesheet" href="/ims/dashboard/material-dashboard.css">
<link rel="stylesheet" href="/tui/tui-pagination/dist/tui-pagination.css">
<link rel="stylesheet" href="/css/edms/edms.css">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">

<script src="https://kit.fontawesome.com/4ac0e9170f.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css"/>

<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">

<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

<!-- AdminLTE App -->
<script src="/css/AdminLTE_main/dist/js/adminlte.js"></script>

<%--<script type="text/javascript"--%>
<%--        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=f720f60108ac7e478e0ea412c7a0eac4"></script>--%>

<!-- services 라이브러리 불러오기 -->
<script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=f720f60108ac7e478e0ea412c7a0eac4&libraries=services"></script>

<script src="/ims/dashboard/sig.js"></script>

<script>
    var selectpicker;
    var currentMonth = new Date().getMonth() + 1;
    Chart.register(ChartDataLabels);
    $(document).ready(() => {
        init();
    })

    /* 초기설정 */
    async function init() {
        edsUtil.setForm(document.querySelector("#searchForm"), "basma");
        selectpicker = $('.selectpicker').select2({
            language: 'ko'
        });
        $('select[name="ad"] option:contains(' + '전체' + ')').remove();

        /* 이벤트 셋팅 */
        selectHome();

        /* 그리드 생성 */
        editChar();
        editMonthlyChart();
        /* 지도 생성 */
        editMap();

        //	이벤트

        var isExpanded = false;
        var mapWidth = $('#map-body').css('width');

        $('#expandMapBtn').on('click', ()=>{
            isExpanded = !isExpanded;

            if (isExpanded) {
                $('#map').css('width', '100vw');
                $('#map').css('height', '96vh');
                map.relayout();
            } else {
                $('#map').css('width', mapWidth);
                $('#map').css('height', '83.5vh');
                map.relayout();
            }
        })

        $(".selectpicker").on('change', async ev => {
            var id = ev.target.id;
            switch (id) {
                case 'ad':
                    editMap();
                    $('#category').children().removeClass('on');
            }
        });
    }

    /**********************************************************************
     * 화면 함수 영역 START
     ***********************************************************************/
    var errorData;

    async function selectHome() {
        var param = {}; //조회조건
        param.corpCd = ${LoginInfo.corpCd};
        param.year = edsUtil.getToday('%Y');
        // param.progressDivi = '01';
        let calendarData = edsUtil.getAjax("/calendarView/selectTodayCalendar", param);

        let siteData = edsUtil.getAjax("/siteView/selectSite", param);

        let inspectionData = edsUtil.getAjax("/inspection/selectThisMonthPercent", param);

        errorData = edsUtil.getAjax("/errorView/selectError", param);
        var inCompleteError = [];
        for (let i = 0; i < errorData.length; i++) {
            if (errorData[i].progressDivi === '01') {
                inCompleteError.push(errorData[i]);
            }
        }
        $('#todayCalendarCnt').text(calendarData.length + '건');
        $('#siteCnt').text(siteData.length + '개소');
        if (inspectionData[0] !== null) {
            $('#thisMonthInspectionPercent').text((inspectionData[0].completionNum / inspectionData[0].totNum * 100).toFixed(1) + '%');
        }
        $('#errorCnt').text(inCompleteError.length + '건');
    }

    function sendHome(id) {
        const data = {};
        data.messageDivi = 'home';//
        data.id = id;
        window.parent.postMessage(data);
    }

    function editChar() {
        var param = {};
        param.corpCd = ${LoginInfo.corpCd};
        // let errorData = edsUtil.getAjax("/errorView/selectError", param);
        // console.log('errorData')
        // console.log(errorData)
        var errorInCompletionData = [];
        var errorCompletionData = [];
        for (let i = 0; i < errorData.length; i++) {
            if (errorData[i].progressDivi === '01') {
                errorInCompletionData.push(errorData[i]);
            } else if (errorData[i].progressDivi === '02') {
                errorCompletionData.push(errorData[i]);
            }
        }
        // param.progressDivi = '02';
        // let errorCompletionData = edsUtil.getAjax("/errorView/selectError", param);
        //
        // param.progressDivi = '01';
        // let errorInCompletionData = edsUtil.getAjax("/errorView/selectError", param);

        const el = document.getElementById('chart-area');
        const data = {
            series: [
                {
                    name: '완료',
                    data: errorCompletionData.length,
                },
                {
                    name: '미결',
                    data: errorInCompletionData.length,
                },
            ],
        };
        const theme = {
            legend: {
                label: {
                    fontSize: 18,
                },
            },
            chart: {
                fontFamily: 'Noto Sans KR',
            },
            series: {
                hover: {
                    lineWidth: 1,
                    strokeStyle: '#000000',
                },
                dataLabels: {
                    useSeriesColor: true,
                    lineWidth: 1,
                    textStrokeColor: '#ffffff',
                    shadowColor: '#ffffff',
                    shadowBlur: 2,
                    fontSize: 20,
                    callout: {
                        lineWidth: 1,
                        lineColor: '#f44336',
                        useSeriesColor: false,
                    },
                    pieSeriesName: {
                        color: '#FFFFFF',
                        fontSize: 16,
                        fontWeight: '500',
                    },
                },
                colors: ['#3498DB', '#E74C3C'],
                lineWidth: 1,
                strokeStyle: '#ABB2B9',
                select: {
                    color: '#808B96',
                    lineWidth: 1,
                    shadowBlur: 10,
                    restSeries: {
                        areaOpacity: 0.5,
                    },
                    areaOpacity: 1,
                },
                areaOpacity: 1,
            },
        };
        const options = {
            chart: {height: 'auto'},
            series: {
                // radiusRange: {
                //     inner: '40%',
                //     outer: '100%',
                // },
                selectable: true,
                dataLabels: {
                    visible: true,
                    pieSeriesName: {
                        visible: true,
                    },
                },
            },
            exportMenu: { visible: false },
            theme,
        };

        const chart = toastui.Chart.pieChart({el, data, options});
    }

    var map;
    var markers = [];
    var overlayList = [];
    var polygons=[];

    function editMap() {
        removeMarker(markers);
        removeOverlay(overlayList);

        var param = {};
        param.corpCd = '${LoginInfo.corpCd}';
        param.ad = $(".selectpicker").val();
        param.year = edsUtil.getToday('%Y');

        var coordinateData = edsUtil.getAjax('siteView/selectSite', param);
        // console.log('확인')
        // console.log(coordinateData)

        var nature1Num = [];
        var nature2Num = [];
        var socialNum = [];
        for (let i = 0; i < coordinateData.length; i++) {
            if (coordinateData[i].latitude === '' || coordinateData[i].longitude === null) {
                continue;
            } else if (coordinateData[i].depaCd === '1008') {
                nature1Num.push(coordinateData[i]);
            } else if (coordinateData[i].depaCd === '1009') {
                nature2Num.push(coordinateData[i]);
            } else if (coordinateData[i].depaCd === '1012') {
                socialNum.push(coordinateData[i]);
            }
        }
        $('#numberTextNature1').text('(' + nature1Num.length + ')');
        $('#numberTextNature2').text('(' + nature2Num.length + ')');
        $('#numberTextSocial').text('(' + socialNum.length + ')');
        var totalNum = nature1Num.length + nature2Num.length + socialNum.length;
        $('#numberTextAll').text('(' + totalNum + ')');

        var imageData = edsUtil.getAjax("/siteView/selectSiteImageList", param);

        // // 함수 호출하여 중심 좌표 계산
        // const centerCoordinate = centroid(coordinateData);
        //
        // // 결과 출력
        // if (centerCoordinate) {
        //     console.log('중심 좌표:', centerCoordinate);
        // } else {
        //     console.error('중심 좌표를 계산할 수 없습니다.');
        // }

        var container = document.getElementById('map'); //지도를 담을 영역
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(35.919395, 128.601404),
            level: 9 //지도의 레벨(확대, 축소 정도)
        };

        // if (isNaN(centerCoordinate.La) || isNaN(centerCoordinate.Ma)) {
        //     var options = { //지도를 생성할 때 필요한 기본 옵션
        //         center: new kakao.maps.LatLng(35.919395, 128.601404), //지도의 중심좌표.
        //         level: 9 //지도의 레벨(확대, 축소 정도)
        //     };
        // } else {
        //     var options = { //지도를 생성할 때 필요한 기본 옵션
        //         center: new kakao.maps.LatLng(centerCoordinate.Ma, centerCoordinate.La), //지도의 중심좌표.
        //         level: 9 //지도의 레벨(확대, 축소 정도)
        //     };
        // }

        if (map === undefined) {
            map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
            map.setMaxLevel(13); //지도의 최고레벨(최대 축소)
            // 아래와 같이 옵션을 입력하지 않아도 된다
            var zoomControl = new kakao.maps.ZoomControl();

            // 지도 오른쪽에 줌 컨트롤이 표시되도록 지도에 컨트롤을 추가한다.
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        }
        // else if (map !== undefined) {
            // // 주어진 centerCoordinate 객체에서 위도와 경도 값을 가져와서 LatLng 객체를 생성
            // if (isNaN(centerCoordinate.La) || isNaN(centerCoordinate.Ma)) {
            //     var latLng = new kakao.maps.LatLng(35.919395, 128.601404);
            //     // 생성된 LatLng 객체를 사용하여 지도의 중심을 설정
            //     // map.setCenter(latLng);
            // } else {
            //     var latLng = new kakao.maps.LatLng(centerCoordinate.Ma, centerCoordinate.La);
            //     // 생성된 LatLng 객체를 사용하여 지도의 중심을 설정
            //     // map.setCenter(latLng);
            // }
        // }

        // 폴리곤
        var coordinates = [];    //좌표 저장할 배열
        var adName = $('#ad :selected').text();
        var adData = '';

        for (let i = 0; i < sigData.features.length; i++) {
            coordinates = sigData.features[i].geometry.coordinates;
            adData = sigData.features[i].properties.SIG_KOR_NM;

            if (adName === adData) {
                displayArea(coordinates)
            }
        }

        //행정구역 폴리곤
        function displayArea(coordinates) {
            // 기존 폴리곤이 있을 경우 제거
            if (polygons.length > 0) {
                $.each(polygons, function (index, existingPolygon) {
                    existingPolygon.setMap(null); // 지도에서 폴리곤 제거
                });
                polygons = []; // 배열 초기화
            }

            var path = [];            //폴리곤 그려줄 path
            var points = [];        //중심좌표 구하기 위한 지역구 좌표들

            $.each(coordinates, function(index, coordinate) {
                // console.log('index='+index);
                if(index<1) {
                    $.each(coordinate, function(index,value) {
                        var point = new Object();
                        point.x = value[1];
                        point.y = value[0];
                        points.push(point);

                        path.push(new kakao.maps.LatLng(value[1], value[0]));
                    });
                }
            })

            // 다각형을 생성합니다
            var polygon = new kakao.maps.Polygon({
                map : map, // 다각형을 표시할 지도 객체
                path : path,
                strokeWeight : 3,
                strokeColor : '#1F618D',
                strokeOpacity : 0.8,
                fillColor : '#000',
                fillOpacity : 0.1
            });

            polygons.push(polygon);            //폴리곤 제거하기 위한 배열

            if (points.length < 10) {
                map.setLevel(6);
            } else {
                map.setLevel(9);
            }
            map.setCenter(centroid(points)); //센터로 이동
        }

        // 지도 영역
        // param.neLat = map.getBounds().getNorthEast().getLat();
        // param.neLng = map.getBounds().getNorthEast().getLng();
        // param.swLat = map.getBounds().getSouthWest().getLat();
        // param.swLng = map.getBounds().getSouthWest().getLng();
        //
        // var markerData = edsUtil.getAjax("/siteView/selectSite", param);

        // 아이콘 공통 설정
        var baseImageParams = {
            size: new kakao.maps.Size(32, 32),
            option: {offset: new kakao.maps.Point(14, 37)}
        };

        // 아이콘 정의
        var icons = {
            social: '/ims/dashboard/social.png',
            natural1: '/ims/dashboard/natural1.png',
            natural2: '/ims/dashboard/natural2.png'
        };

        // 마커 생성 및 이벤트 핸들러 등록
        // for (var i = 0; i < markerData.length; i++) {
        //     var position = new kakao.maps.LatLng(markerData[i].latitude, markerData[i].longitude);
        //
        //     // 마커 생성
        //     var markerImage;
        //
        //     switch (markerData[i].depaCd) {
        //         case '1012':
        //             markerImage = new kakao.maps.MarkerImage(icons.social, baseImageParams.size, baseImageParams.option);
        //             break;
        //         case '1008':
        //             markerImage = new kakao.maps.MarkerImage(icons.natural1, baseImageParams.size, baseImageParams.option);
        //             break;
        //         case '1009':
        //             markerImage = new kakao.maps.MarkerImage(icons.natural2, baseImageParams.size, baseImageParams.option);
        //             break;
        //         default:
        //             // 처리하지 않는 경우
        //             continue;
        //     }
        //
        //     // 이미지 데이터 가져오기
        //     var imageDataForMarker = getImageDataForMarker(markerData[i].index);
        //
        //     var marker = new kakao.maps.Marker({
        //         map: map,
        //         position: position,
        //         title: markerData[i].siteNm,
        //         image: markerImage,
        //         clickable: true
        //     });
        //     markers.push(marker);
        //
        //     // 커스텀 오버레이 생성
        //     var customOverlay = new kakao.maps.CustomOverlay({
        //         position: position,
        //         content: '<div class="customOverlayText">' + markerData[i].siteNm + '</div>',
        //         currCategory : ''
        //     });
        //
        //     console.log(customOverlay.currCategory)
        //     // customOverlay.setMap(map);
        //
        //     // 이미지 표출
        //     var imageContent = '<div class="left col-md-6" style="padding: unset">';
        //     if (imageDataForMarker) {
        //         for (var j = 0; j < Math.min(imageDataForMarker.length, 4); j++) {
        //             imageContent += '<img class="col-6 infoImage" src="/file/1001/ims/0001/images/' + imageDataForMarker[j].saveNm + '.' + imageDataForMarker[j].ext + '">';
        //         }
        //     }
        //     imageContent += '</div>';
        //
        //     // 인포윈도우 생성
        //     var infowindow = new kakao.maps.InfoWindow({
        //         content: '<div class="info-header">' + markerData[i].siteNm + '</div>' +
        //             '<div class="info-body">' +
        //             '<span>' + markerData[i].address + '</span>' +
        //             '<div class="row">' +
        //             '<div class="left col-md-6" style="padding: unset">' +
        //             // 이미지 등 추가 정보 표시
        //             imageContent +
        //             '</div>' +
        //             '<div class="left info col-md-6" style="padding: 0 0 0 0">' +
        //             '<span>설치일 : ' + markerData[i].installDt + '</span>' +
        //             '<span>배터리 : ' + markerData[i].batteryDt + '</span>' +
        //             '<span>IP : ' + markerData[i].ipAdr + '</span>' +
        //             '</div>' +
        //             '</div>' +
        //             '</div>',
        //         removable: true
        //     });
        //
        //     // 이벤트 핸들러 등록
        //     kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
        // }

        // removeMarker(markers);
        // customOverlay.setMap(null);

        addCategoryClickEvent();
        // onClickCategory();
        // changeCategoryClass();
        // searchPlaces();

        // 중심좌표 알고리즘
        function centroid (points) {
            var i, j, len, p1, p2, f, area, x, y;

            area = x = y = 0;

            for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
                p1 = points[i];
                p2 = points[j];

                f = p1.y * p2.x - p2.y * p1.x;
                x += (p1.x + p2.x) * f;
                y += (p1.y + p2.y) * f;
                area += f * 3;
            }
            return new kakao.maps.LatLng(x / area, y / area);
        }


        // function centroid(points) {
        //     var i, j, len, p1, p2, f, area, x, y;
        //     area = x = y = 0;
        //
        //     // 위경도 빈 값인 데이터 필터링
        //     const validCoordinates = points.filter(coord => coord.latitude !== '' && coord.longitude !== '');
        //
        //     for (i = 0, len = validCoordinates.length, j = len - 1; i < len; j = i++) {
        //         p1 = validCoordinates[i];
        //         p2 = validCoordinates[j];
        //
        //         f = Number(p1.longitude) * Number(p2.latitude) - Number(p2.longitude) * Number(p1.latitude);
        //         x += (Number(p1.latitude) + Number(p2.latitude)) * f;
        //         y += (Number(p1.longitude) + Number(p2.longitude)) * f;
        //         area += f * 3;
        //     }
        //     return new kakao.maps.LatLng(x / area, y / area);
        // }

        // 이미지 데이터 가져오기 함수
        function getImageDataForMarker(siteIndex) {
            <%--var param = {};--%>
            <%--param.corpCd = ${LoginInfo.corpCd};--%>
            <%--var imageData = edsUtil.getAjax("/siteView/selectSiteImageList", param);--%>
            return imageData.filter(function (data) {
                return data.siteIndex === siteIndex;
            });
        }

        // 각 카테고리에 클릭 이벤트를 등록합니다
        function addCategoryClickEvent() {
            var category = document.getElementById('category'),
                children = category.children;

            for (var i = 0; i < children.length; i++) {
                children[i].onclick = onClickCategory;
            }
        }

        // 카테고리를 클릭했을 때 호출되는 함수입니다
        function onClickCategory() {
            var id = this.id,
                className = this.className;
            if (className === 'on') {
                currCategory = '';
                changeCategoryClass();
                removeMarker(markers);
                removeOverlay(overlayList);
            } else {
                currCategory = id;
                changeCategoryClass(this);
                searchPlaces();
            }
        }

        // 카테고리 검색을 요청하는 함수입니다
        function searchPlaces() {
            // var ps = new kakao.maps.services.Places(map);
            if (!currCategory) {
                return;
            }

            if (currCategory === 'social') {
                param.depaCd = '1012';
            } else if (currCategory === 'nature1') {
                param.depaCd = '1008';
            } else if (currCategory === 'nature2') {
                param.depaCd = '1009';
            } else if (currCategory === 'all') {
                param.depaCd = '';
            }

            // 지도 영역
            // param.neLat = map.getBounds().getNorthEast().getLat();
            // param.neLng = map.getBounds().getNorthEast().getLng();
            // param.swLat = map.getBounds().getSouthWest().getLat();
            // param.swLng = map.getBounds().getSouthWest().getLng();

            var markerData = edsUtil.getAjax("/siteView/selectSite", param);

            removeMarker(markers);
            removeOverlay(overlayList);

            // 마커 생성 및 이벤트 핸들러 등록
            for (var i = 0; i < markerData.length; i++) {
                var position = new kakao.maps.LatLng(markerData[i].latitude, markerData[i].longitude);

                // 마커 생성
                var markerImage;

                switch (markerData[i].depaCd) {
                    case '1012':
                        markerImage = new kakao.maps.MarkerImage(icons.social, baseImageParams.size, baseImageParams.option);
                        break;
                    case '1008':
                        markerImage = new kakao.maps.MarkerImage(icons.natural1, baseImageParams.size, baseImageParams.option);
                        break;
                    case '1009':
                        markerImage = new kakao.maps.MarkerImage(icons.natural2, baseImageParams.size, baseImageParams.option);
                        break;
                    default:
                        // 처리하지 않는 경우
                        continue;
                }

                // 이미지 데이터 가져오기
                var imageDataForMarker = getImageDataForMarker(markerData[i].index);

                var marker = new kakao.maps.Marker({
                    map: map,
                    position: position,
                    title: markerData[i].siteNm,
                    image: markerImage,
                    clickable: true
                });
                markers.push(marker);

                // 커스텀 오버레이 생성
                var customOverlay = new kakao.maps.CustomOverlay({
                    position: position,
                    content: '<div class="customOverlayText">' + markerData[i].siteNm + '</div>',
                    currCategory: ''
                });
                overlayList.push(customOverlay);

                customOverlay.setMap(map);

                // 이미지 표출
                var imageContent = '<div class="left col-md-6" style="padding: unset">';
                if (imageDataForMarker) {
                    for (var j = 0; j < Math.min(imageDataForMarker.length, 4); j++) {
                        imageContent += '<img class="col-6 infoImage" src="/file/1001/ims/0001/images/' + imageDataForMarker[j].saveNm + '.' + imageDataForMarker[j].ext + '">';
                    }
                }
                imageContent += '</div>';

                // 인포윈도우 생성
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div class="info-header">' + markerData[i].siteNm + '</div>' +
                        '<div class="info-body">' +
                        '<span>' + markerData[i].address + '</span>' +
                        '<div class="row">' +
                        '<div class="left col-md-6" style="padding: unset">' +
                        // 이미지 등 추가 정보 표시
                        imageContent +
                        '</div>' +
                        '<div class="left info col-md-6" style="padding: 0 0 0 0">' +
                        '<span>설치일 : ' + markerData[i].installDt + '</span>' +
                        '<span>배터리 : ' + markerData[i].batteryDt + '</span>' +
                        '<span>IP : ' + markerData[i].ipAdr + '</span>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                    removable: true
                });

                // 이벤트 핸들러 등록
                kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
            }
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        // function placesSearchCB(data, status, pagination) {
        //     console.log(data)
        //     console.log(status)
        //     if (status === kakao.maps.services.Status.OK) {
        //         // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
        //         displayPlaces(data);
        //     } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        //         // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
        //     } else if (status === kakao.maps.services.Status.ERROR) {
        //         // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
        //     }
        // }

        // 지도에 마커를 표출하는 함수입니다
        // function displayPlaces(places) {
        //     // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
        //     // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
        //     var order = document.getElementById(currCategory).getAttribute('data-order');
        //     console.log('order 확인')
        //     console.log(order)
        //
        //
        //     // for ( var i=0; i<places.length; i++ ) {
        //     //
        //     //     // 마커를 생성하고 지도에 표시합니다
        //     //     var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
        //     //
        //     //     // 마커와 검색결과 항목을 클릭 했을 때
        //     //     // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
        //     //     (function(marker, place) {
        //     //         kakao.maps.event.addListener(marker, 'click', function() {
        //     //             displayPlaceInfo(place);
        //     //         });
        //     //     })(marker, places[i]);
        //     // }
        // }

        // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
        function changeCategoryClass(el) {
            var category = document.getElementById('category'),
                children = category.children,
                i;

            for (i = 0; i < children.length; i++) {
                children[i].className = '';
            }

            if (el) {
                el.className = 'on';
            }
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker(markers) {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers.length = 0;
            // markers = [];
        }

        // 지도 위에 표시되고 있는 오버레이를 모두 제거합니다
        function removeOverlay(overlayList) {
            for (var i = 0; i < overlayList.length; i++) {
                overlayList[i].setMap(null);
            }
            overlayList.length = 0;
            // overlayList = [];
        }

        // 클로저를 이용한 인포윈도우 표시 함수
        function makeOverListener(map, marker, infowindow) {
            return function () {
                infowindow.open(map, marker);
                var img = document.getElementsByClassName('infoImage')
                var imgToArr = Array.from(img);
                for (let i = 0; i < imgToArr.length; i++) {
                    imgToArr[i].onclick = () => {
                        $('#expandModal').modal('show');
                        $('#expandImage').attr('src', img[i].src);
                    }
                }
            };
        }
    }

    function editMonthlyChart() {
        let param = {};
        param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>'
        param.year = edsUtil.getToday('%Y');

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

        var scNum = 0;
        var ndOneNum = 0;
        var ndTwoNum = 0;
        var scTooltipData = [];
        var ndOneTooltipData = [];
        var ndTwoTooltipData = [];

        for (const row of data) {
            if (row.month == null) continue;
            switch (row.depaCd) {
                case '1012' :
                    if (row.month < '40') {
                        scData[row.month] = row.completionNum / row.totNum * 100;
                        scTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                        scNum = row.totNum;
                    }
                    break;
                case '1008' :
                    if (row.month < '40') {
                        ndOneData[row.month] = row.completionNum / row.totNum * 100;
                        ndOneTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                        ndOneNum = row.totNum;
                    }
                    break;
                case '1009' :
                    if (row.month < '40') {
                        ndTwoData[row.month] = row.completionNum / row.totNum * 100;
                        ndTwoTooltipData[Number(row.month)] = row.completionNum + '/' + row.totNum;
                        ndTwoNum = row.totNum;
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

        //-------------
        //- BAR CHART -
        //-------------
        var barChartCanvas = $('#monthlyChart').get(0).getContext('2d')
        var barChartData = $.extend(true, {}, areaChartData)

        var barChartOptions = {
            plugins: {
                datalabels: {
                    display: function (context) {
                        return context.dataset.data[context.dataIndex] && context.dataIndex + 1 === currentMonth;
                    },
                    align: 'center',
                    anchor: 'center',
                    // backgroundColor: '#ccc', // 라벨 배경색
                    // borderRadius: 4, // 라벨 모서리 둥글기
                    color: '#333', // 라벨 텍스트 색상
                    font: {
                        size: '11px',
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
        progressChart = new Chart(barChartCanvas, {
            type: 'bar',
            data: barChartData,
            options: barChartOptions
        })
    }

    /* 지도 함수 시작 */

    <%--// 중심좌표 알고리즘--%>
    <%--function centroid (points) {--%>
    <%--    var i, j, len, p1, p2, f, area, x, y;--%>
    <%--    area = x = y = 0;--%>

    <%--    // 위경도 빈 값인 데이터 필터링--%>
    <%--    const validCoordinates = points.filter(coord => coord.latitude !== '' && coord.longitude !== '');--%>

    <%--    for (i = 0, len = validCoordinates.length, j = len - 1; i < len; j = i++) {--%>
    <%--        p1 = validCoordinates[i];--%>
    <%--        p2 = validCoordinates[j];--%>

    <%--        f = Number(p1.longitude) * Number(p2.latitude) - Number(p2.longitude) * Number(p1.latitude);--%>
    <%--        x += (Number(p1.latitude) + Number(p2.latitude)) * f;--%>
    <%--        y += (Number(p1.longitude) + Number(p2.longitude)) * f;--%>
    <%--        area += f * 3;--%>
    <%--    }--%>
    <%--    return new kakao.maps.LatLng(x / area, y / area);--%>
    <%--}--%>

    <%--// 이미지 데이터 가져오기 함수--%>
    <%--function getImageDataForMarker(siteIndex) {--%>
    <%--    var param = {};--%>
    <%--    param.corpCd = ${LoginInfo.corpCd};--%>
    <%--    var imageData = edsUtil.getAjax("/siteView/selectSiteImageList", param);--%>
    <%--    return imageData.filter(function (data) {--%>
    <%--        return data.siteIndex === siteIndex;--%>
    <%--    });--%>
    <%--}--%>

    <%--// 각 카테고리에 클릭 이벤트를 등록합니다--%>
    <%--        function addCategoryClickEvent() {--%>
    <%--            var category = document.getElementById('category'),--%>
    <%--                children = category.children;--%>

    <%--            for (var i = 0; i < children.length; i++) {--%>
    <%--                children[i].onclick = onClickCategory;--%>
    <%--            }--%>
    <%--        }--%>

    <%--// 카테고리를 클릭했을 때 호출되는 함수입니다--%>
    <%--        function onClickCategory() {--%>
    <%--            var id = this.id,--%>
    <%--                className = this.className;--%>

    <%--            if (className === 'on') {--%>
    <%--                currCategory = '';--%>
    <%--                changeCategoryClass();--%>
    <%--                removeMarker();--%>
    <%--            } else {--%>
    <%--                currCategory = id;--%>
    <%--                changeCategoryClass(this);--%>
    <%--                searchPlaces();--%>
    <%--            }--%>
    <%--        }--%>

    <%--// 카테고리 검색을 요청하는 함수입니다--%>
    <%--function searchPlaces() {--%>
    <%--    console.log(currCategory)--%>
    <%--    var ps = new kakao.maps.services.Places(map);--%>
    <%--    if (!currCategory) {--%>
    <%--        return;--%>
    <%--    }--%>

    <%--    // 커스텀 오버레이를 숨깁니다--%>
    <%--    //placeOverlay.setMap(null);--%>

    <%--    // 지도에 표시되고 있는 마커를 제거합니다--%>
    <%--    // removeMarker(markers);--%>

    <%--    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});--%>
    <%--    //console.log('currCategory='+currCategory);--%>

    <%--    // displayPlaces(sido,currCategory);--%>
    <%--}--%>

    <%--// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다--%>
    <%--function placesSearchCB(data, status, pagination) {--%>
    <%--    if (status === kakao.maps.services.Status.OK) {--%>
    <%--        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다--%>
    <%--        displayPlaces(data);--%>
    <%--    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {--%>
    <%--        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요--%>
    <%--    } else if (status === kakao.maps.services.Status.ERROR) {--%>
    <%--        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요--%>
    <%--    }--%>
    <%--}--%>

    <%--// 지도에 마커를 표출하는 함수입니다--%>
    <%--function displayPlaces(places) {--%>

    <%--    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다--%>
    <%--    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다--%>
    <%--    var order = document.getElementById(currCategory).getAttribute('data-order');--%>
    <%--    console.log('order 확인')--%>
    <%--    console.log(order)--%>


    <%--    // for ( var i=0; i<places.length; i++ ) {--%>
    <%--    //--%>
    <%--    //     // 마커를 생성하고 지도에 표시합니다--%>
    <%--    //     var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);--%>
    <%--    //--%>
    <%--    //     // 마커와 검색결과 항목을 클릭 했을 때--%>
    <%--    //     // 장소정보를 표출하도록 클릭 이벤트를 등록합니다--%>
    <%--    //     (function(marker, place) {--%>
    <%--    //         kakao.maps.event.addListener(marker, 'click', function() {--%>
    <%--    //             displayPlaceInfo(place);--%>
    <%--    //         });--%>
    <%--    //     })(marker, places[i]);--%>
    <%--    // }--%>
    <%--}--%>

    <%--// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다--%>
    <%--function changeCategoryClass(el) {--%>
    <%--    var category = document.getElementById('category'),--%>
    <%--        children = category.children,--%>
    <%--        i;--%>

    <%--    for (i = 0; i < children.length; i++) {--%>
    <%--        children[i].className = '';--%>
    <%--    }--%>

    <%--    if (el) {--%>
    <%--        el.className = 'on';--%>
    <%--    }--%>
    <%--}--%>

    <%--// 지도 위에 표시되고 있는 마커를 모두 제거합니다--%>
    <%--function removeMarker(markers) {--%>
    <%--    for (var i = 0; i < markers.length; i++) {--%>
    <%--        markers[i].setMap(null);--%>
    <%--    }--%>
    <%--    markers = [];--%>
    <%--}--%>

    <%--// 클로저를 이용한 인포윈도우 표시 함수--%>
    <%--function makeOverListener(map, marker, infowindow) {--%>
    <%--    return function () {--%>
    <%--        infowindow.open(map, marker);--%>
    <%--        var img = document.getElementsByClassName('infoImage')--%>
    <%--        var imgToArr = Array.from(img);--%>
    <%--        for (let i = 0; i < imgToArr.length; i++) {--%>
    <%--            imgToArr[i].onclick = () => {--%>
    <%--                $('#expandModal').modal('show');--%>
    <%--                $('#expandImage').attr('src', img[i].src);--%>
    <%--            }--%>
    <%--        }--%>
    <%--    };--%>
    <%--}--%>
    /*지도 함수 끝*/
    /**********************************************************************
     * 화면 함수 영역 END
     ***********************************************************************/
</script>

<body style="padding-top: 0.5rem;overflow: hidden">
<div class="row main">
  <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
    <div class="card">
      <div class="card-header" style="padding:1px 1rem 1px 1rem !important;">
        <div class="icon icon-md icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n2 position-absolute">
          <i class="material-icons opacity-10">event_available</i>
        </div>
        <div class="text-end pt-1">
          <p class="text-sm mb-0 text-capitalize">오늘의 일정</p>
          <h4 class="mb-0" id="todayCalendarCnt">0건</h4>
        </div>
      </div>
      <hr class="dark horizontal my-0">
      <div class="card-footer p-1">
        <p class="mb-0"><span class="text-success text-sm font-weight-bolder"> </span>
          <a onclick="sendHome('121')" href="#" class="small-box-footer">
            캘린더 바로가기 <i class="fas fa-arrow-circle-right"></i></a>
        </p>
      </div>
      <%--      <div class="card-footer p-3">--%>
      <%--        <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+55% </span>than last week</p>--%>
      <%--      </div>--%>
    </div>
  </div>
  <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
    <div class="card">
      <div class="card-header p-3 pt-2" style="padding:1px 1rem 1px 1rem !important;">
        <div class="icon icon-md icon-shape bg-gradient-info shadow-primary text-center border-radius-xl mt-n2 position-absolute"
             style="background: #3498DB !important;">
          <i class="material-icons opacity-10">public</i>
        </div>
        <div class="text-end pt-1">
          <p class="text-sm mb-0 text-capitalize">합계</p>
          <h4 class="mb-0" id="siteCnt">0개소</h4>
        </div>
      </div>
      <hr class="dark horizontal my-0">
      <div class="card-footer p-1">
        <p class="mb-0"><span class="text-success text-sm font-weight-bolder"> </span>
          <a onclick="sendHome('123')" href="#" class="small-box-footer">
            사이트 바로가기 <i class="fas fa-arrow-circle-right"></i></a>
        </p>
      </div>
    </div>
  </div>
  <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
    <div class="card">
      <div class="card-header p-3 pt-2" style="padding:1px 1rem 1px 1rem !important;">
        <div class="icon icon-md icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n2 position-absolute">
          <i class="material-icons opacity-10">build</i>
        </div>
        <div class="text-end pt-1">
          <p class="text-sm mb-0 text-capitalize">이달의 점검율</p>
          <h4 class="mb-0" id="thisMonthInspectionPercent">0%</h4>
        </div>
      </div>
      <hr class="dark horizontal my-0">
      <div class="card-footer p-1">
        <p class="mb-0"><span class="text-success text-sm font-weight-bolder"> </span>
          <a onclick="sendHome('141')" href="#" class="small-box-footer">
            점검 바로가기 <i class="fas fa-arrow-circle-right"></i></a>
        </p>
      </div>
    </div>
  </div>
  <div class="col-xl-3 col-sm-6">
    <div class="card">
      <div class="card-header p-3 pt-2" style="padding:1px 1rem 1px 1rem !important;">
        <div class="icon icon-md icon-shape bg-gradient-primary shadow-info text-center border-radius-xl mt-n2 position-absolute"
             style="background: #E74C3C !important;">
          <i class="material-icons opacity-10">priority_high</i>
        </div>
        <div class="text-end pt-1">
          <p class="text-sm mb-0 text-capitalize">미결건수</p>
          <h4 class="mb-0" id="errorCnt">0건</h4>
        </div>
      </div>
      <hr class="dark horizontal my-0">
      <div class="card-footer p-1">
        <p class="mb-0"><span class="text-success text-sm font-weight-bolder"> </span>
          <a onclick="sendHome('145')" href="#" class="small-box-footer">
            장애처리 바로가기 <i class="fas fa-arrow-circle-right"></i></a>
        </p>
      </div>
    </div>
  </div>
  <section class="col-lg-4">
    <div class="card">
      <div class="card-header" style="padding: 0.25rem 1rem 0.25rem 1rem">
        <h3 class="card-title">
          장애처리 현황
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
      </div>
      <div class="card-body">
        <div id="chart-area" style="height: 350px"></div>
      </div>
    </div>
    <div class="card">
      <div class="card-header" style="padding: 0.25rem 1rem 0.25rem 1rem">
        <h3 class="card-title">
          점검 현황
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
      </div>
      <div class="card-body">
        <div class="chart">
          <div class="chartjs-size-monitor">
            <div class="chartjs-size-monitor-expand">
              <div class=""></div>
            </div>
            <div class="chartjs-size-monitor-shrink">
              <div class=""></div>
            </div>
          </div>
          <canvas id="monthlyChart"
                  style="display: block; height: 38vh; width: inherit !important;" class="chartjs-render-monitor"></canvas>
        </div>
      </div>
    </div>
  </section>

  <section class="col-lg-8" style="padding: unset">
    <div class="card">
      <div class="card-header" style="padding: 0 1rem 0 0; height: 2.5rem">
        <h3 class="card-title">
          <%--          지도--%>
          <form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" style="width: 150px">
            <select class="form-control selectpicker" style="width: 150px;" name="ad" id="ad"></select>
          </form>
        </h3>
        <div class="card-tools">
          <button type="button" class="btn btn-tool" data-card-widget="collapse">
            <i class="fas fa-minus"></i>
          </button>
          <button type="button" class="btn btn-tool" id="expandMapBtn" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
        </div>
      </div>
      <div class="card-body" id="map-body" style="overflow: hidden;">
        <div id="map" style="height: 83.5vh"></div>
        <ul id="category">
          <li id="social" data-order="0">
            <span class="category_bg social"></span>
            사회
            <span class="numberText" id="numberTextSocial">d</span>
          </li>
          <li id="nature1" data-order="1">
            <span class="category_bg nature1"></span>
            자연 1
            <span class="numberText" id="numberTextNature1">d</span>
          </li>
          <li id="nature2" data-order="2">
            <span class="category_bg nature2"></span>
            자연 2
            <span class="numberText" id="numberTextNature2">d</span>
          </li>
          <li id="all" data-order="3">
            <span class="category_bg all"></span>
            전체
            <span class="numberText" id="numberTextAll">d</span>
          </li>
        </ul>
      </div>
    </div>
  </section>
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
        <div style="width: inherit; height: inherit">
          <img id="expandImage">
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
