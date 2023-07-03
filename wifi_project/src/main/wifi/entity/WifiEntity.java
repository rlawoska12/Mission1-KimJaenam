package main.wifi.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class WifiEntity {

    String manageNo;
    String borough;
    String name;
    String adres1;
    String adres2;
    String floor;
    String instalType;
    String instalAgency;
    String service;
    String netType;
    int instalYear;
    String inOutDoor;
    String connectionEvir;
    double coorX;
    double coorY;
    double distance;
    LocalDateTime workDate;

}
