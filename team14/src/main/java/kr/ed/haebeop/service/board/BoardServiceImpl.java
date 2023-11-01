package kr.ed.haebeop.service.board;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.Like;
import kr.ed.haebeop.domain.Report;
import kr.ed.haebeop.repository.BoardRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    private BoardRepositoryImpl boardRepository;

    @Override
    public List<Board> boardList() throws Exception {
        return boardRepository.boardList();
    }

    @Override
    public Board boardDetail(int bno) throws Exception {
        return boardRepository.boardDetail(bno);
    }

    @Override
    public void boardInsert(Board dto) throws Exception {
        boardRepository.boardInsert(dto);
    }

    @Override
    public void boardDelete(int bno) throws Exception {
        boardRepository.boardDelete(bno);
    }

    @Override
    public void boardEdit(Board dto) throws Exception {
        boardRepository.boardEdit(dto);
    }

    @Override
    public void countUp(int bno) throws Exception {
        boardRepository.countUp(bno);
    }

    @Override
    public List<Board> commentList(int bno) throws Exception {
        return boardRepository.commentList(bno);
    }

    @Override
    public void commentInsert(Board dto) throws Exception {
        boardRepository.commentInsert(dto);
    }

    @Override
    public void commentDeleteAll(int bno) throws Exception {
        boardRepository.commentDeleteAll(bno);
    }
    @Override
    public List<Board> allCommentList() throws Exception {
        return boardRepository.allCommentList();
    }

    @Override
    public void reportBoard(Report report) throws Exception {
        boardRepository.reportBoard(report);
    }
    @Override
    public int checkReported(Report report) throws Exception {
        return boardRepository.checkReported(report);
    }

    @Override
    public List<Board> boardReportList() throws Exception {
        return boardRepository.boardReportList();
    }

    @Override
    public List<Board> recentReportList() throws Exception {
        return boardRepository.recentReportList();
    }

    @Override
    public int cntReport(int bno) throws Exception {
        return boardRepository.cntReport(bno);
    }
    @Override
    public int checkLiked(Like like) throws Exception {
        return boardRepository.checkLiked(like);
    }

    @Override
    public void removeLike(Like like) throws Exception {
        boardRepository.removeLike(like);
    }

    @Override
    public void addLike(Like like) throws Exception {
        boardRepository.addLike(like);
    }

    @Override
    public List<Board> boardLikeList(String id) throws Exception {
        return boardRepository.boardLikeList(id);
    }

    @Override
    public boolean getReadable(int bno) throws Exception {
        return boardRepository.getReadable(bno);
    }

    @Override
    public void readableEdit(Board bno) throws Exception{
         boardRepository.readableEdit(bno);
    }
}
