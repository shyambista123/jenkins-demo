package com.example.jenkinsdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class JenkinsDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(JenkinsDemoApplication.class, args);
        System.out.println("✅ Spring Boot App started!");
    }
}
