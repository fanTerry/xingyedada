package com.esportzoo.esport.connect.response.expert;

import com.esportzoo.esport.constants.ArticleFreeType;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * @author tingting.shen
 * @date 2019/05/10
 */
public class ExpertArticleVo implements Serializable{

	private static final long serialVersionUID = 6928331488957973510L;
	
	/** 文章id */
	private Long id;
	/** 用户ID */
	private Long userId;
	/** 游戏ID */
	private Integer videogameId;
	/** 标题 */
    private String title;
    /** 是否免费:1是 0不是 {@link ArticleFreeType}  */
	private Integer isFree;
    /** 单价 */
    private BigDecimal price;
    /** 查看次数 */
    private Integer views;
    /** 发布时间 */
    private String publishTime;
    /** 对阵信息 */
    private List<MatchVo> matchList;
    
    /**当前登录用户是否已经支付了改文章*/
	private boolean hasPayed = false;
    
	public Long getId() {
		return id;
	}
	public String getTitle() {
		return title;
	}
	public Integer getIsFree() {
		return isFree;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public Integer getViews() {
		return views;
	}
	public String getPublishTime() {
		return publishTime;
	}
	public List<MatchVo> getMatchList() {
		return matchList;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setIsFree(Integer isFree) {
		this.isFree = isFree;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public void setViews(Integer views) {
		this.views = views;
	}
	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}
	public void setMatchList(List<MatchVo> matchList) {
		this.matchList = matchList;
	}

	public Integer getVideogameId() {
		return videogameId;
	}

	public void setVideogameId(Integer videogameId) {
		this.videogameId = videogameId;
	}
	public boolean isHasPayed() {
		return hasPayed;
	}
	public void setHasPayed(boolean hasPayed) {
		this.hasPayed = hasPayed;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}
}
