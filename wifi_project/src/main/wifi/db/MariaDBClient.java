package main.wifi.db;

import main.wifi.entity.BookmarkEntity;
import main.wifi.entity.HistoryEntity;
import main.wifi.entity.WifiBookmarkEntity;
import main.wifi.entity.WifiEntity;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MariaDBClient {

    private final String DB_URL = "jdbc:mariadb://172.30.1.21:3306/wifi_db";
    private final String DB_USER_ID = "testuser1";
    private final String DB_USER_PW = "qwer1234";

    public MariaDBClient() throws ClassNotFoundException {
        Class.forName("org.mariadb.jdbc.Driver");
    }

    public void deleteAllWifiList() throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "DELETE FROM `wifi`";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.execute();

        ps.close();
        connection.close();
    }

    public void insertWifiList(List<WifiEntity> wifiList) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);
        String sql = "" +
            "INSERT INTO `wifi` (" +
                "`MANAGE_NO`, `BOROUGH`, `NAME`, `ADRES1`, `ADRES2`, `FLOOR`, `INSTAL_TYPE`, `INSTAL_AGENCY`, " +
                "`SERVICE`, `NET_TYPE`, `INSTAL_YEAR`, `INOUT_DOOR`, `CONNECTION_EVIR`, `X_COOR`, `Y_COOR`, `WORK_DATE`" +
            ") VALUES (" +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?" +
            ")";
        PreparedStatement ps = connection.prepareStatement(sql);

        for (WifiEntity wifi : wifiList) {
            ps.setString(1, wifi.getManageNo());
            ps.setString(2, wifi.getBorough());
            ps.setString(3, wifi.getName());
            ps.setString(4, wifi.getAdres1());
            ps.setString(5, wifi.getAdres2());
            ps.setString(6, wifi.getFloor());
            ps.setString(7, wifi.getInstalType());
            ps.setString(8, wifi.getInstalAgency());
            ps.setString(9, wifi.getService());
            ps.setString(10, wifi.getNetType());
            ps.setInt(11, wifi.getInstalYear());
            ps.setString(12, wifi.getInOutDoor());
            ps.setString(13, wifi.getConnectionEvir());
            ps.setDouble(14, wifi.getCoorX());
            ps.setDouble(15, wifi.getCoorY());
            ps.setObject(16, wifi.getWorkDate());
            ps.execute();
        }

        ps.close();
        connection.close();
    }

    public WifiEntity getWifiDetail(double lat, double lnt, String manageNo) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);
        String sql = "SELECT *," +
            "(6371 * acos(cos(radians(?)) * cos(radians(`Y_COOR`)) * cos(radians(`X_COOR`) - radians(?)) + sin(radians(?)) * sin(radians(`Y_COOR`)))) AS `DISTANCE`" +
            "FROM `wifi`" +
            "WHERE `MANAGE_NO` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setDouble(1, lnt);
        ps.setDouble(2, lat);
        ps.setDouble(3, lnt);
        ps.setString(4, manageNo);

        ResultSet resultSet = ps.executeQuery();
        if (!resultSet.next()) {
            return null;
        }

        WifiEntity entity = new WifiEntity();
        entity.setManageNo(resultSet.getString("MANAGE_NO"));
        entity.setBorough(resultSet.getString("BOROUGH"));
        entity.setName(resultSet.getString("NAME"));
        entity.setAdres1(resultSet.getString("ADRES1"));
        entity.setAdres2(resultSet.getString("ADRES2"));
        entity.setFloor(resultSet.getString("FLOOR"));
        entity.setInstalType(resultSet.getString("INSTAL_TYPE"));
        entity.setInstalAgency(resultSet.getString("INSTAL_AGENCY"));
        entity.setService(resultSet.getString("SERVICE"));
        entity.setNetType(resultSet.getString("NET_TYPE"));
        entity.setInstalYear(resultSet.getInt("INSTAL_YEAR"));
        entity.setInOutDoor(resultSet.getString("INOUT_DOOR"));
        entity.setConnectionEvir(resultSet.getString("CONNECTION_EVIR"));
        entity.setCoorX(resultSet.getDouble("X_COOR"));
        entity.setCoorY(resultSet.getDouble("Y_COOR"));
        entity.setWorkDate(resultSet.getObject("WORK_DATE", LocalDateTime.class));
        entity.setDistance(resultSet.getDouble("DISTANCE"));

        ps.close();
        connection.close();

        return entity;
    }

    public List<WifiEntity> getWifiList(double lat, double lnt, int limit) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);
        String sql = "SELECT *," +
            "(6371 * acos(cos(radians(?)) * cos(radians(`Y_COOR`)) * cos(radians(`X_COOR`) - radians(?)) + sin(radians(?)) * sin(radians(`Y_COOR`)))) AS `DISTANCE`" +
            "FROM `wifi`" +
            "ORDER BY `DISTANCE`" +
            "LIMIT ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setDouble(1, lnt);
        ps.setDouble(2, lat);
        ps.setDouble(3, lnt);
        ps.setInt(4, limit);

        List<WifiEntity> wifiList = new ArrayList<>();
        ResultSet resultSet = ps.executeQuery();
        while (resultSet.next()) {
            WifiEntity entity = new WifiEntity();
            entity.setManageNo(resultSet.getString("MANAGE_NO"));
            entity.setBorough(resultSet.getString("BOROUGH"));
            entity.setName(resultSet.getString("NAME"));
            entity.setAdres1(resultSet.getString("ADRES1"));
            entity.setAdres2(resultSet.getString("ADRES2"));
            entity.setFloor(resultSet.getString("FLOOR"));
            entity.setInstalType(resultSet.getString("INSTAL_TYPE"));
            entity.setInstalAgency(resultSet.getString("INSTAL_AGENCY"));
            entity.setService(resultSet.getString("SERVICE"));
            entity.setNetType(resultSet.getString("NET_TYPE"));
            entity.setInstalYear(resultSet.getInt("INSTAL_YEAR"));
            entity.setInOutDoor(resultSet.getString("INOUT_DOOR"));
            entity.setConnectionEvir(resultSet.getString("CONNECTION_EVIR"));
            entity.setCoorX(resultSet.getDouble("X_COOR"));
            entity.setCoorY(resultSet.getDouble("Y_COOR"));
            entity.setWorkDate(resultSet.getObject("WORK_DATE", LocalDateTime.class));
            entity.setDistance(resultSet.getDouble("DISTANCE"));
            wifiList.add(entity);
        }

        ps.close();
        connection.close();

        return wifiList;
    }

    public void insertHistory(double x, double y) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = " INSERT INTO `history` (" +
            " `X_COOR`, `Y_COOR`, `CHECK_DATE` " +
            ") VALUES (?, ?, NOW());";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setDouble(1, x);
        ps.setDouble(2, y);
        ps.execute();
        ps.close();
        connection.close();
    }

    public List<HistoryEntity> getHistoryList() throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "SELECT * " +
            "FROM `history`" +
            "ORDER BY `ID` DESC";
        PreparedStatement ps = connection.prepareStatement(sql);

        List<HistoryEntity> historyList = new ArrayList<>();
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            HistoryEntity history = new HistoryEntity();
            history.setId(rs.getInt("ID"));
            history.setX(rs.getDouble("X_COOR"));
            history.setY(rs.getDouble("Y_COOR"));
            history.setCheckDate(rs.getObject("CHECK_DATE", LocalDateTime.class));
            historyList.add(history);
        }

        ps.close();
        connection.close();

        return historyList;
    }

    public void deleteHistory(int id) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "DELETE FROM `history` WHERE `ID` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.execute();

        ps.close();
        connection.close();
    }

    public void insertBookmark(String name, int order) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "INSERT INTO `bookmark` (`NAME`, `ORDER`, `REG_DATE`)" +
                " VALUE (?, ?, NOW()); ";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ps.setInt(2, order);
        ps.execute();

        ps.close();
        connection.close();
    }

    public void updateBookmark(int id, String name, int order) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "UPDATE `bookmark` SET `NAME` = ?, `ORDER` = ?, `EDIT_DATE` = NOW() WHERE `ID` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ps.setInt(2, order);
        ps.setInt(3, id);
        ps.execute();

        ps.close();
        connection.close();
    }

    public BookmarkEntity getBookmarkDetail(int id) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "SELECT * FROM `bookmark` WHERE `ID` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }

        BookmarkEntity bookmark = new BookmarkEntity();
        bookmark.setId(rs.getInt("ID"));
        bookmark.setName(rs.getString("NAME"));
        bookmark.setOrder(rs.getInt("ORDER"));
        bookmark.setRegDate(rs.getObject("REG_DATE", LocalDateTime.class));
        bookmark.setEditDate(rs.getObject("EDIT_DATE", LocalDateTime.class));

        ps.close();
        connection.close();

        return bookmark;
    }

    public List<BookmarkEntity> getBookmarkList() throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "SELECT * FROM `bookmark` ORDER BY `ORDER`";
        PreparedStatement ps = connection.prepareStatement(sql);

        List<BookmarkEntity> bookmarkList = new ArrayList<>();
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            BookmarkEntity bookmark = new BookmarkEntity();
            bookmark.setId(rs.getInt("ID"));
            bookmark.setName(rs.getString("NAME"));
            bookmark.setOrder(rs.getInt("ORDER"));
            bookmark.setRegDate(rs.getObject("REG_DATE", LocalDateTime.class));
            bookmark.setEditDate(rs.getObject("EDIT_DATE", LocalDateTime.class));
            bookmarkList.add(bookmark);
        }

        ps.close();
        connection.close();

        return bookmarkList;
    }

    public void deleteBookmark(int id) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "DELETE FROM `bookmark` WHERE `ID` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.execute();

        ps.close();
        connection.close();
    }

    public void insertWifiBookmark(String wifiManageNo, int bookmarkId) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "INSERT INTO `wifi_bookmark` (`WIFI_MANAGE_NO`, `BOOKMARK_ID`, `REG_DATE`)" +
                " VALUE (?, ?, NOW()); ";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, wifiManageNo);
        ps.setInt(2, bookmarkId);
        ps.execute();

        ps.close();
        connection.close();
    }

    public List<WifiBookmarkEntity> getWifiBookmarkList() throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "" +
                "SELECT `wifi_bookmark`.`ID`, `bookmark`.`NAME` AS `BOOKMARK_NAME`, `wifi`.`NAME` AS `WIFI_NAME`, `wifi_bookmark`.`REG_DATE`" +
                "FROM `wifi_bookmark`" +
                "JOIN `bookmark` ON `wifi_bookmark`.`BOOKMARK_ID` = `bookmark`.`ID`" +
                "JOIN `wifi` ON `wifi_bookmark`.`WIFI_MANAGE_NO` = `wifi`.`MANAGE_NO`" +
                "ORDER BY `id` DESC";
        PreparedStatement ps = connection.prepareStatement(sql);

        List<WifiBookmarkEntity> wifiBookmarkList = new ArrayList<>();
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            WifiBookmarkEntity wifiBookmark = new WifiBookmarkEntity();
            wifiBookmark.setId(rs.getInt("ID"));
            wifiBookmark.setBookmarkName(rs.getString("BOOKMARK_NAME"));
            wifiBookmark.setWifiName(rs.getString("WIFI_NAME"));
            wifiBookmark.setRegDate(rs.getObject("REG_DATE", LocalDateTime.class));
            wifiBookmarkList.add(wifiBookmark);
        }

        ps.close();
        connection.close();

        return wifiBookmarkList;
    }

    public void deleteWifiBookmark(int id) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER_ID, DB_USER_PW);

        String sql = "DELETE FROM `wifi_bookmark` WHERE `ID` = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.execute();

        ps.close();
        connection.close();
    }


}
