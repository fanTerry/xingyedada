<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta name=”robots” content=”noindex,nofollow” />
<title>部落(海南)电竞</title>
<link href="" rel="shortcut icon" type="image/x-icon" />

<jsp:include page="/WEB-INF/commons/common-file.jsp"/>
<script type="text/javascript" src="/resources/plugins/jquery.cookie/1.4.1/jquery.cookie.js"></script>

<body class="admin_bg">
	<!-- 头部 -->
	<jsp:include page="/WEB-INF/commons/header.jsp"/>

    <div class="content clearfix">
        <jsp:include page="/WEB-INF/commons/profit-left.jsp">
			<jsp:param name="menu" value="profit_index"/>
		</jsp:include>
        <div class="aside">        
            <div class="wrap1080 ppd70">
                <p class="pu_title">
                	发布竞彩足球亚盘盈利计划
                </p>
                <div class="jd_title clearfix add_lh">
                    <h5 class="fl">赛事类型</h5>
                    <ul class="tab_play">
                        <li ><a href="/profit/index">2串1</a></li>
                        <li class="play_cho"><a href="/profit/yp/index">亚盘</a></li>
                    </ul>
                </div>
                <div class="jd_title clearfix add_lh">
                    <h5 class="fl">请选择盈利计划</h5>
                    <select name="profitPlanId" id="jq_profit_id">
                        <c:forEach items="${profitList}" var="profitPlan" varStatus="status">
                        	<option value="${profitPlan.id }" <c:if test="${status.index == 0}"> selected </c:if> >${profitPlan.title }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="jd_title clearfix add_lh">
                    <h5 class="fl">请至少选择1场比赛</h5>
                    <span id="matchDisplay" class="sqsh sqsh2">收起赛事</span>
                </div>
               
                <!-- 赛事选择 -->
                <div class="text_nocenter pub_list_jczq" style="display: block;">
					<table id="jczq_yp_table" class="BMTable">
						<tr style="background-color: #dddddd" class="th12">
							<th>编号</th>
							<th class="competition">
								<div>
									<div>
										<span>赛事</span><i class="sprite"></i>
									</div>
									<jsp:include page="/WEB-INF/jsp/common/publish-common-league.jsp"/>
								</div>
							</th>
							<th>比赛时间</th>
							<th>主队</th>
							<th>比分</th>
							<th>客队</th>
							<th>盘口</th>
							<th>主胜</th>
							<th>客胜</th>
							<th>数据</th>
							<th>平均欧赔</th>
						</tr>
						
						<c:if test="${empty groupVoList}">
							<tbody>
								<tr>
									<td colspan="12">暂时没有数据</td>
								</tr>
							</tbody>
						</c:if>
						<c:forEach items="${groupVoList}" var="groupVo">
							<tbody>
								<tr>
									<td colspan="12" class="game_time">
										<span> <span class="time_marr">${groupVo.groupName}</span>${groupVo.dayOfWeek}(12:00-次日12:00)</span>
										<i class="sprite Jq_i_bottom"></i>
									</td>
								</tr>
					
								<c:forEach items="${groupVo.matchVoList}" var="matchVo">
									<c:set var="yp_handicap" value="${fn:split(matchVo.spYP, '|')[0]}"/>
									<c:set var="yp_3" value="${fn:split(fn:split(matchVo.spYP, '|')[1], '-')[0]}"/>
									<c:set var="yp_0" value="${fn:split(fn:split(matchVo.spYP, '|')[1], '-')[1]}"/>
									<c:set var="eroup_3" value="${fn:split(matchVo.avgEroupSp, '-')[0]}"/>
									<c:set var="eroup_1" value="${fn:split(matchVo.avgEroupSp, '-')[1]}"/>
									<c:set var="eroup_0" value="${fn:split(matchVo.avgEroupSp, '-')[2]}"/>
									
									<tr data-leaguename="${matchVo.leagueName}" data-gametype="4078" data-raceid="${matchVo.raceId }" data-leagueindex="${matchVo.leagueIndex}" data-fxid="${matchVo.fxId}" data-matchid="${matchVo.matchId}" data-matchno="${matchVo.uniqueMatchNo}" class="Jq_line_match">
										<td class="game_number">${matchVo.matchNo}</td>
										<td class="game_match"><span style="background-color: #005bd8;">${matchVo.leagueName}</span></td>
										<td class="game_start"><fmt:formatDate value="${matchVo.matchTime.time}" pattern="HH:mm"/></td>
										<td class="game_host">${matchVo.homeTeamName}</td>
										<td class="game_score">VS</td>
										<td class="game_guest">${matchVo.guestTeamName}</td>
										<td class="game_pankou" data-handicap="${empty yp_handicap ? null : yp_handicap}">
											${empty yp_handicap ? '-' : yp_handicap}
										</td>
										<td class="game_sheng gm_bgp Jq_sp" data-index="0" data-sp="${empty yp_3 ? null : '3-'.concat(yp_3)}">
											${empty yp_3 ? '-' : yp_3}
										</td>
										<td class="game_fu gm_bgp Jq_sp" data-index="1" data-sp="${empty yp_0 ? null : '0-'.concat(yp_0)}">
											${empty yp_0 ? '-' : yp_0}
										</td>
										<td class="game_trend">
											<em><a href="http://live.aicai.com/zc/xyo_${matchVo.fxId}_407.html" target="_blank">析</a></em>
					          	    		<em><a href="http://www.aicai.com/lotnew/jc/zqchart/${matchVo.matchId}.htm" target="_blank">势</a></em>
					              			<em><a href="https://yq.aicai.com/matchPlanDetail/${matchVo.fxId}-1/matchPlanIntelligence?showHeader=1" target="_blank">情</a></em>
										</td>
										<td class="game_odds">
											<em class="ml0">${empty eroup_3 ? '-' : eroup_3}</em>
						      				<em>${empty eroup_1 ? '-' : eroup_1}</em>
						      				<em>${empty eroup_0 ? '-' : eroup_0}</em>
										</td>
									</tr>
								</c:forEach>
							</tbody>	
						</c:forEach>
					</table>
            	</div> 
            	<div class="game_reason">
                    <div class="intro_reason intro_reason2" style="margin-top:16px;">
	                	<div style="margin-bottom:8px">提示：编辑内容含有图片时，请在编辑区手工上传。</div>
	                	<span>解读内容(选填)：</span>
	                	<div style="margin-top:-12px">
	                		<textarea id="jq_text_content" name="content" placeholder="请输入专家解读内容，分析越透彻，内容越详细，查看的用户越多，您的收益也越多！（注：内容不得含非法、虚假内容或联系方式）"></textarea>
						</div>
	                </div>
                    <div class="clearfix">
                        <a class="confirm_push confirm_push2" id="btnNowSubmit">提交推荐</a>
                    </div>
                </div>   
        	</div>
    	</div>
    </div>
	<!-- 尾部 -->
	<jsp:include page="/WEB-INF/commons/footer.jsp"/>
    
	<!-- 发布推荐成功 -->
    <div class="bg_rgba" style="display:none"></div>
    <div id="dialog-success" class="pub_success" style="display:none">
        <p class="sprite success_close" data-mark="x"></p>
        <p class="sprite success_logo"></p>
        <p class="success_word">恭喜你发布亚盘盈利计划方案成功</p>
        <div class="success_btn">
            <a href="javascript:void(0)" class="success_look">查看方案</a>
            <a href="/profit/yp/index" class="go_pub">继续发布</a>        
        </div>
    </div>
	<!-- 发布失败 -->
    <div id="dialog-error" class="pub_success" style="display:none">
        <p class="sprite success_close" data-mark="x"></p>
        <p class="sprite fail_logo"></p>
        <p class="fail_word">抱歉,发布未成功</p>
        <p class="return_word">请返回重新发布</p>
        <a href="javascript:void(0)" class="return_btn" data-mark="x">返回</a>
    </div>
	<!-- 无logo -->
    <div id="dialog-alert" class="pub_success" style="display:none">
        <p class="sprite success_close" data-mark="x"></p>
        <p class="success_word success_word2">至少选择一场比赛</p>
        <a href="javascript:void(0)" class="return_btn" data-mark="x">确定</a>
    </div>
    <div id="dialog-reload" class="pub_success" style="display:none">
	    <p class="sprite success_close" data-mark="x"></p>
	    <p class="success_word success_word2">xx</p>
	    <a href="javascript:void(0)" class="return_btn" id="jq_reload">确定</a>
	</div>

