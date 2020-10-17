package com.geekbrains.geekmarketwinter.entites;

public class Message {
    private static int name=0;

    public int getName() {
        name++;
        return name;
    }

    @Override
    public String toString() {
        return name + "";
    }
}
