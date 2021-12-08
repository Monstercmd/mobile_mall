<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>商家客服</span>

      </div>
      <div>
        <el-row :gutter="10">
          <el-col :span="6"><span><img src="http://localhost:8181/assets/common/qq.ico" /></span>&nbsp;<el-button type="text" @click="contact(1)"><span style="font-size: 24px">7940758</span></el-button></el-col>
          <el-col :span="6"><span><img src="http://localhost:8181/assets/common/wx.ico" /></span>&nbsp;<el-button type="text" @click="contact(2)"><span style="font-size: 24px">STY1570</span></el-button></el-col>
          <el-col :span="6"><span><img src="http://localhost:8181/assets/common/phone.ico" /></span>&nbsp;<el-button type="text" @click="contact(3)"><span style="font-size: 24px">18240754289</span></el-button></el-col>
        </el-row>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "Customer_Service",
        methods:{
            qq(){},
            contact(num){
                if(num===1){
                    window.open('http://wpa.qq.com/msgrd?v=3&uin=7940758&site=qq&menu=yes','_blank')
                }else if(num===2){
                    window.open('weixin://dl/business/?ticket=t59a2235a3662135bfb0e8f7edccc22c5#wechat_redirect#wechat_redirect','_blank')
                }else{
                    window.open('tel://18240754289','_blank')
                }
            }
        }
    }
</script>

<style scoped>

</style>
