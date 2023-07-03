<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 삭제</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        MariaDBClient mariaDBClient = new MariaDBClient();
        mariaDBClient.deleteBookmark(Integer.parseInt(id));
    %>
    <script>
        alert("삭제되었습니다.");
        location.href = "bookmark.jsp";
    </script>
</body>
</html>
