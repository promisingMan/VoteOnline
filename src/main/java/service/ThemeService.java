package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bean.Theme;
import bean.ThemeExample;
import bean.ThemeExample.Criteria;
import dao.ThemeMapper;

@Service
public class ThemeService {

	@Autowired
	ThemeMapper themeMapper;

	/**
	 * 创建投票
	 * 
	 * @param theme
	 */
	public void createVote(Theme theme) {
		themeMapper.insertSelective(theme);
	}

	/**
	 * 
	 * @return
	 */
	public List<Theme> getUserThemes(String user_id) {
		ThemeExample example = new ThemeExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(user_id);
		criteria.andIsDeletedEqualTo(0);
		List<Theme> themes = themeMapper.selectByExample(example);
		return themes;
	}

	/**
	 * 获取所有的主题
	 * 
	 * @return
	 */
	public List<Theme> getAllThemes() {
		List<Theme> themes = themeMapper.selectByExample(null);
		return themes;
	}

	/**
	 * 获取一个投票
	 * 
	 * @param vote_id
	 * @return
	 */
	public Theme getVote(String vote_id) {
		return themeMapper.selectByPrimaryKeyWithOptions(vote_id);
	}

	/**
	 * 获得封装了选项的主题
	 * 
	 * @return
	 */
	public List<Theme> getAllVotes() {
		ThemeExample example = new ThemeExample();
		Criteria criteria = example.createCriteria();
		criteria.andIsDeletedEqualTo(0);
		List<Theme> themes = themeMapper.selectByExampleWithOptionsWithSelect(example);
		return themes;
	}
	
	/**
	 * 按照关键字寻找投票
	 * @return
	 */
	public List<Theme> seachVote(String keyWord) {
		ThemeExample example = new ThemeExample();
		Criteria criteria = example.createCriteria();
		criteria.andIsDeletedEqualTo(0);
		criteria.andNameLike("%"+keyWord+"%");
		List<Theme> themes = themeMapper.selectByExampleWithOptionsWithSelect(example);
		return themes;
	}

	/**
	 * 获取一个主题
	 * 
	 * @param id
	 * @return
	 */
	public Theme getTheme(String id) {
		return themeMapper.selectByPrimaryKey(id);
	}

	/**
	 * 根据id删除投票
	 * 
	 * @param vote_id
	 */
	public void deleteVoteById(String vote_id) {
		Theme theme = new Theme();
		theme.setId(vote_id);
		theme.setIsDeleted(1);
		themeMapper.updateByPrimaryKeySelective(theme);
	}

	public void modifyTheme(Theme theme) {
		themeMapper.updateByPrimaryKeySelective(theme);
	}

}
