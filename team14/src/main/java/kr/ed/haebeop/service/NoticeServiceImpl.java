package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Notice;
import kr.ed.haebeop.persistence.MyclassMapper;
import kr.ed.haebeop.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService{

    @Autowired
    private NoticeRepository noticeRepository;

    @Autowired
    private MyclassMapper myclassMapper;

    @Override
    public List<Notice> noticeList() throws Exception {
        return noticeRepository.noticeList();
    }

    @Override
    public Notice noticeDetail(int no) throws Exception {
        return noticeRepository.noticeDetail(no);
    }

    @Override
    public void noticeInsert(Notice dto) throws Exception {
        noticeRepository.noticeInsert(dto);
    }

    @Override
    public void noticeDelete(int no) throws Exception {
        noticeRepository.noticeDelete(no);
    }

    @Override
    public void noticeEdit(Notice dto) throws Exception {
        noticeRepository.noticeEdit(dto);
    }

    @Override
    public void countUp(int no) throws Exception {
        noticeRepository.countUp(no);
    }


}
