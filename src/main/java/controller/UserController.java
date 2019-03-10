package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bean.User;
import service.UserService;
import utils.UUIDUtil;

@Controller
public class UserController {

	@Autowired
	UserService userService;

//	@RequestMapping("/register")
//	public ModelAndView doRegister(User user, HttpSession session) {
//		ModelAndView mv = new ModelAndView();
//		User find_user = userService.checkUser(user.getUsername());
//		/*为空既未查到相同用户名的用户，既用户名可用，返回success，否则返回fail*/
//		if (find_user == null) {
//			user.setId(UUIDUtil.getId());
//			userService.addUser(user);
//			session.setAttribute("user_id", user.getId());
//			session.setAttribute("username", user.getUsername());
//			mv.setViewName("VoteIndex.jsp");
//			return mv;
//		} else {
//			mv.addObject("find_user", "用户名已存在");
//			mv.setViewName("loginAndRegister.jsp");
//			return mv;
//		}
//	}
	
	@RequestMapping("/register")
	public String doRegister(User user, HttpSession session) {
		user.setId(UUIDUtil.getId());
		userService.addUser(user);
		session.setAttribute("user_id", user.getId());
		session.setAttribute("username", user.getUsername());
		return "VoteIndex.jsp";
	}

	@RequestMapping("/login")
	public ModelAndView doLogin(User user, HttpSession session) {
		User result = userService.getUser(user);
		ModelAndView mv = new ModelAndView();
		if (result != null) {
			session.setAttribute("user_id", result.getId());
			session.setAttribute("username", user.getUsername());
			mv.setViewName("VoteIndex.jsp");
			return mv;
		} else {
			mv.addObject("msg", "用户名或密码错误");
			mv.setViewName("loginAndRegister.jsp");
			return mv;
		}
	}

	@ResponseBody
	@RequestMapping("/updatePassword")
	public String doUpdatePassword(User user, String oldPwd, String newPwd) {
		boolean isSuccess = userService.editPassword(user, oldPwd, newPwd);
		if (isSuccess) {
			return "success";
		} else {
			return "fail";
		}
	}

	@ResponseBody
	@RequestMapping("/checkUser")
	public String checkUser(String username) {
		User user = userService.checkUser(username);
		/*为空既未查到相同用户名的用户，既用户名可用，返回success，否则返回fail*/
		if (user == null) {
			return "success";
		} else {
			return "fail";
		}
	}

	@RequestMapping("/exit")
	public String doExit(HttpSession session) {
		session.invalidate();
		return "VoteIndex.jsp";
	}

}
