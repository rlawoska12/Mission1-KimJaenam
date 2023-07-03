package main.wifi.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class HistoryEntity {
    int id;
    double x;
    double y;
    LocalDateTime checkDate;
}
