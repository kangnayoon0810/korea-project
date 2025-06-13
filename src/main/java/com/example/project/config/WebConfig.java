package com.example.project.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.project.interceptor.BeforeActionInterceptor;
import com.example.project.interceptor.NeedLoginInterceptor;
import com.example.project.interceptor.NeedLogoutInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	private BeforeActionInterceptor beforeActionInterceptor;
	private NeedLoginInterceptor needLoginInterceptor;
	private NeedLogoutInterceptor needLogoutInterceptor;

	public WebConfig(BeforeActionInterceptor beforeActionInterceptor, NeedLoginInterceptor needLoginActionInterceptor,
			NeedLogoutInterceptor needLogoutInterceptor) {
		this.beforeActionInterceptor = beforeActionInterceptor;
		this.needLoginInterceptor = needLoginActionInterceptor;
		this.needLogoutInterceptor = needLogoutInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**");

		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/usr/article/write")
				.addPathPatterns("/usr/article/doWrite").addPathPatterns("/usr/article/modify")
				.addPathPatterns("/usr/article/doModify").addPathPatterns("/usr/article/delete")
				.addPathPatterns("/usr/member/logout");

		registry.addInterceptor(needLogoutInterceptor).addPathPatterns("/usr/member/signup")
				.addPathPatterns("/usr/member/login").addPathPatterns("/usr/member/doLogin");
	}
	
	 @Value("${custom.file.dir}")
	    private String uploadDir;

	    @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	        // /gen/으로 시작하는 URL 요청을 실제 로컬 폴더와 연결
	        registry.addResourceHandler("/gen/**")
	                .addResourceLocations("file:///" + uploadDir + "/");
	    }

}