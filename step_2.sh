#!/bin/bash

cat > src/main/java/com/example/demo/DemoApplication.java <<END
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
END

read  -n 1 -p "Continue: " mainmenuinput

set -x

mvn clean package

cf push twelve-factor -p target/demo-0.0.1-SNAPSHOT.jar

set +x

read  -n 1 -p "Continue: " mainmenuinput

set -x

cf create-service cleardb spark twelve-factor-mysql
cf bind-service twelve-factor twelve-factor-mysql
cf restart twelve-factor

set +x
