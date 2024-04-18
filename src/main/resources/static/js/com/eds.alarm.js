var edsAlarm;

edsAlarm =
{
	"selectAlarm": async function(target,params){
		var alarmDiv=document.getElementById(target);
		var alarmCount=document.getElementById('alarmCount');
		var newCount=document.getElementById('newCount');
		var data=params;
		alarmDiv.innerHTML='';
		var test = await edsUtil.getAjax("/ALARM_REG/selectAlarmList", data);
		for(var i=0; i<test.length; i++){
			var corpCd = test[i].corpCd;//회사코드
			var empCd = test[i].empCd;//확장자
			var src = "/BASE_USER_MGT_LIST/selectUserFaceImageEdms/" +corpCd+":"+empCd;
			var initDiv = document.createElement('div');
			if(test[i].readDivi=='01')
			{
				initDiv.className = 'dropdown-item alarmCard readState';
			}
			else
			{
				initDiv.className = 'dropdown-item alarmCard';
			}
			
			//initDiv.setAttribute('id', test[i].target+"__"+test[i].seq);
			// Create the inner media div
			var mediaDiv = document.createElement('div');

			mediaDiv.className = 'notify';
			mediaDiv.setAttribute('submitCd', test[i].submitCd);
			mediaDiv.setAttribute('submitNm', test[i].submitNm);
			mediaDiv.setAttribute('stateDivi', test[i].stateDivi);
			mediaDiv.setAttribute('readDivi', test[i].readDivi);
			edsAlarm.alarmClcikEvent2(mediaDiv,test[i]);
			
			// Create the m-auto div
			// var mAutoDiv = document.createElement('div');
			// mAutoDiv.className = 'm-auto';
			
			// Create the image element
			var img = document.createElement('img');
			img.src = src;
			img.alt = 'User Avatar';
			img.className = 'img-circle';
			img.style.cssText = 'height: 1.75rem; width: 1.75rem; border: 1.5px solid #c6c6c6;';
			img.onerror = function () {
				this.src = '/login/img/usersolid.jpg';
			};
		
			// // Append the image to m-auto div
			// mAutoDiv.appendChild(img);
		
			// Append m-auto div to media div
			//mediaDiv.appendChild(mAutoDiv);
		
			// Create media-body div
			var mediaBodyDiv = document.createElement('div');
			mediaBodyDiv.className = 'media-body';

			var spanName = document.createElement('span');
			spanName.innerText=test[i].empNm;
			// Create dropdown-item-title h3
			var h3 = document.createElement('h3');
			h3.className = 'dropdown-item-title';
			h3.appendChild(img);
			h3.appendChild(spanName);

			// 상태 요소 생성
			var textContent='';
			var className='';
			if(test[i].submitDivi=='01')
			{textContent='결재중';className='right badge badge-warning';}
			else if(test[i].submitDivi=='03')
			{textContent='완료';className='right badge badge-success';}
			else if(test[i].submitDivi=='04')
			{textContent='반려';className='right badge badge-danger'}
			else 
			{
				console.log(test[i].stateDivi);
				if(test[i].stateDivi=='05')
				{textContent = '활동내역';className = 'right badge badge-info';}
				else if(test[i].stateDivi=='07')
				{textContent = '코멘트내역';className = 'right badge badge-danger';}
				else if(test[i].stateDivi=='08')
				{textContent = '발주요청';className = 'right badge badge-warning';}
				else if(test[i].stateDivi=='09')
				{textContent = '발주승인';className = 'right badge badge-success';}
				else if(test[i].stateDivi=='10')
				{textContent = '발주반려';className = 'right badge badge-danger';}
				else if(test[i].stateDivi=='11')
				{textContent = '견적요청';className = 'right badge badge-warning';}
				else if(test[i].stateDivi=='12')
				{textContent = '견적승인';className = 'right badge badge-success';}
				else if(test[i].stateDivi=='13')
				{textContent = '견적반려';className = 'right badge badge-danger';}
				else {textContent = '문서';className = 'right badge badge-danger';}
			}
			var spanElement = document.createElement('span');
			spanElement.className = className;
			spanElement.style.marginLeft = '5px';
			spanElement.textContent = textContent;
			h3.appendChild(spanElement)

			var stateTextContent='';
			var stateClassName='';
			if(test[i].stateDivi=='01')
			{stateTextContent='메시지';stateClassName='right badge badge-info';}
			else if(test[i].stateDivi=='03')
			{stateTextContent='결재요청';stateClassName='right badge badge-info';}
			else if(test[i].stateDivi=='04')
			{stateTextContent='참조';stateClassName='right badge badge-warning';}
			else if(test[i].stateDivi=='06')
			{stateTextContent='결재반려';stateClassName='right badge badge-danger';}
			var stateElement = document.createElement('span');
			stateElement.className = stateClassName;
			stateElement.style.marginLeft = '5px';
			stateElement.textContent = stateTextContent;
			h3.appendChild(stateElement)

			// Create a checkbox input
			var checkboxInput = document.createElement('input');
			checkboxInput.type = 'checkbox';
			checkboxInput.className = 'mr-1';
			checkboxInput.name='checks';
			checkboxInput.value=test[i].seq;
			checkboxInput.style.transform = 'scale(1.5)';

			// Create a label for the checkbox
			var checkboxLabel = document.createElement('label');
			checkboxLabel.appendChild(checkboxInput);
		
			// Create a float-right div and append the checkbox to it
			var floatRightDiv = document.createElement('a');
			floatRightDiv.className = 'float-right';
			floatRightDiv.appendChild(checkboxLabel);
			// Create a about div and append the checkbox to it
			var about = document.createElement('div');
			about.className = 'text-sm';
			about.innerText = test[i].navMessage;
			about.style.whiteSpace = 'pre-wrap';
			about.style.overflowWrap = 'anywhere';
			// Append h3, float-right div, and other elements to media-body div
			mediaBodyDiv.appendChild(h3);
			mediaBodyDiv.appendChild(about);
			mediaBodyDiv.appendChild(document.createElement('div')).className = 'text-sm text-muted';
			mediaBodyDiv.lastChild.innerHTML = '<i class="far fa-clock mr-1"></i>' + test[i].inpDttm;
			
		
			// Append media-body div to media div
			mediaDiv.appendChild(mediaBodyDiv);
			//mediaDiv.appendChild(floatRightDiv);
		
			// Append the media div to the initDiv
			initDiv.appendChild(floatRightDiv)
			initDiv.appendChild(mediaDiv);
			
			// // Create a dropdown-divider div
			// var dividerDiv = document.createElement('div');
			// dividerDiv.className = 'dropdown-divider';
		
			// // Append the divider div to the initDiv
			// initDiv.appendChild(dividerDiv);
		
			// Now, you can append the 'initDiv' to your target element in the DOM
			// For example, if you have a target element with an ID 'targetElement'
			// document.getElementById('targetElement').appendChild(initDiv);
			// alarmList+=initDiv;
			alarmDiv.appendChild(initDiv)
		}
		//alarmDiv.innerHTML=alarmList;
		if(target=='alarmDiv'){alarmCount.innerHTML=test.length;}
		else if(target=='modalAlarm'){newCount.innerHTML=test.length;}
		//edsAlarm.alarmClcikEvent();
	},
	"updateAlarmList" :async function(param)
	{

		await $.ajax({
			url: "/ALARM_REG/updateAlarmList",
			headers: {
				'X-Requested-With': 'XMLHttpRequest'
			},
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			type: "POST",
			async: false,
			data: JSON.stringify({data:[param]}),
			success: function(result){
				if (!result.sess && typeof result.sess != "undefined") {
					alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
					return;
				}
			}});
	},
	"alarmClcikEvent" : function()
	{
		const btn = document.querySelectorAll('.notify')
		btn.forEach((target) => 
		{
			if(!target.classList.contains('event'))
			{
				target.classList.add('event');
				target.addEventListener("click", async function(e){ 
					let params={};
					params.submitCd=target.getAttribute('submitCd');
					if(params.submitCd == null || params.submitCd =='' ||params.submitCd =='undefined') return ;
					params.submitNm=target.getAttribute('submitNm');
					params.stateDivi=target.getAttribute('stateDivi');
					let reqData = await edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitTempList", params); // 데이터 set
					if(reqData.length>0)
					{
						if(reqData[0].submitDivi=='02')return Swal.fire({icon: 'warning',html: "결재 취소된 문서입니다. <br/> 결재요청자에게 학인해주세요."});//결재취소문서
						if(params.stateDivi==='03')//결재요청
						{
							if(reqData[0].currApproverCd=='<c:out value="${LoginInfo.empCd}"/>' && reqData[0].submitDivi=='01')
							{
								submitDivi='01'
							}
							else if(reqData[0].currApproverCd!='<c:out value="${LoginInfo.empCd}"/>' && reqData[0].submitDivi=='01')
							{
								return Swal.fire({icon: 'warning',html: "승인 가능한 단계가 아닙니다."});
							}
							else
							{
								
								return Swal.fire({icon: 'warning',html: "이미 완료된 문서입니다. <br/>결재내역함에서 학인해주세요."});
							}
						}
						else if(params.stateDivi==='06')//반려
						{
							submitDivi='04'
						}
						else//참조
						{
							submitDivi='05'
						}
						edsAlarm.addEDMSclikcEventtarget(submitDivi,reqData[0].docDivi,reqData[0].submitCd);
						let readDivi=target.getAttribute('readDivi');
						if(readDivi=='00' || readDivi=='null')//처음 읽는 문서는 읽음으로 업데이트
						{
							var checkboxes = target.parentNode.querySelector('input[name="checks"]');
							target.parentNode.classList.add('readState');
							var objCheck={};
							objCheck.seq=checkboxes.value;
							objCheck.readDivi='01';
							edsAlarm.updateAlarmList(objCheck);
						}

					}
					else
					{
						Swal.fire({icon: 'warning',html: "일치하는 문서가 없습니다.<br/>결재요청자에게 문서를 확인해주세요"});
						let readDivi=target.getAttribute('readDivi');
						console.log(readDivi)
						if(readDivi=='00' || readDivi=='null')//처음 읽는 문서는 읽음으로 업데이트
						{
							var checkboxes = target.parentNode.querySelector('input[name="checks"]');
							target.parentNode.classList.add('readState');
							var objCheck={};
							objCheck.seq=checkboxes.value;
							objCheck.readDivi='01';
							edsAlarm.updateAlarmList(objCheck);
						}
					}
				})
			}
			else
			{

			}
		}
		);
	},
	"alarmClcikEvent2" : function(target,param)
	{
		if(!target.classList.contains('event'))
		{
			target.classList.add('event');
			target.addEventListener("click", async function(e){ 
				let readDivi=target.getAttribute('readDivi');
				let alarmParams=param;
				if(alarmParams.submitCd == null || alarmParams.submitCd =='' ||alarmParams.submitCd =='undefined') return ;
				let reqData = await edsUtil.getAjax("/ALARM_REG/selectAlarmSubmit", alarmParams); // 데이터 set
				//let reqData = param; // 데이터 set
				if(reqData.length>0)
				// if(!reqData.submitDivi==null || reqData.submitDivi )
				{
					if(reqData[0].submitDivi=='02')
					{
						if(readDivi=='00' || readDivi === 'null')//처음 읽는 문서는 읽음으로 업데이트
						{
							var checkboxes = target.parentNode.querySelector('input[name="checks"]');
							target.parentNode.classList.add('readState');
							var objCheck={};
							objCheck.seq=checkboxes.value;
							objCheck.readDivi='01';
							edsAlarm.updateAlarmList(objCheck);
						}
						return Swal.fire({icon: 'warning',html: "결재 취소된 문서입니다. <br/> 결재요청자에게 학인해주세요."});//결재취소문서
					};
					
					if(alarmParams.stateDivi==='03')//결재요청
					{

						if(reqData[0].currApproverCd==alarmParams.target && reqData[0].submitDivi=='01')
						{
							submitDivi='01'
						}
						else if(reqData[0].currApproverCd!=alarmParams.target && reqData[0].submitDivi=='01')
						{
							return Swal.fire({icon: 'warning',html: "승인 가능한 단계가 아닙니다."});
						}
						else
						{
							if(readDivi=='00' || readDivi === 'null')//처음 읽는 문서는 읽음으로 업데이트
							{
								var checkboxes = target.parentNode.querySelector('input[name="checks"]');
								target.parentNode.classList.add('readState');
								var objCheck={};
								objCheck.seq=checkboxes.value;
								objCheck.readDivi='01';
								edsAlarm.updateAlarmList(objCheck);
							}
							return Swal.fire({icon: 'warning',html: "이미 완료된 문서입니다. <br/>결재내역함에서 학인해주세요."});
						}
					}
					else if(alarmParams.stateDivi==='06')//반려
					{
						submitDivi='04'
					}
					else//참조
					{
						submitDivi='05'
					}
					edsAlarm.addEDMSclikcEventtarget(submitDivi,reqData[0].docDivi,reqData[0].submitCd);
					if(readDivi=='00' || readDivi === 'null')//처음 읽는 문서는 읽음으로 업데이트
					{
						var checkboxes = target.parentNode.querySelector('input[name="checks"]');
						target.parentNode.classList.add('readState');
						var objCheck={};
						objCheck.seq=checkboxes.value;
						objCheck.readDivi='01';
						edsAlarm.updateAlarmList(objCheck);
					}

				}
				else
				{
					if(target.getAttribute("statedivi") === '05') ; // 활동
					else if(target.getAttribute("statedivi") === '07') ; // 코멘트
					else if(target.getAttribute("statedivi") === '08') ; // 발주요청
					else if(target.getAttribute("statedivi") === '09') ; // 발주승인
					else if(target.getAttribute("statedivi") === '10') ; // 발주반려
					else if(target.getAttribute("statedivi") === '11') ; // 발주요청
					else if(target.getAttribute("statedivi") === '12') ; // 발주승인
					else if(target.getAttribute("statedivi") === '13') ; // 발주반려
					else Swal.fire({icon: 'warning',html: "일치하는 문서가 없습니다.<br/>결재요청자에게 문서를 확인해주세요"});
					if(readDivi=='00' || readDivi=='null')//처음 읽는 문서는 읽음으로 업데이트
					{
						var checkboxes = target.parentNode.querySelector('input[name="checks"]');
						target.parentNode.classList.add('readState');
						var objCheck={};
						objCheck.seq=checkboxes.value;
						objCheck.readDivi='01';
						edsAlarm.updateAlarmList(objCheck);
					}
				}
			})
		}
		else
		{

		}
	},
	"deleteAlarm":  async function(param)
	{
		Swal.fire({
		title: "알림을 삭제하시겠습니까?",
		type: "warning",
		showCancelButton: true,
		confirmButtonColor: "#dc3545",
		confirmButtonText: "예",
		cancelButtonText: "아니요",
		closeOnConfirm: false,
		closeOnCancel : true
		}).then(async (result) => {
	/* Read more about isConfirmed, isDenied below */
		if (result.isConfirmed) {
			await $.ajax({
			url: "/ALARM_REG/deleteAlarmList",
			headers: {
				'X-Requested-With': 'XMLHttpRequest'
			},
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			type: "POST",
			async: false,
			data: JSON.stringify({data:param}),
			success: function(result){
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
					return edsAlarm.selectAlarm('alarmDiv',{});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패',
						text: result.IO.Message,
					});
					return false;
				}
			}
		});
		} else if (result.isDenied) {
			Swal.fire("Changes are not saved", "", "info");
		}
		})

	},
	"checkDeleteAlarm": async function()
	{
			var checkboxes = document.querySelectorAll('input[name="checks"]:checked');
			var checkedValues = [];
			checkboxes.forEach(function(checkbox) {
				var objectcheck={};
				objectcheck.seq=checkbox.value;
				checkedValues.push(objectcheck);
			});
			if(checkedValues.length>0)
			{
			
				const check=await edsAlarm.deleteAlarm(checkedValues);
			}
			else
			{
				return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '선택된 결재가 없습니다.',
						});
			}
	},
	"allDeleteAlarm": async function()
	{
		var param=[]
		var temp={};
		temp.temp='eweqwe'
		param.push(temp);
		Swal.fire({
			titleColor:"#dc3545",
			title: "전체 알림을 삭제하시겠습니까?",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#dc3545",
			confirmButtonText: "전체삭제",
			cancelButtonText: "아니요",
			closeOnConfirm: false,
			closeOnCancel : true
		}).then(async (result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				await $.ajax({
					url: "/ALARM_REG/deleteAlarmList",
					headers: {
						'X-Requested-With': 'XMLHttpRequest'
					},
					dataType: "json",
					contentType: "application/json; charset=UTF-8",
					type: "POST",
					async: false,
					data: JSON.stringify({data:param}),
					success: function(result){
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
							return edsAlarm.selectAlarm('alarmDiv',{});
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패',
								text: result.IO.Message,
							});
							return false;
						}
					}
				});
			} else if (result.isDenied) {
				Swal.fire("Changes are not saved", "", "info");
			}
		})
	},
	"notialr": async function ()
	{
		let params = {};
		params.readDivi='00'
		await edsAlarm.selectAlarm('modalAlarm',params);
		var num=document.getElementById('newCount').innerHTML;
		if(num>0)
		{
			myModal.modal('show');
		}
	},
	"addEDMSclikcEventtarget" : async function(submitDivi,docDivi,submitCd)
	{
		let param = {};
		param.submitCd=submitCd;
		if(submitDivi=='04')
		{
			if(docDivi=='01')param.url="/EDMS_EST_REPORT_TEMP_VIEW"
			else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_TEMP_VIEW"
			else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_TEMP_VIEW"
			else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_TEMP_VIEW"
			else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_TEMP_VIEW"
			else if(docDivi=='11')param.url="/EDMS_PROJECT_UPDATE_REPORT_TEMP_VIEW"
			else {return ;}
			await popupHandler('edmsTemp','open',param);
		}
		else if(submitDivi=='01')
		{
			if(docDivi=='01')param.url="/EDMS_EST_REPORT_VIEW"
			else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_VIEW"
			else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_VIEW"
			else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_VIEW"
			else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_VIEW"
			else if(docDivi=='11')param.url="/EDMS_PROJECT_UPDATE_REPORT_VIEW"
			else {return ;}
			await popupHandler('edmsDoc','open',param)
		}
		else
		{
			if(docDivi=='01')param.url="/EDMS_EST_REPORT_CONF_VIEW"
			else if(docDivi=='02')param.url="/EDMS_PROJECT_REPORT_CONF_VIEW"
			else if(docDivi=='03')param.url="/EDMS_EXPENSE_REPORT_CONF_VIEW"
			else if(docDivi=='05')param.url="/EDMS_PROJECT_COM_REPORT_CONF_VIEW"
			else if(docDivi=='04')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='06')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='07')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='08')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='09')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='10')param.url="/EDMS_EDIT_REPORT_CONF_VIEW"
			else if(docDivi=='11')param.url="/EDMS_PROJECT_UPDATE_REPORT_CONF_VIEW"
			else {return ;}
			await popupHandler('edmsConf','open',param)
		}

	}

	
};