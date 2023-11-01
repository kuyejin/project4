package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Review {
    private int no;
    private String id;
    private String content;
    private String resdate;
    private int score;
    private int par;

    private String title;
    private int lno;
    private int ino;
}
