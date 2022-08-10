package com.ruoyi.web.controller.md.service.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.ruoyi.web.controller.md.service.entity.Article;


import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;

public class ArticleUtil {

    public static void dfs(List<Article> res, List<Article> list) {
        for (int i = 0; i < list.size(); i++) {
            Article node = (Article)list.get(i);
            Article chapter = new Article(node.getId(), node.getPid(), node.getLevel(), node.getNo(), node.getLabel(), node.getContent(), null);
            res.add(chapter);
            if (list.get(i).getChildren().length != 0) {
                dfs(res, Arrays.asList(list.get(i).getChildren()));
            }
        }
    }

    public static List<Article> parseArticle(JSONArray json){
        List<Article> list = JSON.parseArray(json.toJSONString(), Article.class);

        List<Article> res = new ArrayList<>();
        dfs(res, list);

        for (int i = 0; i < res.size(); i++) {
            System.out.println(res.get(i)); 
        }

        return res;
    }
}

