package kr.ed.haebeop.domain;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import kr.ed.haebeop.api.NaverOAuthApi;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.UUID;

@NoArgsConstructor
@Data
@Component
@PropertySource("classpath:api_info.properties")
public class NaverLoginBo { //    business object

    @Value("${naver.clientId}")
    private String clientId;

    @Value("${naver.clientSecret}")
    private String clientSecret;

    @Value("${naver.redirectUri}")
    private String redirectUri;

    @Value("${naver.sessionState}")
    private String sessionState;

    @Value("${naver.profileApiUrl}")
    private String profileApiUrl;


    public String getAuthorizationUrl(HttpSession session) {
        String state = generateRandomString();
        setSession(session, state);

        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(clientId)
                .apiSecret(clientSecret)
                .callback(redirectUri)
                .state(state)
                .build(NaverOAuthApi.instance()); //BO

        return oauthService.getAuthorizationUrl();
    }

    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws Exception {

        if (StringUtils.pathEquals(getSession(session), state)) {
            OAuth20Service oauthService = new ServiceBuilder()
                    .apiKey(clientId)
                    .apiSecret(clientSecret)
                    .callback(redirectUri)
                    .state(state)
                    .build(NaverOAuthApi.instance()); //BO

            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            return accessToken;
        }
        return null;
    }

    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    private void setSession(HttpSession session, String state) {
        session.setAttribute(sessionState, state);
    }

    private String getSession(HttpSession session) {
        return (String) session.getAttribute(sessionState);
    }

    public String getUserProfile(OAuth2AccessToken oauthToken) throws Exception {

        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(clientId)
                .apiSecret(clientSecret)
                .callback(redirectUri).build(NaverOAuthApi.instance()); //BO

        OAuthRequest request = new OAuthRequest(Verb.GET, profileApiUrl, oauthService);
        oauthService.signRequest(oauthToken, request);
        Response response = request.send();
        return response.getBody();
    }
}