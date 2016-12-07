package com.icss.demo.controller.common;

import com.icss.demo.service.common.UMService;
import com.icss.demo.util.DictUtils;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by thinkpad on 2016/12/1.
 */
@RestController
@RequestMapping(value="bd")
public class bdDictController {

    @Autowired
    private UMService service;

    @RequestMapping(value="initializeUser")
    public JSONArray initializeUser(){

        List list = service.getUser();
        JSONArray jsonArray = JSONArray.fromObject(list);

        return jsonArray;

    }
}
