<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>위치 히스토리 삭제</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        MariaDBClient mariaDBClient = new MariaDBClient();
        mariaDBClient.deleteHistory(Integer.parseInt(id));
    %>
    <script>
        alert("삭제되었습니다.");
        location.href = "history.jsp";
    </script>
</body>
</html>
