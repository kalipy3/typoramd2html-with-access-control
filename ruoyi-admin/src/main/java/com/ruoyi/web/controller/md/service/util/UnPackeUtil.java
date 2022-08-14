package com.ruoyi.web.controller.md.service.util;

import com.github.junrar.Archive;
import com.github.junrar.rarfile.FileHeader;
import net.lingala.zip4j.core.ZipFile;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;


public class UnPackeUtil {

    private static final Logger logger = LoggerFactory.getLogger(UnPackeUtil.class);

    /**
     * zip文件解压
     *
     * @param destPath 解压文件路径
     * @param zipFile  压缩文件
     * @param password 解压密码(如果有)
     */
    public static void unPackZip(File zipFile, String password, String destPath) {
        try {
            ZipFile zip = new ZipFile(zipFile);
            /*zip4j默认用GBK编码去解压,这里设置编码为GBK的*/
            zip.setFileNameCharset("utf-8");
            logger.info("begin unpack zip file....");
            zip.extractAll(destPath);
            // 如果解压需要密码
            if (password != null) {
                if (zip.isEncrypted()) {
                    zip.setPassword(password);
                }
            }
        } catch (Exception e) {
            logger.error("解压失败：", e.getMessage(), e);
        }
    }

    /**
     * rar文件解压(不支持有密码的压缩包)
     *
     * @param rarFile  rar压缩包
     * @param destPath 解压保存路径
     */
    public static void unPackRar(File rarFile, String destPath) {
        try (Archive archive = new Archive(rarFile)) {
            if (null != archive) {
                FileHeader fileHeader = archive.nextFileHeader();
                File file = null;
                while (null != fileHeader) {
                    // 防止文件名中文乱码问题的处理
                    String fileName = fileHeader.getFileNameW().isEmpty() ? fileHeader.getFileNameString() : fileHeader.getFileNameW();
                    if (fileHeader.isDirectory()) {
                        //是文件夹
                        file = new File(destPath + File.separator + fileName);
                        file.mkdirs();
                    } else {
                        //不是文件夹
                        file = new File(destPath + File.separator + fileName.trim());
                        if (!file.exists()) {
                            if (!file.getParentFile().exists()) {
                                // 相对路径可能多级，可能需要创建父目录.
                                file.getParentFile().mkdirs();
                            }
                            file.createNewFile();
                        }
                        FileOutputStream os = new FileOutputStream(file);
                        archive.extractFile(fileHeader, os);
                        os.close();
                    }
                    fileHeader = archive.nextFileHeader();
                }
            }
        } catch (Exception e) {
            logger.error("解压失败：", e.getMessage(), e);
        }
    }






    private final static String ZIP_FILE = "application/zip";
    private final static String RAR_FILE = "application/vnd.rar";

    public static String uploadPack(MultipartFile uploadFile, String destPath) {
        boolean isZipPack = true;

        //不存在则创建
        File packFile = new File(destPath);
        if (!packFile.exists()) {
            boolean mkdirs = packFile.mkdirs();
        }

        if (uploadFile== null) {
            throw new RuntimeException("请上传文件");
        }
        String contentType = uploadFile.getContentType();
        String filename = uploadFile.getOriginalFilename();
        //将压缩包保存在指定路径
        String packFilePath = destPath + File.separator + filename;
        if (ZIP_FILE.equals(contentType)) {
            //zip解压缩处理
        } else if (RAR_FILE.equals(contentType)) {
            //rar解压缩处理
            isZipPack = false;
        } else {
            throw new RuntimeException("上传的压缩包格式不正确,仅支持rar和zip压缩文件!");
        }

        File file = new File(packFilePath);

        try {
            uploadFile.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("压缩文件到:" + destPath + " 失败!");
        }
        if (isZipPack) {
            //zip压缩包
            UnPackeUtil.unPackZip(file, null, destPath);
        } else {
            //rar压缩包
            UnPackeUtil.unPackRar(file, destPath);
        }
        //获取压缩包名称
        filename = filename.substring(0, filename.lastIndexOf("."));

        System.out.println("解压成功，解压目录：" + packFilePath);
        //可以根据解压路径、压缩包名称、文件名称，取出对应文件进行操作
        //
        
        return filename;
    }
}



