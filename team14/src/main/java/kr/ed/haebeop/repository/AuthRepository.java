package kr.ed.haebeop.repository;

import java.util.List;

public interface AuthRepository {

    List<String> getAuthList(int state_cd) throws Exception;

}
