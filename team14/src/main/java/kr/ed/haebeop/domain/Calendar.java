package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Calendar {
    private int no;
    private String id;
    private int groupId;
    private String title;
    private String writer;
    private String content;
    private String start;
    private String end;
    private String textColor;
    private String backgroundColor;
    private String borderColor;
}
