package com.icss.demo.controller;

import com.icss.demo.util.SessionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by wxx on 16-11-25.
 */
@RestController
@RequestMapping(value="/demo")
public class PortalController {

    private static final Logger logger = LoggerFactory.getLogger(PortalController.class);

    //r1 集成
    @RequestMapping(value = "/portal/{sysid}", method = RequestMethod.GET)
    public ModelAndView portal(@PathVariable("sysid") Integer sysid, HttpServletRequest request) {

        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
        //String json = ROneUtil.getMenuJson(basePath, sysid);

        ModelAndView mv = new ModelAndView();
        //mv.addObject("menu", json);
        mv.addObject("sysid", sysid);
        mv.addObject("userid", SessionUtil.getInstance().getUserID());
        mv.setViewName("portal/index");

        return mv;
    }

    //demo 测试
    @RequestMapping(value = "/frame", method = RequestMethod.GET)
    public ModelAndView frame(HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("portal/frame");
        return mv;
    }

}