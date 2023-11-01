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
public class Product {
    private int no; // 상품번호
    private String cate; // 카테고리
    private String cateno; // 카테고리번호
    private String pname; // 상품명
    private String pcomment; // 상품설명
    private String plist; // 상품목차
    private int pqty; // 상품 수량
    private int price; // 상품단가
    private String imgSrc1; // 상품이미지
    private String imgSrc2; // 상품이미지
    private String imgSrc3; // 상품이미지
    private String resdate; // 등록일
    private String cname;
}
