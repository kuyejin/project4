package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Grade {
    private int no;
    private String stuname;
    private String stuid;
    private int kor;
    private int math;
    private int eng;
    private int social;
    private int science;
    private String exam;
    private String tname;
    private String tid;
    private String regdate;
    private int su; // 합계
    private int av; // 평균
}
