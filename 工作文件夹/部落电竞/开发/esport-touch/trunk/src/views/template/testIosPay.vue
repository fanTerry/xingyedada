<template>
  <div id="app">
    <header class="mod_header">
      <navBar :pageTitle="'测试ios支付'"></navBar>
    </header>
    <button class="pay" @click="toPay(ids[0])">点击测试</button>
  </div>
</template>

<script>
import navBar from "components/header/nav_bar";
export default {
  components: {
    navBar
  },
  data() {
    return {
      iap: {},
      ids: ["10001", "10002"] //应用内购项目，需要申请
    };
  },
  created() {
    if (this.$route.query.clientType != 4) {
      //ios
      this.$router.push("/home");
    }
    document.addEventListener("plusready", function() {
      console.log(
        "所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
      );
    });
    document.addEventListener("plusready", this.plusReady(), false);
  },
  methods: {
    plusReady() {
      let _self = this;
      // 获取支付通道
      plus.payment.getChannels(
        function(channels) {
          console.log(channels, "getChannels所有渠道");
          for (var i in channels) {
            var channel = channels[i];
            // 用于标识支付通道： "alipay" - 表示支付宝； "wxpay" - 表示微信支付； "appleiap" - 表示苹果应用内支付； "qhpay" - 表示360聚合支付（仅360手助流应用环境下支持）。
            if (channel.id === "appleiap") {
              _self.iap = channel;
              _self.requestOrder();
            }
          }
        },
        function(e) {
          console.log("获取支付通道失败：" + e.message);
        }
      );
    },
    requestOrder() {
      let _self = this;
      plus.nativeUI.showWaiting("检测支付环境...");
      console.log("检测支付环境...");
      _self.iap.requestOrder(
        _self.ids,
        function(e) {
          plus.nativeUI.closeWaiting();
          plus.nativeUI.alert("支付环境检测成功", null, "支付环境", "确定");
          console.log("requestOrder success: " + JSON.stringify(e));
        },
        function(e) {
          console.log("requestOrder failed: " + JSON.stringify(e));
          plus.nativeUI.closeWaiting();
          plus.nativeUI.confirm(
            "错误信息：" + JSON.stringify(e),
            function(e) {
              if (e.index == 0) {
                _self.requestOrder();
              } else {
                // back();
              }
            },
            "重新请求支付",
            ["确定", "取消"]
          );
        }
      );
    },
    // 支付
    toPay(id) {
      console.log(id, "点击toPay");
      let _self = this;
      // plus.nativeUI.showWaiting("", {
      //   style: "black",
      //   background: "rgba(0,0,0,0)"
      // });
      plus.nativeUI.showWaiting("支付中...");
      plus.payment.request(
        _self.iap,
        { productid: id },
        function(result) {
          plus.nativeUI.closeWaiting();
          plus.nativeUI.alert("已经支付成功", null, "支付状态", "确定");
          _self.fetchPayStatus(result);
        },
        function(e) {
          console.log("toPay错误信息", e);
          plus.nativeUI.closeWaiting();
          plus.nativeUI.alert(
            "错误信息：" + e.message,
            null,
            "支付失败：" + e.code
          );
        }
      );
    },
    fetchPayStatus(result) {
      // let ordercode = window.location.href.split("ordercode=")[1]; //收集支付需要专递的参数
      console.log(result, ",topay fetchPayStatus");
      // this.$post("https://pay.52dd.cn/PayApple/applepayAction", {}).then(
      //   res => {
      //     if (res.data.code === 1) {
      //       window.location.href = `${window.location.origin}/bzjp/detail.html?ordercode=${ordercode}`;
      //     }
      //   }
      // );
    }
  }
};
</script>
<style lang='scss' scoped>
@import "../../assets/common/_base.scss";
@import "../../assets/common/_mixin.scss";
@import "../../assets/common/_var.scss";
.pay {
  width: 85px;
  height: 24px;
  border-radius: 4px;
  background-color: #fea21b;
  border: none;
  color: #fff;
}
</style>