package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class InstructorFile {
    private int no;
    private String title;
    private String content;
    private String resdate;
    private int cnt;
    private int instructorno;

    private String sfile1; //
    private String sfile2; //
    private String sfile3; //
    private String sfile4;
    private String sfile5;


}
