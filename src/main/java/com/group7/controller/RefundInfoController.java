package com.group7.controller;

import com.group7.service.RefundInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * className:RefundInfoService
 * discriptoin:
 * author:邢博
 * createTime:2018-12-13 14:16
 */
@Controller
public class RefundInfoController {
    /**
     * 依赖注入
     */
    @Autowired
    private RefundInfoService refundInfoService;

    /**
     * 查询还款的信息列表
     * @param map
     * @return
     */
    @ResponseBody
    @RequestMapping("/OverdueInfo")
    public Map OverdueInfo(@RequestBody Map map){
        Map tempMap = new HashMap();
        tempMap.put("page",refundInfoService.getOverdueInfo(map));
        tempMap.put("totel",refundInfoService.getPageCount(map));
        return tempMap;
    }

    /**
     * 还款时调用存储过程
     * @return
     */
    @RequestMapping("RefundInfo")
    @Scheduled(cron="0 * 14 * * ?")
    public String RefundInfo(){
        System.out.println("调用存储过程");
        Map map = new HashMap();
        refundInfoService.getRefundInfo(map);
        return "frontEnd/Refund";
    }
}