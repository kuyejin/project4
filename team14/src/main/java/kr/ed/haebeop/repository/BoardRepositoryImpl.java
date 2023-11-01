package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.Like;
import kr.ed.haebeop.domain.Report;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardRepositoryImpl implements BoardRepository {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Board> boardList() throws Exception {
        return sqlSession.selectList("board.boardList");
    }

    @Override
    public Board boardDetail(int bno) throws Exception {
//        sqlSession.update("board.countUp", bno); // 이건 나중에 서비스 쪽에 넣어라
        return sqlSession.selectOne("board.boardDetail", bno);
    }

    @Override
    public void countUp(int bno) throws Exception {
        sqlSession.update("board.countUp",bno);
    }

    @Override
    public void boardInsert(Board dto) throws Exception {
        sqlSession.insert("board.boardInsert", dto);
    }

    @Override
    public void boardDelete(int bno) throws Exception {
        sqlSession.delete("board.boardDelete", bno);
    }

    @Override
    public void boardEdit(Board dto) throws Exception {
        sqlSession.update("board.boardEdit", dto);
    }

    @Override
    public void commentInsert(Board dto) throws Exception {
        sqlSession.insert("board.commentInsert", dto);
    }

    @Override
    public List<Board> commentList(int bno) throws Exception {
        return sqlSession.selectList("board.commentList", bno);
    }

    @Override
    public void commentDeleteAll(int bno) throws Exception {
        sqlSession.delete("board.commentDeleteAll", bno);
    }
    @Override
    public List<Board> allCommentList() throws Exception {
        return sqlSession.selectList("board.allCommentList");
    }
    @Override
    public void reportBoard(Report report) throws Exception {
        sqlSession.insert("board.reportBoard", report);
    }

    @Override
    public int checkReported(Report report) throws Exception {
        return sqlSession.selectOne("board.checkReported",report);
    }

    @Override
    public List<Board> boardReportList() throws Exception {
        return sqlSession.selectList("board.boardReportList");
    }

    @Override
    public List<Board> recentReportList() throws Exception {
        return sqlSession.selectList("board.recentReportList");
    }

    @Override
    public int cntReport(int bno) throws Exception {
        return sqlSession.selectOne("board.cntReport",bno);
    }
    @Override
    public int checkLiked(Like like) throws Exception {
        return sqlSession.selectOne("board.checkLiked", like);
    }

    @Override
    public void removeLike(Like like) throws Exception {
        sqlSession.delete("board.removeLike", like);
    }

    @Override
    public void addLike(Like like) throws Exception {
        sqlSession.insert("board.addLike", like);
    }

    @Override
    public List<Board> boardLikeList(String id) throws Exception {
        return sqlSession.selectList("board.boardLikeList",id);
    }

    @Override
    public boolean getReadable(int bno) throws Exception {
        return sqlSession.selectOne("board.getReadable" , bno);
    }

    @Override
    public void readableEdit(Board bno) throws Exception {
        sqlSession.update("board.readableEdit", bno);
    }
}
