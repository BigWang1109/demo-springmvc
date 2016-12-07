package com.icss.demo.study;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class Queue {

    private int maxSize;
    private int []queueArray;
    private int front;
    private int rear;
    private int nItems;

    public Queue(int size){
        maxSize = size;
        queueArray = new int[maxSize];
        front = 0;
        rear = -1;
        nItems = 0;
    }

    public void insert(int temp){
        if(rear==maxSize-1) rear = -1;
        queueArray[++rear] = temp;
        nItems++;
    }

    public int remove(){
        int temp = queueArray[front++];
        if(front==maxSize) front=0;
        nItems--;
        return temp;
    }

    public int show(){
        return queueArray[front];
    }

    public boolean isEmpty(){
        return (nItems==0);
    }

    public boolean isFull(){
        return (nItems==maxSize);
    }



}
