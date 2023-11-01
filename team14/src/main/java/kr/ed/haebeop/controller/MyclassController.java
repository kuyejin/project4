package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.DateCalculator;
import kr.ed.haebeop.util.VideoTimeCut;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Slf4j
@RequestMapping("/myclass/*")
public class MyclassController {


    @Autowired
    private MyclassService myclassService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private InstService instService;

    @Autowired
    private InstructorService instructorService;

    @Autowired
    private PaymentService paymentService;
    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MemberService memberService;

    @Autowired
    HttpSession session;


    @GetMapping("myclassList.do")        // board/list.do
    public String myclassList(Model model) throws Exception {
        List<MyClassVO> myclassList = myclassService.myclassList();
        model.addAttribute("myclassList", myclassList);
        return "/myclass/";
    }


    // 해당회원이 수강 중인 강의 리스트 가져오기
    @RequestMapping("myclassIndex.do")
    public String myclassIndex(Model model) throws Exception {
        DateCalculator dateCalculator = new DateCalculator();
        String id = (String) session.getAttribute("sid");
        List<MyClassVO> myclassList = myclassService.getMyclassList(id);


        //topbar정보
        Member member = memberService.getMember(id);
        System.out.println("내 정보: " + member);
        model.addAttribute("member", member);

        //최근 수강 중인 강의 수
        int count = myclassService.takingCount(id);
        model.addAttribute("count", count);

        //출력해보기
        System.out.println(myclassList.toString());

        String ck = "";
        int Ddays = 0;
        for (MyClassVO myClass : myclassList) {
            //테스트
//            String strDate = "2023-10-30";
//            String todayFm = "2024-01-25";

            String strDate = myClass.getLecStudyend(); // 기준 날짜 데이터 (("yyyy-MM-dd")의 형태)
            String todayFm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis())); // 오늘날짜

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date date = new Date(dateFormat.parse(strDate).getTime());
            Date today = new Date(dateFormat.parse(todayFm).getTime());

            long calculate = date.getTime() - today.getTime();

            Ddays = (int) (calculate / (24 * 60 * 60 * 1000));

            System.out.println(myClass.getLecTitle() + " : 남은 기간: " + Ddays);


            Course course = new Course();

            course.setSid(id);
            course.setLec_no(myClass.getLec_no());

            if (Ddays <= 0) {
                course.setCheck(3);
                courseService.checkUpdate(course);
            } else {
                course.setCheck(1);
                courseService.checkUpdate(course);
            }


            System.out.println(myClass);

            int check = myClass.getCk();

            System.out.println(check);

            if (check == 1) {
                ck = "수강 중";
            } else if (check == 3) {
                ck = "수강 완료";
            }

            Map<String, Object> myclassMap = new HashMap<>();
            myclassMap.put("Ddays", Ddays);
            myclassMap.put("ck", ck);

