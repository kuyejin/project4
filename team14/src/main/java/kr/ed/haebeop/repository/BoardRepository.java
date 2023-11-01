package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.Like;
import kr.ed.haebeop.domain.Report;

import java.util.List;

public interface BoardRepository {
    public List<Board> boardList() throws Exception;
    public Board boardDetail(int bno) throws Exception;
    public void boardInsert(Board dto) throws Exception;
    public void boardDelete(int bno) throws Exception;
    public void boardEdit(Board dto) throws Exception;
    public void commentInsert(Board dto) throws Exception;
    public List<Board> commentList(int bno) throws Exception;
    public void commentDeleteAll(int bno) throws Exception;
    public List<Board> allCommentList() throws Exception;
    void reportBoard(Report report) throws Exception;
    int checkReported(Report report) throws Exception;
    public List<Board> boardReportList() throws Exception;
    public List<Board> recentReportList() throws Exception;

    public int cntReport(int bno) throws Exception;
    public int checkLiked(Like like) throws Exception;
    public void removeLike(Like like) throws Exception;
    public void addLike(Like like) throws Exception;
    public List<Board> boardLikeList(String id) throws Exception;

    public boolean getReadable(int bno) throws Exception;
    public void readableEdit(Board bno) throws Exception;

    void countUp(int bno) throws Exception;
}
