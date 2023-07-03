<%@ page import="main.wifi.openapi.OpenAPIClient" %>
<%@ page import="main.wifi.entity.WifiEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>와이파이 정보 구하기</title>
  </head>
  <style type="text/css">
    h1, div {
      text-align: center;
    }

  </style>
  <body>
    <%
      OpenAPIClient openAPIClient = new OpenAPIClient();
      List<WifiEntity> wifiList = openAPIClient.getAllWifiList();
      MariaDBClient mariaDBClient = new MariaDBClient();
      mariaDBClient.deleteAllWifiList();
      mariaDBClient.insertWifiList(wifiList);
    %>
    <h1>총 <%= wifiList.size() %>개의 와이파이 정보가 수집되었습니다.</h1>
    <div class="gnb">
      <a href="index.jsp">홈 으로 가기</a>
    </div>
  </body>
</html>
