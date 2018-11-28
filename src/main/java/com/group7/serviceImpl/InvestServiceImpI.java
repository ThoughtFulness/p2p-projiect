package com.group7.serviceImpl;

import com.group7.dao.InvestDao;
import com.group7.entity.Invest;
import com.group7.entity.InvestmentAmount;
import com.group7.service.InvestService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * className:InvestServiceImpI
 * discriptoin:
 * author:ZHEN
 * createTime:2018-11-24 12:35
 */
@Service
public class InvestServiceImpI implements InvestService {

    @Autowired
    private InvestDao investDao;


    /**
     * 多条件筛选 查询分页
     * @param map
     * @return
     */
    public List<Map> getInves(Map map) {
        //如果pageNo为空默认1  pageSize 为空,默认10
        int pageNo = map.get("pageNo")==null?1:Integer.valueOf(map.get("pageNo")+"");
        int pageSize = map.get("pageSize")==null?5:Integer.valueOf(map.get("pageSize")+"");
        //计算分页的开始值和结束值
        map.put("start",(pageNo-1)*pageSize);
        map.put("end",pageNo*pageSize+1);
        return investDao.getInves(map);
    }


    /**
     * 分页总数量
     * @param map
     * @return
     */
    @Override
    public Map getInvesCount(Map map) {
        int pageSize = Integer.valueOf(map.get("pageSize")+"");  //当前页数据条数
        int pageNo = Integer.valueOf(map.get("pageNo")+"");  //当前页数
        int invesCount = investDao.getInvesCount(map); //获取总页数
        int maxPage =  invesCount % pageSize == 0 ? invesCount / pageSize : invesCount / pageSize + 1;  //判断当前是第几页
        Map tempMap = new HashMap();
        if(pageNo>=maxPage){   //如果当前页大于最大页     把值赋给Map 1为显示 0为隐藏  下一页按钮
            tempMap.put("hi",0);
        }else {
            tempMap.put("sh",1);
        }
        return tempMap;
    }


    /**
     * 获取个人贷款信息  个人信息 账户信息
     * @param map
     * @return
     */
    @Override
    public Map investment(Map map) {
        return investDao.investment(map);
    }

    /**
     * 投资信息表   贷款人的投资人和投资信息记录
     * @param invest
     * @return
     */
    @Override
    public int investmentAmount(InvestmentAmount invest) {
        return investDao.investmentAmount(invest);
    }

    /**
     * 查询投资信息  不能重复投资
     * @param userId
     * @param loansId
     * @return
     */
    @Override
    public Map investmentVerify(@Param("userId") Integer userId,@Param("loansId") Integer loansId) {
        return investDao.investmentVerify(userId,loansId);
    }

    @Override
    public int investmentMoeny(InvestmentAmount invest) {
        return investDao.investmentMoeny(invest);
    }
}