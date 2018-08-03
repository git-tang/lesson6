package com.biz.lesson.util;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.URL;
import java.util.Date;
import java.util.Properties;

public class OSSUtil {

    private final Logger LOG = LoggerFactory.getLogger(OSSUtil.class);
    // 阿里云API的内或外网域名
    private String ENDPOINT;
    // 阿里云API的密钥Access Key ID
    private String ACCESS_KEY_ID;
    // 阿里云API的密钥Access Key Secret
    private String ACCESS_KEY_SECRET;

    private String BNCKENAME = null;

    private String PICLOCATION = null;

    OSSClient client = null;

    /**
     * oss.properties文件
     *
     */
    private final String CONFIG_PROPERTIES = "oss.properties";


    public void getValue() throws IOException {

        ENDPOINT = getConfigResource("endpoint");
        ACCESS_KEY_ID = getConfigResource("accessKeyId");
        ACCESS_KEY_SECRET = getConfigResource("accessKeySecret");
        PICLOCATION = getConfigResource("picLocation");
        BNCKENAME = getConfigResource("bucketName");
        init();

    }

    @SuppressWarnings("deprecation")
    public void init() {
        client = new OSSClient(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
    }

    /**
     *
     * 测试类
     * @throws FileNotFoundException
     */

    public void name() throws FileNotFoundException {
        String file = "F:\\4.png";

        upload(file);

    }

    /**
     * 获得oss.properties中的值
     *
     * @param key
     * @return
     * @throws IOException
     */
    public String getConfigResource(String key) throws IOException {
        ClassLoader loader = Thread.currentThread().getContextClassLoader();
        Properties properties = new Properties();
        InputStream in = loader.getResourceAsStream(CONFIG_PROPERTIES);
        properties.load(in);
        String value = properties.getProperty(key);
        // 编码转换，从ISO-8859-1转向指定编码
        value = new String(value.getBytes("ISO-8859-1"), "UTF-8");
        in.close();
        return value;
    }

    public void upload(String url) {

        try {
            getValue();
        } catch (IOException e) {
            e.printStackTrace();
        }

        File file = new File(url);
        System.out.println("uploa" + file.getPath() + file.getName());

        try {

            String bucketName = "file-img";

            InputStream is = new FileInputStream(file);

            String fileName = file.getName();

            long fileLength = file.length();

            // 创建上传Object的Metadata
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(is.available());
            metadata.setCacheControl("no-cache");
            metadata.setHeader("Pragma", "no-cache");
            metadata.setContentEncoding("utf-8");
            metadata.setContentType(this.getContentType(fileName));
            metadata.setContentDisposition("filename/filesize=" + fileName
                    + "/" + fileLength + "Byte.");

            client.putObject(bucketName, fileName, is, metadata);

        } catch (Exception e) {

            LOG.error("上传阿里云OSS服务器异常." + e.getMessage(), e);
        }
        //client.shutdown();

        //URL url1 = get();
        //return url1;
    }

    /**
     *
     * @return
     */
    public URL get() {
        Date expiration = new Date(new Date().getTime() + 3600l * 1000 * 24
                * 365 * 10);
        URL url = client.generatePresignedUrl(BNCKENAME, ACCESS_KEY_ID,
                expiration);
        OSSObject object = client.getObject(BNCKENAME, ACCESS_KEY_ID);

        System.out.println(object.getObjectContent().toString());
        return url;
    }

    /**
     * 获得文件类型
     *
     * @param fileName
     * @return
     */
    private String getContentType(String fileName) {
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        if (".bmp".equalsIgnoreCase(fileExtension))
            return "image/bmp";
        if (".gif".equalsIgnoreCase(fileExtension))
            return "image/gif";
        if (".jpeg".equalsIgnoreCase(fileExtension))
            return "image/jpeg";
        if (".jpg".equalsIgnoreCase(fileExtension))
            return "image/jpeg";
        if (".png".equalsIgnoreCase(fileExtension))
            return "image/jpeg";
        if (".html".equalsIgnoreCase(fileExtension))
            return "text/html";
        if (".txt".equalsIgnoreCase(fileExtension))
            return "text/plain";
        if (".vsd".equalsIgnoreCase(fileExtension))
            return "application/vnd.visio";
        if (".ppt".equalsIgnoreCase(fileExtension)
                || "pptx".equalsIgnoreCase(fileExtension))
            return "application/vnd.ms-powerpoint";
        if (".doc".equalsIgnoreCase(fileExtension)
                || "docx".equalsIgnoreCase(fileExtension))
            return "application/msword";
        if (".xml".equalsIgnoreCase(fileExtension))
            return "text/xml";

        System.out.println(fileExtension);
        return "text/html";

    }

}