<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="#" onClick='reset()' class="brand-link" style="background:#262626;padding: unset;padding-bottom: 6px;padding-top: 5px;padding-left: 15px;">
<%--      <img src="/AdminLTE_main/dist/img/logo.png" alt="AdminLTE Logo" class="brand-image" style="opacity: .8">--%>
    &nbsp;<b style="visibility: visible !important;color: #e21f27;font-size: 30px" id="edsE">E</b><span class="brand-text font-weight-normal">arth</span>
    <span class="brand-text font-weight-normal">&nbsp;<b style="visibility: visible !important;font-size: 30px">D</b>isaster</span>
    <span class="brand-text font-weight-normal">&nbsp;<b style="visibility: visible !important;font-size: 30px">S</b>afety</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
<%--   <div class="form-inline">--%>
      <div class="user-panel mt-3 pb-3 mb-3 d-flex" style="padding: unset !important;margin: unset !important;border-bottom: unset;">
        <div class="info-box" style="background-color: #724e36;color: #cac3b7;width: 100%;height: 100%;margin-bottom: unset !important;border-radius: unset !important;">
          <img id="userFace" style="margin: auto; border-radius: 50%; width: 50px; height: 50px" alt="User Image" >
          <div class="info-box-content">
            <span class="info-box-number" style="margin-top: 5px;text-align: center!important;">${LoginInfo.busiNm}</span>
            <span class="info-box-number" style="margin-top: 5px;text-align: center!important;">${LoginInfo.empNm} / ${LoginInfo.respDiviNm}</span>
          </div>
          <!-- /.info-box-content -->
        </div>
        <!-- /.info-box -->
        <script>
          var corpCd = "${LoginInfo.corpCd}";
          var saveNm = "${LoginInfo.saveNm}";
          var ext = "${LoginInfo.ext}";
          var param = corpCd+":"+saveNm+":"+ext;

          document.getElementById('userFace').setAttribute("src","/BASE_USER_MGT_LIST/selectUserFaceImage/" + param);
        </script>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" style="color:#4d4a41;border-radius: unset !important;"type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar" style="background-color: #997149;color:#4d4a41;border-radius: unset !important;">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2" style="margin: unset !important;">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false"id="menulist">
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>