<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 추가</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String wifiManageNo = request.getParameter("wifiManageNo");
        String bookmarkId = request.getParameter("bookmarkId");
        MariaDBClient mariaDBClient = new MariaDBClient();
        mariaDBClient.insertWifiBookmark(wifiManageNo, Integer.parseInt(bookmarkId));
    %>
    <script>
        alert("추가되었습니다.");
        location.href = "wifi-bookmark.jsp";
    </script>
</body>
</html>
