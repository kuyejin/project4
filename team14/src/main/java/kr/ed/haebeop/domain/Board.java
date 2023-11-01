package kr.ed.haebeop.domain;

import lombok.Data;

// get, set, 생성자 모두 사용가능하게 하는 코드 Data
@Data
public class Board {
    private int bno;
    private String title;
    private String content;
    private String author;
    private String resdate;
    private int cnt;
    private int lev;
    private int par;
    private String reason;
    private String report_date;
    private int report_count;
    private String board_type;
    private String liketime;
    private int like_count;
    private boolean readable;
    private String userid;
}
