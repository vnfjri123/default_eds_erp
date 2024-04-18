var targetList = new Set();
var imsUtil = {
    /*
    <script src="/js/util/eds.ims.js"></script>
    */

    /*
    "/" 누를시 searchID에 포커싱, parent.document => iframe 영역
    body 태그에 className "body" 할당 후 사용
    */
    "focusSearch" : function (searchID) {
        document.getElementById(searchID).focus();
        $(parent.document).on('keydown', (e) => {
            if (e.which === 191) {
                e.preventDefault();
                document.getElementById(searchID).focus();
            }
        });

        $(document).on('keydown', (e) => {
            const targetTag = e.target.tagName;
            const targetClass = e.currentTarget.body.className;
            const keyCode = e.which || e.keyCode;

            if (keyCode === 191 && targetClass === 'body' && targetTag !== 'INPUT') {
                e.preventDefault();
                document.getElementById(searchID).focus();
            }
        });
    },
    // yyyy-mm-dd hh:mm:ss 포맷
    "getDate" : function () {
        const date = new Date();
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');

        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    },
    // Comment 생성자 함수
    "Comment" : function (options) {
            // 기본 옵션 설정
            var defaultOptions = {
                el: null, // 컨테이너가 될 객체
                height: '30px', // 높이
                maxHeight: '198px', // 최대 높이
                labelText: '코멘트',
                placeholder : '입력',
                corpCd: '', // 사용자의 기업 코드
                empCd: '' // 사용자의 직원 코드
            };

            // 사용자가 전달한 옵션과 기본 옵션을 병합
            var mergedOptions = Object.assign({}, defaultOptions, options);

            // 부모 요소 생성
            this.containerDiv = document.createElement('div');

            // 카드 요소 생성
            this.cardDiv = document.createElement('div');
            this.cardDiv.classList.add('card', 'card-lightblue', 'card-outline');
            this.cardDiv.style.border = 'none';
            this.containerDiv.appendChild(this.cardDiv);

            // 컨테이너가 될 객체 설정
            this.el = mergedOptions.el;
            if (this.el) {
                this.el.appendChild(this.containerDiv);
            }

            // 라벨 요소 생성
            var label = document.createElement('label');
            label.innerHTML = '<b>' + mergedOptions.labelText + '</b>'; // <b> 태그 추가
            this.cardDiv.appendChild(label);

            // 카드 푸터 생성 (코멘트 박스)
            this.footerDiv = document.createElement('div');
            this.footerDiv.classList.add('card-footer', 'card-comments', 'p-0');
            this.footerDiv.id = 'messageBox';
            this.footerDiv.style.position = 'relative';
            this.footerDiv.style.maxHeight = mergedOptions.maxHeight; // 최대 높이 설정
            this.footerDiv.style.overflow = 'auto';
            this.cardDiv.appendChild(this.footerDiv);

            // 카드 푸터 생성 (입력 창)
            var inputFooterDiv = document.createElement('div');
            inputFooterDiv.classList.add('card-footer');
            this.cardDiv.appendChild(inputFooterDiv);

            // 이미지 요소 생성
            var img = document.createElement('img');
            img.style.borderRadius = '50%';
            img.style.height = '1.875rem';
            img.style.width = '1.875rem';
            img.style.float = 'left';
            img.style.maxWidth = '100%';
            img.style.verticalAlign = 'middle';
            img.style.borderStyle = 'none';
            img.classList.add('img-fluid', 'img-circle', 'img-sm');
            img.setAttribute('src', '/BASE_USER_MGT_LIST/selectUserFaceImageEdms/' + mergedOptions.corpCd + ':' + mergedOptions.empCd);
            img.setAttribute('alt', 'Alt Text');
            img.id = 'messageFace';
            inputFooterDiv.appendChild(img);

            // 입력 창 생성
            var inputContainerDiv = document.createElement('div');
            inputContainerDiv.classList.add('img-push');
            inputContainerDiv.style.width = 'calc(100% - 2.5*1.875rem)';
            inputContainerDiv.style.float = 'left';
            inputFooterDiv.appendChild(inputContainerDiv);

            var textarea = document.createElement('textarea');
            textarea.id = 'submitInput';
            textarea.setAttribute('type', 'text');
            textarea.classList.add('form-control', 'form-control-sm');
            textarea.placeholder = mergedOptions.placeholder;
            textarea.setAttribute('onkeyup', "if(window.event.keyCode==13 && window.event.shiftKey===false){imsUtil.initMessage(this)}");
            textarea.style.height = mergedOptions.height; // 높이 설정
            inputContainerDiv.appendChild(textarea);


            this.reset = function() {
            textarea.value = ''; // 입력창 내용 초기화
            };

            // 최종 결과 반환
            // return this.containerDiv;
        },
    "initMessage": async function (message) {
        let param={};
        param.status="C"
        param.content=message.value;
        param.submitCd=document.getElementById('index').value;
        param.inpId =document.getElementById('inpId').value;
        param.depaCd = document.getElementById('commentDepaCd').value;
        param.submitNm=document.getElementById('titleUpdate').value;

        let newSet;

        if (targetList.has(param.inpId)) {
            targetList.delete(param.inpId);
            newSet = new Set(targetList); // 남은 값으로 새로운 Set 생성
            param.target = newSet;
        } else {
            newSet = new Set(targetList);
            param.target = newSet;
        }

        var userParam = {};
        userParam.corpCd = document.getElementById('commentCorpCd').value;
        userParam.useYn = '01';

        var userInfo = await edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", userParam);
        console.log('확인')
        console.log(userInfo)
        var userEmail = [];
        for (let i = 0; i < userInfo.length; i++) {
            if (userInfo[i].emailKakaowork !== '' && userInfo[i].emailKakaowork !== null && userInfo[i].emailKakaowork !== undefined && userInfo[i].accDivi !== '01') {
                if (newSet.has(userInfo[i].empCd)) {
                    userEmail.push(userInfo[i].emailKakaowork);
                }
            }
        }
        param.userEmail = userEmail;
        param.postNum = document.getElementById('index').value;
        param.title = document.getElementById('titleUpdate').value;
        param.writer = document.getElementById('commentEmpNm').value + '[' + document.getElementById('commentDepaNm').value + ']';
        param.content = document.getElementById('submitInput').value.replace(/\n/g, "");
        param.date = imsUtil.getDate();

        let check=await imsUtil.messageSubmit(param);
        await this.selectMessageData();
        message.value='';
    },
    "updateMessage": async function (message, seq) {
        let param={};
        param.status="U"
        param.content=message.value;
        param.submitCd=document.getElementById('index').value
        param.seq = seq;

        let check=await imsUtil.messageSubmit(param);
        await this.selectMessageData();
        message.value='';
    },
    "messageSubmit": async function (param) {
        let paramList=[param];
        await $.ajax({
            url: "/comment/cudComment",
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            type: "POST",
            async: false,
            data: JSON.stringify({data:paramList}),
            success: function(result){
                // console.log(result.ajax);
                targetList.clear();
                if (!result.sess && typeof result.sess != "undefined") {
                    alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
                    return;
                }
                if (result.IO.Result == 0 || result.IO.Result == 1) {
                    Swal.fire({
                        icon: 'success',
                        title: '성공',
                        text: "성공적으로 저장되었습니다. ",
                    });
                    return true;
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
    },
    "selectMessageData": async function ()
    {
        targetList.clear();
        targetList.add(document.getElementById('userId').value)

        let param = {};
        param.submitCd = document.getElementById('index').value;
        param.corpCd = document.getElementById('commentCorpCd').value;
        param.depaCd = document.getElementById('commentDepaCd').value;

        let messageData = edsUtil.getAjax("/comment/selectComment", param); // 데이터 set
        let messagebox=document.getElementById('messageBox');
        let tempMessage=''

        for(const data of messageData)
        {
            targetList.add(data.inpId);
            let roots = data.corpCd+":"+data.inpId;
            let date = data.updDttm ? data.updDttm + '(수정됨)' : data.inpDttm;
            let el=`
			<div class="card-comment">
				<img class="img-circle img-sm" src="`+"/BASE_USER_MGT_LIST/selectUserFaceImageEdms/" + roots+`" alt="User Image">
				<div class="comment-text">
			  		<span class="username">
					`+data.empNm + '[' + data.depaNm + ']' +`
					<span class="text-muted float-right">`+date+`		
					<button name="updateBtn" type="button" class="btn btn-tool" data-card-widget="update" seq="`+data.seq+`" corpCd="`+data.corpCd+`" inpId="`+data.inpId+`" onclick="imsUtil.prepareUpdate(this)" > 수정
					</button>
				  		<button name="deleteBtn" type="button" class="btn btn-tool" data-card-widget="remove" seq="`+data.seq+`" corpCd="`+data.corpCd+`" inpId="`+data.inpId+`" onclick="imsUtil.removeMessage(this)" >
							<i class="fas fa-times"></i>
				  		</button>
					</span>
			  		</span>
					  <div name="content" style="white-space:pre-wrap;">`+data.content+`</div>
				</div>
		  	</div>`
            tempMessage+=el;
        }
            messagebox.innerHTML=tempMessage;
        var buttons = document.querySelectorAll('button[name="updateBtn"], button[name="deleteBtn"]');

        // 각 버튼에 대해 반복합니다.
        buttons.forEach(function(button) {
            // 버튼의 inpId 속성 값을 가져옵니다.
            var inpId = button.getAttribute('inpId');

            // 버튼의 inpId 값과 document.getElementById('inpId').value 값을 비교합니다.
            if (inpId !== document.getElementById('inpId').value) {
                // 만약 값이 다르다면 d-none 클래스를 추가합니다.
                button.classList.add('d-none');
            }
        });
    },
    "prepareUpdate": async function(btn) {
        // 버튼을 클릭한 요소(button)를 기준으로 가장 가까운 card-comment 요소를 찾습니다.
        var cardComment = btn.closest('.card-comment');
        var seq = btn.getAttribute('seq');

        // 해당 card-comment 요소 내에서 comment-text 요소를 찾습니다.
        var commentText = cardComment.querySelector('.comment-text');

        // comment-text 요소 내의 content div를 찾습니다.
        var contentDiv = commentText.querySelector('div[name="content"]');

        // content div에 현재 텍스트가 저장되어 있는지 확인합니다.
        var originalContent = contentDiv.textContent.trim();

        // content div에 textarea 요소가 이미 존재하는지 확인합니다.
        var isTextarea = commentText.querySelector('textarea') !== null;

        if (!isTextarea) { // textarea가 없는 경우 (div를 표시하고 textarea를 생성합니다.)
            // 새로운 textarea 요소를 생성합니다.

            var textarea = document.createElement('textarea');
            textarea.className = 'form-control';
            textarea.style.whiteSpace = 'pre-wrap';
            textarea.name = 'content';
            textarea.value = originalContent;
            textarea.setAttribute('onkeyup', `if(window.event.keyCode==13 && window.event.shiftKey===false){imsUtil.updateMessage(this,${seq})}`);
            // content div를 숨기고, textarea를 추가합니다.
            contentDiv.style.display = 'none';
            commentText.appendChild(textarea);
            textarea.focus();

            // 수정 버튼 텍스트를 '취소'로 변경합니다.
            btn.textContent = '취소';

            // 이전에 수정한 내용을 저장하는 변수에 현재 내용을 저장합니다.
            btn.previousContent = originalContent;
        } else { // textarea가 있는 경우 (textarea의 값을 가져와서 div에 설정합니다.)
            if (btn.textContent === '취소') { // 취소 버튼을 클릭한 경우
                // 이전에 수정한 내용을 가져와서 content div에 설정합니다.
                contentDiv.textContent = btn.previousContent;

                // content div를 표시하고, textarea를 제거합니다.
                contentDiv.style.display = 'block';
                commentText.querySelector('textarea').remove();

                // 수정 버튼 텍스트를 '수정'으로 변경합니다.
                btn.textContent = '수정';
            } else { // 수정 버튼을 클릭한 경우
                // textarea 요소를 찾습니다.
                var textarea = commentText.querySelector('textarea');

                // textarea의 값을 가져옵니다.
                var newText = textarea.value.trim();

                // content div에 textarea의 값을 설정합니다.
                contentDiv.textContent = newText;

                // content div를 표시하고, textarea를 제거합니다.
                contentDiv.style.display = 'block';
                textarea.remove();

                // 수정 버튼 텍스트를 '수정'으로 변경합니다.
                btn.textContent = '수정';

                // 이전에 수정한 내용을 저장하는 변수를 제거합니다.
                delete btn.previousContent;
            }
        }
    }
,
    "removeMessage": async function (btn)
    {
        Swal.fire({
            title: '코멘트 삭제',
            text: '정말 삭제하시겠습니까?',
            type: "warning",
            showCancelButton: true,
            confirmButtonClass: "btn-danger",
            confirmButtonText: "예",
            cancelButtonText: "아니오",
            reverseButtons: true,
            closeOnConfirm: false,
            closeOnCancel: true
        }).then(async (result) => {

            if (result.value) {
                let param = {};
                param.status = "D";
                param.corpCd = btn.getAttribute('corpCd');
                param.submitCd = document.getElementById('index').value;
                param.seq = btn.getAttribute('seq');
                param.inpId = btn.getAttribute('inpId');
                let check = await imsUtil.messageSubmit(param);
                await this.selectMessageData(); // 이 부분에서 this는 전역 객체를 참조할 것입니다.
            }
        });


    },

}