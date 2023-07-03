<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page import="main.wifi.entity.BookmarkEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 관리</title>
</head>
<style type="text/css">
    table {
        border: lightgrey 1px solid; border-collapse: collapse;
        font-size: 10pt;
        width: 100%;
    }

    th { border: white 1px solid; padding: 10px 5px; }

    th { background-color: #14a461; color: white; }

    td { border: lightgrey 1px solid; text-align: center; }

    .gnb { margin-bottom: 10px; }

    .form { margin-bottom: 10px; }

    .gnb li { display: inline-block; }

    .form li { display: inline-block; }

    .delete { text-align: center; }
</style>
<body>
<%
    MariaDBClient mariaDBClient = new MariaDBClient();
    List<BookmarkEntity> bookmarkList = mariaDBClient.getBookmarkList();
%>

<h1>북마크 그룹 관리</h1>
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
<div class="form">
    <li><input type="button" value="북마크 그룹 이름 추가" onclick="onAddBookmark()"></li>
</div>
<table>
    <tr height="50">
        <th width="100">ID</th>
        <th width="600">북마크 이름</th>
        <th width="200">순서</th>
        <th width="300">등록일자</th>
        <th width="300">수정일자</th>
        <th width="130">비고</th>
    </tr>
    <td id="nodata" height="70" colspan="6"><font size="4">정보가 존재하지 않습니다.</font></td>
    <tbody id="datalist">
        <% for (BookmarkEntity entity : bookmarkList) { %>
            <tr height="30">
                <td><%= entity.getId() %></td>
                <td><%= entity.getName() %></td>
                <td><%= entity.getOrder() %></td>
                <td><%= entity.getRegDate() %></td>
                <td><%= entity.getEditDate() == null ? "" : entity.getEditDate() %></td>
                <td class="delete">
                    <input type="button" value="수정" onclick="onEditBookmark(<%= entity.getId() %>)">
                    <input type="button" value="삭제" onclick="onDeleteBookmark(<%= entity.getId() %>)">
                </td>
            </tr>
        <% } %>
    </tbody>
</table>
<script>
    const nodataEl = document.getElementById("nodata");
    nodataEl.style.display = <%= bookmarkList.isEmpty() %> ? "auto" : "none";
    const datalistEl = document.getElementById("datalist");
    datalistEl.style.display = <%= bookmarkList.isEmpty() %> ? "none" : "auto";

    function onAddBookmark() {
        location.href = "bookmark-add.jsp";
    }

    function onEditBookmark(id) {
        location.href = "bookmark-edit.jsp" + "?id=" + id;
    }

    function onDeleteBookmark(id) {
        if (!confirm("정말 삭제하시겠습니까?")) {
            return;
        }
        location.href = "bookmark-delete.jsp" + "?id=" + id;
    }
</script>
</body>
</html>