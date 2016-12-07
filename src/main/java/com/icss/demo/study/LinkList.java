package com.icss.demo.study;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class LinkList {

    private Link first;

    private LinkList(){
        first = null;
    }
    public boolean isEmpty(){
        return (first==null);
    }
    public void insertFirst(int id,int data){
        Link newLink = new Link(id,data);
        newLink.next=first;
        first=newLink;
    }
    public Link deleteFirst(){
        Link temp = first;
        first=first.next;
        return temp;
    }
    public Link find(int key){
        Link current = first;
        while(current.iData!=key){
            if(current!=null){
                current = current.next;
            }else{
                return null;
            }
        }
        return current;
    }
    public Link delete(int key){
        Link previous = first;
        Link current = first;
        while(current.iData!=key){
            if(current==null){
                return null;
            }else{
                previous = current;
                current = current.next;
            }
        }
        if(current == first){
            first = first.next;
        }else{
            previous.next = current.next;
        }
        return current;
    }
}
