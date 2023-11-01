package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Menu;

public interface MenuRepository {
    public Menu getMenu(String sc_name);
}
