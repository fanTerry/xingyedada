<template>
  <section class="mod_points_exchange">
    <mod-title :titleTxt="'积分兑换'"></mod-title>
    <div class="points_exchange">
      <p class='flex_hc'>椰子分余额:<img src="../../assets/images/pop/coco_icon.png"
          alt=""><span>{{getUserData.yeYunPoints}}</span>
      </p>
      <a @click="creditsExchange">兑换椰子分</a>
    </div>
    <p class="exchange_tips">椰子分为官方唯一竞猜兑奖货币，玩家可通过竞猜星星等值兑换，一经兑换不可回退，请玩家根据兑换所需椰子分合理兑换</p>
    <div class="exchange_con">
      <ul>
        <li @click="goUrlPage(0)">
          <img src="../../assets/images/home/exchange_gold.png" alt="">
          <p>黄金兑换</p>
        </li>
        <li @click="goUrlPage(1)">
          <img src="../../assets/images/home/exchange_fee.png" alt="">
          <p>话费充值</p>
        </li>
        <li @click="goUrlPage(2)">
          <img src="../../assets/images/home/exchange_oil.png" alt="">
          <p>加油卡充值</p>
        </li>
        <li @click="goUrlPage(3)">
          <img src="../../assets/images/home/exchange_supermarket.png" alt="">
          <p>小椰超市</p>
        </li>
        <li @click="goUrlPage(4)">
          <img src="../../assets/images/home/exchange_livecost.png" alt="">
          <p>生活缴费</p>
        </li>
        <li @click="goUrlPage(5)">
          <img src="../../assets/images/home/exchange_vip.png" alt="">
          <p>会员卡券</p>
        </li>
        <li @click="goUrlPage(6)">
          <img src="../../assets/images/home/exchange_travel.png" alt="">
          <p>海南旅游</p>
        </li>
        <li @click="goUrlPage(7)">
          <img src="../../assets/images/home/exchange__special.png" alt="">
          <p>海南特产</p>
        </li>
      </ul>
    </div>

    <exchange-pops :showType="showType" @closePop="showType = false">
    </exchange-pops>
  </section>
</template>

<script>
import modTitle from "../../components/title/title.vue";
import exchangePops from "./components/exchange_pops.vue";
import { mapGetters, mapActions } from "vuex";

export default {
  components: { modTitle, exchangePops },
  props: [],
  data() {
    return {
      goodsUrl: [],
      showType: false
    };
  },
  mounted() {
    // this.getGoodsUrl();
  },
  computed: {
    ...mapGetters({
      getLoginData: "getLoginData",
      getUserData: "getUserData"
    })
  },
  methods: {
    ...mapActions(["setLoginData", "setUserData"]),
    creditsExchange() {
      if (this.checkLogin()) {
        console.log("已登录");
        this.creditsExchangeShow();
        this.showType = true;
      }
    },
    getGoodsUrl() {
      let param = {};
      return this.$post("/api/yeYunUser/getYeYunUrlList", param)
        .then(rsp => {
          const dataResponse = rsp;
          if (dataResponse.code == 200) {
            this.goodsUrl = dataResponse.data;
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    // 跳转链接
    goUrlPage(index) {
      if (this.checkLogin()) {
        this.getGoodsUrl().then(()=>{
        window.open( this.goodsUrl[index], "_blank");
        });        
      }
    },
    //检查是否登录
    checkLogin() {
      if (this.getLoginData.loginState == true) {
        return true;
      } else {
        console.log("用户没有登录");
        this.setLoginData({
          ...this.getLoginData,
          loginShowType: true, // 控制登录弹窗
          codeType: 1
        });
        return false;
      }
    },
    //查询用户可兑换的星星
    creditsExchangeShow() {
      return this.$post("/api/starNum/queryStarNum")
        .then(rsp => {
          const dataResponse = rsp;
          if (dataResponse.code == 200) {
            this.setUserData({
              ...this.getUserData,
              starNum: dataResponse.data.ableRecScore,
              recScore: dataResponse.data.recScore
            });
            // console.log(dataResponse.data.recScore, " 获取用户可以兑换的星星");
          } else {
            this.$toast(dataResponse.message);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    //查询椰云积分
    queryYeYunPoints() {
      return this.$post("/api/yeYunUser/yeYunUserInfo")
        .then(rsp => {
          const dataResponse = rsp;
          if (dataResponse.code == 200) {
            // console.log(dataResponse.data, "获得用户椰云积分");
            this.setUserData({
              ...this.getUserData,
              yeYunPoints: dataResponse.data.score
            });
          } else {
            this.$toast(dataResponse.message);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    dataRefresh() {
      this.queryYeYunPoints();
      this.creditsExchangeShow();
    }
  }
};
</script>

<style lang='scss' scoped>
@import "../../assets/common/_base";

.mod_points_exchange {
  display: table;
  margin: 30px auto 0;
}

.points_exchange {
  @extend .flex_hc;
  margin-top: 23px;
  font-size: 14px;
  color: #ffdcd7;
  font-weight: bold;
  img {
    width: 23px;
    height: 23px;
    margin: 0 8px;
  }
  span {
    color: #f3d40c;
  }
  a {
    display: block;
    width: 122px;
    margin-left: 45px;
    line-height: 32px;
    font-size: 16px;
    font-weight: normal;
    color: #ffdcd7;
    border-radius: 3px;
    background-color: #401c20;
    text-align: center;
    border: 1px solid #8a652e;
    border-image: linear-gradient(
        0deg,
        rgba(138, 101, 46, 1),
        rgba(185, 157, 110, 1)
      )
      10 10;
    border-image: -webkit-linear-gradient(
        90deg,
        rgba(138, 101, 46, 1),
        rgba(185, 157, 110, 1)
      )
      10 10;
    border-image: -ms-linear-gradient(
        0deg,
        rgba(138, 101, 46, 1),
        rgba(185, 157, 110, 1)
      )
      10 10;
  }
}

.exchange_tips {
  padding-top: 26px;
  font-size: 14px;
  color: #ffdcd7;
}

.exchange_con {
  margin-top: 18px;
  padding: 60px 0;
  background: linear-gradient(to right bottom, #34201d, #2a181c);
  background: -webkit-linear-gradient(left top, #34201d, #2a181c);
  background: -moz-linear-gradient(left top, #34201d, #2a181c);
  ul {
    @extend .flex_v_justify;
    padding: 0 10px;
    text-align: center;
  }
  li {
    margin: 0 9px;
    cursor: pointer;
  }
  img {
    width: 134px;
    height: 148px;
  }
  p {
    padding-top: 30px;
    font-size: 22px;
    color: #ffdcd7;
  }
}
</style>
