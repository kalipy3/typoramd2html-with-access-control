package com.ruoyi.web.controller.md.service.entity;

public class ArticleMenu
{
    private String data;
    private int articleId;

	public ArticleMenu() {
		
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public ArticleMenu(String data, int articleId) {
        this.data = data;
        this.articleId = articleId;
    }

}

