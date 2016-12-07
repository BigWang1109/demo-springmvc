package com.icss.demo.controller.messBoardManage;

import com.icss.demo.model.messBoard.messBoard;
import com.icss.demo.service.messBoardManage.MBService;
import com.icss.demo.util.DateTimeUtil;
import com.icss.demo.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;

/**
 * Created by thinkpad on 2016/11/30.
 */
@RestController
@RequestMapping(value="mb")
public class MBController {

    @Autowired
    private MBService service;
    //留言板入口
    @RequestMapping(value="enter/{messageId}", method = RequestMethod.GET)
    public ModelAndView messEnter(@PathVariable(value="messageId") String messageId){

        ModelAndView mv = new ModelAndView();
        messBoard mess = service.getMessage(messageId);
        if(mess!=null){
            mv.addObject("mess",mess);
        }

//        mv.setViewName("messBoard/messBoard");
        mv.setViewName("messBoard/messBoardTest");

        return mv;

    }
    @ResponseBody
    @RequestMapping(value="/save")
    public Boolean leaveMess(messBoard mess){

        String content = mess.getContent();
        mess.setModifytime(new Date());
        mess.setContent(content);
        mess.setModifier("sa");
        mess.setFlag("1");
        if(mess.getMessageId()==null || "".equals(mess.getMessageId())){
            mess.setMessageId(UUIDUtil.getUUID());
        }
        Boolean flag = service.leaveMessage(mess);

        return flag;

    }
    @RequestMapping(value = "messList")
    public ModelAndView messList(){
        ModelAndView mv = new ModelAndView();
        List messList = service.loadMessList();
        mv.addObject("messList", messList);
        mv.setViewName("messBoard/messListTest");
        return mv;
    }
    @RequestMapping(value="del")
    public String delMess(String ids){
//        String  str = ids;
//        System.out.print(str);
//        int count = service.delMess(ids);
//        if(count>0){
//            return true;
//        }
//        return false;

        if(ids == null || "".equals(ids.trim()) ){
            return "error";
        }
        ids = ids.replaceAll(",","','");
        ids = "'" + ids +"'";
        service.delMess(ids);
        return "success";

    }
}
