<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<style>
		.btn-primary
		{
			color: #fff;
			background-color: #544e4c;
    		border-color: #544e4c;
			box-shadow: none;
		}
		.btn-primary :hover
		{
			color: #fff;
			background-color: #4f5962;
			border-color: #525D6B;
		}
	</style>

	<script>
		let select;
		var edmsSubmitGridList;
		let tempData;
		$(document).ready(function () {
			select =$('.select2').select2();
			init();
			// setTimeout(async function(){
			// 	await InitIframe($('#docDivi').val());
			// }, 100);
		});
		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "edms");

            /* 조회옵션 셋팅 */
            document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
            // document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
			// document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';


			/* 이벤트 셋팅 */
			//edsUtil.addChangeEvent("edmsSubmitGridListForm", fn_CopyForm2edmsSubmitGridList);
			await edsIframe.setParams();
			document.getElementById('submitDt').value= edsUtil.getToday("%Y-%m-%d");

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		//ifram 로딩완료 후 데이터 전달 이벤트 생성
		$("#iframSubmit").ready(function() {
				//수신 이벤트 발생
				window.addEventListener("message", function(message) {
					if(message.data=='complete')
					{
						const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						//data.messageDivi='select';//
						data.depaCd='<c:out value="${LoginInfo.depaCd}"/>';
						data.empCd='<c:out value="${LoginInfo.empCd}"/>';
						data.messageDivi='insert';//
						data.tempData=tempData;
						document.getElementById("iframSubmit").contentWindow.postMessage(data);
					}
				})
				document.getElementById("btnTempSave").addEventListener("click", async function(message) {
					const busiCd=document.getElementById("busiCd").value;
					if(busiCd=='undefined'||!busiCd||busiCd==null)
					{
						return Swal.fire({icon: 'error',title: '실패',text: '사업장을 선택하세요.'});
					}
					let docData=document.getElementById("docDivi").value;
					if(docData=='undefined'||!docData||docData==null||docData=='')
					{
						return Swal.fire({icon: 'error',title: '실패',text: '문서를 선택하세요.'});
					}
					const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					const approverDatas=document.getElementsByName('approver'); //결재유저 
					let approverArray=[];
					for(const user of approverDatas)
					{	
						approverArray.push(user.value);
					}
					const ccDatas=document.getElementsByName('ccUser'); //참조유저
					let ccArray=[];
					for(const user of ccDatas)
					{	
						ccArray.push(user.value);
					}
					data.submitApprover=approverArray;
					data.submitCcUser=ccArray;
					data.messageDivi='tempSave';
					data.submitDivi='02'//임시저장
					data.submitCd=null;
					document.getElementById("iframSubmit").contentWindow.postMessage(data);
				})
				document.getElementById("btnSave").addEventListener("click",  async function(message) {
					const busiCd=document.getElementById("busiCd").value;//사업장체크
					if(busiCd=='undefined'||!busiCd||busiCd==null)
					{
						return Swal.fire({icon: 'error',title: '실패',text: '사업장을 선택하세요.'});
					}
					let docData=document.getElementById("docDivi").value;
					if(docData=='undefined'||!docData||docData==null||docData=='')
					{
						return Swal.fire({icon: 'error',title: '실패',text: '문서를 선택하세요.'});
					}
					const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					//결재자
					const approverDatas=document.getElementsByName('approver');  
					if(approverDatas.length<=0) return Swal.fire({icon: 'error',title: '실패',text: '결재자를 선택하세요.'});
					let approverArray=[];
					for(const user of approverDatas)
					{	
						approverArray.push(user.value);
					}
					//참조자
					const ccDatas=document.getElementsByName('ccUser'); 
					let ccArray=[];
					for(const user of ccDatas)
					{	
						ccArray.push(user.value);
					}

					data.submitApprover=approverArray;
					data.submitCcUser=ccArray;
					data.messageDivi='save';
					data.submitDivi='01'//상신
					data.submitCd=null;
					document.getElementById("iframSubmit").contentWindow.postMessage(data);
				})
				$('#docDivi').on('change', function (e) {
					tempData=null;
					const firm=$('#docDivi').val();
					const busiCd=document.getElementById("busiCd").value;
					if(firm!=''&&(busiCd=='undefined'||!busiCd||busiCd==null))
					{
						$('#docDivi').val('').trigger('change');
						return Swal.fire({icon: 'error',title: '실패',text: '사업장을 선택하세요.'});
					}
					setTimeout(async function(){
						if($('#docDivi').val()=='02')
						{
							Swal.fire({
							title: "프로젝트등록에 적용할 견적서를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else if($('#docDivi').val()=='05')
						{
							Swal.fire({
							title: "준공 프로젝트를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply2','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else if($('#docDivi').val()=='11')
						{
							Swal.fire({
							title: "변경할 프로젝트를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply3','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else
						{
							await InitIframe($('#docDivi').val());
						}
					}, 100);
				});
				$('#busiCd').on('change', function (e) {
					tempData=null;
					const firm=$('#docDivi').val();
					const busiCd=document.getElementById("busiCd").value;
					if(firm!=''&&(busiCd=='undefined'||!busiCd||busiCd==null))
					{
						$('#docDivi').val('').trigger('change');
						return Swal.fire({icon: 'error',title: '실패',text: '사업장을 선택하세요.'});
					}
					setTimeout(async function(){
						if($('#docDivi').val()=='02')
						{
							Swal.fire({
							title: "프로젝트등록에 적용할 견적서를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else if($('#docDivi').val()=='05')
						{
							Swal.fire({
							title: "준공 프로젝트를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply2','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else if($('#docDivi').val()=='11')
						{
							Swal.fire({
							title: "변경할 프로젝트를 선택하세요.",
							showCancelButton: true,
							confirmButtonColor: "#3085d6",
							cancelButtonColor: "#d33",
							cancelButtonText: "취소",
							confirmButtonText: "확인"
							}).then((result) => {
							if (result.isConfirmed) {	
								popupHandler('apply3','open');
							}
							else
							{
								$('#docDivi').val('').trigger('change');
							}
							});
							
						}
						else
						{
							await InitIframe($('#docDivi').val());
						}
					}, 100);
				});
			})
		

		/**********************************************************************
		 * 화면 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 START
		 ***********************************************************************/
			/** table 팝업창
			 * */
			async function popupHandler(name,divi,callback){
					var names = name.split('_');
					switch (names[0]) {
						case 'busi':
							if(divi==='open'){
								var param={}
								param.corpCd= document.getElementById('corpCd').value;
								param.name= name;
								await edsIframe.openPopup('BUSIPOPUP',param)
							}else{
								if(callback.busiCd==undefined) return;
								document.getElementById('busiCd').value=callback.busiCd;
								document.getElementById('busiNm').value=callback.busiNm;
								const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
								data.messageDivi='insert';
								document.getElementById("iframSubmit").contentWindow.postMessage(data);			
							}
						break;
						case 'approver':{
							if(divi==='open'){
								var param={}
									param.corpCd= document.getElementById('corpCd').value;
									param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
									param.name= name;
								await edsIframe.openPopup('SUBMITUSERPOPUP',param)
							}else{
								addUser(callback,'approver');
							}
						}
						break;		
						case 'ccUser':{
							if(divi==='open'){
								var param={}
									param.corpCd= document.getElementById('corpCd').value;
									param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
									param.name= name;
								await edsIframe.openPopup('SUBMITUSERPOPUP',param)
							}else{
								addUser(callback,'ccUser');
							}
						}
						break;		
						case 'apply':
						if(divi==='open'){
							var param={}
							param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
							param.busiCd= document.getElementById("busiCd").value
							param.busiNm= document.getElementById("busiNm").value
							param.name= name;
							await edsIframe.openPopup('ESTPOPUP',param);
						}else{
							if(callback.rows === undefined) 
							{
								$('#docDivi').val('').trigger('change')
								Swal.fire("프로젝트 등록이 취소되었습니다.");
								return ;
							}
							else
							{
								document.getElementById("submitCd").value=callback.rows[0].submitCd;
								document.getElementById("keyCd").value=callback.rows[0].estCd;
								await InitIframe('02');
							}
						}
						break;	
						case 'apply2':	
						if(divi==='open'){
							var param={}
							param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
							param.busiCd= document.getElementById("busiCd").value
							param.busiNm= document.getElementById("busiNm").value
							param.name= name;
							await edsIframe.openPopup('PROJEDMSPOPUP',param);
						}else{
							if(callback.rows === undefined) 
							{
								$('#docDivi').val('').trigger('change')
								Swal.fire("프로젝트선택이 취소되었습니다.");
								return ;
							}
							else
							{
								//document.getElementById("submitCd").value=callback.rows[0].submitCd;
								document.getElementById("keyCd").value=callback.rows[0].projCd;
								tempData=callback.rows[0];
								tempData.stDt=callback.rows[0].dueDt;
								tempData.keyCd=callback.rows[0].projCd;
								tempData.empCd=callback.rows[0].manCd;
								await InitIframe('05');
							}
						}
						break;	
						case 'apply3':	
						if(divi==='open'){
							var param={}
							param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
							param.busiCd= document.getElementById("busiCd").value
							param.busiNm= document.getElementById("busiNm").value
							param.name= name;
							await edsIframe.openPopup('PROJEDMSPOPUP',param);
						}else{
							if(callback.rows === undefined) 
							{
								$('#docDivi').val('').trigger('change')
								Swal.fire("프로젝트선택이 취소되었습니다.");
								return ;
							}
							else
							{
								//document.getElementById("submitCd").value=callback.rows[0].submitCd;
								document.getElementById("keyCd").value=callback.rows[0].projCd;
								tempData=callback.rows[0];
								tempData.stDt=callback.rows[0].dueDt;
								tempData.keyCd=callback.rows[0].projCd;
								tempData.empCd=callback.rows[0].manCd;
								await InitIframe('11');
							}
						}
						break;	
					}
					
				}
	

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/
		 async function InitIframe(docDivi)
		 {
			if(docDivi=='01')url="/EDMS_EST_REPORT_INS_VIEW"
			//if(docDivi=='01')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='02')url="/EDMS_PROJECT_REPORT_INS_VIEW"
			else if(docDivi=='03')url="/EDMS_EXPENSE_REPORT_INS_VIEW"
			else if(docDivi=='04')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='05')url="/EDMS_PROJECT_COM_REPORT_INS_VIEW"
			else if(docDivi=='06')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='07')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='08')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='09')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='10')url="/EDMS_EDIT_REPORT_INS_VIEW"
			else if(docDivi=='11')url="/EDMS_PROJECT_UPDATE_REPORT_INS_VIEW"
			else {return ;}
			document.searchForm.action =url;
			document.searchForm.submit();
		 }
		 async function addUser(param,target)
        {
            let userData=param;
            let targetEl=document.getElementById(target);
            if(!(userData.length==0))targetEl.innerHTML='';
            for(const data of userData)
            {    
                if(document.getElementById(target+data.empCd)) continue;
                /* 직원 얼굴 세팅 */
                var corpCd = data.corpCd;//회사코드
                var saveNm = data.saveNm;//저장명
                var ext = data.ext;//확장자
                var params = corpCd+":"+saveNm+":"+ext;
                var url="/BASE_USER_MGT_LIST/selectUserFaceImage/" + params;
                let userEl=
                `<div class='card' id='`+target+data.empCd+`'>
                    <div class='card-body'>
                        <div class='post' style='overflow: auto; padding-bottom:0px;'>
                            <input type='hidden' name='`+target+`' value='`+data.empCd+`'>
                            <div class='user-block' style='margin:0'>
                              <img class='img-circle img-bordered-sm' src=`+url+` alt='user image'>
                              <span class='username'>
                                <a href='#'>`+data.empNm+`</a>`+
                                `<a style='color: #6c757d;font-size: 13px;margin-top: -3px;margin-left:3px'>`+data.posiDiviNm+`</a>`+
                                `<a href='#' onclick=deleteUser('`+target+data.empCd+`'); class='float-right btn-tool'><i class='fas fa-times'></i></a>`+
                             `</span>
                              <span class='description'>`+data.respDiviNm+`</span>
                            </div>
                        </div>
                    </div>
                </div>`;
                targetEl.innerHTML+=userEl;
            }
        }
        function deleteUser(id)
        {
            let node=document.getElementById(id);
            console.log(node);
            node.remove();
        }    
        async function btnEvent(name){
        switch (name) {
            case 'cancel':
            {
                let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));
                await edsEdms.deleteSubmitList([param]);
                param.name = document.getElementById('name').value;

                await edsIframe.closePopup(param);
            }
            break;
            case 'save':
            {
                let data={};
                data.submitApprover=$("#appUsers").val();
                data.submitCcUser=$("#ccUsers").val();
                data.busiCd=document.getElementById("busiCd").value;
                data.docDivi=document.getElementById("docDivi").value;
                data.submitDt=document.getElementById("submitDt").value;
                data.submitCd=document.getElementById("submitCd").value;
                data.submitDivi='01'//저장
                const parentData=data;
                var result=await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
            }
            break;        
            case 'tempSave':
            {
                let data={};
                data.submitApprover=$("#appUsers").val();
                data.submitCcUser=$("#ccUsers").val();
                data.busiCd=document.getElementById("busiCd").value;
                data.docDivi=document.getElementById("docDivi").value;
                data.submitDt=document.getElementById("submitDt").value;
                data.submitCd=document.getElementById("submitCd").value;
                data.submitDivi='02'//임시저장
                const parentData=data;
                var result= await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
                
            }
            break;        
            case 'close':    
            {
                let param = {};
                param.name = document.getElementById('name').value;

                await edsIframe.closePopup(param);
            }
            break;            
        }
    }

	

		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>
<div class="row" style="margin: 0; height: 100vh;" >
	<div class="col-sm-12 pt-1">
		<div class="card bg-defalt">
			<div class="card-body">
			<!-- form start -->
				<form class="form-inline" name="searchForm" id="searchForm" method="POST" target="iframSubmit">
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
				<input type="hidden" name="keyCd" id="keyCd" title="키코드">
				<div class="form-row" >
					<div class="form-group" style="margin-left: 30px;">
						<div class="input-group-prepend">
							<label >사업장 &nbsp;</label>
							<div class="input-group-prepend" style="min-width: 15rem;">
								<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd" >
								</select>
							</div>
						</div>
						<div class="input-group-append" hidden>
							<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
						</div>
					</div>
					<div class="form-group"style="margin-left: 30px;">
						<label>기안양식 &nbsp;</label>
						<div class="input-group-prepend" style="min-width: 12rem;">
							<select class="form-control select2" style="width: 100%;" name="docDivi" id="docDivi" >
							</select>
						</div>
					</div>
					<div class="form-group" style="margin-left: 30px;">
						<label for="submitDt">작성일자 &nbsp;</label>
						<div class="input-group-prepend">
							<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="submitDt" id="submitDt" title="입력일자" disabled>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-sm-10"style="height: calc(100% - 5.2rem - 76px);">
		<!-- form start -->
		<div style="height: 100%;">
			<iframe class="card card-primary" scrolling="auto" id="iframSubmit" class="embed-responsive-item" name="iframSubmit" style="min-height:300px; width: 100%; border: 0; height: inherit "  allowfullscreen>
			
			</iframe>
		</div>
	</div>
	<div class="col-sm-2" style="height: calc(100% - 5.2rem - 76px);">
		<div style="height: 50%;padding: 7.5px;">
			<div class="card card-lightblue card-outline" style="height: 100%;margin: 0;overflow-y: auto;">
				<div class="card-header" style="">
					<label class="card-title" style="">결재라인</label>
				  <!-- <ul class="nav nav-pills">
					<li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">결재자</a></li>
				  </ul> -->
				</div><!-- /.card-header -->
				<div class="card-body">
				  <div class="tab-content">
						<div class="active tab-pane" id="approver">
						
						</div>
				  </div>
				  <!-- /.tab-content -->
				</div><!-- /.card-body -->
			</div>	
		</div>
		<div style="height: 50%;padding: 7.5px;">
			<div class="card card-lightblue card-outline" style="height: 100%;margin: 0;overflow-y: auto;">
				<div class="card-header" style="">
					<label class="card-title" style="">참조라인</label>
				  <!-- <ul class="nav nav-pills">
					<li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">결재자</a></li>
				  </ul> -->
				</div><!-- /.card-header -->
				<div class="card-body">
				  <div class="tab-content">
						<div class="active tab-pane" id="ccUser">
							
						</div>
				  </div>
				  <!-- /.tab-content -->
				</div><!-- /.card-body -->
			</div>	
		</div>
	</div>
	<div class="col-sm-12" >
		<div class="card bg-defalt" style="margin: 0;">
			<div class="card-body">
				<form class="form-inline" role="form" name="edmsEstGridItemButtonForm" id="edmsEstGridItemButtonForm" method="post" onsubmit="return false;">
					<div class="m-auto">
						<div class="container">
							<button type="button" class="btn btn-primary mr-1 mt-1" name="btnAppSave" id="btnAppSave" onclick="popupHandler('approver','open'); return false;"><i class="fa fa-user-plus"></i> 결재지정</button>
							<button type="button" class="btn btn-primary mr-1 mt-1" name="btnReferSave" id="btnReferSave" onclick="popupHandler('ccUser','open');return false;"><i class="fa fa-user-plus"></i> 참조지정</button>	
							<button type="button" class="btn btn-primary mr-1 mt-1" name="btnTempSave" id="btnTempSave" ><i class="fa fa-plus"></i> 임시저장</button>
							<button type="button" class="btn btn-primary mr-1 mt-1" name="btnSave" id="btnSave" ><i class="fa fa-edit"></i> 결재상신</button>		
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>