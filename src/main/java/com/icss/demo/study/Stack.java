package com.icss.demo.study;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class Stack {
    private int maxSize;
    private char []stackArray;
    private int top;

    public Stack(int size){
        maxSize = size;
        stackArray = new char[maxSize];
        top = -1;
    }
    public void push(char temp){
        stackArray[++top] = temp;
    }
    public char pop(){
        char temp = stackArray[top--];
        return temp;
    }
    public char peek(){
        return stackArray[top];
    }
    public boolean isEmpty(){
        return (top==-1);
    }
    public boolean isFull(){
        return (top==maxSize-1);
    }

}
