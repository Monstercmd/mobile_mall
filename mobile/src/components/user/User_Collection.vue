<template>
  <div>
    <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>我的收藏</span>
    </div>
    <div>
      <el-row>
        <el-col :span="4" v-for="(r, index) in collect" :key="index" :offset="index%5!=0 ? 1 : 0">
          <div @click="detail(r.product.id)">
            <el-card :body-style="{ padding: '0px' }" shadow="hover"  style="cursor:pointer;margin-bottom: 15px;" >
              <el-image
                style="width: 258px; height: 150px;"
                :src="r.product.image"
                fit="contain"></el-image>
              <!--                      <img :src="[r.image]" class="image">-->
              <div style="padding: 14px;">
                <div align="center">
                  <p>{{r.product.proName}}</p>
                  <span style="color: #d3dce6">{{r.product.message|ellipsis}}</span>
                </div>

                <div class="bottom clearfix">
                  <span style="color: red;float:right">￥{{r.product.price}}</span>
                </div>
              </div>
            </el-card>

          </div>
        </el-col>
      </el-row>
    </div>
  </el-card>
  </div>
</template>

<script>
    export default {
        name: "User_Collection",
        data(){
            return{
                collect:[],
            }
        },
        methods:{
            loadCollect(){
                this.axios.get("/collect",{params:{uid:JSON.parse(this.$store.state.userName).id}}).then(resp=>{this.collect=resp.data})
            },
            detail(i){
                this.$router.push({path: '/mobile/detail', query:{ id: i }})
            }
        },
        //添加监听器
        filters: {
            ellipsis(value) {
                const len = 10;
                if (!value) return "";
                if (value.length > len) {
                    return value.slice(0, len) + "...";
                }
                return value;
            }
        },
        created() {
            this.loadCollect();
        }
    }
</script>

<style scoped>

</style>
