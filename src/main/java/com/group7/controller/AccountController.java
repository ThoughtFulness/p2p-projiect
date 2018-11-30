package com.group7.controller;

import com.group7.service.AccountService;
import com.group7.util.FileUtil.FileUpAndDown;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * ClassName:AccountController
 * Description:
 * Author:严浩天
 * CreateTime:2018-11-28 18:12
 */

@Controller
@SuppressWarnings("all")
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private HttpSession session;

    @RequestMapping("/accountList")
    @ResponseBody
    public Map accountList(String userName){
        String  name = session.getAttribute("userName")+"";
        Map accountList = accountService.accountInfo("sunzhen");
        session.setAttribute("accountList",accountList);
        return accountList;
    }

    @RequestMapping("/fileUpload")
    @ResponseBody
    public Object fileUpload(@RequestParam MultipartFile file){
        FileUpAndDown.upLoad(file);
       return 1;
    }
}