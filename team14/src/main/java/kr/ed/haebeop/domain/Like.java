package kr.ed.haebeop.domain;

import lombok.Data;


@Data
public class Like {
    private String userId;
    private int boardNo;
    private String likedTime;

}
