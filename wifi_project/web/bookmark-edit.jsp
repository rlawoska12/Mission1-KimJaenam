<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page import="main.wifi.entity.BookmarkEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 수정</title>
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
<%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    MariaDBClient mariaDBClient = new MariaDBClient();
    BookmarkEntity bookmark = mariaDBClient.getBookmarkDetail(Integer.parseInt(id));
%>

<h1>북마크 그룹 수정</h1>
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
<form name="form" method="post" action="bookmark-edit-submit.jsp">
    <input style="display: none;" name="id" value="<%= bookmark.getId() %>">
    <table>
        <tr>
            <th scope="row">북마크 이름</th>
            <td><label><input id="nameForm" name="name" type="text" value="<%= bookmark.getName() %>"></label></td>
        </tr>
        <tr>
            <th scope="row">순서</th>
            <td><label><input id="orderForm" name="order" type="text" value="<%= bookmark.getOrder() %>"></label></td>
        </tr>
        <td class="wrap-add" colspan="2">
            <input type="button" value="돌아가기" onclick="history.back()">
            <input type="button" value="수정" onclick="updateBookmark()">
        </td>
    </table>
</form>
<script>
    function updateBookmark() {
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