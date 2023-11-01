package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.TestVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

// Mapper 인터페이스 + MyBatis Mapper
// test2Mapper.xml 의 안에 namespace 속성에 kr.ed.haebeop.persistence.TestMapper
// test2Mapper.xml 의 안에 명령 tag 의 id 와 kr.ed.haebeop.persistence.TestMapper

@Mapper
public interface TestMapper {
    public List<TestVO> testList() throws Exception;
    public TestVO getTest(int num) throws Exception;
    public void testInsert(TestVO test) throws Exception;
    public List<TestVO> testList2();
    public TestVO getTest2(int num);
    public void insert2(TestVO test);
    public void update2(TestVO test);
    public void delete2(int num);
}
