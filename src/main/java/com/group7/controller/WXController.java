package com.group7.controller;


import com.group7.entity.MessageText;
import com.group7.util.CheckCodeUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * @className:WXController
 * @discription:
 * @author:zz
 * @crateTime:2019-01-13 15:41
 */
@RestController//默认返回json
public class WXController {
    @GetMapping("/checkToken")
    public String checkWXToken(String signature,String timestamp,String nonce,String echostr){
        if(CheckCodeUtil.checkSignature(signature, timestamp, nonce)){
            return echostr;
        }
        return null;
    }


    @PostMapping(value="/checkToken",produces = {"application/xml; charset=UTF-8"})
    public MessageText getMsg(@RequestBody MessageText ms){
        System.out.println(ms.getContent());

        MessageText text = new MessageText(ms.getFromUserName(), ms.getToUserName(), new Date().getTime()+"", "text", "<a href='http://8x4xgr.natappfree.cc/p2p/'>打开项目</a>", null);
        return text;
    }
}
