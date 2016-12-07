package com.icss.demo.study;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane;
import java.math.BigInteger;
import java.util.Date;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class mainTest {

    public static void main(String[] args){
//        int num[] = new int[]{3,6,1,4,5,2,9,8,7};
//        sortTest sort = new sortTest();
//        for(int i=0;i<num.length;i++){
//            System.out.print(num[i]);
//        }
////        sort.bubbleSort(num);
////        sort.quickSort(num,0,num.length-1);
////        sort.selectSort(num);
//        sort.insertSort(num);
//        System.out.println();
//        for(int i=0;i<num.length;i++){
//            System.out.print(num[i]);
//        }
       Queue queue = new Queue(6);

        System.out.println(queue.isEmpty());

        queue.insert(1);
        queue.insert(2);
        queue.insert(3);
        queue.insert(4);
        queue.insert(5);
        queue.insert(6);

        System.out.println(queue.isFull());

        System.out.println(queue.remove());
        System.out.println(queue.remove());
        System.out.println(queue.remove());

        System.out.println(queue.show());

//     Stack stack = new Stack(6);
//
//     System.out.println(stack.isEmpty());
//
//     stack.push('1');
//     stack.push('2');
//     stack.push('3');
//     stack.push('4');
//     stack.push('5');
//     stack.push('6');
//
//     System.out.println(stack.isFull());
//
//     System.out.println(stack.peek());
//
//     stack.pop();
//     stack.pop();
//     stack.pop();
//     stack.pop();
//
//     System.out.println(stack.peek());

//        BigInteger count=new BigInteger("100000000");
//        BigInteger start =new BigInteger("0");
//        Long diff;
//        while(start.compareTo(count)==-1){
//            start = start.add(new BigInteger("10000000"));
//            System.out.println(start);
//        }
//        String str = "宁夏货运航空有限公司是经宁夏回族自治区人民政府于2008年7月10日批复P5_14109_2";
//        String s = "151";
//        if(str.contains(s)){
//            System.out.print("include");
//        }


    }
}
