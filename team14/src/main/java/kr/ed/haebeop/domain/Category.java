package kr.ed.haebeop.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

//카테고리
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Category {
    // 초등: 초등, 중등:중등, 고등:고등
    private String cno;
    private String cname;   //카테고리명
}
