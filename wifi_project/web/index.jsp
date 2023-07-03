<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page import="main.wifi.entity.WifiEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>와이파이 정보 구하기</title>
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
  </style>
  <body>
    <%
      request.setCharacterEncoding("utf-8");
      String lat = request.getParameter("lat");
      String lnt = request.getParameter("lnt");
      List<WifiEntity> wifiList = new ArrayList<>();
      if (lat != null && !lat.isEmpty() && lnt != null && !lnt.isEmpty()) {
        MariaDBClient mariaDBClient = new MariaDBClient();
        List<WifiEntity> result = mariaDBClient.getWifiList(Double.parseDouble(lat), Double.parseDouble(lnt), 20);
        mariaDBClient.insertHistory(Double.parseDouble(lat),Double.parseDouble(lnt));
        wifiList.addAll(result);
      }
    %>

    <h1>와이파이 정보 구하기</h1>
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
      <li>LAT: <label><input id="latForm" type="number" value="<%= lat %>"></label></li>
      <li>LNT: <label><input id="lntForm" type="number" value="<%= lnt %>"></label></li>
      <li><input type="button" value="내 위치 가져오기" onclick="getCurrentLocation()"></li>
      <li><input type="button" value="근처 WIFI 정보 가져오기" onclick="getNearByWifiList()"></li>
    </div>
    <table>
      <tr height="50">
        <th width="50">거리(Km)</th>
        <th width="80">관리번호</th>
        <th>자치구</th>
        <th width="100">와이파이명</th>
        <th width="100">도로명주소</th>
        <th width="300">상세주소</th>
        <th width="50">설치위치(층)</th>
        <th width="100">설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th width="80">망종류</th>
        <th>설치년도</th>
        <th width="40">실내외구분</th>
        <th>WIFI접속환경</th>
        <th width="60">X좌표</th>
        <th width="60">Y좌표</th>
        <th width="100">작업일자</th>
      </tr>
      <td id="nodata" height="70" colspan="17"><font size="4">위치정보를 입력한 후에 조회해주세요.</font></td>
      <tbody id="datalist">
        <% for (WifiEntity entity : wifiList) { %>
          <tr>
            <td><%= entity.getDistance() %></td>
            <td><%= entity.getManageNo() %></td>
            <td><%= entity.getBorough() %></td>
            <td><a href="<%= "detail.jsp" + "?lat=" + lat + "&lnt=" + lnt + "&manageNo=" + entity.getManageNo() %>"><%= entity.getName() %></a></td>
            <td><%= entity.getAdres1() %></td>
            <td><%= entity.getAdres2() %></td>
            <td><%= entity.getFloor() %></td>
            <td><%= entity.getInstalType() %></td>
            <td><%= entity.getInstalAgency() %></td>
            <td><%= entity.getService() %></td>
            <td><%= entity.getNetType() %></td>
            <td><%= entity.getInstalYear() %></td>
            <td><%= entity.getInOutDoor() %></td>
            <td><%= entity.getConnectionEvir() %></td>
            <td><%= entity.getCoorX() %></td>
            <td><%= entity.getCoorY() %></td>
            <td><%= entity.getWorkDate() %></td>
          </tr>
        <% } %>
      </tbody>
    </table>
    <script>
      const nodataEl = document.getElementById("nodata");
      nodataEl.style.display = <%= wifiList.isEmpty() %> ? "auto" : "none";
      const datalistEl = document.getElementById("datalist");
      datalistEl.style.display = <%= wifiList.isEmpty() %> ? "none" : "auto";

      function getCurrentLocation() {
        navigator.geolocation.getCurrentPosition((position) => {
          const latEl = document.getElementById("latForm");
          const lntEl = document.getElementById("lntForm");
          latEl.value = position.coords.latitude;
          lntEl.value = position.coords.longitude;
        });
      }

      function getNearByWifiList() {
        const latEl = document.getElementById("latForm");
        const lntEl = document.getElementById("lntForm");
        if (!latEl.value) {
          alert("LAT값을 입력해주세요.");
          return;
        }
        if (!lntEl.value) {
          alert("LNT값을 입력해주세요.");
          return;
        }
        location.href = "index.jsp" + "?lat=" + latEl.value + "&lnt=" + lntEl.value;
      }
    </script>
  </body>
</html>