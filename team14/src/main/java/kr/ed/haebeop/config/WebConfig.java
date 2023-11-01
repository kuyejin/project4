package kr.ed.haebeop.config;

import kr.ed.haebeop.exception.UncheckException;
import kr.ed.haebeop.util.AdminInterceptor;
import kr.ed.haebeop.util.UserInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import java.util.Properties;

// web.xml에 적용 했던 것들을 여기에 자바로 적용

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"kr.ed.haebeop"})
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer implements WebMvcConfigurer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] {RootConfig.class, SecurityConfig.class };
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] {ServletContext.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] {"/"};
    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        return new Filter[] {characterEncodingFilter};
    }
    
    @Bean // 회원 접근 권한
    public UserInterceptor userIntercepter() {
        return new UserInterceptor();
    }

    @Bean // 관리자 접근 권한
    public AdminInterceptor adminIntercepter() {
        return new AdminInterceptor();
    }
    
    // 접근 권한 위치 지정
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userIntercepter())
                .addPathPatterns("/boardPar/**").addPathPatterns("/boardTea/**")
                .addPathPatterns("/file/**").addPathPatterns("/infoAct/**")
                .addPathPatterns("/infoStu/**").addPathPatterns("/infoUni/**")
                .addPathPatterns("/grade/**").addPathPatterns("/cart/**").addPathPatterns("/payment/**")
                .addPathPatterns("/myclass/**");
        registry.addInterceptor(adminIntercepter()).addPathPatterns("/admin/**");
    }

    /* Exception Resolver를 설정  */
    @Bean
    public SimpleMappingExceptionResolver getExceptionResolver() {
        SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();

        // 지정되지 않은 예외에 대한 기본 에러페이지 입니다.
        smer.setDefaultErrorView("/common/error/error");
        // 상태코드 맵핑이 없는 예외를 위한 기본 상태값 입니다.
        smer.setDefaultStatusCode(200);
        // 기본값이 "exception" 입니다. 예외 모돌 속성의 키값입니다. ${exception.message}
        smer.setExceptionAttribute("exception");
        // 하나 또는 그 이상의 예외를 리졸버에서 제외합니다. 제외된 예외는 web.xml에서 지정된 값이 적용됩니다.
        smer.setExcludedExceptions(UncheckException.class);

        // 예외 클래스에 대해 에러 페이지를 지정합니다.
        Properties mappings = new Properties();
        mappings.setProperty("kr.ed.haebeop.exception.DatabaseException", "/common/error/databaseError");
        mappings.setProperty("kr.ed.haebeop.exception.SecurityException", "/common/error/securityError");
        mappings.setProperty("kr.ed.haebeop.exception.NotFoundException", "/common/error/notFoundError");
        mappings.setProperty("kr.ed.haebeop.exception.exception.BusinessException", "/common/error/businessError");
        mappings.setProperty("kr.ed.haebeop.exception.exception.AjaxException", "/common/error/ajaxError");
        smer.setExceptionMappings(mappings);

        // 에러페이지에 상태코드를 지정합니다.
        Properties statusCodes = new Properties();
        statusCodes.setProperty("/common/error/databaseError", "500");
        statusCodes.setProperty("/common/error/securityError", "403");
        statusCodes.setProperty("/common/error/notFoundError", "404");
        statusCodes.setProperty("/common/error/businessError", "200");
        statusCodes.setProperty("/common/error/ajaxError", "200");
        smer.setStatusCodes(statusCodes);
        return smer;
    }
}
