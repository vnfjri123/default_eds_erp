package com.springboot.myapp;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@SpringBootApplication
@MapperScan(value={"com.springboot.myapp"})
@ServletComponentScan
public class MyappApplication extends SpringBootServletInitializer {
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(MyappApplication.class);
	}
	
	public static void main(String[] args) throws Exception {
		SpringApplication.run(MyappApplication.class, args);
	}

	@Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:mappers/**/*.xml");
        sessionFactory.setMapperLocations(res);

        return sessionFactory.getObject();
    }
	
	@Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
      final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
      return sqlSessionTemplate;
    }
}