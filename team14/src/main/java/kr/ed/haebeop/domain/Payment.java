package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Payment {
    private int sno;	            // (auto)결제번호
    private String id;              // 고객아이디
    private int lec_no;             // 강의 번호
    private String lec_name;        // 상품명
    private String pmethod;	        // 결제수단
    private String pcom;		    // 결제 대행사
    private String cnum;		    // 결제카드(계좌)번호
    private int price;		        // 결제금액
    private int state;              // 상품 확인
    private String resdate;         // 결제일
    private String buydate;         // 구매 확정일
    private int pt;                 // 사용한 포인트
    private String enddate;
}
