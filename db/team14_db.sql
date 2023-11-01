-- pro04

-- 핵심기능 : 공지사항, 자료실, 회원, 자유게시판, 강의별 댓글, 교재와 시범강의

-- 부가기능 : 파일업로드, 채팅 및 쪽지, 타계정 또는 SNS로 로그인, 수강평, 달력
-- 가입시 축하 메일 보내기, 비밀번호 변경시 이메일 보내기
-- 온라인 평가, 진도 관리 등


CREATE DATABASE haebeop;

USE haebeop

DROP TABLE MEMBER;
-- 회원(아이디, 비밀번호, 이름, 이메일, 전화번호, 주소1, 주소2, 우편번호, 가입일, 생년월일, 점수, 방문횟수, 직업)
CREATE TABLE member(
	id VARCHAR(20) PRIMARY KEY, -- 아이디
	pw VARCHAR(350) NOT NULL, -- 비밀번호
	NAME VARCHAR(50) NOT NULL, -- 이름
	email VARCHAR(150), -- 이메일
	tel VARCHAR(20), -- 전화번호
	addr1 VARCHAR(200), -- 주소1
	addr2 VARCHAR(200), -- 주소2
	postcode VARCHAR(20), -- 우편번호
	regdate DATETIME DEFAULT CURRENT_TIME, -- 가입일
	birth DATE DEFAULT CURRENT_TIME, -- 생년월일
	pt INT DEFAULT 0, -- 점수(포인트)
	cnt INT DEFAULT 0, -- 방문횟수,
	login_tp_cd INT DEFAULT 1, -- 로그인 타입 1: 일반 2: 카카오 3: 네이버
	state_cd INT DEFAULT 1, -- 상태코드 1: 정상 2: 신고정지 3: 탈퇴 4: 휴면
	job INT DEFAULT 1
);
-- ALTER TABLE member add COLUMN job INT;

-- 로그인 타입 1: 일반 2: 카카오 3: 네이버
-- ALTER TABLE member ADD login_tp_cd INT DEFAULT 1;
-- 상태코드 1: 정상 2: 신고정지 3: 탈퇴 4: 휴면
-- ALTER TABLE member ADD state_cd INT DEFAULT 1;

-- 관리자
INSERT INTO member VALUES(
'admin', '1234', '관리자', 'admin@edu.com', '010-1234-5678', 
	'경기 성남시 분당구 대왕판교로 477', '102호', '13480', DEFAULT, '1980-04-22',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT, 0);

-- 일반 회원
INSERT INTO member VALUES(
'oh1234', '1234', '오세훈', 'do11anm@naver.com', '010-1234-5678', 
	'경기 성남시 분당구 대왕판교로 477', '102호', '13480', DEFAULT, '1998-04-22',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1);
INSERT INTO member VALUES(
'hong', '1234', '홍길동', 'hong@edu.com', '010-2222-3333', 
	'경기 성남시 분당구 대왕판교로 477', '102호', '13480', DEFAULT, '1980-04-22',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1);
	INSERT INTO member VALUES(
'kang', '1234', '강감찬', 'kang@edu.com', '010-1212-1212', 
	'경기 성남시 분당구 대왕판교로 477', '102호', '13480', DEFAULT, '1975-04-22',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1);

-- 비밀번호 1234 spring 암호화 버전
UPDATE member SET pw='$2a$10$3zl8fmNyd1IsP1Ru0TNVee9AMtpM9E7yz5ZR9Qiofbj8zqqjJiqIi' WHERE pw='1234';

