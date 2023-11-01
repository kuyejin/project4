package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Faq;

import java.util.List;

public interface FaqRepository {
    public List<Faq> faqList() throws Exception;
}
