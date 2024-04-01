package com.springboot.myapp;

import com.springboot.myapp.interceptor.SessionInterceptor;
import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.tomcat.util.descriptor.web.SecurityCollection;
import org.apache.tomcat.util.descriptor.web.SecurityConstraint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private SessionInterceptor sessioninterceptor;

    /* 파일 예외처리 */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(sessioninterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/HOME_VIEW/**",
                        "/LOGIN_VIEW/**",
                        "/test/**",
                        "/AdminLTE_main/**",
                        "/bootstrap-4.6.2/**",
                        "/plugins/**",
                        "/css/**",
                        "/img/**",
                        "/js/**",
                        "/login/**",
                        "/LOGIN/**", // 로그인 페이지 예외처리
                        "/eds/pda/login/**", // 모바일 로그인 페이지 예외처리
                        "/tui/**", // TUI Grid
                        "/file/**" // email file
                        ); // 예외처리
        WebMvcConfigurer.super.addInterceptors(registry);
    }

    /* CORS 예외처리 */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins(
                        "http://localhost:80",
                        "https://192.168.0.31:81",
                        "https://edscorp.iptime.org:8181"
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("Authorization", "Content-Type")
                .exposedHeaders("headers")
                .allowCredentials(true)
                .maxAge(3600);
    }

    @Value("${server.port.http}")
    private int serverPortHttp;
    
    @Bean
	public ServletWebServerFactory serverFactory() {

	    TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory(){
	        @Override
	        protected void postProcessContext(Context context) {
	            SecurityConstraint securityConstraint = new SecurityConstraint();
	            securityConstraint.setUserConstraint("CONFIDENTIAL");
	            SecurityCollection collection = new SecurityCollection();
	            collection.addPattern("/*");
	            securityConstraint.addCollection(collection);
	            context.addConstraint(securityConstraint);
	        }
	    };
	    tomcat.addAdditionalTomcatConnectors(createSslConnector());
	    return tomcat;
	}


    private Connector createStandardConnector(){
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setPort(serverPortHttp);
        return connector;
    }
    private Connector createSslConnector() {
	    Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
	    connector.setScheme("http");
	    connector.setSecure(false);
	    connector.setPort(80);
	    connector.setRedirectPort(8181);
	    return connector;
	}
}