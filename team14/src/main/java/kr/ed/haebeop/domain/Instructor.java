package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Instructor {
    private int no;             // 강사 번호
    private String name;        // 이름
    private String tel;         // 전화번호
    private String email;       // 이메일
    private String intro;       // 소개글
    private String cate;        // 담당 과목
    private String img;         // 프로필 이미지

    private String id; // ID
}
