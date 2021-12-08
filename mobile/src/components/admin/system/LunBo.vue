<template>
  <div>
    <el-card class="box-card">
      <div>
        <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane label="轮播图管理" name="first">
            <div v-for="lb in lbs">
              <el-form :inline="true" :model="lb" class="demo-form-inline" size="medium">
                <el-form-item :label="'图片地址'+lb.id">
                  <el-input v-model="lb.img" placeholder="请输入图片地址" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item :label="'跳转超链接'+lb.id">
                  <el-input v-model="lb.url" placeholder="请输入跳转的链接url" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="updateLb(lb)">修改</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
          <el-tab-pane label="右上侧图管理" name="second">
            <div>
              <el-form :inline="true" :model="yc" class="demo-form-inline" size="medium">
                <el-form-item label="图片地址">
                  <el-input v-model="yc.img" placeholder="请输入图片地址" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item label="跳转超链接">
                  <el-input v-model="yc.url" placeholder="请输入跳转的链接url" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="updateLb(yc)">修改</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
          <el-tab-pane label="通知管理" name="third">
            <div v-for="(tz,index) in tzs" :key="index">
              <el-form :inline="true" :model="tz" class="demo-form-inline" size="medium">
                <el-form-item :label="'消息信息'+(index+1)">
                  <el-input v-model="tz.title" placeholder="请输入消息" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item :label="'跳转超链接'+(index+1)">
                  <el-input v-model="tz.url" placeholder="请输入跳转的链接url" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="updateLb(tz)">修改</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
          <el-tab-pane label="网站公告管理" name="fourth">
            <div>
              <el-form :inline="true" :model="gg" class="demo-form-inline" size="medium">
                <el-form-item label="公告信息">
                  <el-input v-model="gg.title" placeholder="请输入公告" style="width: 400px"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="updateLb(gg)">修改</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </el-card>
  </div>

</template>

<script>
    export default {
        name: "LunBo",
        data() {
            return {
                activeName: 'first',
                //轮播图
                lbs:[],
                //右上侧图
                yc:{},
                //右上侧通知
                tzs:[],
                //网站公告
                gg:{}

            };
        },
        methods: {
            handleClick(tab, event) {
                console.log(tab, event);
            },
            updateLb(lb){
                this.axios({
                    method:"put",
                    url:"/adv",
                    data:lb
                }).then(resp=>{
                    if(resp.data==="success"){
                        this.$message({
                            type: 'success',
                            message: '修改成功',
                        });
                    }else {
                        this.$message({
                            type: 'error',
                            message: '修改失败',

                        });
                    }
                })
            }
        },
        created() {
            //加载轮播图
            this.axios({
                method:"get",
                url:"/adv",
                params:{
                    tj:'lb'
                }
            }).then(resp=>{
                this.lbs=resp.data;

            });
            //加载通知
            this.axios({
                method:"get",
                url:"/adv",
                params:{
                    tj:'tz'
                }
            }).then(resp=>{
                this.tzs=resp.data;

            });
            //加载公告
            this.axios({
                method:"get",
                url:"/adv/one",
                params:{
                    id:5
                }
            }).then(resp=>{
                this.gg=resp.data;

            });
            //加载右侧图
            this.axios({
                method:"get",
                url:"/adv/one",
                params:{
                    id:10
                }
            }).then(resp=>{
                this.yc=resp.data;

            });
        }
    }
</script>

<style scoped>

</style>
