package kr.ed.haebeop.domain;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Member {
    private String id;
    private String pw;
    private String name;
    private String email;
    private String tel;
    private String addr1;
    private String addr2;
    private String postcode;
    private String regdate;
    private int pt;
    private String birth;
    private int job;
    private int visited;
    private int login_tp_cd; //로그인 타입 1: 일반 2: 카카오 3: 네이버
    private int state_cd; //상태코드 1: 정상 2: 신고정지 3: 탈퇴 4: 휴면
}