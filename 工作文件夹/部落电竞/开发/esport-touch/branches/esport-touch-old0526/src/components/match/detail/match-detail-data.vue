<template>
  <div>
    <section class="data_comparison" v-if="detailData!=null">
      <!-- 数据对比 -->
      <article v-if="detailData.homeTeamData!=null">
        <div class="title">
          <span class="comparison">数据对比</span>
          <span class="average">近5场均值数据</span>
        </div>
        <div class="data_con">
          <!-- <h3>胴体胜率比</h3> -->
          <div class="team">
            <div>
              <img :src="matchDetail.homeTeamLogo |getDefaultImg(globalConst.matchTeamDefaultIcon)" />
              {{matchDetail.homeTeamName |subStr(5)}}
            </div>
            <div>
              {{matchDetail.awayTeamName |subStr(5)}}
              <img :src="matchDetail.awayTeamLogo |getDefaultImg(globalConst.matchTeamDefaultIcon)" />
            </div>
          </div>
          <div class="KDA">
            <p>
              <span class="num pr5">{{detailData.homeTeamData.kda}}</span>
              {{detailData.homeTeamData.kills}}/{{detailData.homeTeamData.deaths}}/{{detailData.homeTeamData.assists}}
            </p>
            <p class="tips">KDA</p>
            <p>
              {{detailData.awayTeamData.kills}}/{{detailData.awayTeamData.deaths}}/{{detailData.awayTeamData.assists}}
              <span class="num pl5">{{detailData.awayTeamData.kda}}</span>
            </p>
          </div>
          <div class="bar_con">
            <div class="bar_item">
              <p>
                <span>{{detailData.homeTeamData.minionsKilled}}</span>
                <span class="tips">分均补刀</span>
                <span>{{detailData.awayTeamData.minionsKilled}}</span>
              </p>
              <div class="bar_f">
                <span class="bar_red"
                  :style="'width:'+getAvgVal(detailData.homeTeamData.minionsKilled,detailData.awayTeamData.minionsKilled)+'%'"></span>
                <span class="bar_blue"></span>
              </div>
            </div>
            <div class="bar_item">
              <p>
                <span>{{detailData.homeTeamData.goldEarned}}</span>
                <span class="tips">分均经济</span>
                <span>{{detailData.awayTeamData.goldEarned}}</span>
              </p>
              <div class="bar_f">
                <span class="bar_red"
                  :style="'width:'+getAvgVal(detailData.homeTeamData.goldEarned,detailData.awayTeamData.goldEarned)+'%'"></span>
                <span class="bar_blue"></span>
              </div>
            </div>
            <div class="bar_item">
              <p>
                <span>{{detailData.homeTeamData.damage}}</span>
                <span class="tips">分均伤害</span>
                <span>{{detailData.awayTeamData.damage}}</span>
              </p>
              <div class="bar_f">
                <span class="bar_red"
                  :style="'width:'+getAvgVal(detailData.homeTeamData.damage,detailData.awayTeamData.damage)+'%'"></span>
                <span class="bar_blue"></span>
              </div>
            </div>
          </div>
          <!-- <div class="limitations">
            <div>
              <p>
                <span class="num">0</span>场比赛时间>38
              </p>
              <div class="bar_f">
                <span class="bar_red"></span>
                <span></span>
              </div>
            </div>
            <div>
              <p>
                <span class="num">0</span>场比赛总击杀>38
              </p>
              <div class="bar_f">
                <span></span>
                <span class="bar_blue"></span>
              </div>
            </div>
          </div>-->
        </div>
      </article>
      <!-- 双方交战 -->
      <article v-if="detailData.teamBattleInfoVos!=null">
        <div class="title">
          <span class="comparison">双方交战</span>
          <span class="average">近期交锋3场</span>
        </div>
        <div class="fight_con">
          <h3>
            <span>赛事</span>
            <span>人头比</span>
            <span>日期/时长</span>
          </h3>
          <div class="fight_item" v-for="(item,index) in detailData.teamBattleInfoVos" :key="index">
            <div>
              <div class="logo">
                <img :src="item.leagueLogo |getDefaultImg(globalConst.matchTeamDefaultIcon)" />
              </div>
            </div>
            <!-- 左边队伍胜加win_left,右边胜加win_right -->
            <div>
              <div :class="item.winnerTeam==1?'win_left':'win_right'">
                <img :src="matchDetail.homeTeamLogo |getDefaultImg(globalConst.matchTeamDefaultIcon)" />
                <span class="score">{{item.homeTeamKills}} - {{item.awayTeamKills}}</span>
                <img :src="matchDetail.awayTeamLogo |getDefaultImg(globalConst.matchTeamDefaultIcon)" />
              </div>
            </div>
            <div class="time">
              {{item.matchBeginAt}}
              <br />
              {{Number.parseInt(item.length/60)}}'{{item.length%60}}"
            </div>
          </div>
          <!-- <div class="get_more">
            点击获取更多
            <span></span>
          </div>-->
        </div>
      </article>
      <!-- 对战阵容 -->
      <article v-if="matchResData.length>0||curLiveDetail!=null">
        <div class="title">
          <span class="comparison">比赛数据</span>
        </div>
        <div class="war_item" v-for="(item,index) in matchResData" :key="index">
          <span class="left_win" v-if='item.winnerTeam==1'></span>
          <span class="right_win" v-if='item.winnerTeam==0'></span>
          <div class="top">
            <div class="left">
              <p v-if="item.homeTeamPentaKills==1">
                <span class="ten"></span>五杀
              </p>
              <p v-if="item.homeTeamFirstBlood==1">
                <span class="first_blood"></span>一血
              </p>
            </div>
            <div class="center">
              <span>{{item.homeTeamKills}}</span>
              <div class="score_con">
                <p>第{{index+1}}场</p>
                <p class="score">
                  <span>{{Number.parseInt(item.length/60)}}</span>
                  <i>:</i>
                  <span>{{item.length%60}}</span>
                </p>
              </div>
              <span>{{item.awayTeamKills}}</span>
            </div>
            <div class="right">
              <p v-if="item.awayTeamPentaKills==1">
                <span class="ten"></span>五杀
              </p>
              <p v-if="item.awayTeamFirstBlood==1">
                <span class="first_blood"></span>一血
              </p>
            </div>
          </div>
          <div class="war_team">
            <span>{{matchDetail.homeTeamName |subStr(5)}}</span>
            <span>{{matchDetail.awayTeamName |subStr(5)}}</span>
          </div>
          <div class="hero_contrast">
            <div class="tal">
              <img v-for="(hero,index) in item.homeTeamHeros" :key="index" :src="hero.heroLogo" />
            </div>
            <!-- <a class="look_for">查看战报数据</a> -->
            <div class="tar">
              <img v-for="(hero,index) in item.awayTeamHeros" :key="index" :src="hero.heroLogo" />
            </div>
          </div>
        </div>
        <!-- 直播时数据-->
        <div class="war_item" v-if="curLiveDetail!=null">
          <span class="left_win" v-if='curLiveDetail.winnerTeam==1'></span>
          <span class="right_win" v-if='curLiveDetail.winnerTeam==0'></span>
          <div class="top">
            <div class="left">
              <p v-if="curLiveDetail.homeTeamPentaKills==1">
                <span class="ten"></span>五杀
              </p>
              <p v-if="curLiveDetail.homeTeamFirstBlood==1">
                <span class="first_blood"></span>一血
              </p>
            </div>
            <div class="center">
              <span>{{curLiveDetail.homeTeamKills}}</span>
              <div class="score_con">
                <p>第{{matchResData.length+1}}场</p>
                <p class="score">
                  <span>{{Number.parseInt(curLiveDetail.length/60)}}</span>
                  <i>:</i>
                  <span>{{curLiveDetail.length%60}}</span>
                </p>
              </div>
              <span>{{curLiveDetail.awayTeamKills}}</span>
            </div>
            <div class="right">
              <p v-if="curLiveDetail.awayTeamPentaKills==1">
                <span class="ten"></span>五杀
              </p>
              <p v-if="curLiveDetail.awayTeamFirstBlood==1">
                <span class="first_blood"></span>一血
              </p>
            </div>
          </div>
          <div class="war_team">
            <span>{{matchDetail.homeTeamName |subStr(5)}}</span>
            <span>{{matchDetail.awayTeamName |subStr(5)}}</span>
          </div>
          <div class="hero_contrast">
            <div class="tal">
              <img v-for="(hero,index) in curLiveDetail.homeTeamHeros" :key="index" :src="hero.heroLogo" />
            </div>
            <a class="look_for" v-if="!curLiveDetail.finished">进行中</a>
            <div class="tar">
              <img v-for="(hero,index) in curLiveDetail.awayTeamHeros" :key="index" :src="hero.heroLogo" />
            </div>
          </div>
        </div>
      </article>
      <!-- 柱状图 -->
      <!-- <article class="histogram">
        <div class="team">
          <p>
            <img src alt />
            <span class="bg_red"></span>10场
          </p>
          <p>
            <img src alt />
            <span class="bg_blue"></span>10场
          </p>
        </div>
      </article>-->
    </section>
  </div>