<script src="/resources/plugins/kindeditor/4.1.11/kindeditor-all.js" charset="utf-8"></script>
<script src="/resources/js/jiedu.js"></script>
<script src="/resources/js/profit_publish.js"></script>
<script>
$(document).ready(function(){
  	//发布解读
	$("#btnNowSubmit").click(function(){
		var _this = this;
		if($(_this).data('isLock')){return;};
		$(_this).data('isLock', 1);
		setTimeout(function(){
			$(_this).data('isLock', 0);
		}, 15000); 
		
		var data = publish.getPostDataYp();
		if($.type(data) === "object"){
			console.log(JSON.stringify(data));
			$.ajax({
				contentType : 'application/json',
				type: "POST",
	         	dataType: "json",
				url: "/profit/save",
				data: JSON.stringify(data),
				success: function(json){
					$(_this).data('isLock', 0);
					
					if(json.isSuccess){
						var uri = "";
						if(!json.model) {
							uri = "/profit/publishRecord/";
						} else {
							uri = "/profit/publishRecordDetail/" + json.model;
						}
						return jiedu.dialog.success(uri);
					}else if(json.code == "101"){
						return alert(json.msg);
					}else if(json.code == "-1"){
						return jiedu.dialog.error();
					}else{
						return jiedu.dialog.alert(json.msg);
					}
				}
			});
		} 
    });
});

</script>
</body>
</html>