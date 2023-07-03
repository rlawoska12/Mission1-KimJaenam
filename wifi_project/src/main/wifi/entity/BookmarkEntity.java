package main.wifi.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BookmarkEntity {

    int id;
    String name;
    int order;
    LocalDateTime regDate;
    LocalDateTime editDate;

}
