<%@ page import="java.util.List" %>
<%@ page import="main.wifi.db.MariaDBClient" %>
<%@ page import="main.wifi.entity.HistoryEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>위치 히스토리 목록</title>
</head>
<style type="text/css">
  table {
    border: white 1px solid; border-collapse: collapse;
    font-size: 10pt;
    width: 100%;
  }

  th { border: white 1px solid; padding: 10px 5px;}

  th { background-color: #14a461; color: white; }

  td { border: lightgrey 1px solid; text-align: center; }

  .gnb li { display: inline-block; }

  .delete { text-align: center; }
</style>
<body>
  <%
    MariaDBClient mariaDBClient = new MariaDBClient();
    List<HistoryEntity> historyList = mariaDBClient.getHistoryList();
  %>

  <h1>위치 히스토리 목록</h1>
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

  <table>
    <tr height="50">
      <th width="100">ID</th>
      <th width="400">X좌표</th>
      <th width="400">Y좌표</th>
      <th width="500">조회일자</th>
      <th width="130">비고</th>
    </tr>
    <td id="nodata" height="70" colspan="5"><font size="4">정보가 존재하지 않습니다.</font></td>
    <tbody id="datalist">
      <% for (HistoryEntity entity : historyList) { %>
        <tr height="30">
          <td><%= entity.getId() %></td>
          <td><%= entity.getX() %></td>
          <td><%= entity.getY() %></td>
          <td><%= entity.getCheckDate() %></td>
          <td class="delete"><input type="button" value="삭제" onclick="onDeleteHistory(<%= entity.getId() %>)"></td>
        </tr>
      <% } %>
    </tbody>
  </table>
  <script>
    const nodataEl = document.getElementById("nodata");
    nodataEl.style.display = <%= historyList.isEmpty() %> ? "auto" : "none";
    const datalistEl = document.getElementById("datalist");
    datalistEl.style.display = <%= historyList.isEmpty() %> ? "none" : "auto";

    function onDeleteHistory(id) {
      if (!confirm("정말 삭제하시겠습니까?")) {
        return;
      }
      location.href = "history-delete.jsp" + "?id=" + id;
    }
  </script>
</body>
</html>
