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
    }
}