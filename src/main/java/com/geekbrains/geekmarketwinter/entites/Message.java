package com.geekbrains.geekmarketwinter.entites;

public class Message {
    private static int name=0;

    public int getName() {
        name++;
        return name;
    }

    public void setName(){
        name = 0;
    }

    @Override
    public String toString() {
        return name + "";
    }

    public int nameMinus() {
        name--;
        return name;
    }
}
