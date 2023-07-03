<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 추가</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String order = request.getParameter("order");
        MariaDBClient mariaDBClient = new MariaDBClient();
        mariaDBClient.insertBookmark(name, Integer.parseInt(order));
    %>
    <script>
        alert("추가되었습니다.");
        location.href = "bookmark.jsp";
    </script>
</body>
</html>
