package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PayCheck {
    private int value; // 구매 확정인지 아닌지
    private boolean check; // 강의를 들을 수 있는지 없느지 확인
    private long day; // 남은 일 수
    private String startDate; // 수강 시작 날짜
    private String endDate; // 수강 종료 날짜
}
