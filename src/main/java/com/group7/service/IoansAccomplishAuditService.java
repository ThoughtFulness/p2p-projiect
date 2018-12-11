package com.group7.service;


import java.util.List;
import java.util.Map;

/**
 * className:IoansAccomplishAuditService
 * discriptoin:
 * author:ZHEN
 * createTime:2018-12-08 15:13
 */
public interface IoansAccomplishAuditService {

    /**
     * 查询 所有满标贷款信息  进行审核
     * @param map
     * @return
     */
    List<Map> getList(Map map);

    /**
     * 查询 所有满标贷款信息 条数
     * @param map
     * @return
     */
    int getPageCount(Map map);
}