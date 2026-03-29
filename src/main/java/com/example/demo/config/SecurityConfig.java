package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
	
	// ૧. પાસવર્ડને હેશ કરવા માટેનો બીન
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // ૨. સિક્યોરિટી ફિલ્ટર ચેઈન (બધા પેજીસને એક્સેસ કરવા દેવા માટે)
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // CSRF સુરક્ષા અત્યારે બંધ કરો (Development માટે)
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll() // અત્યારે બધા જ URL ને પરમિશન આપો
            )
            .formLogin(form -> form.disable()) // Spring નું ડિફોલ્ટ લોગિન ફોર્મ બંધ કરો
            .httpBasic(basic -> basic.disable());

        return http.build();
    }

}
