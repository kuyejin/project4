package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Board;
import kr.ed.haebeop.domain.TestVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

// Mapper 인터페이스 + MyBatis Mapper
// test2Mapper.xml 의 안에 namespace 속성에 kr.ed.haebeop.persistence.TestMapper
// test2Mapper.xml 의 안에 명령 tag 의 id 와 kr.ed.haebeop.persistence.TestMapper

@Mapper
public interface TestMapper2 {

    @Select("select * from board where ${field} like '%${query}' order by regdate desc limit #{offset}, #{size}")
    public List<Board> getBoardList(int offset, int size, String field, String query);

    @Select("SELECT * FROM test")
    public List<TestVO> testList3();

    @Select("SELECT * FROM test WHERE num = #{num}")
    public TestVO getTest3(int id);

    @Insert("INSERT into test (title) VALUES (#{title})")
    @Options(useGeneratedKeys=true, keyProperty="num")
    public void insert3(TestVO test);

    @Update("UPDATE test SET title = #{title} WHERE num = #{num}")
    public void update3(TestVO test);

    @Delete("DELETE FROM test WHERE num = #{num}")
    public void delete3(int num);
}
