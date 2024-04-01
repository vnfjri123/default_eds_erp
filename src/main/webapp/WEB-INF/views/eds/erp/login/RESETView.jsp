<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<%@ include file="/WEB-INF/views/comm/common-include-url.jspf"%><!-- 공통 Content-Security-Policy -->
<!DOCTYPE html>
<html>
<head>

	<title>Login</title>
	<meta content="width=device-width,initial-scale=1" name="viewport">
	<!--===============================================================================================-->
	<link rel="stylesheet" href="/login/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.blue-deep_purple.min.css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
	<link href="/login/fonts/fontello/css/fontello.css" rel="stylesheet" />
	<link rel="stylesheet" href="/login/css/bootstrap-offset-right.css">
	<link rel="stylesheet" href="/login/css/style.css">
	<!--===============================================================================================-->
	<style>

		.mdl-checkbox__label2 {
			color: #ffffff;
		}
	</style>
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
							<img class="img-responsive center-block" src="/AdminLTE_main/dist/img/edsLogo_big.png" alt="step1" style="margin-top: 50%; padding: 0 10px 0 10px">
						</div>
					</div>
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
				</div>
				<!--mlt-carousel-->
			</div>
			<!-- Slider -->
		</div>
		<!-- Login -->

		<div class="col-lg-6 col-lg-offset-right-1 col-md-6 col-md-offset-right-1 col-sm-12 col-xs-12 no-padding">
			<div  id="loginScreen" class="mlt-content">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#reset" data-toggle="tab" style="color: #FFF; border-color: #FFF;">Password Setting</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade in active" id="reset">
						<div class="col-lg-10 col-lg-offset-1 col-lg-offset-right-1 col-md-10 col-md-offset-1 col-md-offset-right-1 col-sm-12 col-xs-12 pull-right ">

							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
								<input class="mdl-textfield__input" type="text" name="empId" id="empId" readonly>
								<label class="mdl-textfield__label" for="empId" style="color: #FFF;">User Id</label>
							</div>

							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label form-group has-feedback">
								<input class="mdl-textfield__input" type="text" name="empNm" id="empNm" readonly>
								<label class="mdl-textfield__label" for="empNm" style="color: #FFF;">User Name</label>
							</div>

							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
								<input class="mdl-textfield__input" type="password" name="pwd" id="pwd">
								<label class="mdl-textfield__label" for="pwd" style="color: #FFF;">Set Password</label>
							</div>

							<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
								<input class="mdl-textfield__input" type="password" name="pwd2" id="pwd2">
								<label class="mdl-textfield__label" for="pwd2" style="color: #FFF;">Confirm Password</label>
							</div>

							<label class="mdl-js-ripple-effect">
								<span class="mdl-checkbox__label" id="span1">초기 비밀번호를 설정해주세요.</span>
								<span class="mdl-checkbox__label" id="span2">비밀번호 변경 후 <a href="# ">90일</a>이 경과 되었습니다. 비밀번호를 변경해주세요.</span>
							</label>

							<br>
							<label class="mdl-js-ripple-effect">
								<span class="mdl-checkbox__label2" id="span3"></span>
							</label>

							<br>
							<button class="btn lt-register-btn" formaction="# " id="btnSave">비밀번호 저장 <i class="icon-right pull-right "></i></button>
							<button class="btn lt-register-btn" formaction="# " id="btnNext">다음에 변경 <i class="icon-right pull-right "></i></button>
						</div>
					</div>
				</div>
			</div>
			<!--Login-->
		</div>
		<!--center-block-->
	</div>
	<!--container-->
</div>

<!--===============================================================================================-->
<script src="/login/js/jquery.min.js "></script>
<script src="/login/js/bootstrap.min.js "></script>
<script src="/login/libs/mdl/material.min.js "></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js "></script>
<!--===============================================================================================-->