            System.out.println(myclassList);
            System.out.println(myclassMap);
            model.addAttribute("myclassList", myclassList);
            myClass.setMyclassMap(myclassMap);
        }
        return "/myclass/myclassIndex";
    }


    // 좋아요 목록
    @GetMapping("/likeList.do")
    public String LikeList(HttpServletRequest req, Model model) throws Exception {


        String id = (String) session.getAttribute("sid");

        //topbar정보
        Member member = memberService.getMember(id);
        System.out.println("내 정보: " + member);
        model.addAttribute("member", member);

        //최근 수강 중인 강의 수
        int count = myclassService.takingCount(id);
        model.addAttribute("count", count);


        List<LectureLikes> lectureLikes = lectureService.getByIdLikeList(id);
        List<Lecture> lectureList = new ArrayList<>();

        for (LectureLikes lec : lectureLikes) {
            lectureList.add(lectureService.getLecture(lec.getLno()));
        }

        model.addAttribute("lectureList", lectureList);
        model.addAttribute("likeList", lectureLikes);
        return "/myclass/likeList";
    }


    // 수강신청한 강좌 디테일
    @RequestMapping(value = "/myclassDetail.do", method = RequestMethod.GET)
    public String myclassDetail(Model model, HttpServletRequest req) throws Exception {
        int no = Integer.parseInt(req.getParameter("no"));
        String id = (String) session.getAttribute("sid");
        MyClassVO myClassVO = new MyClassVO();
        myClassVO.setLec_no(no);
        myClassVO.setId(id);
        List<MyClassVO> takingClassList2 = myclassService.gettakingClassList2(myClassVO);
        model.addAttribute("takingList2", takingClassList2);
        //topbar정보
        Member member = memberService.getMember(id);
        System.out.println("내 정보: " + member);
        model.addAttribute("member", member);
        //최근 수강 중인 강의 수
        int count = myclassService.takingCount(id);
        model.addAttribute("count", count);
        List<MyClassVO> myclassList = myclassService.getMyclassList(id);
        List<MyClassVO> takingClassList = myclassService.gettakingClassList(no);
        Lecture getLectureList = lectureService.getLecture(no);// 서비스 클래스에 비즈니스 로직을 정의하고 호출
        model.addAttribute("lecList", getLectureList);





        /* region 1. 강의소개 메뉴 */
        Lecture Lecture1 = lectureService.getLecture(no);

        List<String> vList = new ArrayList<>(); // 비디오 이름 받기
        String scoreAvg = reviewService.avgScore(no);
        if (scoreAvg != null) {
            scoreAvg = String.format("%.1f", Double.parseDouble(scoreAvg));
        }

        // 강의 영상 개수 카운트
        int cnt = 0;
        if (Lecture1.getSfile2() != null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(Lecture1.getSfile2());
            vList.add(realName);
        }
        if (Lecture1.getSfile3() != null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(Lecture1.getSfile3());
            vList.add(realName);
        }
        if (Lecture1.getSfile4() != null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(Lecture1.getSfile4());
            vList.add(realName);
        }
        if (Lecture1.getSfile5() != null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(Lecture1.getSfile5());
            vList.add(realName);
        }

        System.out.println("강의소개: " + takingClassList);
        model.addAttribute("takingList", takingClassList);
        model.addAttribute("cnt", cnt);
        model.addAttribute("avg", scoreAvg);


        // region 2. 강의목차 메뉴
        Lecture lecture = lectureService.getLecture(no); // 강의 정보 추출
        List<String> videoList = new ArrayList<>(); // 비디오 이름 받기
        List<String> videoList2 = new ArrayList<>(); // 실제 저장된 UUID 비디오 이름
        List<String> vtl = new ArrayList<>(); // 비디오 길이 추출
        Instructor inst = instService.getInstructorName(lecture.getIno());

        // 서버 절대경로 주소
//        String path = req.getSession().getServletContext().getRealPath("/");
//        String path2 = req.getContextPath();
//        path = path.replace("\\", "/");
//        path2 = path2.replace("\\", "/");

        if (lecture.getSfile2() != null) {
            String sfileName = lecture.getSfile2();
            String realName = lectureService.getLecFileName(sfileName);
            videoList.add(realName);
            videoList2.add(sfileName);
//            String t = VideoTimeCut.media_player_time(path2, path, sfileName);
//            vtl.add(t);
        }
        if (lecture.getSfile3() != null) {
            String sfileName = lecture.getSfile3();
            String realName = lectureService.getLecFileName(sfileName);
            videoList.add(realName);
            videoList2.add(sfileName);
//            String t = VideoTimeCut.media_player_time(path2, path, sfileName);
//            vtl.add(t);
        }
        if (lecture.getSfile4() != null) {
            String sfileName = lecture.getSfile4();
            String realName = lectureService.getLecFileName(sfileName);
            videoList.add(realName);
            videoList2.add(sfileName);
//            String t = VideoTimeCut.media_player_time(path2, path, sfileName);
//            vtl.add(t);
        }
        if (lecture.getSfile5() != null) {
            String sfileName = lecture.getSfile5();
            String realName = lectureService.getLecFileName(sfileName);
            videoList.add(realName);
            videoList2.add(sfileName);
//            String t = VideoTimeCut.media_player_time(path2, path, sfileName);
//            vtl.add(t);
        }

        System.out.println(videoList);
        System.out.println(videoList2);
        System.out.println(lecture);
        System.out.println(inst);
        System.out.println(vtl);

//        model.addAttribute("vtl", vtl);
        model.addAttribute("videoList", videoList);
        model.addAttribute("videoList2", videoList2);
        model.addAttribute("lecture", lecture);
        model.addAttribute("inst", inst);
        // endregion


        // region 3. 공지사항 메뉴
        Lecture lecture3 = lectureService.getLecture(no);
        int lns_No3 = lecture3.getIno();

        List<InstructorNotice> instructorNotices = instructorService.getInstructorNoticeList(lns_No3);
        model.addAttribute("instructorNotices", instructorNotices);
        System.out.println(instructorNotices.toString());


        // region 4. QnA
        Lecture lecture4 = lectureService.getLecture(no);
        int lns_No4 = lecture4.getIno();

        List<InstructorQna> qnaList = instructorService.instructorQnaList(lns_No4);
        model.addAttribute("qnaList", qnaList);


        // region 5. 수강후기
        Lecture lecture5 = lectureService.getLecture(no);
        int lns_No5 = lecture5.getIno();

        List<Review> reviewList = instructorService.getReviewList(lns_No5);
        model.addAttribute("reviewList", reviewList);


        // region 6. 자료실
        Lecture lecture6 = lectureService.getLecture(no);
        int ins_No6 = lecture6.getIno();

        Instructor instructor = instructorService.getInstructor(ins_No6);
        model.addAttribute("instructor", instructor);

        List<InstructorFile> instructorFiles = instructorService.getInstructorFileList(no);
        model.addAttribute("instructorFiles", instructorFiles);



        model.addAttribute("ino", ins_No6);

        System.out.println(instructor);
        System.out.println(takingClassList);
        System.out.println(getLectureList);

        return "myclass/myclassDetail";
    }


    // 강의 영상 보기
    @RequestMapping(value = "/getLecVideo", method = RequestMethod.GET)
    public String getLecture(Model model, HttpServletRequest req) {
        int no = Integer.parseInt(req.getParameter("no"));
        Lecture product = lectureService.getLecture(no); // 서비스 클래스에 비즈니스 로직을 정의하고 호출
        Instructor inst = instService.getInstructorName(product.getIno()); // 강사 번호로 이름 추출

        model.addAttribute("pro", product);
        model.addAttribute("inst", inst);
        return "myclass/lecVideo";
    }


}