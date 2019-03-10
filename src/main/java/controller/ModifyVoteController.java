package controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bean.Option;
import bean.Theme;
import service.OptionService;
import service.ThemeService;
import utils.DateConvertUtil;

@Controller
public class ModifyVoteController {

	@Autowired
	ThemeService themeService;

	@Autowired
	OptionService optionService;

	@RequestMapping("/deleteVote")
	public String deleteVoteById(String vote_id) {
		themeService.deleteVoteById(vote_id);
		return "showVoteList.jsp";
	}

	/**
	 * 进入编辑投票界面
	 * 
	 * @param vote_id
	 * @return
	 */
	@RequestMapping("/editVote")
	public ModelAndView editVote(String vote_id) {
		ModelAndView mv = new ModelAndView();
		Theme vote = themeService.getVote(vote_id);
		mv.addObject("vote", vote);
		mv.addObject("endtime", DateConvertUtil.getFormatDate(vote.getEndtime()));
		mv.setViewName("editVote.jsp");
		return mv;
	}

	/**
	 * 
	 * @param img
	 * @param theme
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveVote")
	public String createVote(@RequestParam MultipartFile[] img, Theme theme, HttpSession session) {
		try {
			for (MultipartFile image : img) {
				if (!image.isEmpty()) {
					String path = session.getServletContext().getRealPath("/static/images");
					String fileName = image.getOriginalFilename();
					String serverPath = path + File.separator + fileName;
					
					//本地路径
					// String realPath = "E:\\git_repository\\VoteOnlineSystem\\src\\main\\webapp\\static\\images"+ File.separator + fileName;
					
					if (fileName.endsWith("jpg") || fileName.endsWith("png") || fileName.endsWith("gif")) {
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
		themeService.modifyTheme(theme);
		return "showVoteList.jsp";
	}

	@ResponseBody
	@RequestMapping("/saveOption")
	public void saveEdit(String theme_id, String[] str_options, String type) {
		// 更新option
		for (String string : str_options) {
			String[] option_id_content_linkAddress = string.split("-");
			if (" ".equals(option_id_content_linkAddress[0])) {// 新添加的选项
				Option option = new Option();
				option.setThemeId(theme_id);
				option.setType(type);
				option.setContent(option_id_content_linkAddress[1]);
				if (option_id_content_linkAddress[2] != null && !"".equals(option_id_content_linkAddress[2])) {
					option.setLinkAddress(option_id_content_linkAddress[2]);
				}
				optionService.createOption(option);
			} else {// 旧选项
				Option option = new Option();
				option.setId(Integer.parseInt(option_id_content_linkAddress[0]));
				option.setContent(option_id_content_linkAddress[1]);
				option.setType(type);
				if (option_id_content_linkAddress[2] != null && !"".equals(option_id_content_linkAddress[2])) {
					option.setLinkAddress(option_id_content_linkAddress[2]);
				}
				option.setThemeId(theme_id);
				optionService.modifyOption(option);
			}
		}
	}

}
