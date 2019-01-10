package com.group7.service;

import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface diagramService {
    /**
     * 获取12个月的贷款信息
     * @return
     */
    List<Map> getDaikuan(Map map);

    /**
     * 获取12个月的还款信息
     * @return
     */
    List<Map> getHuankuan(Map map);

    /**
     * 获取12个月充值信息
     * @return
     */
    List<Map> getChongChi(Map map);


    /**
     * 获取12个月的提现信息
     * @return
     */
    List<Map> getTiXian(Map map);
}
