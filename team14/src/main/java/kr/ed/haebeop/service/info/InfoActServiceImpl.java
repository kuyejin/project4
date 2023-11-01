package kr.ed.haebeop.service.info;

import kr.ed.haebeop.domain.Infomation;
import kr.ed.haebeop.repository.InfoActRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InfoActServiceImpl implements InfoService{

    @Autowired
    private InfoActRepositoryImpl infoActRepository;

    @Override
    public List<Infomation> infoList() throws Exception {
        return infoActRepository.infoList();
    }

    @Override
    public Infomation infoDetail(int bno) throws Exception {
        return infoActRepository.infoDetail(bno);
    }

    @Override
    public void infoInsert(Infomation dto) throws Exception {
        infoActRepository.infoInsert(dto);
    }

    @Override
    public void infoDelete(int bno) throws Exception {
        infoActRepository.infoDelete(bno);
    }

    @Override
    public void infoEdit(Infomation dto) throws Exception {
        infoActRepository.infoEdit(dto);
    }

    @Override
    public void countUp(int bno) throws Exception {
        infoActRepository.countUp(bno);
    }
}
