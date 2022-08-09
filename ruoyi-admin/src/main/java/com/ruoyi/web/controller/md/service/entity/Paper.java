package com.ruoyi.web.controller.md.service.entity;

public class Paper {
    private int articleId;
    private String title;

    public Paper(int articleId, String title) {
        this.articleId = articleId;
        this.title = title;
    }

    public Paper() {
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
