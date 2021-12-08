<template>
  <div>
  <el-card class="box-card">
    <div style="margin-top: 20px">
      <el-row :gutter="10">
        <div align="center" style="font-size: 30px">
          <el-col :span="24">欢迎进入个人中心</el-col>
        </div>
      </el-row>
      <div style="margin-top: 50px">
        <el-row :gutter="10">
          <el-col :span="24">

            <div align="center" v-if="this.$store.state.userName!=''">
              <span>
               <img :src="JSON.parse(this.$store.state.userName).avatar" style="width: 80px;"/>
              </span>

            </div>
          </el-col>
        </el-row>
      </div>
      <div style="margin-top: 60px">
      <el-row :gutter="10">
        <el-col :span="24" style="border: solid 1px aquamarine; border-radius:20px;width: 50%; height:35px;margin-left: 300px">
          <div align="center" style="color: #ea6f5a;font-size: 20px;font-family: 'Arial Unicode MS';margin-top: 7px" v-text="yy">
            加载中....
          </div>
        </el-col>
      </el-row>
      </div>
    </div>
  </el-card>
    <el-card class="box-card">
      <div style="margin-top: 20px">
      <el-row :gutter="10">
        <div align="center">
       <el-col :span="6">
         <router-link to="/">
         <el-button type="primary">网站首页</el-button>
         </router-link>
       </el-col>
        </div>
        <div align="center">
          <el-col :span="6">
            <router-link to="/cart">
              <el-button type="primary">我的购物车</el-button>
            </router-link>
          </el-col>
        </div>
        <div align="center">
          <el-col :span="6">
            <router-link to="/user/my_order">
              <el-button type="primary">我的订单</el-button>
            </router-link>
          </el-col>
        </div>
        <div align="center">
          <el-col :span="6">
            <router-link to="/user/collection">
              <el-button type="primary">我的收藏</el-button>
            </router-link>
          </el-col>
        </div>
      </el-row>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "Index",
        data() {
            return {
                value: new Date(),
                yy: "不要盲目听从别人的建议，自己觉得好的，往往才是最好的",
                logo:''
            }
        },
        methods:{
          check() {
              this.axios("http://121.40.159.226/yiyan/?c=f&encode=json").then(resp => {
                  this.yy = resp.data.hitokoto;
              }).catch(err => {
              });
          }
        },
        mounted() {
            this.$nextTick(() => {
                window.setInterval(() => {
                    setTimeout(this.check(), 0)
                }, 3000)
            })
        },
        created() {

        }
    }
</script>

<style scoped>
  /*设置行垂直边距*/
  .el-row {
    margin-bottom: 15px;
  }
  .el-card{
    margin-bottom: 10px;
  }
</style>
