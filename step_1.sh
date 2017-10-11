#!/bin/bash

cat > src/main/java/com/example/demo/DemoApplication.java <<END
package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class DemoApplication {

  @Value("\${config.greeting}")
  String greeting;

  @RequestMapping("/")
  public String home() {
    return "Hello " + greeting;
  }

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);
  }

}
END

read  -n 1 -p "Continue: " mainmenuinput

set -x

mvn clean verify package -Dconfig.greeting=Anything

cf push twelve-factor -p target/demo-0.0.1-SNAPSHOT.jar

set +x

read  -n 1 -p "Continue: " mainmenuinput

set -x

cf set-env twelve-factor SPRING_APPLICATION_JSON '{"config":{"greeting":"Universe"}}'

cf restart twelve-factor
