package com.example.demo.config;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Value("${file.upload-dir:./src/main/resources/static/user-photos/}")
	private String uploadDir;

	@Value("${file.payment-dir:./src/main/resources/static/payment-screenshots/}")
	private String paymentDir;

	@Value("${file.documents-dir:./src/main/resources/static/documents/}")
	private String documentsDir;

	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/user-photos/**")
                .addResourceLocations(Paths.get(uploadDir).toAbsolutePath().toUri().toString())
                .setCachePeriod(0);

        registry.addResourceHandler("/payment-screenshots/**")
                .addResourceLocations(Paths.get(paymentDir).toAbsolutePath().toUri().toString())
                .setCachePeriod(0);

        registry.addResourceHandler("/documents/**")
                .addResourceLocations(Paths.get(documentsDir).toAbsolutePath().toUri().toString())
                .setCachePeriod(0);
    }

	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        WebContentInterceptor interceptor = new WebContentInterceptor();
        interceptor.setCacheSeconds(0);
        registry.addInterceptor(interceptor).addPathPatterns("/**");
    }

}