package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.persistence.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentService {
    @Autowired
    private PaymentMapper paymentMapper;
    
    // 결제 확인
    public void paymentInsert(Payment payment){
        paymentMapper.paymentInsert(payment);
    }

    // 모든 결제 정보 리스트, 관리자 전용
    public List<Payment> paymentList(){
        return paymentMapper.paymentList();
    }

    // 해당 회원의 결제 정보
    public List<Payment> paymentMemList(String id){
        return paymentMapper.paymentMemList(id);
    }
    
    // 결제 취소
    public void paymentDelete(int sno){
        paymentMapper.paymentDelete(sno);
    }

    // 결제 확정
    public void buyPayemnt(int sno) {paymentMapper.buyPayemnt(sno);}

    // 이미 수강하고 있는 강의인지 아닌지 확인
    public int checkPayment(Payment payment) {return paymentMapper.checkPayment(payment);}

    // 결제 번호를 통한 결제 정보
    public Payment getPayment(int sno) {return paymentMapper.getPayment(sno);}

    // 리뷰 작성을 위해 state 확인
    public int statePayemnt(Payment payment) { return paymentMapper.statePayemnt(payment); }
    // 수강 기한일 저장
    public void updateEndPayment(Payment payment) {paymentMapper.updateEndPayment(payment);}
}
