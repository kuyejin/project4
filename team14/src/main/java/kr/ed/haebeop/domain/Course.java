package kr.ed.haebeop.domain;

import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Course {

    int no;
    int lec_no;
    String sid;
    String ctime; //수강시간 (default 0)
    int check; // 1.수강중, 2.수강정지 , 3.수강완료

}
