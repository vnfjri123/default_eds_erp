<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Navbar -->
<nav class="main-header navbar navbar-expand-sm navbar-white navbar-light"style="background-color: #262626;border-bottom: unset;">
  <!-- Left navbar links -->
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a class="nav-link" data-widget="pushmenu" href="#" role="button" style="color: #86837c;background-color:#262626!important;"><i class="fas fa-bars"></i></a>
    </li>
    <!-- <li class="nav-item d-none d-sm-inline-block">
      <a href="/eds/erp/global/selectMAINCONTENTView" class="nav-link" style="color: #86837c;background-color:#262626!important;" id="home">Home</a>
    </li> -->
  </ul>
  <button class="navbar-toggler" style="color: #86837c;background: #fafafa;" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="#tebs" aria-expanded="false" aria-label="Toggle navigation">
    <span class="fas fa-bars"></span>
  </button>
  <!-- Right navbar links -->
  <div class="navbar-collapse collapse" id="tebs" style="">
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Attendance check -->
      <li class="nav-item">
        <a class="nav-link" href="/ERROR_LOG_MGT_VIEW" role="button" style="color: #86837c;background-color:#262626!important;">
          <i class="fas fa-shield-heart nav-icon">A/S신청</i>
        </a>
      </li>
  
      <!-- Navbar Attendance check -->
      <li class="nav-item">
        <a class="nav-link" href="/COMMUTE_LOG_CALENDAR_VIEW" role="button" style="color: #86837c;background-color:#262626!important;">
          <i class="fas fa-calendar"> 출·퇴</i>
        </a>
      </li>
      
  
      <!-- Navbar Search -->
      <li class="nav-item">
        <div class="nav-link" role="button" style="color: #86837c;background-color:#262626!important;" onclick="popup()">
          <i class="fa-regular fa-circle-question"> 매뉴얼</i>
        </div>
        <div class="navbar-search-block">
          <form class="form-inline">
            <div class="input-group input-group-sm">
              <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                  <i class="fas fa-search"></i>
                </button>
                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </li>
  
      <!-- Messages Dropdown Menu -->
      <li class="nav-item dropdown" id="alarmDrop">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button" style="color: #86837c;background-color:#262626!important;">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge" id='alarmCount'>0</span>
        </a>
        <!-- <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" id="alarmDiv">
          
        </div> -->
  
      </li>
        <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" style="color: #86837c;background-color:#262626!important;">
          <i class="fas fa-th-large"></i>
          <!-- <span class="badge badge-warning navbar-badge">15</span> -->
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <span class="dropdown-item dropdown-header">
            <img src="/AdminLTE_main/dist/img/edsLogo_small.png" class="img-circle" alt="User Image">
            <p>
              ${LoginInfo.busiNm} - ${LoginInfo.empNm}
            </p>
          </span>
          <div class="dropdown-divider"></div>
          <a href="#" onClick="logReset()" class="dropdown-item">
            <i class="fas fa-share  mr-2 "></i> 비밀번호재설정
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" onClick="logout()" class="dropdown-item">
            <i class="fas fa-share  mr-2 "></i> 로그아웃
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">close</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button" style="color: #86837c;background-color:#262626!important;">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
    </ul>

  </div>

</nav>
<!-- /.navbar -->

<script type="text/javascript">
    function reset() {
        location.href='/eds/erp/global/selectCONTENTView';
    }
    function logout() {
        location.href='/LOGIN/LOGOUT';
    }
    function logReset() {
        location.href='/LOGIN/RESET';
    }
    function popup(){
            var url = "/MANUAL_VIEW";
            var name = "popup test";
            var option = "width = 1000, height = 1000, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
</script>
