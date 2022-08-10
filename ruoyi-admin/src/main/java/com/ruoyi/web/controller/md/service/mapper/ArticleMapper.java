package com.ruoyi.web.controller.md.service.mapper;
import java.util.List;
import java.util.Map;


import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.ArticleMenu;
import com.ruoyi.web.controller.md.service.entity.Paper;

public interface ArticleMapper
{
    public int insertArticle(Map<String, Object> map);

    public int insertArticleMenu(Map<String, Object> map);

    public int insertArticleBatch(List<Article> list);


    public List<Paper> selectArticleList();
    public ArticleMenu selectArticleMenu(int articleId);
    public List<Article> selectArticleChapterList(int articleId);

    public Article selectChapterContent(Map<String, Object> map);
}