-- 자유 게시판
CREATE TABLE board(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(1000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	lev INT DEFAULT 0, -- 게시글 0, 답글 1 이상
	par INT, -- 부모 게시글 번호
	readable boolean default false,
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE 		
		CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

INSERT INTO board(title, content, author) VALUES('본문 제목1', '본문 내용1', 'admin');
UPDATE board SET par=bno WHERE bno=1;
INSERT INTO board(title, content, author) VALUES('본문 제목2', '본문 내용2', 'hong'); 
UPDATE board SET par=bno WHERE bno=2;
INSERT INTO board(title, content, author) VALUES('본문 제목3', '본문 내용3', 'kang');
UPDATE board SET par=bno WHERE bno=3;
INSERT INTO board(title, content, author) VALUES('본문 제목4', '본문 내용4', 'lee');
UPDATE board SET par=bno WHERE bno=4;
INSERT INTO board(title, content, author) VALUES('본문 제목5', '본문 내용5', 'son');
UPDATE board SET par=bno WHERE bno=5;
INSERT INTO board(title, content, author) VALUES('본문 제목6', '본문 내용6', 'hong');
UPDATE board SET par=bno WHERE bno=6; 
INSERT INTO board(title, content, author) VALUES('본문 제목7', '본문 내용7', 'hong');
UPDATE board SET par=bno WHERE bno=7; 
INSERT INTO board(title, content, author) VALUES('본문 제목8', '본문 내용8', 'hong');
UPDATE board SET par=bno WHERE bno=8; 
INSERT INTO board(title, content, author) VALUES('본문 제목9', '본문 내용9', 'hong');
UPDATE board SET par=bno WHERE bno=9; 
INSERT INTO board(title, content, author) VALUES('본문 제목10', '본문 내용10', 'hong');
UPDATE board SET par=bno WHERE bno=10; 

INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 7);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 7);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 6);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 5);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 4);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 3);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 2);
INSERT INTO board(title, content, author, lev, par) VALUES('댓글', '댓글내용', 'admin', 1, 1);

select * from board where par = 7 and lev = 1 order by resdate DESC;

-- 공지사항(notice) 테이블 생성
create table notice(
	no int primary KEY AUTO_INCREMENT, -- notice 글 번호
	title varchar(200) not NULL,	-- 제목
	content varchar(1000), -- 내용
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt int DEFAULT 0 -- 조회수
);

-- 공지사항 더미글 추가 10건
INSERT INTO notice(title, content) VALUES ('공지사항1', '공지사항1 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항2', '공지사항2 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항3', '공지사항3 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항4', '공지사항4 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항5', '공지사항5 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항6', '공지사항6 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항7', '공지사항7 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항8', '공지사항8 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항9', '공지사항9 더미글입니다.');
INSERT INTO notice(title, content) VALUES ('공지사항10', '공지사항10 더미글입니다.');


-- 자주 묻는 질문 (FAQ) 테이블 생성
CREATE TABLE faq (
    fno int PRIMARY KEY AUTO_INCREMENT, -- faq 글 번호
    question VARCHAR(1000) NOT NULL, -- 질문
    answer VARCHAR(1000) NOT NULL -- 답변
);

INSERT INTO faq(question, answer) VALUES('자주 묻는 질문1', '자주 묻는 질문1 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문2', '자주 묻는 질문2 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문3', '자주 묻는 질문3 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문4', '자주 묻는 질문4 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문5', '자주 묻는 질문5 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문6', '자주 묻는 질문6 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문7', '자주 묻는 질문7 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문8', '자주 묻는 질문8 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문9', '자주 묻는 질문9 더미글입니다.');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문10', '자주 묻는 질문10 더미글입니다.');


