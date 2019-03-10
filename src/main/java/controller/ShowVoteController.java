package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import bean.MSG;
import bean.Option;
import bean.Theme;
import bean.User;
import service.ThemeService;
import service.UserService;
import utils.DateConvertUtil;

@Controller
public class ShowVoteController {

	@Autowired
	ThemeService themeService;

	@Autowired
	UserService userService;

	/**
	 * 后台管理显示投票列表
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/showVoteList")
	public MSG showtThemeList(String user_id) {
		List<Theme> allThemes = themeService.getUserThemes(user_id);
		return MSG.success().add("themes", allThemes);
	}

	/**
	 * 获得当个投票信息
	 * 
	 * @param vote_id
	 * @param model
	 * @return
	 */
	@RequestMapping("/getVoteInfo")
	public ModelAndView showVoteInfo(String vote_id) {
		Theme vote = themeService.getVote(vote_id);
		int totalVote = 0;
		for (Option option : vote.getOptions()) {
			totalVote += option.getVotedTimes();
		}
		vote.setTotalVote(totalVote);
		ModelAndView mv = new ModelAndView();
		mv.addObject("vote", vote);
		mv.addObject("createtime", DateConvertUtil.getFormatDate(vote.getCreatetime()));
		mv.addObject("endtime", DateConvertUtil.getFormatDate(vote.getEndtime()));
		mv.setViewName("voteInfo.jsp");
		return mv;
	}

	/**
	 * 主页显示投票列表 或 显示搜索结果
	 * 
	 * @param pageNum
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getAllVotes")
	public MSG getAllVotes(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, String keyWord) {
		PageHelper.startPage(pageNum, 5);
		List<Theme> themes;
		if(keyWord == null || "".equals(keyWord)) { //如果没有搜索关键字，表示展示首页投票列表
			themes = themeService.getAllVotes();
		} else {									//显示搜索结果列表
			themes = themeService.seachVote(keyWord);
		}
		
		for (Theme theme : themes) {
			int num = 0;
			List<Option> options = theme.getOptions();
			for (Option option : options) {
				num += option.getVotedTimes();
			}
			theme.setTotalVote(num);
		}
		PageInfo<Theme> pageInfo = new PageInfo<Theme>(themes, 5);
		return MSG.success().add("pageInfo", pageInfo);
	}
	
//	@ResponseBody
//	@RequestMapping("/seachVote")
//	public MSG seachVote(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, String keyWord) {
//		PageHelper.startPage(pageNum, 5);
//		List<Theme> themes = themeService.seachVote(keyWord);
//		for (Theme theme : themes) {
//			int num = 0;
//			List<Option> options = theme.getOptions();
//			for (Option option : options) {
//				num += option.getVotedTimes();
//			}
//			theme.setTotalVote(num);
//		}
//		PageInfo<Theme> pageInfo = new PageInfo<Theme>(themes, 5);
//		return MSG.success().add("pageInfo", pageInfo);
//	}

	/**
	 * 展示投票界面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/showDoVoteView")
	public ModelAndView showDoVoteView(String id) {
		Theme vote = themeService.getVote(id);
		int totalVote = 0;
		for (Option option : vote.getOptions()) {
			totalVote += option.getVotedTimes();
		}
		vote.setTotalVote(totalVote);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("vote", vote);
		
		// 获得用户姓名
		User user = userService.getUserById(vote.getUserId());
		mv.addObject("vote_username", user.getUsername());
		
		mv.addObject("endtime", DateConvertUtil.getFormatDate(vote.getEndtime()));
		mv.setViewName("doVote.jsp");
		return mv;
	}
}
