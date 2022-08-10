package com.ruoyi.web.controller.md.service.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.ArticleMenu;
import com.ruoyi.web.controller.md.service.entity.Paper;

public interface IArticleService
{
    public int saveArticle(JSONObject json);


    public List<Paper> selectArticleList();
    public ArticleMenu selectArticleMenu(int articleId);
    public List<Article> selectArticleChapterList(int articleId);

    public Article selectChapterContent(int articleId, int chapterId);
}
