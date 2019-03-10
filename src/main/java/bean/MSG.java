package bean;

import java.util.HashMap;
import java.util.Map;

public class MSG {
	private int code;
	private String msg;
	private Map<String, Object> map = new HashMap<String, Object>();

	public static MSG success() {
		MSG result = new MSG();
		result.setCode(1);
		result.setMsg("处理成功");
		return result;
	}

	public static MSG fail() {
		MSG result = new MSG();
		result.setCode(0);
		result.setMsg("处理失败");
		return result;
	}

	public MSG add(String key, Object value) {
		this.getMap().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

}
