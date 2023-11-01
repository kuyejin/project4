package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.MyClassVO;
import kr.ed.haebeop.persistence.MyclassMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MyclassService {


    @Autowired
    private MyclassMapper myclassMapper;


    // 전체 수강 강좌 가져오기
    public List<MyClassVO> myclassList() throws Exception{
        return myclassMapper.myclassList();
    }

    // 해당 수강 중인 강좌 가져오기
    public List<MyClassVO> getMyclassList(String id) throws Exception {
        return myclassMapper.getMyclassList(id);
    }


    // 수강신청한 강좌 중 선택한 강의의 정보 selectone
    public List<MyClassVO> gettakingClassList(int lec_no) throws Exception{
        return myclassMapper.gettakingClassList(lec_no);
    }


    //수강 중인 강의 수 카운트
    public int takingCount(String id)throws Exception{
        return myclassMapper.takingCount(id);
    }

    // 해당 수강 중인 강좌 가져오기
    public List<MyClassVO> gettakingClassList2(MyClassVO myClassVO) throws Exception {
        return myclassMapper.gettakingClassList2(myClassVO);
    }
}
