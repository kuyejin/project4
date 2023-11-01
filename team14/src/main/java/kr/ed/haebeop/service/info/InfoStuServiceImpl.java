package kr.ed.haebeop.service.info;

import kr.ed.haebeop.domain.Infomation;
import kr.ed.haebeop.repository.InfoStuRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InfoStuServiceImpl implements InfoService{

    @Autowired
    private InfoStuRepositoryImpl infoStuRepository;

    @Override
    public List<Infomation> infoList() throws Exception {
        return infoStuRepository.infoList();
    }

    @Override
    public Infomation infoDetail(int bno) throws Exception {
        return infoStuRepository.infoDetail(bno);
    }

    @Override
    public void infoInsert(Infomation dto) throws Exception {
        infoStuRepository.infoInsert(dto);
    }

    @Override
    public void infoDelete(int bno) throws Exception {
        infoStuRepository.infoDelete(bno);
    }

    @Override
    public void infoEdit(Infomation dto) throws Exception {
        infoStuRepository.infoEdit(dto);
    }

    @Override
    public void countUp(int bno) throws Exception {
        infoStuRepository.countUp(bno);
    }
}
