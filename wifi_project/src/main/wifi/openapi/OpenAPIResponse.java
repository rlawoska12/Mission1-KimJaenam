package main.wifi.openapi;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;
import main.wifi.entity.WifiEntity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Getter
@Setter
public class OpenAPIResponse {

    @Getter
    @Setter
    public static class ResultCode {

        @SerializedName("CODE")
        String code;

        @SerializedName("MESSAGE")
        String message;

        public boolean isSuccess() {
            return code.equals("INFO-000");
        }

    }

    @Getter
    @Setter
    public static class PublicWifiInfo {

        @SerializedName("TbPublicWifiInfo")
        PublicWifiInfoEntity entity;

    }

    @Getter
    @Setter
    public static class PublicWifiInfoEntity {

        @SerializedName("list_total_count")
        int listTotalCount;

        @SerializedName("RESULT")
        ResultCode result;

        List<WifiInfoItem> row;

    }

    @Getter
    @Setter
    public static class WifiInfoItem {

        @SerializedName("X_SWIFI_MGR_NO")
        String manageNo;

        @SerializedName("X_SWIFI_WRDOFC")
        String borough;

        @SerializedName("X_SWIFI_MAIN_NM")
        String name;

        @SerializedName("X_SWIFI_ADRES1")
        String adres1;

        @SerializedName("X_SWIFI_ADRES2")
        String adres2;

        @SerializedName("X_SWIFI_INSTL_FLOOR")
        String floor;

        @SerializedName("X_SWIFI_INSTL_TY")
        String instalType;

        @SerializedName("X_SWIFI_INSTL_MBY")
        String instalAgency;

        @SerializedName("X_SWIFI_SVC_SE")
        String service;

        @SerializedName("X_SWIFI_CMCWR")
        String netType;

        @SerializedName("X_SWIFI_CNSTC_YEAR")
        int instalYear;

        @SerializedName("X_SWIFI_INOUT_DOOR")
        String inOutDoor;

        @SerializedName("X_SWIFI_REMARS3")
        String connectionEvir;

        @SerializedName("LNT")
        double coorX;

        @SerializedName("LAT")
        double coorY;

        @SerializedName("WORK_DTTM")
        String workDate;

        WifiEntity toEntity() {
            WifiEntity entity = new WifiEntity();
            entity.setManageNo(manageNo);
            entity.setBorough(borough);
            entity.setName(name);
            entity.setAdres1(adres1);
            entity.setAdres2(adres2);
            entity.setFloor(floor);
            entity.setInstalType(instalType);
            entity.setInstalAgency(instalAgency);
            entity.setService(service);
            entity.setNetType(netType);
            entity.setInstalYear(instalYear);
            entity.setInOutDoor(inOutDoor);
            entity.setConnectionEvir(connectionEvir);
            entity.setCoorX(coorX);
            entity.setCoorY(coorY);
            entity.setWorkDate(LocalDateTime.parse(workDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.0")));
            return entity;
        }

    }

}
