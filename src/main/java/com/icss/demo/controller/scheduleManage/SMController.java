package com.icss.demo.controller.scheduleManage;

import com.icss.demo.common.Pagination;
import com.icss.demo.model.scheduleManage.Schedule;
import com.icss.demo.service.scheduleManage.SMService;
import com.icss.demo.util.SessionUtil;
import com.icss.demo.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.Map;

/**
 * Created by thinkpad on 2016/12/1.
 */
@RestController
@RequestMapping(value="sm")
public class SMController {

    @Autowired
    private SMService service;

    //工作安排入口
    @RequestMapping(value="enter")
    public ModelAndView messEnter(){

        ModelAndView mv = new ModelAndView();

        mv.setViewName("scheduleManage/taskList");

        return mv;

    }

    //查询工作列表
    @ResponseBody
    @RequestMapping(value="/scheduleManage/load", method = RequestMethod.POST)
    public Map<String,Object> load(Pagination pagination){
        Map<String,Object> json = service.loadByPage(pagination);
        return json;
    }
    //添加工作安排
    @RequestMapping(value = "/scheduleManage/save")
    public String saveQuestion(Schedule schedule){


        String testContent = schedule.getTaskContent();
        String responsePerson = schedule.getResponsePerson();

        if(schedule.getTaskId() == null || "".equals(schedule.getTaskId().trim())){
            schedule.setTaskId(UUIDUtil.getUUID());
            schedule.setCreateDate(new Date());
            schedule.setModifyDate(new Date());
        } else {
            schedule = service.getScheduleByUUID(schedule.getTaskId());
        }

        if(testContent==null || "".equals(testContent)){
            testContent = schedule.getTaskContent();
        }

        if(responsePerson==null || "".equals(responsePerson)){
            responsePerson = schedule.getResponsePerson();
        }

        schedule.setModifier("sa");
        schedule.setTaskContent(testContent);
        schedule.setResponsePerson(responsePerson);

        Boolean s = service.saveTask(schedule);
        if(s){
            return "{\"flag\":\"success\",\"uuid\":\""+schedule.getTaskId()+"\"}";
        }
        return "{\"flag\":\"error\"}";
    }

    //界面跳转
    @RequestMapping(value="/addtask/{uuid}/{flag}", method = RequestMethod.GET)
    public ModelAndView addTask(@PathVariable(value="uuid") String uuid,@PathVariable(value="flag") String flag){
        ModelAndView mv = new ModelAndView();
        if(uuid!=null && !"".equals(uuid.trim())  && !"-1".equals(uuid)){
            Schedule schedule  = service.getScheduleByUUID(uuid);
            mv.addObject("task",schedule);
        }
        mv.addObject("flag",flag);
        mv.setViewName("scheduleManage/addTask");

        return mv;

    }

    @RequestMapping(value="/scheduleManage/delete")
    public String deleteTask(String ids){
        if(ids == null || "".equals(ids.trim()) ){
            return "error";
        }
        ids = ids.replaceAll(",","','");
        ids = "'" + ids +"'";
        service.deleteTasks(ids);
        return "success";
    }

}
