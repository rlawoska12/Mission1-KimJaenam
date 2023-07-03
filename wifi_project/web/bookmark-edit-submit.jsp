<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 수정</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String order = request.getParameter("order");
        MariaDBClient mariaDBClient = new MariaDBClient();
        mariaDBClient.updateBookmark(Integer.parseInt(id), name, Integer.parseInt(order));
    %>
    <script>
        alert("수정되었습니다.");
        location.href = "bookmark.jsp";
    </script>
</body>
</html>
