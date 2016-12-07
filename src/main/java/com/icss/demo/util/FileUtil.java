package com.icss.demo.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by 王曉旭
 */
public class FileUtil {

    //文件复制
    public static void saveFileFromInputStream(InputStream stream, String filename) throws IOException {
        FileOutputStream fs=new FileOutputStream(filename);
        byte[] buffer =new byte[1024*1024];
        int bytesum = 0;
        int byteread = 0;
        while ((byteread=stream.read(buffer))!=-1){
            bytesum+=byteread;
            fs.write(buffer,0,byteread);
            fs.flush();
        }
        fs.close();
        stream.close();
    }

    //文件复制
    public static boolean copy(String fileFrom, String fileTo){
        try {
            FileInputStream in = new java.io.FileInputStream(fileFrom);
            FileOutputStream out = new FileOutputStream(fileTo);
            byte[] bt = new byte[1024];
            int count;
            while ((count = in.read(bt)) > 0){
                out.write(bt, 0, count);
            }
            in.close();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
