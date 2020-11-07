package com.geekbrains.geekmarketwinter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

public class TestClassCart {
    private WebDriver driver;

    @BeforeSuite
    public void init() {
        this.driver = new ChromeDriver();
        this.driver.manage().window().maximize();
    }

    @Test
    public void test(){
        driver.get("http://127.0.0.1:8181/shop");
        WebElement webElement = driver.findElement(By.name("product_2"));
        webElement.click();
        driver.get("http://127.0.0.1:8181/cart");
        String string = driver.findElement(By.tagName("td")).getText();
        Assert.assertTrue(string.contains("1"));
    }

    @AfterSuite
    public void shutdown() {
        this.driver.quit();
    }
}
