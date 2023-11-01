package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.TestVO;
import kr.ed.haebeop.persistence.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestServiceImpl implements TestService {

    @Autowired
    private TestMapper testMapper;

    @Override
    public List<TestVO> testList() throws Exception {
        return testMapper.testList();
    }

    @Override
    public TestVO getTest(int num) throws Exception {
        return testMapper.getTest(num);
    }

    @Override
    public void testInsert(TestVO test) throws Exception {
        testMapper.testInsert(test);
    }

    @Override
    public List<TestVO> testList2() {
        return testMapper.testList2();
    }

    @Override
    public TestVO getTest2(int num) {
        return null;
    }

    @Override
    public void insert2(TestVO test) {

    }

    @Override
    public void update2(TestVO test) {

    }

    @Override
    public void delete2(int num) {

    }
}
