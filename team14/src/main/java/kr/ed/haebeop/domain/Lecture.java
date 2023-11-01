package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

// 상품
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Lecture {
    private int no; // 상품번호
    private String cate; // 카테고리
    private String slevel; // 수강 레벨
    private String title; // 강의 제목
    private String content; // 강의 소개글
    private String simg; // 목록 프로필 이미지
    private String sfile1; // ot 영상
    private String sfile2; // 강의 영상1
    private String sfile3; // 강의 영상2
    private String sfile4; // 강의 영상3
    private String sfile5; // 강의 영상4
    private int price; // 가격
    private int ino; // 강사 코드(FK)
    private int cnt; // 조회수
    private int lec; // 현재 수강인원
    private int lec_max; // 최대 수강인원
    private String aplctClss1; // 수강신청 시작일
    private String aplctClss2; // 수강신청 종료일
    private String studyStart; // 강의 시작일
    private String studyEnd; // 강의 종료일
    private int endDay; // 강의 수강 기간일
}