</template>

<script type="text/ecmascript-6">
const COMPONENT_NAME = "match-detail-data";
export default {
  name: COMPONENT_NAME,
  components: {},
  props: {
    matchDetail: Object,
    socketUrl: String,
    gameIdArray: Array
  },
  data() {
    return {
      detailData: [],
      matchResData: [],
      curLiveDetail: null,
      timer: [],
      lockReconnect: false, //默认进来是断开链接的
      limit: 0, //重连次数
      scene: "matchdata", //聊天场景
      ready: false
    };
  },
  computed: {},
  created() {},
  mounted() {
    this.getMatchTabData();
  },
  methods: {
    getMatchTabData() {
      var _self = this,
        matchStatus = _self.matchDetail.status;
      // if (matchStatus != 2) {
      //0603修改:不是结束后的比赛都有数据
      _self.getMatchHistoryData(_self);
      // }
      if (matchStatus == 2) {
        //结束后获取,比赛结束有赛果
        _self.getMatchAfterData(_self);
      }
      if (matchStatus == 1) {
        this.getGameByGameId();
      }
    },
    // 获取赛前赛事数据,这部分赛中的时候不展示
    getMatchHistoryData(_self) {
      this.$post("/api/league/data/" + _self.matchDetail.matchId)
        .then(res => {
          console.log(res, "获取赛事数据");
          if (res.code == "200" && res.data) {
            _self.detailData = res.data;
          }
        })
        .catch(e => {
          console.log(e);
        });
    },

    //获取赛果数据
    getMatchAfterData(_self) {
      this.$post("/api/league/result/" + _self.matchDetail.matchId)
        .then(res => {
          console.log(res, "获取赛事数据的赛果");
          if (res.code == "200" && res.data) {
            _self.matchResData = res.data;
          } else {
            this.getGameByGameId(); //数据库延迟没有数据从json数据里面取
          }
        })
        .catch(e => {
          console.log(e);
        });
    },

    //获取赛中数据
    getMatchLiveData(_self) {
      // console.log(_self.matchDetail.matchId, '本场是直播中的赛事');
      // console.log(_self.socketUrl, 'socket地址');
    },

    reflushMatchResData(matchResData) {
      console.error(matchResData, "matchResData");
      this.matchResData = matchResData;
    },

    reflushData(curLiveDetail) {
      this.curLiveDetail = curLiveDetail;
    },

    getGameByGameId() {
      var _self = this;
      this.socketApi.matchesLiveForHistory(_self);
    },
    getAvgVal(avg1, avg2) {
      avg1 = Number.parseFloat(avg1);
      avg2 = Number.parseFloat(avg2);
      if (!avg1 || !avg2) {
        return 0;
      }
      if (avg1 + avg2 == 0) {
        return 0;
      }
      return (avg1 / (avg1 + avg2)) * 100;
    }
  },
  watch: {}
};
</script>
<style lang='scss' scoped>
@import "../../../assets/common/_base.scss";
@import "../../../assets/common/_mixin.scss";
@import "../../../assets/common/_var.scss";
@import "../../../assets/common/iconfont.css";

