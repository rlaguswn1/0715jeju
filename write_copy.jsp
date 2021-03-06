<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="css/write.css">
    <title>write</title>
</head>
<body>
    <div class="logo">등록</div>
    <form>
    <div class="post">
        <div class="title">
             <input type="text" id='title' placeholder="제목을 입력">
             <input type="text" id='writer' placeholder="작성자를 입력">
        </div>
        <br />
        <div class="contents">
            <input type="text" id='contents' placeholder="내용을 입력"/>
        </div>
    </div>
    </form>
    <br />
    <div class="buttons">
        <input type="button" id="return" value="취소" />
        <input type="reset" id='reset' value="초기화" />
        <input type="submit" id="submit" value="등록" />
    </div>

<script>
    // 등록 누르면 >> 완료 알럿, 닫으면 리스트로 이동
    const submit = document.getElementById('submit');
    submit.onclick=function(){
        // 사용자가 입력한 제목, 작성자, 내용 저장
        const title=document.getElementById('title').value.toString();
        const contents=document.getElementById('contents').value.toString();
        const writer=document.getElementById('writer').value.toString();
        
        // 날짜 클래스 객체
        const date= new Date();

        //연도 갖고오기
        const year=date.getFullYear().toString();

        // 월, 일 갖고와서 일단 앞에 0을 붙이고, 뒤에서부터 2자리 슬라이스
        const month=('0'+(date.getMonth()+1)).slice(-2).toString();
        const day=('0'+(date.getDate())).slice(-2).toString();

        // 전체 날짜
        const fullDate=year+'. '+month+'. '+day+'.';

        // id 계산
        axios.get("http://localhost:3200/posts/")
        .then((res) => {
            const num = res.data.length;
            return num;
        })
        // 계산한 id 포함해서 글 올리기
        .then((num)=> {
            axios.post("http://localhost:3200/posts/", {
            id:num,
            writer:writer,
            title:title,
            contents:contents,
            date:fullDate
            });
        });

        alert("등록이 완료되었습니다.");
        location.href='list_div.html';
    }

    back=document.getElementById('return');
    back.onclick=function(){
        location.href='list_div.html';
    }

    // 초기화 버튼 >> 문서에서 input 태그를 다 받아와서 배열에 담고, i번째 요소의 타입이 텍스트면 값을 공백으로 넣어라
    reset.onclick=function(){
        const con=confirm("초기화 하시겠습니까?");
        if (con===true){
            var inputs = document.getElementsByTagName('input');
            for (var i=0;i<inputs.length;i++){
                if (inputs[i].type==='text') {
                    inputs[i].value="";
                }
            }
        } 

    }    
</script>
</body>
</html>