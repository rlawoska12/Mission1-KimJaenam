package main.wifi.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class WifiBookmarkEntity {
    int id;
    String wifiName;
    String bookmarkName;
    LocalDateTime regDate;
}
