package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;

@RestController
@SpringBootApplication
public class DemoApplication {

  @Autowired
  JdbcTemplate jdbcTemplate;

  @RequestMapping("/")
  public String home() throws SQLException {
    String answer = jdbcTemplate.queryForObject("SELECT 42", String.class);

    return "Hello " + answer + "<br>" + jdbcTemplate.getDataSource().getConnection();
  }

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);
  }

}
