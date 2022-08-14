package com.ruoyi.web.controller.md;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.web.controller.md.service.service.IArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;


import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.ArticleMenu;
import com.ruoyi.web.controller.md.service.entity.Paper;

import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;


import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;

@RestController
public class ArticleController extends BaseController {

    @Autowired
    private IArticleService articleService;

    @RequestMapping(value = "/saveArticle", method= RequestMethod.POST)
    public int article(@RequestBody JSONObject json) throws Exception{

        return articleService.saveArticle(json);
    }

    @RequestMapping(value = "/paper", method= RequestMethod.GET)
    public TableDataInfo selectArticleList(Paper paper) {
        startPage();//此函数里面会自动处理前端传过来的pageNum和pageSize参数
        List<Paper> list = articleService.selectArticleList(paper);
        return getDataTable(list);
    }

    @RequestMapping(value = "/articleMenu/{articleId}", method= RequestMethod.GET)
    public ArticleMenu selectArticleMenu(@PathVariable("articleId") int articleId) {
        return articleService.selectArticleMenu(articleId);
    }
    
    @RequestMapping(value = "/chapters/{articleId}", method= RequestMethod.GET)
    public List<Article> selectArticleChapterList(@PathVariable("articleId") int articleId) {
        return articleService.selectArticleChapterList(articleId);
    }

    @RequestMapping(value = "/article/{articleId}/chapter/{chapterId}", method= RequestMethod.GET)
    public Article selectChapterContent(@PathVariable("articleId") int articleId, @PathVariable("chapterId") int chapterId) {
        return articleService.selectChapterContent(articleId, chapterId);
    }

    @RequestMapping(value = "/user", method= RequestMethod.GET)
    public int selectUserRoleId() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        List<SysRole> roles = loginUser.getUser().getRoles();
        int permission = Integer.MAX_VALUE;
        for (int i = 0; i < roles.size(); i++) {
            int permi = Integer.parseInt(roles.get(i).getRoleSort());
            permission = Math.min(permi, permission);
        }

        return permission;
    }

    //查询上一篇文章
    @RequestMapping(value = "/paper/prePaper/{articleId}", method= RequestMethod.GET)
    public Paper selectPrePaper(@PathVariable("articleId") int articleId) {
        return articleService.selectPrePaper(articleId);
    }
    
    //查询下一篇文章
    @RequestMapping(value = "/paper/nextPaper/{articleId}", method= RequestMethod.GET)
    public Paper selectNextPaper(@PathVariable("articleId") int articleId) {
        return articleService.selectNextPaper(articleId);
    }

}
