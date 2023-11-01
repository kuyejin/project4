package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Faq;

import java.util.List;

public interface FaqService {
    public List<Faq> faqList() throws Exception;
}