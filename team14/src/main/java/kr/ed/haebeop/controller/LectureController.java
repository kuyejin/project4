package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.InstService;
import kr.ed.haebeop.service.LectureService;
import kr.ed.haebeop.service.PaymentService;
import kr.ed.haebeop.service.ReviewService;
import kr.ed.haebeop.util.DateCalculator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/lecture/*")
public class LectureController {

    @Resource(name="uploadPath")
    String uploadPath;

    @Autowired
    private LectureService lectureService;
    @Autowired
    private InstService instService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    HttpSession session; // 세션 생성

    // 강의 추가 폼 이동
    @RequestMapping(value = "/addLectureForm", method = RequestMethod.GET)
    public String addLectureForm(Model model) {
        String msg = "관리자의 상품 등록폼이 로딩되었습니다.";
        List<Instructor> instList = instService.getInstructorList();
        model.addAttribute("msg", msg);
        model.addAttribute("instList", instList);
        return "admin/addLecture";
    }

    // 강의 추가
    @PostMapping("/addLecture")
    public String addLecture(HttpServletRequest req, Model model) {
        MultipartHttpServletRequest files = (MultipartHttpServletRequest) req;

        // 파일 처리
        MultipartFile simg = files.getFile("simg");
        MultipartFile sfile1 = files.getFile("sfile1");
        MultipartFile sfile2 = files.getFile("sfile2");
        MultipartFile sfile3 = files.getFile("sfile3");
        MultipartFile sfile4 = files.getFile("sfile4");
        MultipartFile sfile5 = files.getFile("sfile5");

        // 다른 폼 필드 처리
        Lecture lecture = new Lecture();
        lecture.setCate(files.getParameter("cate"));
        lecture.setSlevel(files.getParameter("level1") + " " + files.getParameter("level2"));
        lecture.setTitle(files.getParameter("title"));
        lecture.setContent(files.getParameter("content").trim());
        lecture.setPrice(Integer.parseInt(files.getParameter("price")));
        lecture.setIno(Integer.parseInt(files.getParameter("ino")));
        lecture.setLec_max(Integer.parseInt(files.getParameter("lec_max")));
        lecture.setAplctClss1(files.getParameter("aplctClss1"));
        lecture.setAplctClss2(files.getParameter("aplctClss2"));
        lecture.setStudyStart(files.getParameter("studystart"));
        lecture.setStudyEnd(files.getParameter("studyend"));
        lecture.setEndDay(Integer.parseInt(files.getParameter("endDay")));

        // 개발 서버 파일 저장 경로
         String uploadDir = "D:/team_pro4/team14/src/main/webapp/resources/upload/"; // 회사
//         String uploadDir = "E:/git/spring_study/pro04/src/main/webapp/resources/upload/"; // 집
        // 실제 서버 파일 저장 경로
        String uploadSev = req.getRealPath("/resources/upload/");

        // 실제 파일 이름 db 저장
        LecFile lecFile = new LecFile();

        if (!simg.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = simg.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSimg(RandomFileName);

            try {
//                simg.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                simg.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile1.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile1.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile1(RandomFileName);

            try {
//                sfile1.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile1.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile2.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile2.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile2(RandomFileName);

            try {
//                sfile2.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile2.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile3.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile3.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile3(RandomFileName);

            try {
//                sfile3.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile3.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile4.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile4.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile4(RandomFileName);

            try {
//                sfile4.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile4.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile5.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile5.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile5(RandomFileName);

            try {
//                sfile5.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile5.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                lecFile.setSfile(RandomFileName);
                lecFile.setRealName(OriginalFilename);
                lectureService.setLecFile(lecFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        lectureService.addLecture(lecture);

        return "redirect:/lecture/lecList";
    }

    // 강의 삭제
    @RequestMapping(value = "/deleteLecture", method = RequestMethod.GET)
    public String deleteLecture(@RequestParam("no") int no) {
        lectureService.delLecture(no); // 서비스 클래스에 비즈니스 로직을 정의하고 호출
        return "redirect:/product/proList";
    }

    @RequestMapping(value = "/likeLecture", method = RequestMethod.GET)
    public String likeLecture(Model model, @RequestParam("pno") String pno, @RequestParam("sid") String sid) {
        return "redirect:/product/getLecture?no=" + pno;
    }

    // 강의 상세
    @RequestMapping(value = "/getLecture", method = RequestMethod.GET)
    public String getLecture(HttpServletRequest request,Model model, @RequestParam("no") int no) {
//        lectureService.countUp(no); // 조회수 갱신




        Lecture product = lectureService.getLecture(no); // 서비스 클래스에 비즈니스 로직을 정의하고 호출
        Instructor inst = instService.getInstructorName(product.getIno()); // 강사 번호로 이름 추출
        List<String> videoList = new ArrayList<>(); // 비디오 이름 받기
        String scoreAvg = reviewService.avgScore(no);

        List<Integer> likedProductIds = new ArrayList<>();

        if(scoreAvg != null) {
            scoreAvg = String.format("%.1f", Double.parseDouble(scoreAvg));
        }
        int check = 0; // 구매를 확정하고 리뷰를 작성하지 않은 경우를 확인하기 위해 사용한 변수

        // 강의 영상 개수 카운트
        int cnt = 0;
        if(product.getSfile2()!=null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(product.getSfile2());
            videoList.add(realName);
        }
        if(product.getSfile3()!=null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(product.getSfile3());
            videoList.add(realName);
        }
        if(product.getSfile4()!=null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(product.getSfile4());
            videoList.add(realName);
        }
        if(product.getSfile5()!=null) {
            cnt += 1;
            String realName = lectureService.getLecFileName(product.getSfile5());
            videoList.add(realName);
        }

        // 리뷰 작성을 위한 조건 (구매 확정 + 리뷰 작성 안함)
        if((String) session.getAttribute("sid") != null) {
            String id = (String) session.getAttribute("sid");
            Payment payment = new Payment();
            payment.setLec_no(no);
            payment.setId(id);

            likedProductIds = lectureService.getLikedProductsByUser(id);

            Review review = new Review();
            review.setId(id);
            review.setPar(no);
            try {
                int rc1 = paymentService.statePayemnt(payment); // 결제 확인을 했는지 확인
                int rc2 = reviewService.reviewCheck(review);
                if(rc1 == 1 && rc2 == 0) {
                    check = 1;
                }
            } catch (Exception e) {

            }
        }

        List<Review> revList = reviewService.getReviewListPar(no); // 해당 강의 리뷰 정보 출력

        HttpSession session = request.getSession();
        Cookie[] cookieFromRequest = request.getCookies();
        String cookieValue = null;
        for(int i = 0 ; i<cookieFromRequest.length; i++) {
            // 요청정보로부터 쿠키를 가져온다.
            cookieValue = cookieFromRequest[0].getValue();  // 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴
        }
        // 쿠키 세션 입력
        if (session.getAttribute(no+":cookieLec") == null) {
            session.setAttribute(no+":cookieLec", no + ":" + cookieValue);
        } else {
            session.setAttribute(no+":cookieLec ex", session.getAttribute(no+":cookieLec"));
            if (!session.getAttribute(no+":cookieLec").equals(no + ":" + cookieValue)) {
                session.setAttribute(no+":cookieLec", no + ":" + cookieValue);
            }
        }
// 쿠키와 세션이 없는 경우 조회수 카운트
        if (!session.getAttribute(no+":cookieLec").equals(session.getAttribute(no+":cookieLec ex"))) {
            lectureService.countUp(no);
            product.setCnt(product.getCnt()+1);
        }



        model.addAttribute("likedProductIds", likedProductIds);
        model.addAttribute("revList", revList);
        model.addAttribute("pro", product);
        model.addAttribute("videoList", videoList);
        model.addAttribute("cnt", cnt);
        model.addAttribute("inst", inst);
        model.addAttribute("check", check);
        model.addAttribute("avg", scoreAvg);
        return "lecture/getLecture";
    }

    // 강의 영상 보기
    @RequestMapping(value = "/getLecVideo2", method = RequestMethod.GET)
    public String getLecture2(Model model, HttpServletRequest req) {
        int no = Integer.parseInt(req.getParameter("no"));
        Lecture product = lectureService.getLecture(no); // 서비스 클래스에 비즈니스 로직을 정의하고 호출
        Instructor inst = instService.getInstructorName(product.getIno()); // 강사 번호로 이름 추출

        model.addAttribute("pro", product);
        model.addAttribute("inst", inst);
        return "member/myPage/lecVideo";
    }

    @RequestMapping(value = "/getLecVideo", method = RequestMethod.GET)
    public String getLecture(Model model, HttpServletRequest req) {
        String video = req.getParameter("sfile");

        model.addAttribute("video", video);
        return "myclass/lecVideo";
    }

    // 강의 정보 수정폼 이동
    @RequestMapping(value = "/updateLectureForm.do", method = RequestMethod.GET)
    public String updateLectureForm(Model model, @RequestParam("no") int no) {
        Lecture lecture = lectureService.getLecture(no); // 서비스 클래스에 비즈니스 로직을 정의하고 호출
        Instructor inst = instService.getInstructorName(lecture.getIno());
        List<String> lecFileList = new ArrayList<>();

        if(lecture.getSimg() != null && !lecture.getSimg().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSimg());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }

        if(lecture.getSfile1() != null && !lecture.getSfile1().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSfile1());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }


        if(lecture.getSfile2() != null && !lecture.getSfile2().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSfile2());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }


        if(lecture.getSfile3() != null && !lecture.getSfile3().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSfile3());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }


        if(lecture.getSfile4() != null && !lecture.getSfile4().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSfile4());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }


        if(lecture.getSfile5() != null && !lecture.getSfile5().equals("")) {
            String lecFile = lectureService.getLecFileName(lecture.getSfile5());
            lecFileList.add(lecFile);
        } else {
            lecFileList.add("");
        }

        model.addAttribute("lecFileList", lecFileList);
        model.addAttribute("instructor", inst);
        model.addAttribute("lecture", lecture);
        return "admin/updateLecture";
    }

    // 강의 정보 수정
    @RequestMapping(value = "/updateLecture.do", method = RequestMethod.POST)
    public String updateLecture(Model model, HttpServletRequest req) {
        MultipartHttpServletRequest files = (MultipartHttpServletRequest) req;

        // 파일 처리
        MultipartFile simg = files.getFile("simg");
        MultipartFile sfile1 = files.getFile("sfile1");
        MultipartFile sfile2 = files.getFile("sfile2");
        MultipartFile sfile3 = files.getFile("sfile3");
        MultipartFile sfile4 = files.getFile("sfile4");
        MultipartFile sfile5 = files.getFile("sfile5");

        // 기존의 값을 가져와서 수정된 정보들 대입
        Lecture lecture = lectureService.getLecture(Integer.parseInt(files.getParameter("no")));
        lecture.setCate(files.getParameter("cate"));
        lecture.setSlevel(files.getParameter("level1") + " " + files.getParameter("level2"));
        lecture.setTitle(files.getParameter("title"));
        lecture.setContent(files.getParameter("content").trim());
        lecture.setIno(Integer.parseInt(files.getParameter("ino")));

        // 개발 서버 파일 저장 경로
//        String uploadDir = "D:/spring_study/pro04/src/main/webapp/resources/upload/"; // 회사
        String uploadDir = "/Users/juncheol/Desktop/team_pro4/team14/src/main/webapp/resources/upload"; // 회사
        // String uploadDir = "E:/git/spring_study/pro04/src/main/webapp/resources/upload/"; // 집
        // 실제 서버 파일 저장 경로
        String uploadSev = req.getRealPath("/resources/upload/");

        // 기존 파일 이름 가져오기
        int no = lecture.getNo();
        Lecture lecture2 = lectureService.getLecture(no);

        if (!simg.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = simg.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSimg(RandomFileName);

            try {
//                simg.transferTo(new File(uploadDir + RandomFileName));
                simg.transferTo(new File(uploadSev + RandomFileName));
                int check = lectureService.selectLecFileCheck(lecture2.getSimg());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSimg());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile1.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile1.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile1(RandomFileName);

            try {
//                sfile1.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile1.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                int check = lectureService.selectLecFileCheck(lecture2.getSfile1());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSfile1());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile2.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile2.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile2(RandomFileName);

            try {
//                sfile2.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile2.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                int check = lectureService.selectLecFileCheck(lecture2.getSfile2());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSfile2());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile3.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile3.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile3(RandomFileName);

            try {
//                sfile3.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile3.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                int check = lectureService.selectLecFileCheck(lecture2.getSfile3());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSfile3());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile4.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile4.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile4(RandomFileName);

            try {
//                sfile4.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile4.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                int check = lectureService.selectLecFileCheck(lecture2.getSfile4());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSfile4());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile5.isEmpty()) {
            // 실제 파일 이름 db 저장
            LecFile lecFile = new LecFile();
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile5.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            lecture.setSfile5(RandomFileName);

            try {
//                sfile5.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile5.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                int check = lectureService.selectLecFileCheck(lecture2.getSfile5());
                if(check > 0) { // 이미 파일이 있는경우
                    int no2 = lectureService.selectLecFile(lecture2.getSfile5());
                    lecFile.setNo(no2);
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.updateLecFile(lecFile);
                } else { // 파일이 없는 경우
                    lecFile.setSfile(RandomFileName);
                    lecFile.setRealName(OriginalFilename);
                    lectureService.setLecFile(lecFile);
                }
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        lectureService.updateLecture(lecture);
        return "redirect:/lecture/getLecture?no=" + lecture.getNo();
    }

    // 강의 내역
    @RequestMapping(value = "/lecList", method = RequestMethod.GET)
    public String proList(Model model) {
        List<Lecture> productList = lectureService.getLectureList();// 서비스 클래스에 비즈니스 로직을 정의하고 호출
        model.addAttribute("lecList", productList);
        for (Lecture lec: productList) {
            System.out.println(lec.toString());
        }

        //좋아요한 상품 표시 기능 처리 부분
        //세션의 아이디값 가져오기
        String id = (String) session.getAttribute("sid");
        List<Integer> likedProductIds = lectureService.getLikedProductsByUser(id);
        model.addAttribute("likedProductIds", likedProductIds);

        return "lecture/lecList";
    }

    // 사용자 수강 내역
    @GetMapping("lecMemList.do")
    public String paymentList(Model model) throws Exception{
        DateCalculator dateCalculator = new DateCalculator();
        String id = (String) session.getAttribute("sid");
        List<Payment> payList =  paymentService.paymentMemList(id);
        List<PayCheck> payChecks = new ArrayList<>();
        List<Lecture> lecList = new ArrayList<>();
        List<Instructor> instList = new ArrayList<>();

        for (Payment pay: payList) {
            Lecture lec = lectureService.getLecture(pay.getLec_no());
            PayCheck check = new PayCheck();

            String startDate = "";

            String buyDate = pay.getBuydate(); // 사용자가 강의를 구매한 날
            if(buyDate!=null && !buyDate.equals("")) {
                int endDay = lec.getEndDay(); // 강의 정보에 게시된 수강일
                String endDate = dateCalculator.endDays(buyDate, endDay); // 마지막 날 구하기
                boolean ck1 = dateCalculator.isAfterEndDays(endDate); // 수강 가능 여부 확인
                long dDay = dateCalculator.daysRemainingInMonths(endDate); // 남은 일 수

                startDate = buyDate.split(" ")[0];

                check.setCheck(ck1);
                check.setDay(dDay);
                check.setValue(2);
                check.setStartDate(startDate);
                check.setEndDate(endDate);
            } else {
                check.setCheck(false);
                check.setDay(0);
                check.setValue(1);
                check.setStartDate(startDate);
                check.setEndDate("");
            }
            payChecks.add(check);

            // 강의 정보
            Lecture lecture = lectureService.getLecture(pay.getLec_no());
            lecList.add(lecture);

            // 강사 정보
            Instructor inst = instService.getInstructorName(lecture.getIno());
            instList.add(inst);
        }

        model.addAttribute("lecList", lecList);
        model.addAttribute("payList", payList);
        model.addAttribute("instList", instList);
        model.addAttribute("payChecks", payChecks);
        return "/member/myPage/lecMemList";
    }

    // 좋아요 목록
    @GetMapping("likeList.do")
    public String LikeList (HttpServletRequest req, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        List<LectureLikes> lectureLikes = lectureService.getByIdLikeList(id);
        List<Lecture> lectureList = new ArrayList<>();

        for (LectureLikes lec: lectureLikes) {
            lectureList.add(lectureService.getLecture(lec.getLno()));
        }

        model.addAttribute("lectureList", lectureList);
        model.addAttribute("likeList", lectureLikes);
        return "/member/myPage/likeList";
    }
    
    // 강의 좋아요
    @PostMapping("lectureLike.do")
    public void lectureLike(HttpServletResponse res, HttpServletRequest req, Model model) throws Exception {
        int lno = Integer.parseInt(req.getParameter("lno"));
        String id = req.getParameter("sid");

        LectureLikes lectureLikes = new LectureLikes();
        lectureLikes.setUserid(id);
        lectureLikes.setLno(lno);

        try {
            if(lectureService.checkLiked(lectureLikes) > 0) {
                lectureService.removeLike(lectureLikes);
                res.getWriter().write("unliked");
                req.setAttribute("isLiked", false);
            } else {
                lectureService.addLike(lectureLikes);
                res.getWriter().write("liked");
                req.setAttribute("isLiked", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("error");
        }
    }

    // 좋아요 삭제
    @GetMapping("delLike.do")
    public String delLike (HttpServletRequest req, Model model) throws Exception {
        int no = Integer.parseInt(req.getParameter("no"));
        String id = (String) session.getAttribute("sid");
        LectureLikes lectureLikes = new LectureLikes();
        lectureLikes.setLno(no);
        lectureLikes.setUserid(id);
        lectureService.removeLike(lectureLikes);
        return "redirect:/myclass/likeList.do";
    }
}
