package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.TestVO;

import java.util.List;

public interface TestService {
    public List<TestVO> testList() throws Exception;
    public TestVO getTest(int num) throws Exception;
    public void testInsert(TestVO test) throws Exception;

    public List<TestVO> testList2();
    public TestVO getTest2(int num);
    public void insert2(TestVO test);
    public void update2(TestVO test);
    public void delete2(int num);
}
