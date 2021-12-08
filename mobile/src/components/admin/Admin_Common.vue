<template>
  <el-container >
    <el-header>
      <div><span  style="font-size: 30px;color: #ffffff">后台管理</span>&nbsp;
        <span v-model="isCollapse" style="cursor:pointer;font-size: 30px;margin-bottom: 20px;color:#ffd04b">
        <span @click="lab"><i class="el-icon-s-operation"></i></span>
      </span></div>
      <div v-if="this.$store.state.myAdmin!==''||this.$store.state.myAdmin!==null">
        <el-dropdown @command="handleCommand">

             <span class="el-dropdown-link">

                          <span v-if="admin.avatar">  <el-avatar size="medium"
                                       :src="admin.avatar"
                                       style=" vertical-align: middle;">
             </el-avatar></span>
               <span v-else>  <el-avatar size="medium"
                                 icon="el-icon-user-solid"
                                 style=" vertical-align: middle;"></el-avatar></span>
               <span> {{admin.nickName}}<i class="el-icon-arrow-down el-icon--right"></i></span>
           </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="handleUser">个人中心</el-dropdown-item>
            <el-dropdown-item command="loginOut">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <div v-else>
        <el-dropdown >
             <span class="el-dropdown-link">
            <el-avatar size="small"
                       icon="el-icon-user-solid"
                       style=" vertical-align: middle;"></el-avatar>
               <span>未登录<i class="el-icon-arrow-down el-icon--left"></i></span>
             </span>
          <el-dropdown-menu slot="dropdown" style="width: 200px;">
            <div align="center">
              <router-link to="/admin/login">
                <el-button type="primary" size="medium">登录</el-button>
              </router-link>
            </div>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </el-header>
    <el-container>
      <el-aside  style="width: 182px">
        <el-menu
          :default-active="onRoutes"
          class="el-menu-vertical-demo"
          @open="handleOpen"
          @close="handleClose"
          :collapse="isCollapse"
          background-color="#545c64"
          text-color="#fff"
          active-text-color="#ffd04b"
          :unique-opened="true"
          router
        >
          <el-menu-item index="/admin">
            <i class="el-icon-s-home"></i>
            <span slot="title">我的首页</span>
          </el-menu-item>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-setting"></i>
              <span>网站管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin/system_set">系统设置</el-menu-item>
              <el-menu-item index="/admin/mail_set">邮件设置</el-menu-item>
              <el-menu-item index="/admin/pay_set">支付设置</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin/user_set">查看用户</el-menu-item>
              <el-menu-item index="/admin/user_add">添加用户</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-goods"></i>
              <span>商品管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/admin/goods_check">查看商品</el-menu-item>
              <el-menu-item index="/admin/goods_add">添加商品</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-menu-item index="/admin/cate_check">
            <i class="el-icon-s-cooperation"></i>
            <span slot="title">分类管理</span>
          </el-menu-item>
          <el-menu-item index="/admin/order_manage">
            <i class="el-icon-s-order"></i>
            <span slot="title">订单管理</span>
          </el-menu-item>
          <el-menu-item index="/admin/comment_manage">
            <i class="el-icon-message-solid"></i>
            <span slot="title">评论管理</span>
          </el-menu-item>
          <el-menu-item index="/admin/carousel_manage">
            <i class="el-icon-picture"></i>
            <span slot="title">广告管理</span>
          </el-menu-item>
          <el-menu-item index="/admin/security">
            <i class="el-icon-s-promotion"></i>
            <span slot="title">安全中心</span>
          </el-menu-item>
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
                admin:{
                    avatar: '',
                    nickName:'',
                },
                token:'',
                isCollapse:false
            }
        },
        methods: {
            ...mapMutations(['loginBack']),
            handleCommand(command) {
                if (command === "loginOut") {
                    this.loginBack();
                    this.$message.success("退出成功");
                    this.$router.replace('/admin/login').catch(err => {
                        console.log(err)
                    });
                } else if (command === "handleUser") {
                    this.$router.push('/admin').catch(err => {
                        console.log(err)
                    });
                }
            },
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            chuShi(){
                if(this.$store.state.myAdmin){
                    this.admin=JSON.parse(this.$store.state.myAdmin);
                }else {
                    this.admin={};
                }
                this.token=window.sessionStorage.getItem("Admintoken");
            },
            adminLogin(){
                if(window.localStorage.getItem('myAdmin')===''||window.localStorage.getItem('myAdmin')===null){
                    this.$message({
                        type: 'warning',
                        message: '请先进行登录再进行操作',
                        onClose:this.$router.push("/admin/login")
                    });
                }
            },
            lab(){
                this.isCollapse = !this.isCollapse;
            }
        },
        computed:{
            onRoutes(){
                return this.$route.path;
            },

        },
created() {
            this.adminLogin();
            this.chuShi();
}

    }
</script>

<style scoped>
  /*布局*/
  .el-header {
    background-color: #545c64;
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
    background-color: #545c64;
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
  .el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 178px;
    min-height: 500px;
  }
</style>
