package com.geekbrains.geekmarketwinter.config;


import com.geekbrains.geekmarketwinter.entites.Product;
import com.geekbrains.geekmarketwinter.entites.SystemUser;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class AppLoggingAspect {
    Logger file = Logger.getLogger("file");
    Logger admin = Logger.getLogger("admin");

     @AfterReturning("execution(public * com.geekbrains.geekmarketwinter.services.UserServiceImpl.loadUserByUsername(..))") // pointcut expression
    public void afterReturningLoadUserByUsername(JoinPoint joinPoint) {
         Object[] args = joinPoint.getArgs();
         file.info("Пользователь " + args[0] + " осуществил вход");
    }
    @AfterThrowing("execution(public * com.geekbrains.geekmarketwinter.services.UserServiceImpl.loadUserByUsername(..))") // pointcut expression
    public void afterThrowingLoadUserByUsername(JoinPoint joinPoint) {
        Object[] args = joinPoint.getArgs();
        file.warn("Несанкцианированная попытка входа");
    }
    @AfterReturning("execution(public * com.geekbrains.geekmarketwinter.services.UserServiceImpl.save(..))") // pointcut expression
    public void afterReturningSave(JoinPoint joinPoint) {
        Object[] args = joinPoint.getArgs();
        file.info("Зарегестрирован новый пользователь " + ((SystemUser)args[0]).getUserName());
    }
    @AfterReturning("execution(public * com.geekbrains.geekmarketwinter.services.ProductService.saveProduct(..))") // pointcut expression
    public void afterReturningSaveProduct(JoinPoint joinPoint) {
        Object[] args = joinPoint.getArgs();
        admin.info("Добавлен товар " + ((Product)args[0]).toString());
    }
}
