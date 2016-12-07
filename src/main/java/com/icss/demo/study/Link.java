package com.icss.demo.study;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class Link {

   public int iData;
    public int dData;
    public Link next;

    public Link(int id,int data){
        iData=id;
        dData=data;
    }
    public void displayLink(){
        System.out.println("{"+iData+","+dData+"}");
    }
}
