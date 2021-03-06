package com.esportzoo.esport.connect.request;

import java.io.Serializable;

public class MatchRequest extends BaseRequest implements Serializable {

	private static final long serialVersionUID = 5479984590421426830L;
	/*游戏类型*/
	private Integer videogameId;
	/*赛事状态*/
	private Integer status;
	/** 联赛id */
	private Long leagueId;
	/** 数据加载方式 */
	private Integer loadType;
	/** 自主创建赛事名字 */
	private String leagueNameSlug;

	private  Integer loadDayRange;

	private  Integer pullPageNo;

	private  Integer bottomPageNo;

	private Integer pageNo = 1;

	private Integer pageSize = 20;

	private Long userId;

	public Integer getVideogameId() {
		return videogameId;
	}

	public void setVideogameId(Integer videogameId) {
		this.videogameId = videogameId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getLeagueId() {
		return leagueId;
	}

	public void setLeagueId(Long leagueId) {
		this.leagueId = leagueId;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getLoadType() {
		return loadType;
	}

	public void setLoadType(Integer loadType) {
		this.loadType = loadType;
	}

	public Integer getLoadDayRange() {
		return loadDayRange;
	}

	public void setLoadDayRange(Integer loadDayRange) {
		this.loadDayRange = loadDayRange;
	}

	public Integer getPullPageNo() {
		return pullPageNo;
	}

	public void setPullPageNo(Integer pullPageNo) {
		this.pullPageNo = pullPageNo;
	}

	public Integer getBottomPageNo() {
		return bottomPageNo;
	}

	public void setBottomPageNo(Integer bottomPageNo) {
		this.bottomPageNo = bottomPageNo;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getLeagueNameSlug() {
		return leagueNameSlug;
	}

	public void setLeagueNameSlug(String leagueNameSlug) {
		this.leagueNameSlug = leagueNameSlug;
	}
}
