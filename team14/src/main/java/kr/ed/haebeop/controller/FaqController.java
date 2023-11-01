package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Faq;
import kr.ed.haebeop.service.FaqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/faq/*")
public class FaqController {

    @Autowired
    private FaqService faqService;

    @Autowired
    HttpSession session; // 세션 생성

    @GetMapping("list.do")
    public String getFaqList(Model model) throws Exception{
        List<Faq> faqList = faqService.faqList();
        model.addAttribute("faqList", faqList);
        return "/faq/faqList";
    }
}