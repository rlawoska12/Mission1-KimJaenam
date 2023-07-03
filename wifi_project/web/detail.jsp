<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page import="main.wifi.entity.WifiEntity" %>
<%@ page import="main.wifi.entity.BookmarkEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>와이파이 상세 정보</title>
</head>
<style type="text/css">
  table {
    border: white 1px solid; border-collapse: collapse;
    font-size: 10pt;
    width: 100%;
  }
  
  tr {
    height: 40px;
  }

  th { border: white 1px solid; padding: 10px 5px;}

  th { background-color: #14a461; color: white; width: 350px; }

  td { border: lightgrey 1px solid; text-align: center; }

  .gnb {
    margin-bottom: 10px;
  }

  .form {
    margin-bottom: 10px;
  }

  .gnb li { display: inline-block; }

  .form li { display: inline-block; }
</style>
<body>
  <%
    request.setCharacterEncoding("utf-8");
    String manageNo = request.getParameter("manageNo");
    String lat = request.getParameter("lat");
    String lnt = request.getParameter("lnt");
    MariaDBClient mariaDBClient = new MariaDBClient();
    WifiEntity wifi = mariaDBClient.getWifiDetail(Double.parseDouble(lat),Double.parseDouble(lnt), manageNo);
    List<BookmarkEntity> bookmarkList = mariaDBClient.getBookmarkList();
  %>

  <h1>와이파이 상세 정보</h1>
  <div class="gnb">
    <li><a href="index.jsp">홈</a></li>
    <li>|</li>
    <li><a href="history.jsp">위치 히스토리 목록</a></li>
    <li>|</li>
    <li><a href="openAPI.jsp">OpenAPI 와이파이 정보 가져오기</a></li>
  </div>
  <div class="form">
    <li>
      <form name="bookmarkForm" method="post" action="wifi-bookmark-add-submit.jsp">
        <input style="display: none;" name="wifiManageNo" value="<%= wifi.getManageNo() %>">
        <select name="bookmarkId" id="bookmarkIdForm">
          <option value="">북마크 그룹 이름 선택</option>
          <%
            for (BookmarkEntity bookmark : bookmarkList) {
          %>
          <option value="<%= bookmark.getId() %>"><%= bookmark.getName() %></option>
          <%
            }
          %>
        </select>
      </form>
    </li>
    <li><input type="button" value="북마크 추가하기" onclick="insertWifiBookmark()"></li>
  </div>
  <table>
    <tr>
      <th scope="row">거리(Km)</th>
      <td><%= wifi.getDistance() %></td>
    </tr>
    <tr>
      <th scope="row">관리번호</th>
      <td><%= wifi.getManageNo() %></td>
    </tr>
    <tr>
      <th scope="row">자치구</th>
      <td><%= wifi.getBorough() %></td>
    </tr>
    <tr>
      <th scope="row">와이파이명</th>
      <td><%= wifi.getName() %></td>
    </tr>
    <tr>
      <th scope="row">도로명주소</th>
      <td><%= wifi.getAdres1() %></td>
    </tr>
    <tr>
      <th scope="row">상세주소</th>
      <td><%= wifi.getAdres2() %></td>
    </tr>
    <tr>
      <th scope="row">설치위치(층)</th>
      <td><%= wifi.getFloor() %></td>
    </tr>
    <tr>
      <th scope="row">설치유형</th>
      <td><%= wifi.getInstalType() %></td>
    </tr>
    <tr>
      <th scope="row">설치기관</th>
      <td><%= wifi.getInstalAgency() %></td>
    </tr>
    <tr>
      <th scope="row">서비스구분</th>
      <td><%= wifi.getService() %></td>
    </tr>
    <tr>
      <th scope="row">망종류</th>
      <td><%= wifi.getNetType() %></td>
    </tr>
    <tr>
      <th scope="row">설치년도</th>
      <td><%= wifi.getInstalYear() %></td>
    </tr>
    <tr>
      <th scope="row">실내외구분</th>
      <td><%= wifi.getInOutDoor() %></td>
    </tr>
    <tr>
      <th scope="row">WIFI접속환경</th>
      <td><%= wifi.getConnectionEvir() %></td>
    </tr>
    <tr>
      <th scope="row">X좌표</th>
      <td><%= wifi.getCoorX() %></td>
    </tr>
    <tr>
      <th scope="row">Y좌표</th>
      <td><%= wifi.getCoorY() %></td>
    </tr>
    <tr>
      <th scope="row">작업일자</th>
      <td><%= wifi.getWorkDate() %></td>
    </tr>
  </table>
  <script>
    function insertWifiBookmark() {
      const bookmarkIdEl = document.getElementById("bookmarkIdForm");
      if (!bookmarkIdEl.value) {
        alert("북마크 그룹을 선택해주세요.");
        return;
      }
      document.bookmarkForm.submit();
    }
  </script>
</body>
</html>
