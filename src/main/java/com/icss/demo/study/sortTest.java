package com.icss.demo.study;

/**
 * Created by Administrator on 2016/6/26 0026.
 */
public class sortTest {

    public static void bubbleSort(int []num){
        int size = num.length,temp;
        for(int i=0;i<size-1;i++){
            for(int j=i+1;j<size;j++){
                if(num[i]<num[j]){
                    temp = num[i];
                    num[i]=num[j];
                    num[j]=temp;
                }
            }
        }
    }
    public static void quickSort(int []num,int start,int end){
        int base = num[start];
        int i=start,j=end,temp;
        do{
            while(i<end && num[i]<base) i++;
            while(j>start && num[j]>base) j--;
            if(i<=j){
                temp = num[i];
                num[i]= num[j];
                num[j] = temp;
                i++;
                j--;
            }
        }while(i<=j);
        if(i<end){
            quickSort(num,i,end);
        }
        if(j>start){
            quickSort(num,start,j);
        }
    }
    public static void selectSort(int []num){
        int size = num.length,temp;
        for(int i=0;i<size;i++){
            int k = i;
            for(int j=size-1;j>i;j--){
                if(num[j]<num[k])k=j;
            }
            temp = num[i];
            num[i]=num[k];
            num[k]=temp;
        }
    }
    public static void insertSort(int []num){
        int size = num.length,j,temp;
        for(int i=1;i<size;i++){
            temp = num[i];
            for(j=i;j>0 && num[j-1]<temp;j--)
                num[j]=num[j-1];
            num[j]=temp;
        }
    }

    public static void mergeSort(int[] numbers, int left, int right) {
        int t = 1;// 每组元素个数
        int size = right - left + 1;
        while (t < size) {
            int s = t;// 本次循环每组元素个数
            t = 2 * s;
            int i = left;
            while (i + (t - 1) < size) {
                merge(numbers, i, i + (s - 1), i + (t - 1));
                i += t;
            }
            if (i + (s - 1) < right)
                merge(numbers, i, i + (s - 1), right);
        }
    }
    /**
     * 归并算法实现
     *
     * @param data
     * @param p
     * @param q
     * @param r
     */
    private static void merge(int[] data, int p, int q, int r) {
        int[] B = new int[data.length];
        int s = p;
        int t = q + 1;
        int k = p;
        while (s <= q && t <= r) {
            if (data[s] <= data[t]) {
                B[k] = data[s];
                s++;
            } else {
                B[k] = data[t];
                t++;
            }
            k++;
        }
        if (s == q + 1)
            B[k++] = data[t++];
        else
            B[k++] = data[s++];
        for (int i = p; i <= r; i++)
            data[i] = B[i];
    }
}
