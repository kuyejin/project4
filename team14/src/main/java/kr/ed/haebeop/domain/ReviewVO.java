package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReviewVO {
    private int no;
    private String id;
    private String content;
    private String resdate;
    private int score;
    private int par;
    private String reason;
    private String report_date;
    private int report_count;
    private String board_type;
}
