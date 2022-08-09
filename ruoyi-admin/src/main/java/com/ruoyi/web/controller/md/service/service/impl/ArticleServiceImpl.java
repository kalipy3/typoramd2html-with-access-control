package com.ruoyi.web.controller.md.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.ArticleMenu;
import com.ruoyi.web.controller.md.service.entity.Paper;
import com.ruoyi.web.controller.md.service.mapper.ArticleMapper;
import com.ruoyi.web.controller.md.service.service.IArticleService;
import com.ruoyi.web.controller.md.service.util.ArticleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleServiceImpl implements IArticleService
{
    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public int saveArticle(JSONObject json) {

        //根据json解析出文章名字、文章章节菜单树、文章内容
        JSONObject jsonObject = JSON.parseObject(json.toJSONString());

        String articleName = (String)jsonObject.get("articleName");
        System.out.println("articleName:" + articleName);

        String articleMenu = ((JSONArray)(jsonObject.get("articleMenu"))).toJSONString();
        System.out.println("articleMenu:" + articleMenu);

        JSONArray article = (JSONArray)jsonObject.get("article");
        System.out.println("article parse before:" + article);
        List<Article> chapaterList = ArticleUtil.parseArticle(article);

        //存储文章名字、文章章节菜单树、文章内容(事务操作)

        //文章表
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("articleId", 666);//666是任意无意义数字，只是自增主键需要articleId字段，数据插入成功后mybatis会把自增主键填充到articleId字段中
        parameters.put("title", articleName);
        articleMapper.insertArticle(parameters);
        Integer articleId = (Integer)parameters.get("articleId");
        System.out.println("parameters articleId:" + articleId);

        //文章菜单表
        parameters = new HashMap<String, Object>();
        parameters.put("data", articleMenu);
        parameters.put("articleId", articleId);
        articleMapper.insertArticleMenu(parameters);

        //文章章节表(批量插入以提高效率)
        //1.给chapaterList填充权限和articleId
        int cnt = 0;
        for (int i = 0; i < chapaterList.size(); i++) {
            Article chapter = chapaterList.get(i);
            chapter.setArticleId(articleId);

            int id = chapter.getId();
            int pid = chapter.getPid();
            //if (id == 1 || id == 2 || id == 3)
            if (pid == -1 && ((cnt++) < 3))//每篇文章的每个章节只有第一小节可以游客试看，且只能试看三个章节
                chapter.setPermission(4);/*1:admin;2:vip;3:login;4:visitor;*/
            else
                chapter.setPermission(3);
        }

        //2.批量插入该文章的所有章节
        articleMapper.insertArticleBatch(chapaterList);

        return 0;
    }



    @Override
    public List<Paper> selectArticleList() {
        return articleMapper.selectArticleList();
    }

    @Override
    public ArticleMenu selectArticleMenu(int articleId) {
        return articleMapper.selectArticleMenu(articleId);
    }

    @Override
    public List<Article> selectArticleChapterList(int articleId) {
        return articleMapper.selectArticleChapterList(articleId);
    }

    @Override
    public String selectChapterContent(int articleId, int chapterId) {
        //权限控制
        //1.后端的admin、commn等角色转换成我们需要的persssion:/*1:admin;2:vip;3:login;4:visitor;*/
        //2.select content from table where aritcle_id = 1 and chapter_id = 1 and permission >= 1

        LoginUser loginUser = SecurityUtils.getLoginUser();
        List<SysRole> roles = loginUser.getUser().getRoles();
        int permission = Integer.MAX_VALUE;
        for (int i = 0; i < roles.size(); i++) {
            int permi = Integer.parseInt(roles.get(i).getRoleSort());//对应后台角色管理中角色的显示顺序(我们用这个顺序作为permission数字)
            permission = Math.min(permi, permission);
        }
        System.out.println("当前登录用户的permission:" + permission);

        HashMap<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("articleId", articleId);
        parameters.put("chapterId", chapterId);
        parameters.put("permission", permission);

        return articleMapper.selectChapterContent(parameters);
    }

}
