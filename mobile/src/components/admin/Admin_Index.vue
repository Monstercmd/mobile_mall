<template>
  <div>
    <div>
      <el-row :gutter="10">
       <el-col :span="4">
         <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
           <div>
            <el-row>
              <div>
                <el-col :span="12"  align="center"><i class="el-icon-user-solid" style="font-size: 70px;color: #8cc5ff"></i></el-col>
              </div>
              <div>
                <el-col :span="12" >
                  <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{userNum}}</div>
                  <div style="margin-top: 15px" align="center">有效用户</div>
                </el-col>
              </div>
            </el-row>
           </div>
         </el-card>
       </el-col>
        <el-col :span="4">
          <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
            <div>
              <el-row>
                <div>
                  <el-col :span="12"  align="center"><i class="el-icon-s-goods" style="font-size: 70px;color: #df5000"></i></el-col>
                </div>
                <div>
                  <el-col :span="12" >
                    <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{proNum}}</div>
                    <div style="margin-top: 15px" align="center">商品数量</div>
                  </el-col>
                </div>
              </el-row>
            </div>
          </el-card>
        </el-col>
        <el-col :span="4">
          <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
            <div>
              <el-row>
                <div>
                  <el-col :span="12"  align="center"><i class="el-icon-chat-dot-round" style="font-size: 70px;color:#FFD700"></i></el-col>
                </div>
                <div>
                  <el-col :span="12" >
                    <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{commNum}}</div>
                    <div style="margin-top: 15px" align="center">评论数量</div>
                  </el-col>
                </div>
              </el-row>
            </div>
          </el-card>
        </el-col>
        <el-col :span="4">
          <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
            <div>
              <el-row>
                <div>
                  <el-col :span="12"  align="center"><i class="el-icon-s-data" style="font-size: 70px;color:#FF69B4"></i></el-col>
                </div>
                <div>
                  <el-col :span="12" >
                    <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{cateNum}}</div>
                    <div style="margin-top: 15px" align="center">分类数量</div>
                  </el-col>
                </div>
              </el-row>
            </div>
          </el-card>
        </el-col>
        <el-col :span="4">
          <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
            <div>
              <el-row>
                <div>
                  <el-col :span="12"  align="center"><i class="el-icon-s-order" style="font-size: 70px;color:#48D1CC"></i></el-col>
                </div>
                <div>
                  <el-col :span="12" >
                    <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{ordNum}}</div>
                    <div style="margin-top: 15px" align="center">订单数量</div>
                  </el-col>
                </div>
              </el-row>
            </div>
          </el-card>
        </el-col>
        <el-col :span="4">
          <el-card style="background-color: #ffffff;height: 100px;vertical-align: center">
            <div>
              <el-row>
                <div>
                  <el-col :span="12"  align="center"><i class="el-icon-s-claim" style="font-size: 70px;color:#67c23a"></i></el-col>
                </div>
                <div>
                  <el-col :span="12" >
                    <div style="font-family: 思源黑体;font-size: 20px;margin-top: 5px" align="center">{{ordOk}}</div>
                    <div style="margin-top: 15px" align="center">成功订单</div>
                  </el-col>
                </div>
              </el-row>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
    <div>
      <div style="margin-top: 30px">
        <el-row :gutter="10">
          <el-col :span="12">
