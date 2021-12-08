<template>
  <el-container>
    <el-header>
      <div style="font-size: 30px;color: #ffffff">用户中心</div>
      <div style="margin-top: 20px" v-if="this.$store.state.userName!=''">
        <el-dropdown @command="handleCommand">

          <span class="el-dropdown-link">
                            <el-avatar size="small"
                                       :src="JSON.parse(this.$store.state.userName).avatar"
                                       style=" vertical-align: middle;">
             </el-avatar>
               <span> {{JSON.parse($store.state.userName).nickName}}<i
                 class="el-icon-arrow-down el-icon--right"></i></span>
             </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="handleUser">个人中心</el-dropdown-item>
            <el-dropdown-item command="loginOut">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </el-header>
    <el-container>
      <el-aside width="200px">
        <el-menu
          :default-active="onRoutes"
          class="el-menu-vertical-demo"
          @open="handleOpen"
          @close="handleClose"
          :unique-opened="true"
          router
        >
          <el-menu-item index="/user">
            <i class="el-icon-s-home"></i>
            <span slot="title">我的首页</span>
          </el-menu-item>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-setting"></i>
              <span>资料管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/user/info">账户信息</el-menu-item>
              <el-menu-item index="/user/security">账户安全</el-menu-item>
              <el-menu-item index="/user/address">收货地址</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-s-goods"></i>
              <span>交易管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/user/my_order">我的订单</el-menu-item>
              <el-menu-item index="/user/collection">我的收藏</el-menu-item>
              <el-menu-item index="/user/evaluate">交易评价</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-s-opportunity"></i>
              <span>我的服务</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/user/logistics">物流查询</el-menu-item>
              <el-menu-item index="/user/refund">退款/售后</el-menu-item>
              <el-menu-item index="/user/service">商家客服</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-container>
        <el-main>

            <router-view/>

        </el-main>
        <el-footer>
          <Footer/>
        </el-footer>
      </el-container>
    </el-container>
  </el-container>
</template>

<script>
    import Footer from "../common/Footer";
    import {mapMutations} from "vuex";
    export default {
        name: "User",
        components: {Footer},
        data(){
            return{
                user:{},

            }
        },
        methods: {
            ...mapMutations(['loginChange']),
            ...mapMutations(['loginOut']),
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            //头像事件
            handleCommand(command) {
                if (command === "loginOut") {
                    this.loginOut();
                    this.$message.success("退出成功");
                    this.$router.replace('/login').catch(err => {
                        console.log(err)
                    });
                } else if (command === "handleUser") {
                    this.$router.push('/user').catch(err => {
                        console.log(err)
                    });
                }
            },

        },
        computed:{
            onRoutes(){
                return this.$route.path;
            }
        },
        created() {

        },
        mounted(){

        }
    }
</script>

<style scoped>
  /*布局*/
  .el-header {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    line-height: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .el-header img {
    height: 50px;
    padding-top: 30px;
  }

  .el-main {
    /*#E9EEF3*/
    background-color: #E9EEF3;
    color: #333;
    line-height: 20px;
  }

  .el-footer {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    line-height: 60px;
    font-size: 10px;
  }

  .el-aside {
    background-color: #ffffff;
    color: #333;
    text-align: center;
    line-height: 200px;
  }

  /*行间距*/
  .el-row {
    margin-bottom: 20px;
  }
  .el-dropdown-link {
    cursor: pointer;
    color: #409EFF;
  }

  .el-icon-arrow-down {
    font-size: 12px;
  }

  .box-card {
    width: 400px;
    height: 172px;
  }
</style>
