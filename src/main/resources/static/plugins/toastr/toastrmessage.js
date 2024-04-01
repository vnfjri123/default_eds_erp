function toastrmessage(position, color, content, title, time) {
/*	
position : 위치	
			toast-top-right 
			toast-bottom-right			 
			toast-bottom-left
			toast-top-left
			toast-top-full-width
			toast-bottom-full-width
			toast-top-center
			toast-bottom-center
color : 색상
			success
			info
			warning
			error
content : 내용
title  : 제목
time : 알림시간(ms)
*/	
	toastr.options = {
	  "closeButton": true,
	  "debug": false,
	  "newestOnTop": true,
	  "progressBar": true,
	  "positionClass": position,
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": time,
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	};
	toastr[color](content, title);
}