package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Payment;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface PaymentMapper {
    // 결제 확인
    @Insert("insert into payment(sno, id, lec_no, lec_name, pmethod, pcom, cnum, price, state, resdate, pt) " +
            "values(default, #{id}, #{lec_no}, #{lec_name}, #{pmethod}, #{pcom}, #{cnum}, #{price}, default, default, #{pt})")
    public void paymentInsert(Payment payment);
    
    // 모든 결제 정보 리스트
    @Select("select * from payment order by sno desc")
    public List<Payment> paymentList();
    
    // 해당 회원의 결제 정보
    @Select("select * from payment where id=#{id}")
    public List<Payment> paymentMemList(String id);

    // 이미 수강하는 강의인지 아닌지 확인
    @Select("select count(*) from payment where id=#{id} and lec_no=#{lec_no}")
    public int checkPayment(Payment payment);

    // 결제 번호를 통한 결제 정보
    @Select("select * from payment where sno=#{sno}")
    public Payment getPayment(int sno);

    // 환불
    @Select("delete from payment where sno=#{sno}")
    public void paymentDelete(int sno);

    // 구매 확정
    @Update("update payment set state=1, buydate=CURRENT_TIMESTAMP() where sno=#{sno}")
    public void buyPayemnt(int sno);

    // 리뷰 작성을 위해 state 확인
    @Select("select state from payment where id=#{id} and lec_no=#{lec_no}")
    public int statePayemnt(Payment payment);

    @Update("update payment set enddate=#{enddate} where sno=#{sno}")
    public void updateEndPayment(Payment payment);
}
