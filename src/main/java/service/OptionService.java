package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bean.Option;
import bean.OptionExample;
import bean.OptionExample.Criteria;
import dao.OptionMapper;

@Service
public class OptionService {

	@Autowired
	OptionMapper optionMapper;

	public void createOption(Option option) {
		optionMapper.insertSelective(option);
	}

	public List<Option> getOptions(String theme_id) {
		OptionExample example = new OptionExample();
		Criteria criteria = example.createCriteria();
		criteria.andThemeIdEqualTo(theme_id);
		List<Option> options = optionMapper.selectByExample(example);
		return options;
	}
	
	public void modifyOption(Option option) {
		optionMapper.updateByPrimaryKeySelective(option);
	}

}
