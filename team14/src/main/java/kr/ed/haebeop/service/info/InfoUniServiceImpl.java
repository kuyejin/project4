package kr.ed.haebeop.service.info;

import kr.ed.haebeop.domain.Infomation;
import kr.ed.haebeop.repository.InfoUniRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InfoUniServiceImpl implements InfoService{

    @Autowired
    private InfoUniRepositoryImpl infoUniRepository;

    @Override
    public List<Infomation> infoList() throws Exception {
        return infoUniRepository.infoList();
    }

    @Override
    public Infomation infoDetail(int bno) throws Exception {
        return infoUniRepository.infoDetail(bno);
    }

    @Override
    public void infoInsert(Infomation dto) throws Exception {
        infoUniRepository.infoInsert(dto);
    }

    @Override
    public void infoDelete(int bno) throws Exception {
        infoUniRepository.infoDelete(bno);
    }

    @Override
    public void infoEdit(Infomation dto) throws Exception {
        infoUniRepository.infoEdit(dto);
    }

    @Override
    public void countUp(int bno) throws Exception {
        infoUniRepository.countUp(bno);
    }
}
