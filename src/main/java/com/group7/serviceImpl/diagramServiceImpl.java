package com.group7.serviceImpl;

import com.group7.dao.diagramDao;
import com.group7.service.diagramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 图表服务实现类
 */
@Service
public class diagramServiceImpl implements diagramService {

    @Autowired
    private diagramDao diagramdao;

    @Override
    public List<Map> getDaikuan(Map map) {
        return diagramdao.getDaikuan(map);
    }

    @Override
    public List<Map> getHuankuan(Map map) {
        return diagramdao.getHuankuan(map);
    }

    @Override
    public List<Map> getChongChi(Map map) {
        return diagramdao.getChongChi(map);
    }

    @Override
    public List<Map> getTiXian(Map map) {
        return diagramdao.getTiXian(map);
    }
}
