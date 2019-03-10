package bean;

import java.util.Date;
import java.util.List;

public class Theme {
	private String id;

	private String name;

	private String description;

	private Integer categoryId;

	private Date endtime;

	private Date createtime;

	private String userId;

	private Integer isDeleted;

	private List<Option> options;

	private Integer totalVote;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description == null ? null : description.trim();
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId == null ? null : userId.trim();
	}

	public Integer getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Integer isDeleted) {
		this.isDeleted = isDeleted;
	}

	public List<Option> getOptions() {
		return options;
	}

	public void setOptions(List<Option> options) {
		this.options = options;
	}

	public Integer getTotalVote() {
		return totalVote;
	}

	public void setTotalVote(Integer totalVote) {
		this.totalVote = totalVote;
	}

	@Override
	public String toString() {
		return "Theme [id=" + id + ", name=" + name + ", description=" + description + ", categoryId=" + categoryId
				+ ", endtime=" + endtime + ", createtime=" + createtime + ", userId=" + userId + ", isDeleted="
				+ isDeleted + ", options=" + options + ", totalVote=" + totalVote + "]";
	}
}