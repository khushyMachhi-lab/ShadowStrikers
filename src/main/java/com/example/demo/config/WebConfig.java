package com.example.demo.config;

import java.nio.file.Paths;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // આ લાઈન તમારા પ્રોજેક્ટના સાચા પાથને URL સાથે જોડે છે
        String uploadPath = Paths.get("src/main/resources/static/user-photos").toAbsolutePath().toUri().toString();
        
        registry.addResourceHandler("/user-photos/**")
                .addResourceLocations(uploadPath)
                .setCachePeriod(0); // Cache 0 રાખવાથી નવી ઈમેજ તરત દેખાશે
    }
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        WebContentInterceptor interceptor = new WebContentInterceptor();
        
        // 0 સેકન્ડ કેશ એટલે બ્રાઉઝર ડેટા સ્ટોર નહીં કરે
        interceptor.setCacheSeconds(0);
        
        // આ લાઈન બધા જ URL (/**) પર આ નિયમ લાગુ કરશે
        registry.addInterceptor(interceptor).addPathPatterns("/**");
    }

}
