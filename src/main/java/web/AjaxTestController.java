package web;

import java.io.File;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import bean.College;
import bean.Data;


@Controller
@RequestMapping(value = "ajaxTest")
public class AjaxTestController {
    /**
     * 先执行此方法
     */
    @ModelAttribute
    public College get(@RequestParam(required = false) String id) {
        return new College();
    }

    @RequestMapping(value = {"main", ""})
    public String main() {
        return "ajaxTest";
    }

    @RequestMapping(value = "contentTypeJson")
    @ResponseBody
    public College contentTypeJson(@RequestBody College college) {
        return college;
    }

    @RequestMapping(value = "contentTypeText")
    @ResponseBody
    public College contentTypeText(College college) {
        return college;
    }

    @RequestMapping(value = "upload")
    @ResponseBody
    public String upload(HttpServletRequest request, @RequestParam(value = "file") MultipartFile file) {
        System.out.println("开始");
        String path = request.getSession().getServletContext().getRealPath("/upload");
        String fileName = file.getOriginalFilename();
        // String fileName = new Date().getTime()+".jpg";
        System.out.println(path);
        assert fileName != null;
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            boolean result = targetFile.mkdirs();
            if (!result) {
                return "创建父路径失败";
            }
        }

        // 保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String s = request.getContextPath() + File.separator + "upload" + File.separator + fileName;
        Data data = new Data();
        data.setMessage(s);
        data.setSuccess(true);
        s = JSON.toJSONString(data);
        return s;
    }
}
