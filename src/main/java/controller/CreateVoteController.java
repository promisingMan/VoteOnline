package controller;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bean.Option;
import bean.Theme;
import service.OptionService;
import service.ThemeService;
import utils.UUIDUtil;

@Controller
public class CreateVoteController {

	@Autowired
	ThemeService themeService;

	@Autowired
	OptionService optionService;

	Theme theme_param = new Theme();

	@RequestMapping(value = "/createVote")
	public String createVote(@RequestParam MultipartFile[] img, Theme theme, HttpSession session) {
		try {
			for (MultipartFile image : img) {
				if (!image.isEmpty()) {
					String path = session.getServletContext().getRealPath("/static/images");
					String fileName = image.getOriginalFilename();
					String serverPath = path + File.separator + fileName;
					// String realPath = "E:\\git_repository\\VoteOnlineSystem\\src\\main\\webapp\\static\\images" + File.separator + fileName;
					if (fileName.endsWith("jpg") || fileName.endsWith("png") || fileName.endsWith("gif")) {
						
						//保存到本地
						// File file1 = new File(realPath);
						// image.transferTo(file1);
						
						//保存到服务器
						File file = new File(serverPath);
						image.transferTo(file);
					}
				} else {
					continue;
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "fail.jsp";
		}
		// 插入UUID给主题表
		theme.setId(theme_param.getId());
		// 给主题表设置创建时间
		theme.setCreatetime(new Date());
		// 给主题表设置创建者
		themeService.createVote(theme);
		return "showVoteList.jsp";
	}

	@ResponseBody
	@RequestMapping("/createOption")
	public String createOption(String[] str_options, String type) {
		theme_param.setId(UUIDUtil.getId());
		// 插入选项表
		for (int i = 0; i < str_options.length; i++) {

			String[] split = str_options[i].split("-");

			Option options = new Option();
			options.setThemeId(theme_param.getId());
			options.setType(type);
			options.setContent(split[0]);
			if (split[1] != null && !"".equals(split[1])) {
				options.setLinkAddress(split[1]);
			}
			optionService.createOption(options);
		}
		return "success";
	}
}