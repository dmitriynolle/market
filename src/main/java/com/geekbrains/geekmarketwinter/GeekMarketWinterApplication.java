package com.geekbrains.geekmarketwinter;

import com.geekbrains.geekmarketwinter.utils.RabbitProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class GeekMarketWinterApplication implements CommandLineRunner {
	private RabbitProvider rabbitProvider;

	@Autowired
	public void setRabbitProvider(RabbitProvider rabbitProvider) {
		this.rabbitProvider = rabbitProvider;
	}

	public static void main(String[] args) {
		SpringApplication.run(GeekMarketWinterApplication.class, args);
	}


	@Override
	public void run(String... args) throws Exception {
		rabbitProvider.openConnect();
		rabbitProvider.receiverMsg();
	}
}