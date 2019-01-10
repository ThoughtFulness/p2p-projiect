package com.group7.serviceImpl;

import com.group7.dao.JinNangDao;
import com.group7.service.JinNangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class JInNangServiceImpl implements JinNangService {
    //
    @Autowired
    private JinNangDao jinNangDao;


    @Override
    public int getId(String userName) {
        List<Map> ListMap = jinNangDao.getId(userName);
        int userId =Integer.valueOf( ListMap.get(0).get("ID")+"");
        return userId;
    }

    @Override
    public int addJInNang(Map map) {
        return jinNangDao.addJInNang(map);
    }

    @Override
    public List<Map> getJinNangListMap(Map map) {
        return jinNangDao.getJinNangListMap(map);
    }

    @Override
    public int getJinNangCount() {
        return jinNangDao.getJinNangCount();
    }

    @Override
    public List<Map> getJinNangById(Map map) {
        return jinNangDao.getJinNangById(map);
    }

    @Override
    public int addComment(Map map) {
        return jinNangDao.addComment(map);
    }

    @Override
    public List<Map> commentList(Map map) {
        return jinNangDao.commentList(map);
    }

    @Override
    public int getCommentCount(Map map) {
        int cont =Integer.valueOf(jinNangDao.getCommentCount(map).get(0).get("CONT")+"") ;
        return cont;
    }

    @Override
    public List<Map> getTouZiCWFenXi(Map mapType) {
        return jinNangDao.getTouZiCWFenXi(mapType);
    }

    @Override
    public List<Map> getJieKuanCWFenXi(Map mapType) {
        return jinNangDao.getJieKuanCWFenXi(mapType);
    }

    @Override
    public List<Map> getTouZiLieXingFenXi(Map mapType) {
        return jinNangDao.getTouZiLieXingFenXi(mapType);
    }

    @Override
    public List<Map> getJieKuanLieXingFenXi(Map mapType) {
        return jinNangDao.getJieKuanLieXingFenXi(mapType);
    }

    @Override
    public int deleteJinNang(Integer ID) {
        return jinNangDao.deleteJinNang(ID);
    }

    @Override
    public int deleteJinNangS(String[] ids) {
        return jinNangDao.deleteJinNangS(ids);
    }
}
