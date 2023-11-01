package kr.ed.haebeop.config;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import java.util.Properties;

@Configuration
@ComponentScan(basePackages = {"kr.ed.haebeop.service", "kr.ed.haebeop.repository"})
@MapperScan(basePackages = {"kr.ed.haebeop.persistence"})
public class RootConfig {
    @Autowired
    private ApplicationContext applicationContext;

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate((SqlSessionFactory) sqlSessionFactoryBean());
    }

    @Bean
    public SqlSessionFactory sqlSessionFactoryBean() throws  Exception { // sqlfactory 설정
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setConfigLocation(applicationContext.getResource("classpath:/mybatis-config.xml"));
        sqlSessionFactory.setMapperLocations(applicationContext.getResources("classpath*:/mappers/**/*Mapper.xml"));
        sqlSessionFactory.setDataSource(dataSource());
        return (SqlSessionFactory) sqlSessionFactory.getObject();
    }

    @Bean
    public DataSourceTransactionManager transactionManager() { // 트랜잭션 설정
        DataSourceTransactionManager transaction = new DataSourceTransactionManager();
        transaction.setDataSource(dataSource());
        return transaction;
    }

    @Bean
    public BasicDataSource dataSource() { // 데이터 베이스 설정
        BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName("org.mariadb.jdbc.Driver");
        // 실제 서버 db 연결
        basicDataSource.setUrl("jdbc:mariadb://10.41.1.198/team14");
        basicDataSource.setUsername("team14");
        basicDataSource.setPassword("team14");

        // 개발 서버 db 연결
//        basicDataSource.setUrl("jdbc:mariadb://localhost:3306/haebeop");
//        basicDataSource.setUsername("root");
//        basicDataSource.setPassword("1234");
        return basicDataSource;
    }
    
    @Bean
    public CommonsMultipartResolver multipartResolver() { // 멀티파트 파일 업로드 설정
        CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
        commonsMultipartResolver.setMaxUploadSize(100000000);
        commonsMultipartResolver.setMaxInMemorySize(100000000);
        return commonsMultipartResolver;
    }
    
    // 개발서버 저장 경로
    @Bean(name = "uploadPath")
    public String uploadPath() { // 멀티파트 업로드 디렉토리 지정
        //환경에 따라 수정 필요
//        return "D:\\spring_study\\pro04\\src\\main\\webapp\\resources\\upload";
        //       return "D:\\kuyejin\\team14\\src\\main\\webapp\\resources\\upload"; //예진
        return "/Users/juncheol/Desktop/team_pro4/team14/src/main/webapp/resources/upload";

    }


    @Bean
    public JavaMailSender mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.naver.com");
        mailSender.setPort(465);
        mailSender.setUsername("spospotv@naver.com");
        mailSender.setPassword("a2217512");
        mailSender.setDefaultEncoding("utf-8");

        Properties javaMailProperties = new Properties();
        javaMailProperties.put("mail.smtp.auth", "true");
        javaMailProperties.put("mail.smtp.ssl.enable", "true");
        javaMailProperties.put("mail.smtp.starttls.enable", "true");
        javaMailProperties.put("mail.smtps.ssl.checkserveridentity", "true");
        javaMailProperties.put("mail.smtps.ssl.trust", "*");
        javaMailProperties.put("mail.debug", "true");
        javaMailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        mailSender.setJavaMailProperties(javaMailProperties);
        return mailSender;
    }
}
