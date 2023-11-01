package kr.ed.haebeop.util;

public class Utils {

    //공통 함수
    public String createRandomStr() {
        String pwd = "";
        for (int i = 0; i < 12; i++) {
            pwd += (char) ((Math.random() * 26) + 97);
        }
        return pwd;
    }
}
