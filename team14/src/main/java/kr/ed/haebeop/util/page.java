package kr.ed.haebeop.util;

import lombok.Data;

@Data
public class page {
    private int offset;
    private int size; // 한페이지에 게시글 수
    private int curpage; //페이비 번호


    public void generateOffset(){
            this.generateOffset(this.curpage,this.size);
    }
    public void generateOffset(int curpage, int size){
        this.size = size;
        this.curpage = curpage;
        this.offset = curpage * size - (size - 1);
    }
}
