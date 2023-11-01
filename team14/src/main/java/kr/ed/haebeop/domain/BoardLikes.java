package kr.ed.haebeop.domain;

import lombok.Data;

@Data
public class BoardLikes {
    private String userid;
    private int boardno;
    private String liketime;
}
