package kr.ed.haebeop.domain;

import lombok.Data;

@Data
public class InstructorNotice {
    private int no;
    private String title;
    private String content;
    private String resdate;
    private int cnt;
    private int instructorno;

}
