package com.flamexander.cloud.client.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient("geek-spring-cloud-market")
public interface GreetingClient {
    @RequestMapping("/category")
    String getCategory();
}

//@FeignClient("geek-spring-cloud-eureka-client")
//public interface GreetingClient {
//    @RequestMapping("/greeting1")
//    String greeting1();
//}
