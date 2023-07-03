<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 이름 추가</title>
</head>
<style type="text/css">
    table {
        border: white 1px solid; border-collapse: collapse;
        font-size: 10pt;
        width: 100%;
    }

    th { border: white 1px solid; padding: 10px 5px;}

    th { background-color: #14a461; color: white; }

    td { border: lightgrey 1px solid; text-align: left; }

    .wrap-add { text-align: center; }

    td input { text-align: center; }

    .gnb { margin-bottom: 10px; }

    .gnb li { display: inline-block; }
</style>
<body>
<h1>북마크 그룹 이름 추가</h1>
<div class="gnb">
    <li><a href="index.jsp">홈</a></li>
    <li>|</li>
    <li><a href="history.jsp">위치 히스토리 목록</a></li>
    <li>|</li>
    <li><a href="fetch.jsp">Open API 와이파이 정보 가져오기</a></li>
    <li>|</li>
    <li><a href="wifi-bookmark.jsp">북마크 보기</a></li>
    <li>|</li>
    <li><a href="bookmark.jsp">북마크 그룹 관리</a></li>
</div>
<form name="form" method="post" action="bookmark-add-submit.jsp">
    <table>
        <tr>
            <th scope="row">북마크 이름</th>
            <td><label><input id="nameForm" name="name" type="text"></label></td>
        </tr>
        <tr>
            <th scope="row">순서</th>
            <td><label><input id="orderForm" name="order" type="text"></label></td>
        </tr>
        <td class="wrap-add" colspan="2"><input type="button" value="추가" onclick="addBookmark()"></td>
    </table>
</form>
<script>
    function addBookmark() {
        const nameEl = document.getElementById("nameForm");
        const orderEl = document.getElementById("orderForm");
        if (!nameEl.value) {
            alert("북마크 이름을 입력해주세요.");
            return;
        }
        if (!orderEl.value) {
            alert("순서를 입력해주세요.");
            return;
        }
        document.form.submit();
    }
</script>
</body>
</html>