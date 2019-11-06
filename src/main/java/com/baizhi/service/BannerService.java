package com.baizhi.service;

import com.baizhi.entity.Banner;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface BannerService {
      //参数一page：当前页  参数二rows：每页展示条数
    Map<String,Object> selectAll(Integer page,Integer rows);
    String add(Banner banner);
    void edit(Banner banner);
    void del(String id, HttpServletRequest request);
}