-- 대외활동 정보
CREATE TABLE info_act(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- qna 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(2000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	rec INT DEFAULT 0,
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE 		
		CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

-- 학습 정보
CREATE TABLE info_stu(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- qna 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(2000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	rec INT DEFAULT 0,
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE 		
		CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

-- 대학 정보
CREATE TABLE info_uni(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- qna 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(2000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	rec INT DEFAULT 0,
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

-- qna
CREATE TABLE qna(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- qna 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(1000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	lev INT DEFAULT 0, -- 게시글 0, 답글 1 이상
	par INT, -- 부모 게시글 번호
	pw VARCHAR(330), -- 비밀글, 비밀번호
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE 		
		CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

-- 자료실 db
CREATE TABLE fileobj (
	no int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	postno INT NOT NULL,
	savefolder VARCHAR(400),
	originfile VARCHAR(400),
	savefile VARCHAR(800),
	filesize LONG,
	uploaddate VARCHAR(100)
);

CREATE TABLE fileboard (
	postno int NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- 글 번호
	title VARCHAR(100) not null,   -- 글제목
	content VARCHAR(1500) not null,    -- 글내용
	regdate DATETIME DEFAULT CURRENT_TIMESTAMP(),   -- 작성일
	visited INT DEFAULT 0   -- 조회수
);

-- 성적 게시판
-- DROP TABLE grade;
CREATE TABLE grade( 
	no INTEGER auto_increment PRIMARY KEY,
	stuname VARCHAR(150) NOT NULL ,
	stuid VARCHAR(150) NOT null ,
	kor INTEGER ,
	math INTEGER,
	eng INTEGER ,
	social INTEGER ,
	science INTEGER ,
	exam VARCHAR(80),
	tname VARCHAR(150),
	tid VARCHAR(150),
	regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
						
-- stuname : 학생 이름, stuid: 학생 아이디, exam : 시험 유형(?), tname: 선생님 성함, stuid: 선생님 아이디 
						  
DROP TABLE grade;

-- grade 더미 데이터
INSERT INTO grade VALUES(DEFAULT, '홍길동', 'hong', 90, 50, 50, 50, 50, '1학기 중간고사', '손흥민','son', DEFAULT);
INSERT INTO grade VALUES(DEFAULT, '강감찬', 'kang', 90, 50, 50, 50, 50, '1학기 중간고사', '손흥민','son', DEFAULT);
INSERT INTO grade VALUES(DEFAULT, '강감찬', 'kang', 90, 50, 50, 50, 50, '2학기 중간고사', '손흥민','son', DEFAULT);
INSERT INTO grade VALUES(DEFAULT, '강감찬', 'kang', 90, 50, 50, 50, 50, '1학기 기말고사', '손흥민','son', DEFAULT);

SELECT * FROM grade WHERE stuid='kang';

-- 관리자 게시판 관리 테이블
CREATE TABLE report (
    report_id INT PRIMARY KEY AUTO_INCREMENT, -- 신고 번호
    board_bno INT, -- 게시글 번호
    reporter VARCHAR(16), -- 신고자
    reason VARCHAR(255), -- 이유
    report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 신고일
    FOREIGN KEY(board_bno) REFERENCES board(bno) ON DELETE CASCADE,
    FOREIGN KEY(reporter) REFERENCES member(id) ON DELETE CASCADE
);

-- 강사, 선생님 테이블
CREATE TABLE instructor(
	NO INT PRIMARY KEY AUTO_INCREMENT, -- 선생님 번호
	NAME VARCHAR(10), -- 선생님 이름
	tel VARCHAR(20), -- 선생님 전화번호
	email VARCHAR(100), -- 선생님 이메일
	intro VARCHAR(1000), -- 선생님 소개글
	cate VARCHAR(20), -- 선생님 담당 과목
	img VARCHAR(1000), -- 선생님 프로필 이미지
	id VARCHAR(50), -- 선생님 아이디
	FOREIGN KEY(id) REFERENCES member(id) ON DELETE 		
		CASCADE -- 선생님 아이디 외래키
);

-- instructor 선생님 테이블 컬럼 추가
--  ALTER TABLE instructor
-- ADD COLUMN id VARCHAR(50);
-- ADD FOREIGN KEY (id) REFERENCES member(id);

INSERT INTO instructor VALUES(DEFAULT, '강감찬', '01011111111', 'kang@edu.com');
INSERT INTO instructor VALUES(DEFAULT, '홍길동', '01022222222', 'hong@edu.com');
INSERT INTO instructor VALUES(DEFAULT, '이순신', '01033333333', 'lee@edu.com');

-- 강의
CREATE TABLE lecture(
	NO INT PRIMARY KEY AUTO_INCREMENT, -- 강의 번호
	cate VARCHAR(100), -- 과목 (국어, 수학, 영어, ...)
	slevel VARCHAR(100), -- 수강 레벨, 분류 ex(중학교 1학년, 고등학교 3학년 등등..)
	title VARCHAR(200) NOT NULL, -- 강의 제목
	content VARCHAR(2000), -- 강의 소개 글
	simg VARCHAR(1000), -- 목록 프로필 이미지
	sfile1 VARCHAR(1000), -- ot 영상
	sfile2 VARCHAR(1000), -- 강의 영상1
	sfile3 VARCHAR(1000), -- 강의 영상2
	sfile4 VARCHAR(1000), -- 강의 영상3
	sfile5 VARCHAR(1000), -- 강의 영상4
	price INT NOT NULL, -- 강의 가격
	ino INT, -- 강사코드(FK)
	cnt INT DEFAULT 0, -- 조회수
	lec INT DEFAULT 0, -- 현재 수강인원
	lec_max INT, -- 최대 수강인원
	aplctClss1 DATE, -- 수강신청 시작일
	aplctClss2 DATE, -- 수강신청 종료일
	studystart DATE, -- 강의 시작일
	studyend DATE, -- 강의 종료일
	endday INT, -- 강의 수강 기간일 지정 (ex 100, 80) 일
	FOREIGN KEY(ino) REFERENCES instructor(NO) -- 강사 번호를 외래키로 사용
);
-- UPDATE lecture SET endday = 100; 

-- 추천(좋아요) 기능 테이
create table lecturelikes (
    userid VARCHAR(20) NOT NULL,      -- 사용자 ID
    lno INT NOT NULL,           -- 강의 no 
    liketime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 좋아요를 누른 시간
    PRIMARY KEY (userid, lno)   -- 사용자 ID와 게시글 no 조합으로 각 레코드를 유일하게 식별
);

-- 강의 리뷰
CREATE TABLE review(
    NO INT AUTO_INCREMENT PRIMARY KEY, -- 번호
    id VARCHAR(20) NOT NULL, -- 작성 아이디
    content VARCHAR(300) NOT NULL, -- 후기
    resdate timestamp DEFAULT CURRENT_TIMESTAMP(), -- 작성일
    score INT CHECK (score >= 1 AND score <= 5), -- 점수 (1부터 5까지의 정수)
    par INT, -- 강의 번호
    FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE -- 회원 아이디를 외래키로 선언
);

-- 관리자 댓글 관리 테이블
CREATE TABLE report_rev (
    report_id INT PRIMARY KEY AUTO_INCREMENT, -- 신고 번호
    board_bno INT, -- 댓글 번호
    reporter VARCHAR(16), -- 신고자
    reason VARCHAR(255), -- 이유
    report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 신고일
    FOREIGN KEY(board_bno) REFERENCES review(no) ON DELETE CASCADE,
    FOREIGN KEY(reporter) REFERENCES member(id) ON DELETE CASCADE
);

-- 실제 파일 이름 저장 경로
CREATE TABLE lecfile (
	NO INT PRIMARY KEY AUTO_INCREMENT, -- 번호
	sfile VARCHAR(1000), -- 난수화된 파일 이름
	realname VARCHAR(250) -- 실제 파일 이름
)

-- 장바구니 테이블
CREATE TABLE cart(
	cartno INT PRIMARY KEY AUTO_INCREMENT, -- 장바구니 번호
	id VARCHAR(20), -- 아이디
	lec_no INT, -- 강의 번호
	FOREIGN KEY(lec_no) REFERENCES lecture(NO) ON DELETE CASCADE,  -- 강의 번호를 외래키로 받음
	FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE -- 회원 아이디를 외래키로 받음
	)

-- 결제 내역(수강 신청, 강의 구매 내역)
CREATE TABLE payment(
	sno INT PRIMARY KEY AUTO_INCREMENT, -- (수강신청, 결제 내역 번호)
	id VARCHAR(20), -- 구매자 id(FK)
	lec_no INT, -- 강의 번호(FK)
	lec_name VARCHAR(200), -- 강의 이름
	pmethod VARCHAR(500), -- 결제 방법
	pcom VARCHAR(500), -- 결제 대행
	cnum VARCHAR(500), -- 결제번호
	price INT, -- 가격
	state INT DEFAULT 0, -- 상태 (1이 되면 구매 확정이 되면서 수강 신청 내역으로 넘어감)
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 결제 일
	buydate TIMESTAMP, -- 구매 확정 일
	pt int, -- 결제 하면서 사용한 포인트
	enddate TIMESTAMP, -- 수강일 한도
	FOREIGN KEY(lec_no) REFERENCES lecture(NO),
	FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE
);
-- ALTER table payment ADD COLUMN enddate TIMESTAMP;

-- 추천(좋아요) 기능 테이
create table boardlikes (
    userid VARCHAR(20) NOT NULL,      -- 사용자 ID
    boardno INT NOT NULL,           -- 게시글 no 
    liketime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 좋아요를 누른 시간
    PRIMARY KEY (userid, boardno)   -- 사용자 ID와 게시글 no 조합으로 각 레코드를 유일하게 식별
);

-- course 테이블에 데이터 타입 수정
CREATE TABLE course(
	NO INT PRIMARY KEY AUTO_INCREMENT,
	lec_no INT, -- 강의코드(FK)
	sid VARCHAR(20), -- 학생아이디(FK)
	ctime INT DEFAULT 0, -- 수강 총 시간 
	CHECK1 int default 1, -- 1:수강 중, 2.수강정지 3.수강완료
	FOREIGN KEY(lec_no) REFERENCES lecture(no), 
	FOREIGN KEY(sid) REFERENCES member(id)
	);

-- myclass 뷰테이블 추가 (나의 학습방 데이터) 
-- myclass 뷰 생성
DROP VIEW myclass; 
CREATE VIEW myclass AS
SELECT DISTINCT
    p.id AS id, 
    p.lec_no AS lec_no, 
    l.cate AS lecCate, 
	ins.name as insname,
	l.slevel AS slevel,
    l.title AS lecTitle, 
	l.content AS lecContent,
    p.buydate AS lecStudystart, 
    p.enddate AS lecStudyend,  
    c.CHECK1 AS ck
FROM 
    course c
JOIN 
    lecture l ON c.lec_no = l.NO     
JOIN 
    instructor ins ON l.ino = ins.NO
LEFT JOIN
    payment p ON p.lec_no = l.NO
WHERE p.id IS NOT NULL AND p.buydate IS NOT NULL AND p.enddate IS NOT NULL GROUP BY p.id, p.lec_no;

create table calendar(
	no INTEGER AUTO_INCREMENT PRIMARY KEY,
	id VARCHAR(100) NOT null,
	groupId integer,
	title varchar(50) NOT null,
	writer varchar(50),
	content varchar(1000),
	start date,
	end date,
	textColor varchar(50),
	backgroundColor varchar(50),
	borderColor varchar(50)
);

-- 캘린더 더미 데이터
INSERT INTO calendar(id, groupId, title, writer, content, START, END, textColor, backgroundColor, borderColor) VALUES ('kang', 1, 'hello', '강감찬', '더미내용', '2023-10-01', '2023-10-18', 'black', 'white', 'black');

-- 강의 배정
-- 과목, 강사, 교재 정보를 강의 테이블에 등록하는 행위
-- 하나의 과목당 여러 강의를 모두 등록해야한다.


-- 수강 신청
-- 강의 정보를 보고, 학생이 수강 신청을 하는 행위,
-- 학생별로 모든 강의 정보가 등록되어야 하며, 
-- 만약 수강신청시 수강인원이 초과될 경우 수강신청을 할 수 없다.


-- 선생님 공지
create table instructornotice(
	no int primary KEY AUTO_INCREMENT, -- notice 글 번호
	title varchar(200) not NULL,	-- 제목
	content varchar(1000), -- 내용
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt int DEFAULT 0, -- 조회수
	instructorno int,
	FOREIGN KEY(instructorno) REFERENCES instructor(no) ON DELETE CASCADE
);

-- 선생님 QNA
CREATE TABLE instructorqna(
	bno INT PRIMARY KEY AUTO_INCREMENT, -- qna 글 번호
	title VARCHAR(200) NOT NULL, -- 제목
	content VARCHAR(1000), -- 내용
	author VARCHAR(16), -- 작성자
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt INT DEFAULT 0, -- 조회수
	lev INT DEFAULT 0, -- 게시글 0, 답글 1 이상
	par INT, -- 부모 게시글 번호
	pw VARCHAR(330), -- 비밀글, 비밀번호
	instructorno int, -- 선생님 구분값 
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE 		
		CASCADE -- 작성자를 member id를 이용해 외래키로 사용
);

-- 선생님 자료실 
CREATE TABLE instructorfile(
	NO INT PRIMARY KEY AUTO_INCREMENT, -- 
	title VARCHAR(200) NOT NULL, -- 
	content VARCHAR(2000), --
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(), -- 작성일
	cnt int DEFAULT 0, -- 조회수
	sfile1 VARCHAR(1000), -- 
	sfile2 VARCHAR(1000), -- 
	sfile3 VARCHAR(1000), --
	instructorno int,
	FOREIGN KEY(instructorno) REFERENCES instructor(NO) -- 강사 번호를 외래키로 사용
);
-- 선생님 자료실 파일
CREATE TABLE instfile (
	NO INT PRIMARY KEY AUTO_INCREMENT, -- 번호
	sfile VARCHAR(1000), -- 난수화된 파일 이름
	realname VARCHAR(250) -- 실제 파일 이름
)
