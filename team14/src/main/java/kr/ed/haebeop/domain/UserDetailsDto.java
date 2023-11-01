package kr.ed.haebeop.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class UserDetailsDto implements UserDetails {

    private String email;
    private String pwd;
    private boolean enabled;
    private ArrayList<GrantedAuthority> authority;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authority;
    }

    public void setAuthority(ArrayList<String> authList) {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        for(int i=0;i<authList.size();i++) {
            auth.add(new SimpleGrantedAuthority(authList.get(i)));
        }
        this.authority=auth;
    }

    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return pwd;
    }

    public void setPassword(String password) {
        pwd = password;
    }

    public void setEnabled(boolean isEnabled) { enabled = isEnabled; }

    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return enabled;
    }
}
