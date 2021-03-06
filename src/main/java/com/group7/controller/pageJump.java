package com.group7.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转
 * 申恩
 */
@Controller
public class pageJump {

    /**
     * 身份证验证界面
     * @return
     */
    @RequestMapping("/toIdentity")
    public String toIdentity(){
        return "backStage/IDCardIdentity";
    }

    /**
     * 支付密码界面
     * @return
     */
    @RequestMapping("/toPay")
    public String toPay(){
        return "backStage/IpayPassword";
    }

    /**
     * 跳转上传页面
     * @return
     */
    @RequestMapping("toUpload")
    public String upLoadPage(){
        return "backStage/Upload";
    }

    /**
     * 跳转首页
     * @return
     */
    @RequestMapping("toIndex")
    public String indexPage(){
        return "frontEnd/index";
    }

    /**
     * 跳转我要投资
     * @return
     */
    @RequestMapping("toInvest")
    public String toInvest(){
        return "frontEnd/invest";
    }

    /**
     * 跳转借贷
     * @return
     */
    @RequestMapping("toBorrow")
    public String toBorrow(){
        return "frontEnd/borrow";
    }

    /**
     * 跳转账户信息
     * @return
     */
    @RequestMapping("toAccount")
    public String toAccount(){
        return "frontEnd/Account";
    }

    /**
     * 测试招标审核
     * @return
     */
    @RequestMapping("/toLoanAudit")
    public String toLoanAudit(){
        return "backStage/LoanAudit";
    }

    /**
     * 跳转逾期审核
     * @return
     */
    @RequestMapping("/toOverdueAudit")
    public String toOverdueAudit(){
        return "backStage/OverdueAudit";
    }

    /**
     * 投资页面
     0     * @return
     */
    @RequestMapping("/toDetail")
    public String toDetail(){
        return "frontEnd/11112/detail";
    }

    /**
     * 跳转常见问题
     * @return
     */
    @RequestMapping("toproblem")
    public String toproblem(){
        return "frontEnd/problem";
    }

    /**
     * 跳转登录
     * @return
     */
    @RequestMapping("toLogin")
    public String toLogin(){
        return "frontEnd/login";
    }

    /**
     * 跳转注册
     * @return
     */
    @RequestMapping("toRegister")
    public String toRegister(){
        return "frontEnd/register";
    }

    /**
     * 跳转公告列表
     * @return
     */
    @RequestMapping("/toNoticelist")
    public String toNoticelist(){
        return "frontEnd/noticelist";
    }

    /**
     * 个人中心首页
     * @return
     */
//    @RequestMapping("toGeRenZhongXinShouYe")
//    public String toGeRenZhongXinShouYe(){
//        return "yirenbaopage/GRZX";
//    }

    /**
     * 个人中心充值
     * @return
     */
    @RequestMapping("toGRZXChongZhi1")
    public String toGRZXChongZhi1(){
        return "yirenbaopage/个人中心-充值.html";

    }

    /**
     * 兑换记录
     * @return
     */
    @RequestMapping("toGRZXDuiHuan")
    public String toGRZXDuiHuan(){
        return "yirenbaopage/个人中心-兑换历史.html";

    }

    /**
     * 回款计划
     * @return
     */
    @RequestMapping("toGRZXHuiKuan")
    public String toGRZXHuiKuan(){
        return "yirenbaopage/个人中心-回款计划.html";
    }

    /**
     * 开通第三方
     * @return
     */
    @RequestMapping("toGRZXKaiTong1")
    public String toGRZXKaiTong1(){
        return "yirenbaopage/个人中心-开通第三方.html";
    }


    /**
     * 我的红包
     * @return
     */
    @RequestMapping("toGRZXHongBao")
    public String toGRZXHongBao(){
        return "yirenbaopage/个人中心-我的红包.html";
    }
/*
    *//**
     * 投资纪录
     * @return
     *//*
    @RequestMapping("toGRZXTouZi")
    public String toGRZXTouZi(){
        return "yirenbaopage/个人中心-投资记录.html";
    }*/

   /* *//**
     * 提现
     * @return
     *//*
    @RequestMapping("toGRZXTiXian1")
    public String toGRZXTiXian1(){
        return "yirenbaopage/个人中心-提现.html";
    }
*/
    /**
     * 系统消息
     * @return
     */
    @RequestMapping("toGRZXXiTongXiaoXi")
    public String toGRZXXiTongXiaoXi(){
        return "yirenbaopage/个人中心-系统消息.html";
    }


    /**
     * 账号设置
     * @return
     */
   /* @RequestMapping("toGRZXZhangHao")
    public String toGRZXZhangHao(){
        return "yirenbaopage/个人中心-账户设置.html";
    }
*/

    /**
     * 资金纪录
     * @return
     */
    @RequestMapping("toGRZXZiJin")
    public String toGRZXZiJin(){
        return "yirenbaopage/个人中心-资金记录.html";
    }


    /**
     * 权限管理  角色信息
     * @return
     */
    @RequestMapping("/permission")
    public String permission(){
        return "permission/authorityManagement";
    }



    @RequestMapping("tojinNangXinXi")
    public String tojinNangXinXi(){
        return "frontEnd/jinNangXinxi";
    }


    @RequestMapping("toSSCW")
    public String toSSCW(){
        return"frontEnd/SSCW";
    }

    @RequestMapping("tojinNang")
    public String tojinNang(){
        return "frontEnd/jinNang";
    }

    /**
     * 修改权限树
     * @return
     */
    @RequestMapping("/updatePermission")
    public String updatePermission(){
        return "permission/updatePermission";
    }

    /**
     * 网站头部
     * @return
     */
    @RequestMapping("toHead")
    public String toHead(){
        return"frontEnd/head";
    }

    /**
     * 账户管理
     * @return
     */
    @RequestMapping("/accountManagement")
    public String accountManagement(){
        return "permission/accountManagement";
    }


    /**
     * 后台登陆
     * @return
     */
    @RequestMapping("/loginTo")
    public String Login(){
        return "permission/toLogin";
    }


    /**
     * 投资支付密码
     * @return
     */
    @RequestMapping("/investmentPassword")
    public String investmentPassword(){
        return "backStage/investmentPassword";
    }

    /**
     * 满标审核信息表
     * @return
     */
    @RequestMapping("/toIoansAccomplishAudit")
    public String toIoansAccomplishAudit(){
        return "backStage/IoansAccomplishAudit";
    }


    /**
     * 流标审核
     * @return
     */
    @RequestMapping("/toLoseABidAudit")
    public String toLoseABidAudit(){
        return "backStage/lose_a_bidAudit";
    }
    /**
     * 公告管理
     * @return
     */
    @RequestMapping("/tonoticeGuanLi")
    public String tonoticeGuanLi(){
        return "permission/noticeGuanLi";
    }

    /**
     * 锦囊管理
     * @return
     */
    @RequestMapping("/tojinnangGuanLi")
    public String tojinnangGuanLi(){
        return "permission/jinnangGuanLi";
    }

    /**
     * 后台统计图表
     * @return
     */
    @RequestMapping("/toBackindex")
    public String toBackindex(){
        return "frontEnd/backindex";
    }



}
