package kr.ed.haebeop.domain;

import lombok.*;

import java.util.Map;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MyClassVO {

    String id; //회원아이디
    int lec_no; //강의코드
    String lecCate; // 강의 강테고리
    String insName; // 강사이름
    String slevel; // 대상 학년
    String lecTitle; // 강의타이틀
    String lecContent; //강의설명
    String lecStudystart; //강의시작일
    String lecStudyend; //강의종료
    int ck; // 1.수강중 , 2.수강정지, 3.수강취소
    String simg;

    private Map<String, Object> myclassMap; // 남은일수, 수강상태(string)

}
