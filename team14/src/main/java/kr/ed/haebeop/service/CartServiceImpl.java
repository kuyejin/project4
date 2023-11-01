package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Cart;
import kr.ed.haebeop.persistence.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl {
    @Autowired
    private CartMapper cartMapper;
    public List<Cart> cartList(String id) {
        return cartMapper.cartList(id);
    }
    public void cartInsert(Cart cart) {
        cartMapper.cartInsert(cart);
    }
    public void cartDelete(int cartno){
        cartMapper.cartDelete(cartno);
    }
    public int cartCnt(String id){
        return cartMapper.cartCnt(id);
    }
    public int getCartCheck(Cart cart){
        System.out.println("service 실행");
        return cartMapper.getCartCheck(cart);
    }
    public int getCart(Cart cart) {return cartMapper.getCart(cart);}
}