.data_comparison {
  position: relative;
  article {
    margin-top: 8px;
    padding: 0 12px;
    background-color: #fff;
  }
  .left_win,
  .right_win {
    position: absolute;
    top: 0;
    width: 15px;
    height: 17px;
    @include getBgImg("../../../assets/images/match/win.png");
  }
  .left_win {
    left: 15px;
  }
  .right_win {
    right: 15px;
  }
  .title {
    padding: 15px 0 20px;
  }
  .comparison {
    color: #333;
    font-size: 20px;
  }
  .average {
    padding-left: 8px;
    font-size: 14px;
    color: #999;
  }
  .data_con {
    overflow: hidden;
    background-color: #fff;
    border-radius: 8px;
    h3 {
      padding: 10px;
      color: #fff;
      background-color: #fea21b;
    }
  }
  .team {
    @extend .flex_v_justify;
    padding: 5px 10px;
    > div {
      @extend .flex_hc;
      &:first-child {
        img {
          margin-right: 5px;
        }
      }
      &:last-child {
        img {
          margin-left: 5px;
        }
      }
    }
    img {
      width: 20px;
      height: 20px;
      color: #575757;
    }
  }
  .KDA {
    position: relative;
    @extend .flex_v_justify;
    padding: 0 10px;
    color: #878787;
    .num {
      font-size: 14px;
      color: #575757;
    }
    .tips {
      @extend .g_v_c_mid;
      color: #575757;
    }
  }
  .bar_con {
    padding: 5px 5px 0;
    margin: 5px;
    border-radius: 8px;
    background-color: #f8f9fe;
  }
  .bar_item {
    padding-bottom: 10px;
    p {
      position: relative;
      @extend .flex_v_justify;
      color: #878787;
      .tips {
        @extend .g_v_c_mid;
      }
    }
  }
  .bar_f {
    @extend .flex;
    margin-top: 5px;
    height: 5px;
    border-radius: 5px;
    background: linear-gradient(
      to right,
      #fe5049 0%,
      #fe5049 1%,
      transparent 2%,
      transparent 98%,
      #556fb5 99%,
      #556fb5 100%
    );
    overflow: hidden;
    span {
      height: 100%;
      transform: skew(-45deg);
    }
  }
  .bar_red {
    background-color: #fe5049;
  }
  .bar_blue {
    flex: 1;
    -webkit-flex: 1;
    margin-left: 5px;
    background-color: #556fb5;
  }
  .limitations {
    padding: 5px 10px;
    color: #a3a3a3;
    > div {
      @extend .flex_v_justify;
      padding: 5px 0;
    }
    .num {
      padding-right: 4px;
      color: #575757;
    }
    .bar_f {
      width: 40px;
      background: #fff;
      span {
        flex: 1;
        background-color: #d5d5d5;
      }
      .bar_red {
        margin-right: 2px;
        background-color: #fe5049;
      }
      .bar_blue {
        margin-left: 2px;
        background-color: #556fb5;
      }
    }
  }
  .fight_con {
    overflow: hidden;
    background-color: #fff;
    border-radius: 8px;
    h3 {
      @extend .flex;
      padding: 10px;
      font-size: 15px;
      color: #333;
      font-weight: normal;
      background-color: #fff9f9;
      span {
        flex: 1;
        -webkit-flex: 1;
        text-align: center;
        &:first-child {
          text-align: left;
        }
        &:nth-child(2) {
          flex: 2;
          -webkit-flex: 2;
        }
      }
    }
    .get_more {
      @extend .flex_v_h;
      padding: 10px 0;
      color: #575757;
      span {
        position: relative;
        width: 12px;
        height: 12px;
        margin-left: 3px;
        @include getArrow(8px, #575757, bottom);
      }
    }
  }
  .fight_item {
    @extend .flex;
    padding: 15px 0;
    margin: 0 5px;
    @include getBorder(bottom, #bcbcbc);
    &:last-child {
      background: initial;
    }
    > div {
      @extend .flex_v_h;
      flex: 1;
      -webkit-flex: 1;
      &:first-child {
        justify-content: flex-start;
        -webkit-justify-content: flex-start;
      }
      &:nth-child(2) {
        flex: 2;
      }
    }
    img {
      width: 16px;
      height: 16px;
    }
    .logo {
      padding: 2px 10px;
      border: 1px solid rgba(#000000, 0.1);
    }
    .score {
      padding: 0 3px;
    }
    .win_left,
    .win_right {
      @extend .flex_hc;
      position: relative;
      &::after {
        content: "";
        position: absolute;
        top: 50%;
        transform: translate(-100%, -50%);
        -webkit-transform: translate(-100%, -50%);
        width: 14px;
        height: 16px;
        @include getBgImg("../../../assets/images/match/win.png");
      }
    }
    .win_left {
      &::after {
        left: -5px;
      }
    }
    .win_right {
      &::after {
        right: -5px;
        transform: translate(100%, -50%);
        -webkit-transform: translate(100%, -50%);
      }
    }
  }
  .war_item {
    position: relative;
    margin-top: 10px;
    padding: 20px 15px 10px;
    border-radius: 8px;
    background-color: #fff;
    text-align: center;
    .top {
      position: relative;
      @extend .flex_v_justify;
    }
    .left,
    .right {
      color: #ed5e46;
      @extend .flex;
    }
    .left p {
      margin-right: 5px;
    }
    .right p {
      margin-left: 5px;
    }
    .center {
      @extend .g_v_c_mid;
      @extend .flex_v_justify;
      font-size: 24px;
      color: #575757;
    }
    .score_con {
      font-size: 14px;
      padding: 0 25px;
    }
    .score {
      @extend .flex;
      padding-top: 10px;
      span {
        margin: 0 1px;
        padding: 2px;
        color: #878787;
        border-radius: 2px;
        background-color: #eeefef;
      }
    }
    .ten,
    .first_blood {
      display: block;
      width: 12px;
      height: 12px;
      margin: 0 auto 4px;
    }
    .ten {
      @include getBgImg("../../../assets/images/match/ten.png");
    }
    .first_blood {
      @include getBgImg("../../../assets/images/match/first_blood.png");
    }
    .war_team {
      @extend .flex_v_justify;
      padding: 10px 0;
      color: #575757;
    }
    .hero_contrast {
      @extend .flex_v_justify;
      img {
        width: 16%;
        margin-right: 1px;
      }
      > div {
        flex: 1;
        font-size: 0;
      }
    }
    .look_for {
      padding: 5px;
      font-size: 10px;
      border-radius: 20px;
      color: #fff;
      background-color: #292c2d;
    }
  }
  .histogram {
    position: relative;
    margin-top: 10px;
    padding: 0 5px;
    height: 240px;
    border-radius: 8px;
    background-color: #fff;
    .team {
      position: absolute;
      right: 10px;
      top: 15px;
      p {
        @extend .flex_hc;
        margin-left: 30px;
        span {
          width: 15px;
          height: 10px;
          margin: 0 4px 0 7px;
          border-radius: 2px;
        }
      }
      img {
        width: 18px;
        height: 18px;
      }
    }
    .bg_red {
      background-color: #fe5049;
    }
    .bg_blue {
      background-color: #556fb5;
    }
  }
}
</style>


