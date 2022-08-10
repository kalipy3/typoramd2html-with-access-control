package com.ruoyi.web.controller.md.service.entity;

public class Article {
    private int id;
    private int pid;
    private String level;
    private String no;
    private String label;
    private String content;
    private int permission;
    private int articleId;
    private Article[] children;

    public Article() {}

    public Article(int id, int pid, String level, String no, String label, String content, int permission, int articleId, Article[] children) {
        this.id = id;
        this.pid = pid;
        this.level = level;
        this.no = no;
        this.label = label;
        this.content = content;
        this.permission = permission;
        this.articleId = articleId;
        this.children = children;
    }

    public Article(int id, int pid, String level, String no, String label, String content, Article[] children) {
        this.id = id;
        this.pid = pid;
        this.level = level;
        this.no = no;
        this.label = label;
        this.content = content;
        this.children = children;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPermission() {
        return permission;
    }

    public void setPermission(int permission) {
        this.permission = permission;
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public Article[] getChildren() {
        return children;
    }

    public void setChildren(Article[] children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "Article{" +
            "id = " + id +
            ", pid = " + pid +
            ", level = " + level +
            ", no = " + no +
            ", label = " + label +
            ", content = " + content +
            ", permission = " + permission +
            ", articleId = " + articleId +
            ", children = " + java.util.Arrays.toString(children) +
            "}";
    }

}


