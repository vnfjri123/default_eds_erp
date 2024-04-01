<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>

<%@ include file="/WEB-INF/views/comm/common-include-url.jspf"%><!-- 공통 Content-Security-Policy -->

<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<meta content="width=device-width,initial-scale=1" name="viewport">

	<%--------------------------------------------------
	웹 상단 아이콘 설정 START
	--------------------------------------------------%>

	<link rel="icon" href="/AdminLTE_main/dist/img/edsLogo_small.png">

	<%--------------------------------------------------
	웹 상단 아이콘 설정 EDN
	--------------------------------------------------%>

	<%--------------------------------------------------
	모바일 전제화면 설정 START
	--------------------------------------------------%>

	<!-- 모바일용웹 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<!-- 안드로이드 홈화면추가시 상단 주소창 제거 -->
	<meta name="mobile-web-app-capable" content="yes">
	<!-- ios홈화면추가시 상단 주소창 제거 -->
	<meta name="apple-mobile-web-app-capable" content="yes">

	<%--------------------------------------------------
	모바일 전제화면 설정 EDN
	--------------------------------------------------%>

	<!--===============================================================================================-->
	<link rel="stylesheet" href="/login/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.blue-deep_purple.min.css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
	<link href="/login/fonts/fontello/css/fontello.css" rel="stylesheet" />
	<link rel="stylesheet" href="/login/css/bootstrap-offset-right.css">
	<link rel="stylesheet" href="/login/css/style.css">
	<style>
		.mdl-textfield--floating-label.is-focused .mdl-textfield__label,
		.mdl-textfield--floating-label.is-dirty .mdl-textfield__label,
		.mdl-textfield--floating-label.has-placeholder .mdl-textfield__label {
			color: white;
		}

		input:-webkit-autofill {
			-webkit-box-shadow: 0 0 0 1000px white inset;
			box-shadow: 0 0 0 1000px rgb(60, 63, 65) inset;
			font-size: 16px;
			-webkit-text-fill-color: #fff !important;
		}
	</style>
	<!--===============================================================================================-->
</head>
<body>
<div class="container">
	<div class="center-block">
		<div class="col-lg-4 col-lg-offset-1 col-md-4 col-md-offset-1 col-sm-12 col-xs-12 no-padding" style="z-index:1">
			<!-- Slider -->
			<div class="mlt-carousel">
				<div id="myCarousel">
					<div>
						<div class="item active" style="background-color: white;">
							<img class="img-responsive center-block" src="/AdminLTE_main/dist/img/edsLogo_big.png" alt="step1" style="margin-top: 50%; padding: 0 10px 0 10px" >
						</div>
					</div>
				</div>
				<!--mlt-carousel-->
			</div>
			<!-- Slider -->
		</div>
		<!-- Login -->

		<div class="col-lg-6 col-lg-offset-right-1 col-md-6 col-md-offset-right-1 col-sm-12 col-xs-12 no-padding">
			<div id="loginScreen" class="mlt-content">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#login" data-toggle="tab" style="color: #FFF; border-color: #FFF;">Login</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade in active" id="login">
						<div class="col-lg-10 col-lg-offset-1 col-lg-offset-right-1 col-md-10 col-md-offset-1 col-md-offset-right-1 col-sm-12 col-xs-12 pull-right ">
							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
								<input class="mdl-textfield__input" type="text" id="id">
								<label class="mdl-textfield__label" for="id">User ID</label>
							</div>
						</div>

						<div class="col-lg-10 col-lg-offset-1 col-lg-offset-right-1 col-md-10 col-md-offset-1 col-md-offset-right-1 col-sm-12 col-xs-12 pull-right ">
							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
								<input class="mdl-textfield__input" type="password" id="pwd">
								<label class="mdl-textfield__label" for="pwd" style="color: #FFF;">Password</label>
							</div>
						</div>

						<div class="col-lg-10 col-lg-offset-1 col-lg-offset-right-1 col-md-10 col-md-offset-1 col-md-offset-right-1 col-sm-12 col-xs-12 pull-right ">
							<button class="btn lt-register-btn" id="btnlogin">login <i class="icon-right "></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Login-->
	</div>
	<!--center-block-->
</div>
<!--container-->

<!--===============================================================================================-->
<script src="/login/js/jquery.min.js "></script>
<script src="/login/js/bootstrap.min.js "></script>
<script src="/login/libs/mdl/material.min.js "></script>
<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js " ></script>
<!--===============================================================================================-->
<script type="text/javascript" src='/plugins/toastr/toastr.min.js'></script>
<script type="text/javascript" src='/plugins/toastr/toastrmessage.js'></script>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="/plugins/toastr/toastr.min.css">
<!--===============================================================================================-->

<script>
	$(document).ready(function () {
		if (isMobile()) {
			document.querySelector('div[class="item active"]').style.height = "100px";
			document.querySelector('img[class="img-responsive center-block"]').style.marginTop="6%";
			document.querySelector('div[class="mlt-carousel"]').style.height = "unset";
			document.querySelector('div[class="mlt-content"]').style.height = "470px"
		}
		/*
		* server session check
		* */
		$.ajax({
			url : "/LOGIN/selectSESSCheck",
			type: "POST",
			async: false,
			success: function(result){
				if(result){// 세션이 있는경우
					if(isMobile()) {// 모바일
						window.location.href = "/eds/pda/salma/selectSALMA3500View";
					} else {// PC
						window.location.href = "/eds/erp/global/selectCONTENTView";
					}
					return;
				}else {

				}
			}
		});

		$('#pwd, #id').keydown(function (e) {
			if (e.keyCode == 13) {
				logincheck();
			}
		});

		$('#btnlogin').click(function () {
			logincheck();
		});

		$('#id').focus();

	});

	function logincheck() {

		if (navigator.onLine == false) {
			toastrmessage("toast-bottom-center", "error", "네트워크에 연결되어 있지 않습니다.", "실패", 1500);
			return;
		}

		if (!$('#id').val()) {
			toastrmessage("toast-bottom-center", "error", "아이디를 입력해 주세요.", "실패", 1500);
			return;
		}
		if (!$('#pwd').val()) {
			toastrmessage("toast-bottom-center", "error", "비밀번호를 입력해 주세요.", "실패", 1500);
			return;
		}

		var param = {
			id: $('#id').val(),
			pwd: $('#pwd').val()
		};

		$.ajax({
			url: "/LOGIN/selectLOGINCheck",
			type: "POST",
			data: param,
			async: false,
			success: function (result) {
				if (result.code == "fail") {
					toastrmessage("toast-bottom-center", "error", "접속 정보를 확인해 주세요.", "실패", 1500);
					$('#id').focus();
				} else if (result.code == "success") {
					/** 사용자 정보 세션 추가
					 * */
					sessionStorage.setItem('userId', $('#id').val());
					// if(isMobile()) {// 모바일
					// 	window.location.href = "/eds/pda/salma/selectSALMA3500View";
					// } else {// PC
					// 	window.location.href = "/LOGIN_VIEW";
					// }
					window.location.href = "/LOGIN_VIEW";

				} else if (result.code == "reset") {
					window.location.href = "/LOGIN/RESET";
				} else if(result.code == "fail_acc") {
					toastrmessage("toast-bottom-center", "error", "접속이 제한된 계정입니다.", "실패", 1500);
				}
			}
		});
	}

	function isMobile(){
		var UserAgent = navigator.userAgent;
		if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
		{
			return true;

		}else{
			return false;
		}
	}
</script>

</body>
</html>