<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>매뉴얼</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/css/AdminLTE_main/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
  <style>
    .none_shadow
    {
      box-shadow: none;
    }

  </style>
</head>
<body class="hold-transition" style="background-color: #f4f6f9;">
  <div class="content">
    <!-- Content Header (Page header) -->
    <section class="content-header" >
      <div class="container-fluid">
        <div class="row mb-2">
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content" >
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">
            <h3>매뉴얼</h3>

            <div class="card none_shadow">
              <div class="card-header">
                <h3 class="card-title text-bold">그룹웨어</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0 border-0">
                <div class="nav flex-column nav-tabs h-100" id="vert-tabs-tab" role="tablist" aria-orientation="vertical">
                  <a class="nav-link active" id="vert-tabs-g1-tab" data-toggle="pill" href="#vert-tabs-g1" aria-controls ="vert-tabs-g1" role="tab" aria-selected="true" onclick="changeName(this);">[전자결재] 결재작성</a>
                  <a class="nav-link" id="vert-tabs-g2-tab" data-toggle="pill" href="#vert-tabs-g2" aria-controls ="vert-tabs-g2" role="tab"  aria-selected="false"  onclick="changeName(this);">[전자결재] 임시보관함</a>
                  <a class="nav-link" id="vert-tabs-g3-tab" data-toggle="pill" href="#vert-tabs-g3" aria-controls ="vert-tabs-g3" role="tab"  aria-selected="false" onclick="changeName(this);">[전자결재] 결재진행함</a>
                  <a class="nav-link" id="vert-tabs-g4-tab" data-toggle="pill" href="#vert-tabs-g4" aria-controls ="vert-tabs-g4" role="tab"  aria-selected="false" onclick="changeName(this);">[전자결재] 결재완료함</a>
                  <a class="nav-link" id="vert-tabs-g5-tab" data-toggle="pill" href="#vert-tabs-g5" aria-controls ="vert-tabs-g5" role="tab"  aria-selected="false" onclick="changeName(this);">[전자결재] 결재수신함</a>
                  <a class="nav-link" id="vert-tabs-g6-tab" data-toggle="pill" href="#vert-tabs-g6" aria-controls ="vert-tabs-g6" role="tab"  aria-selected="false" onclick="changeName(this);">[전자결재] 수신참조함</a>
                  <a class="nav-link" id="vert-tabs-g7-tab" data-toggle="pill" href="#vert-tabs-g7" aria-controls ="vert-tabs-g7" role="tab"  aria-selected="false" onclick="changeName(this);">[전자결재] 결재내역함</a>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">ERP</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-circle text-danger"></i> COMING SOON</a>
                  </li>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            <!-- /.card -->
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">IMS</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-circle text-danger"></i> COMING SOON</a>
                  </li>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title text-bold" id='headName'>[전자결재] 결재작성</h3>

            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="tab-content">
                <div class="tab-pane text-left fade show active" id="vert-tabs-g1" role="tabpanel" aria-labelledby="vert-tabs-g1-tab" >
                  <div class="callout callout-info">필요한 결재양식을 선택하고 작성 및 결재를 기안합니다.</div>
                  <p>&nbsp;</p>
                  <h3>1. 결재 작성 진입</h3>
                  <p><img class="w-100" src="/manualimg/gw1-1.png" alt="gw1-1.png"></p>
                  <p class="p1">1.1 서비스 상단에 [결재 작성하기] 버튼 혹은 자주쓰는 결재의 결재양식을 선택하여 결재 작성 화면으로 이동합니다.</p>
                  <p>&nbsp;</p>
                  <h3>2. 작성 양식 선택</h3>
                  <p><img class="w-100" src="/manualimg/gw1-2.png" alt="gw1-2.png"></p>
                  <p>2.1 [결재 작성하기] 버튼 선택 시 결재 작성 메뉴로 이동됩니다.</p>
                  <p>Ⅰ. 결재양식: 결재양식에 양식명을 확인하고 필요한 양식을 선택하여 결재를 작성합니다.</p>
                  <p>&nbsp;</p>
                  <h3>&nbsp;3. 결재 작성</h3>
                  <p><img class="w-100"  src="/manualimg/gw1-3.png" alt="gw1-3.png"></p>
                  <p><img class="w-100"  src="/manualimg/gw1-4.png" alt="gw1-4.png"></p>
                  <p>3.1 양식을 선택하면 결재 작성화면이 생성되며 각 결재문서의 필요한 결재정보를 입력하고 기안을 진행합니다.</p>
                  <p>Ⅰ. 필수값: 결재시 필수로 작성해야하는 항목.</p>
                  <p>ⅱ. 팝업창: 결재정보 입력시 기초정보에서 연동되어 불러오는 항목.&nbsp;</p>
                  <p>[마우스 클릭, 엔터키를 사용하여 팝업창을 생성, 필요한 정보를 선택할 수 있다.]</p>
                  <p>&nbsp;</p>
                  <h3>&nbsp;4. 결재자 지정</h3>
                  <p><img class="w-100"  src="/manualimg/gw1-5.png" alt="gw1-5.png"></p>
                  <p>4.1 결재지정,참조지정 버튼을 통해 [결재자 지정] 팝업을 생성 결재자,참조자를 지정할 수 있습니다.</p>
                  <p><img class="w-100"  src="/manualimg/gw1-6.png" alt="gw1-6.png"></p>
                  <p>4.2 결재자 지정 팝업에서 이름,사원번호를 통해 결재자를 검색 및 선택하고 추가/제외 버튼, 더블 클릭을 통해 결재자를 지정합니다.&nbsp;</p>
                  <p>&nbsp;</p>
                  <h3>5. 임시저장</h3>
                  <p><img class="w-100"  src="/manualimg/gw1-7.png" alt="gw1-7.png"></p>
                  <p><span>6.1 작성중인 입력정보는 하단 임시저장 기능을 통해 저장할 수 있습니다. 저장된 작성 정보는 임시저장함 메뉴를 통해 확인하고 상신할 수 있습니다.</span><span>&nbsp;</span></p>
                </div>
                <div class="tab-pane fade" id="vert-tabs-g2" role="tabpanel" aria-labelledby="vert-tabs-g2-tab">
                  <div class="callout callout-info"><span>임시보관함은 사용자가 결재 작성 시 임시 저장한 결재 작성정보를 확인하고 작성하여 상신할 수 있습니다.</span></div>
                  <p>&nbsp;</p>
                  <h3>1. 임시보관함 접근</h3>
                  <p><img class="w-100" src="/manualimg/gw2-1.png" alt="gw2-1.png"></p>
                  <p>1.1 좌측 메뉴영역에서 '임시보관함' 메뉴를 선택하여 실행합니다.</p>
                  <p>&nbsp;</p>
                  <h3>2. 임시보관함&nbsp;</h3>
                  <p><img class="w-100" src="/manualimg/gw2-2.png" alt="gw2-2.png"></p>
                  <p class="p1">2.1 임시 저장된 결재 정보는 리스트를 통해 양식명, 결재 제목, 작성일자, 작성자 정보, 결재 정보 등을 확인할 수 있으며 리스트를 선택하여 상세정보를 확인할 수 있습니다.</p>
                  <p>&nbsp;</p>
                  <h3>4. 결재정보 검색</h3>
                  <p><img class="w-100" src="/manualimg/gw2-3.png" alt="gw2-3.png"></p>
                  <p>4.1 상단 검색영역에서 결재 제목을 통해 원하는 결재정보를 검색할 수 있습니다.</p>
                  <p>&nbsp;</p>
                  <h3>5. 다중선택 기능</h3>
                  <p><img class="w-100" src="/manualimg/gw2-4.png" alt="gw2-4.png"></p>
                  <p>5.1 결재 리스트를 선택하면 상단 액션바를 통해 [문서삭제] 기능이 활성화 됩니다.</p>
                  <p>&nbsp;</p>
                  <h3>6. 임시저장 결재 상세정보</h3>
                  <p><img class="w-100" src="/manualimg/gw2-5.png" alt="gw2-5.png"></p>
                  <p class="p1">6.1 결재 리스트 선택 시 상세정보 화면으로 이동하며 선택한 결재에 대한 상세정보를 확인할 수 있습니다.</p>
                  <p class="p1">6.2 내용을 수정하거나 추가하여 기안을 상신 할 수 있으며 임시저장, 삭제 또한 가능합니다.&nbsp;</p>
                  <p class="p1">&nbsp;</p>
                  <p class="p1">&nbsp;</p>
                  <div class="tip"><strong> <img src="https://static.wehago.com/imgs/common/ico_tip.png" alt="tip"> 꼭 읽어주세요</strong>
                    <p>임시보관함에 있는 결재문서는 상신되지 않은 문서입니다.</p>
                  </div>
                </div>
                <div class="tab-pane fade" id="vert-tabs-g3" role="tabpanel" aria-labelledby="vert-tabs-g3-tab">
                  <div class="callout callout-info"><span>결재 진행함에서는 사용자가 상신한 문서 중 결재가 진행중인 문서정보를 확인할 수 있습니다.</span></div>
                  <p>&nbsp;</p>
                  <h3>1. 결재진행함 접근</h3>
                  <p><img class="w-100" src="/manualimg/gw3-1.png" alt="gw3-1.png"></p>
                  <p>1.1 우측 메뉴영역에서 '결재진행함' 메뉴를 선택하여 실행합니다.</p>
                  <p>&nbsp;</p>
                  <h3>2. 결재 진행함&nbsp;</h3>
                  <p><img class="w-100" src="/manualimg/gw3-2.png" alt="gw3-2.png"></p>
                  <p class="p1">2.1 결재 진행함은 사용자가 상신한 문서 중 현재 결재가 진행중인 상태의 결재정보를 확인할 수 있습니다.</p>
                  <p class="p1">2.2 상단에 상태 필터를 통해 진행중인 문서의 정보를 알수있습니다.
                  <p class="p1">* 결재 진행함 리스트: 진행중인 결재정보는 리스트를 통해 양식명, 결재 제목, 작성일자, 작성자 정보, 결재 상태정보 등을 확인할 수 있으며 리스트를 선택하여 상세정보를 확인할 수 있습니다.</p>
                  <p>&nbsp;</p>
                  <h3>3. 결재 상세정보 확인하기&nbsp;</h3>
                  <p><img class="w-100" src="/manualimg/gw3-3.png" alt="gw3-3.png"></p>
                  <p class="wysiwyg-indent1">&nbsp;</p>
                  <p class="p1">3.1 결재 정보 리스트에서 결재 상태정보 클릭시 결제상세정보창이 활성화됩니다.</p>
                  <h3>&nbsp;</h3>
                  <h3>4. 결재정보 검색</h3>
                  <p><img class="w-100" src="/manualimg/gw3-4.png" alt="gw3-4.png"></p>
                  <p>4.1 상단 검색영역에서 결재 제목을 통해 원하는 결재정보를 검색할 수 있습니다.</p>
                  <p>&nbsp;</p>
                  <h3>5. 다중선택 기능</h3>
                  <p>5.1 결재 리스트를 선택하면 하단 액션바를 통해 [결제취소] 기능이 활성화 됩니다.</p>
                  <p>&nbsp;</p>
                  <h3>6. 결재 상세정보</h3>
                  <p><img class="w-100" src="/manualimg/gw3-5.png" alt="gw3-5.png"></p>
                  <p class="p1">6.1 결재 리스트 선택 시 상세정보 화면으로 이동하며 선택한 결재에 대한 상세정보를 확인할 수 있습니다.</p>
                  <p class="p1">&nbsp;</p>
                  <p class="p1"><img class="w-100" src="/manualimg/gw3-6.png" alt="gw3-6.png"></p></p>
                  <p class="p1">6.2 결재 상세정보 하단에 첨부된 파일을 미리보기 하거나 다운로드 받을 수 있으며 결재의견을 등록할 수 있습니다.</p>
                  <p class="p1">&nbsp;</p>
                  <div class="tip"><strong> <img src="https://static.wehago.com/imgs/common/ico_tip.png" alt="tip"> 꼭 읽어주세요</strong>
                    <p>상세기능 중 결재취소 기능은 취소시 임시보관함에 저장되며 지금까지의 결재정보는 초기화됩니다.</p>
                  </div>                 
                </div>                   
                <div class="tab-pane fade" id="vert-tabs-g4" role="tabpanel" aria-labelledby="vert-tabs-g4-tab">
                  <div class="callout callout-info"><span>결재 완료함에서는 사용자가 상신한 문서 중 결재가 완료된 문서정보를 확인할 수 있습니다.</span></div>
                  <p>&nbsp;</p>
                  <h3>1. 결재완료함 접근</h3>
                  <p><img class="w-100" src="/manualimg/gw4-1.png" alt="gw4-1.png"></p>
                  <p>1.1 좌측 메뉴영역에서 '결재 완료함' 메뉴를 선택하여 실행합니다.</p>
                  <p>&nbsp;</p>
                  <h3>2. 결재 완료함&nbsp;</h3>
                  <p><img class="w-100" src="/manualimg/gw4-2.png" alt="gw4-2.png"></p>
                  <p class="p1">2.1 결재 완료함은 사용자가 상신한 문서 중 결재가 완료된 상태의 결재정보를 확인할 수 있습니다.</p>
                  <p class="p1">2.2 스상단에 상태 필터를 선택하여 반려, 승인 상태의 결재정보를 구분하여 확인할 수 있습니다.</p>
                  <p class="p1">* 결재 완료함 리스트: 완료된 결재정보는 리트를 통해 양식명, 결재 제목, 작성일자, 작성자 정보, 결재 결과정보 등을 확인할 수 있으며 리스트를 선택하여 상세정보를 확인할 수 있습니다.</p>
                  <p>&nbsp;</p>
                  <h3>3. 결재 상세정보 확인하기&nbsp;</h3>
                  <p><img class="w-100" src="/manualimg/gw4-3.png" alt="gw4-3.png"></p>
                  <p class="wysiwyg-indent1">&nbsp;</p>
                  <p class="p1">3.1 결재 정보 리스트확인을 통해 결재상태를 알 수 있습니다.</p>
                  <p class="p1">버튼에 따라 현재 진행중인 결재 상태에 대한 정보를 확인하실 수 있습니다.</p>
                  <p class="p1">* 파란아이콘: 현재 결재중인 결재자.</p>
                  <p class="p1">* 초록아이콘: 결재를 완료한 결재자.</p>
                  <p class="p1">* 회색아이콘: 다음 결재대기중인 결재자.</p>
                  <p class="p1">* 붉은아이콘: 결재를 반려한 결재자.</p>
                  <h3>&nbsp;</h3>
                  <h3>4. 결재정보 검색</h3>
                  <p><img class="w-100" src="/manualimg/gw4-4.png" alt="gw4-4.png"></p>
                  <p>4.1 상단 검색영역에서 결재 제목, 일자, 문서종류를 통해 원하는 결재정보를 검색할 수 있습니다.</p>
                  <p>&nbsp;</p>        
                  <h3>5. 결재 상세정보</h3>
                  <p><img class="w-100" src="/manualimg/gw4-5.png" alt="gw4-5.png"></p>
                  <p class="p1">5.1 결재 리스트 선택 시 상세정보 팝업으로 이동하며 선택한 결재에 대한 상세정보를 확인할 수 있습니다.</p>
                  <p class="p1">5.2 결재 상세정보 하단에 첨부된 파일을 미리보기 하거나 다운로드 받을 수 있으며 결재의견을 등록할 수 있습니다.</p>
                  <p class="p1">5.3 반려된 결재건에 대해서는 임시저장, 기안상신의 기능을 사용할 수 있습니다.</p>
                </div>
                <div class="tab-pane fade" id="vert-tabs-g5" role="tabpanel" aria-labelledby="vert-tabs-g5-tab">
                sorry
               </div>
               <div class="tab-pane fade" id="vert-tabs-g6" role="tabpanel" aria-labelledby="vert-tabs-g6-tab">
                sorry
              </div>
              <div class="tab-pane fade" id="vert-tabs-g7" role="tabpanel" aria-labelledby="vert-tabs-g7-tab">
                sorry
               </div>
              </div>
            </div>

          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
<!-- ./wrapper -->
<script>
  function changeName(event)
  {
    document.getElementById('headName').innerHTML=event.innerHTML;
    //console.log(event.getAttribute('aria-controls'));
  }
</script>
<!-- jQuery -->
<script src="/css/AdminLTE_main/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/css/AdminLTE_main/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/css/AdminLTE_main/dist/js/adminlte.min.js"></script>
</body>
</html>
