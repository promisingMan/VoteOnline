package controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bean.MSG;
import bean.Option;
import bean.Theme;
import bean.User;
import service.OptionService;
import service.ThemeService;
import service.UserService;
import utils.DateConvertUtil;

@Controller
public class DoVoteController {

	@Autowired
	OptionService optionService;

	@Autowired
	ThemeService themeService;
	
	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping("/doVote")
	public void doVote(String[] options, HttpServletResponse response) {
		for (String string : options) {
			String[] str_option = string.split("-");
			Option option = new Option();
			option.setId(Integer.parseInt(str_option[0]));
			option.setVotedTimes(Integer.parseInt(str_option[1]));
			optionService.modifyOption(option);
		}
	}

	@RequestMapping("/showVoteResult")
	public ModelAndView showVoteResult(String vote_id) {
		Theme vote = themeService.getVote(vote_id);
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
		mv.setViewName("voteResult.jsp");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/voteAnalysis")
	public MSG voteAnalysis(String vote_id) {
		Theme vote = themeService.getVote(vote_id);
		int totalVote = 0;
		for (Option option : vote.getOptions()) {
			totalVote += option.getVotedTimes();
		}
		vote.setTotalVote(totalVote);
		return MSG.success().add("vote", vote);
	}

}
