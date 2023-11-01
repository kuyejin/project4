package kr.ed.haebeop.util;

import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

// 최대 수강일 전 까지만 수강할 수 있도록 설정
public class DateCalculator {
    // 결제일로 부터 언제까지 들을 수 있는지 날짜를 연산하는
    public static String endDays(String startDateStr, int endDay) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        startDateStr = startDateStr.split(" ")[0]; // 시간 정보 제거
        LocalDate startDate = LocalDate.parse(startDateStr, formatter);

        // 100일 후의 날짜를 계산합니다.
        LocalDate futureDate = startDate.plusDays(endDay);
        System.out.println("100일 후의 날짜: " + futureDate);

        return futureDate.format(formatter);
    }

    // 아직 수강할 수 있는 기간인지 확인
    public static boolean isAfterEndDays(String endDateStr) {
        String todayDateStr = getTodayAsString();
        
        // 수강 기간 테스트용
//        String todayDateStr = "2023-10-22";
//        String todayDateStr = "2024-01-25";

        // 날짜 문자열을 LocalDate 객체로 파싱합니다.
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(todayDateStr, formatter);
        System.out.println("start day : " + startDate);

        LocalDate endDate = LocalDate.parse(endDateStr, formatter);

        // endDay 일 후의 날짜와 종료 날짜를 비교합니다.
        return endDate.isAfter(startDate);
    }

    // 수강 기간 남은 일수 출력 메소드
    public static long daysRemainingInMonths(String endDateStr) {
        String todayDateStr = getTodayAsString();

        // 수강 기간 테스트용
//        String todayDateStr = "2023-10-22";
//        String todayDateStr = "2024-01-25";

        // 날짜 문자열을 LocalDate 객체로 파싱합니다.
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate todayDate = LocalDate.parse(todayDateStr, formatter);
        System.out.println("시작 날짜: " + todayDate);

        LocalDate endDate = LocalDate.parse(endDateStr, formatter);

        // 남은 일 수를 계산합니다.
        long daysRemaining = ChronoUnit.DAYS.between(todayDate, endDate);
        System.out.println("남은 일 수: " + daysRemaining);

        // 월 단위로 나눈 남은 일 수를 계산합니다.
        long monthsRemaining = daysRemaining / 30; // 평균적으로 한 달은 30일로 가정
        System.out.println("남은 개월 수: " + monthsRemaining);

        return daysRemaining;
    }

    // 오늘 날짜 반환
    public static String getTodayAsString() {
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return today.format(formatter);
    }

    // 테스트
    @Test
    public static void main(String[] args) {
        int endDay = 100;
        String startDateStr = "2023-10-16";
        String endDateStr = endDays(startDateStr, endDay);
        if (isAfterEndDays(endDateStr)) {
            System.out.println("수강 기간이 아직 지나지 않았습니다.");
        } else {
            System.out.println("수강 기간이 지났습니다.");
        }

        long remainingDays = daysRemainingInMonths(endDateStr);
        System.out.println("D-" + remainingDays);
    }
}
