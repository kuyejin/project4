package kr.ed.haebeop.domain;


import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardlistVO {
    private int num;
    private String subject;
    private String write_date;


}