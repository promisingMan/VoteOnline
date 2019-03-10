package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bean.User;
import bean.UserExample;
import bean.UserExample.Criteria;
import dao.UserMapper;

@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	public void addUser(User user) {
		userMapper.insert(user);
	}

	public User getUser(User user) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(user.getUsername());
		criteria.andPasswordEqualTo(user.getPassword());
		List<User> trueUser = userMapper.selectByExample(example);
		if (trueUser.size() > 0) {
			return trueUser.get(0);
		}
		return null;
	}

	public User getUserById(String user_id) {
		return userMapper.selectByPrimaryKey(user_id);
	}

	public boolean editPassword(User user, String oldPwd, String newPwd) {
		String pwd = checkPwd(user.getId());
		if (pwd.equals(oldPwd)) {
			user.setPassword(newPwd);
			userMapper.updateByPrimaryKeySelective(user);
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 检查输入的原密码是否正确
	 */
	public String checkPwd(String user_id) {
		User user = userMapper.selectByPrimaryKey(user_id);
		return user.getPassword();
	}

	/**
	 * 检查是否已有此用户
	 * 
	 * @param username
	 */
	public User checkUser(String username) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(username);
		List<User> user = userMapper.selectByExample(example);
		if (user.size() > 0) {
			return user.get(0);
		}
		return null;
	}
}
