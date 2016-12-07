package com.icss.demo.study;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;

/**
 * Created by Administrator on 2016/7/24 0024.
 */
public class InetAddressDemo {

    public static void main(String []args){
        try{
            //使用域名创建对象
            InetAddress inet1  = InetAddress.getByName("www.baidu.com");
            System.out.println(inet1);
            //使用IP创建对象
            InetAddress inet2 = InetAddress.getByName("119.75.217.109");
            System.out.println(inet2);
            //获得本机地址对象
            InetAddress inet3 = InetAddress.getLocalHost();
            System.out.println(inet3);
            //获得对象中存储的域名
            String host = inet3.getHostName();
            //获得对象中存储的IP
            String ip = inet3.getHostAddress();
            System.out.println(host);
            System.out.println(ip);

            Socket socket1 = new Socket("192.168.1.103",10000);

            Socket socket2 = new Socket("www.sohu.com",80);

            OutputStream os = socket1.getOutputStream(); //获得输出流

            InputStream is = socket1.getInputStream();     //获得输入流

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