<!--            <div style="margin-bottom: 15px">-->
<!--              <el-card class="box-card">-->
<!--                <div slot="header" class="clearfix">-->
<!--                  <span>当前时间</span>-->
<!--                </div>-->
<!--                <div>-->
<!--                  {{currentTime}}-->
<!--                </div>-->
<!--              </el-card>-->
<!--            </div>-->
            <el-card class="box-card">
              <div slot="header" class="clearfix">
                <span>系统信息</span>
              </div>
              <div>
                <el-row :gutter="10">
                  <el-col :span="12">
                    首页地址：<span style="color: #df5000">http://121.40.159.226</span>
                  </el-col>
                  <el-col :span="12">
                    作者：<span style="color: #df5000">任冠华</span>
                  </el-col>
                </el-row>
                <el-row :gutter="10">
                  <el-col :span="12">
                    服务器：<span style="color: #df5000">tomcat8.0</span>
                  </el-col>
                  <el-col :span="12">
                    运行环境：<span style="color: #df5000">Jdk8.0</span>
                  </el-col>
                </el-row>
                <el-row :gutter="10">
                  <el-col :span="24">
                    后端框架：<span style="color: #df5000">Spring+SpringMVC+Mybatis_Plus</span>
                  </el-col>
                </el-row>
                <el-row :gutter="10">
                  <el-col :span="24">
                    前端框架：<span style="color: #df5000">Vue+Element_Ui+vueX</span>
                  </el-col>
                </el-row>
              </div>
            </el-card>
            <div style="margin-top: 15px" shadow="hover" align="center">

              <el-card class="box-card">
                <el-row :gutter="10" >
                  <el-col :span="24">
                    <img alt="ip签名图片"  src="https://www.ipip5.com/ipimg">
                  </el-col>
                </el-row>
              </el-card>
            </div>
          </el-col>
            <el-col :span="12">
              <div style="margin-bottom: 15px">
                <el-card class="box-card">
                  <div slot="header" class="clearfix">
                    <span>当前时间</span>
                  </div>
                  <div>
                    {{currentTime}}
                  </div>
                </el-card>
              </div>
              <div>
                <el-card class="box-card">
                  <div slot="header" class="clearfix">
                    <span>更新历程</span>
                  </div>
                  <div class="block">
                    <el-timeline>
                      <el-timeline-item
                        v-for="(activity, index) in activities"
                        :key="index"
                        :icon="activity.icon"
                        :type="activity.type"
                        :color="activity.color"
                        :size="activity.size"
                        :timestamp="activity.timestamp">
                        {{activity.content}}
                      </el-timeline-item>
                    </el-timeline>
                  </div>

                </el-card>
              </div>
            </el-col>
        </el-row>
      </div>

    </div>
  </div>
</template>

<script>
    export default {
        name: "Admin_Index",
        data() {
            return {
                position:{},
                proNum:0,
                cateNum:0,
                userNum:0,
                commNum:0,
                ordNum:0,
                ordOk:0,
                timer: "",//定义一个定时器的变量
                currentTime: new Date(), // 获取当前时间
                //更新树
                activities: [{
                    content: '项目基本完成，增加额外功能，美化填充',
                    timestamp: '2021-03-26 18:46',
                    size: 'large',
                    type: 'primary',
                    icon: 'el-icon-info'
                },{
                    content: '添加数据，并观察行业详情',
                    timestamp: '2021-03-15 20:15',
                    icon: 'el-icon-circle-check',
                    size: 'large',
                    color: '#0bbd87'
                },{
                    content: '向前端添加后端业务，实现前端业务功能',
                    timestamp: '2021-02-15 20:15',
                    icon: 'el-icon-circle-check',
                    size: 'large',
                    color: '#0bbd87'
                }, {
                    content: '编写前端，建立vue前端架构',
                    timestamp: '2021-02-09 09:15',
                    icon: 'el-icon-circle-check',
                    size: 'large',
                    color: '#0bbd87'
                }, {
                    content: '建立数据库，创建基本表，创建SSM项目',
                    timestamp: '2021-02-05 19:20',
                    icon: 'el-icon-circle-check',
                    size: 'large',
                    color: '#0bbd87'
                }, {
                    content: '项目规划，设计伪表，伪页面',
                    timestamp: '2021-01-21 20:46',
                    icon: 'el-icon-circle-check',
                    size: 'large',
                    color: '#0bbd87'
                }]
            }
        },
        methods:{
            selectProduct(){
                this.axios.get("/product/count").then(resp=>{this.proNum=resp.data});
                this.axios.get("/user/count").then(resp=>{this.userNum=resp.data});
                this.axios.get("/cate/num").then(resp=>{this.cateNum=resp.data});
                this.axios.get("/comment/count").then(resp=>{this.commNum=resp.data});
                this.axios.get("/order/count").then(resp=>{this.ordNum=resp.data});
                this.axios.get("/order/count?id=3").then(resp=>{this.ordOk=resp.data});
            },

        },
        created() {

            this.selectProduct();
            var _this = this; //声明一个变量指向Vue实例this，保证作用域一致
            this.timer = setInterval(function() {
                _this.currentTime =
                   new Date();
            }, 1000);
        },
        beforeDestroy() {
            if (this.timer) {
                clearInterval(this.timer); // 在Vue实例销毁前，清除我们的定时器
            }
        },
    }
</script>

<style scoped>
.el-row{
  margin-bottom:15px;
}

</style>