<script>

	$(document).ready(function () {


		document.getElementById('empId').value = '<c:out value="${LoginInfo.empId}"/>';

		if(!document.getElementById('empId').value){
			window.location.href = "/LOGIN_VIEW";
		}

		var pwdUpdDt = '<c:out value="${LoginInfo.pwdUpdDt}"/>';
		var day = calDateRange(pwdUpdDt.substr(0,4)+"-"+pwdUpdDt.substr(4,2)+"-"+pwdUpdDt.substr(6,2), getToday("%Y-%m-%d"));

		if(!pwdUpdDt){// 처음 로그인
			$('#span1').show();
			$('#span2').hide();
			$('#btnNext').hide();
		}else{
			if(day < 90){
				$('#span1').hide();
				$('#span2').hide();
				$('#btnNext').hide();
			}else{
				$('#span1').hide();
				$('#span2').show();
				$('#btnNext').show();
			}
		}
		$('#pwd').focus();


		$('#btnSave').click(function(){
			if (navigator.onLine == false){
				$('#span3').text("네트워크에 연결되어 있지 않습니다.");
				return;
			}

			if(!$('#pwd').val()){
				$('#span3').text("비밀번호를 입력해 주세요.");
				$('#pwd').focus();
				return;
			}
			if(!$('#pwd2').val()){
				$('#span3').text("비밀번호를 입력해 주세요.");
				$('#pwd2').focus();
				return;
			}
			if($('#pwd').val() != $('#pwd2').val()){
				$('#span3').text("비밀번호가 서로 다릅니다.");
				$('#pwd2').focus();
				return;
			}

			var pw = $("#pwd").val();
			var num = pw.search(/[0-9]/g);
			var eng = pw.search(/[a-z]/ig);
			var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			/* 기본 */
			/*if(pw.length < 10 || pw.length > 20){
				$('#span3').text("10자리 ~ 20자리 이내로 입력해 주세요..");
				return;
			}else if(pw.search(/\s/) != -1){
				$('#span3').text("비밀번호는 공백 없이 입력해 주세요..");
				return;
			}else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
				$('#span3').text("영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해 주세요..");
				return;
			}*/

			if(pw.length < 1 || pw.length > 20){
				$('#span3').text("1자리 ~ 20자리 이내로 입력해 주세요..");
				return;
			}else if(pw.search(/\s/) != -1){
				$('#span3').text("비밀번호는 공백 없이 입력해 주세요..");
				return;
			}

			var param = {
				empId  : $('#empId').val(),
				pwd  : $('#pwd').val()
			};

			$.ajax({
				url: "/LOGIN/updatePASSWORD",
				type: "POST",
				data: param,
				async: false,
				success: function(result){
					if(result.code == "success"){
						window.location.href = "/eds/erp/global/selectCONTENTView";
					}
				}
			});
		});

		$('#btnNext').click(function(){
			var param = {
				empId  : $('#empId').val()
			};

			$.ajax({
				url: "/LOGIN/updatePASSWORDNext",
				type: "POST",
				data: param,
				async: false,
				success: function(result){
					if(result.code == "success"){
						window.location.href = "/eds/erp/global/selectCONTENTView";
					}
				}
			});
		});
	});

	function getToday(param) {
		var today;
		var params = {
			param  : param
		};
		$.ajax({
			url: "/eds/erp/com/getToday",
			type: "POST",
			async: false,
			data: params,
			success: function(result){
				today = result;
			}
		});
		return today;
	}

	function calDateRange(val1, val2)
	{
		var FORMAT = "-";

		// FORMAT을 포함한 길이 체크
		if (val1.length != 10 || val2.length != 10)
			return null;

		// FORMAT이 있는지 체크
		if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
			return null;

		// 년도, 월, 일로 분리
		var start_dt = val1.split(FORMAT);
		var end_dt = val2.split(FORMAT);

		// 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
		// Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
		start_dt[1] = (Number(start_dt[1]) - 1) + "";
		end_dt[1] = (Number(end_dt[1]) - 1) + "";

		var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
		var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

		return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
	}
</script>

</body>
</html>