package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Cart;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CartMapper {
    @Select("SELECT * FROM cart WHERE id = #{id}")
    public List<Cart> cartList(String id);
    @Insert("INSERT INTO cart (id, lec_no) VALUES (#{id}, #{lec_no})")
    @Options(useGeneratedKeys=true, keyProperty="cartno")
    public void cartInsert(Cart cart);
    @Delete("DELETE FROM cart WHERE cartno = #{cartno}")
    public void cartDelete(int cartno);
    @Select("SELECT COUNT(*) FROM cart WHERE id = #{id}")
    public int cartCnt(String id);
    @Select("SELECT COUNT(*) FROM cart WHERE id = #{id} AND lec_no = #{lec_no}")
    public int getCartCheck(Cart cart);
    @Select("SELECT cartno FROM cart WHERE id = #{id} AND lec_no = #{lec_no}")
    public int getCart(Cart cart);
}
