package com.geekbrains.geekmarketwinter.utils;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class RabbitProvider {
    private static final String QUEUE_NAME = "auth-err";
    private Channel channel;
    private Connection connection;

    public void openConnect() {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        try {
            connection = factory.newConnection();
            channel = connection.createChannel();
            channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendMsg(String msg) {
        try {
            channel.basicPublish("", QUEUE_NAME, null, msg.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("sent " + msg);
    }

    public void receiverMsg() {
        Logger file = Logger.getLogger("DB");
        try {
            ConnectionFactory factory = new ConnectionFactory();
            factory.setHost("localhost");
            channel.queueDeclare(QUEUE_NAME, false, false, false, null);
            final DeliverCallback deliverCallback = (consumerTag, delivery) -> {
                String msg = new String(delivery.getBody(), "UTF-8");
                System.out.println("Reciver " + msg);
                file.warn("Reciver " + msg);
            };
            channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> {});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
