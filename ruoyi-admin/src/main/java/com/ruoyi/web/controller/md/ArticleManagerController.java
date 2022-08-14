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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;


import com.ruoyi.web.controller.md.service.entity.Article;
import com.ruoyi.web.controller.md.service.entity.ArticleMenu;
import com.ruoyi.web.controller.md.service.entity.Paper;

import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;



import org.apache.commons.lang3.ArrayUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;

import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;


import com.ruoyi.web.controller.md.service.util.UnPackeUtil;

import java.io.IOException;

import com.ruoyi.framework.config.ServerConfig;

@RestController
@RequestMapping("/paper")
public class ArticleManagerController extends BaseController {

    @Autowired
    private IArticleService articleService;

    @Autowired
    private ServerConfig serverConfig;

    //上传文章
    //@PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(Paper paper)
    {
        startPage();//此函数里面会自动处理前端传过来的pageNum和pageSize参数
        List<Paper> list = articleService.selectArticleList(paper);
        return getDataTable(list);
    }


    //修改文章
    //@PreAuthorize("@ss.hasPermi('system:user:edit')")
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody Paper paper)
    {
        //userService.checkUserAllowed(user);

        return toAjax(articleService.updatePaper(paper));
    }

    //@PreAuthorize("@ss.hasPermi('system:user:remove')")
    //@Log(title = "用户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{articleIds}")
    public AjaxResult remove(@PathVariable Integer[] articleIds)
    {
        return toAjax(articleService.deletePaperByIds(articleIds));
    }


    @PostMapping("/upload")
    public AjaxResult uploadFile(MultipartFile file) throws Exception
    {
        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();

            // 上传并返回新文件名称
            //String fileName = FileUploadUtils.upload(filePath, file);
            String fileName = UnPackeUtil.uploadPack(file, filePath + "/" + file.getOriginalFilename().substring(0, file.getOriginalFilename().length() - 4));
            fileName += ".zip";

            fileName = FileUploadUtils.getPathFileName(filePath, fileName);

            String url = serverConfig.getUrl() + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            //ajax.put("newFileName", FileUtils.getName(fileName));
            ajax.put("newFileName", fileName);
            ajax.put("originalFilename", file.getOriginalFilename());
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }
}
