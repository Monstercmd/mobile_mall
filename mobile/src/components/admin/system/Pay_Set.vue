<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>支付宝支付设置</span>
      </div>
      <div>
        <el-form :model="pay" status-icon :rules="rules" ref="ruleForm" label-width="160px" class="demo-ruleForm">
          <el-row :gutter="10">
            <el-col :span="10">
              <el-form-item label="应用APPID" prop="appId">
                <el-tooltip class="item" effect="dark" content="开放平台-应用appid" placement="right">
                  <el-input type="text" v-model="pay.appId" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="10">
              <el-form-item label="开放平台-应用私钥" prop="priKey">
                <el-tooltip class="item" effect="dark" content="商户私钥，您的PKCS8格式RSA2私钥" placement="right">
                  <el-input type="textarea" :rows="5" v-model="pay.priKey" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="10">
              <el-form-item label="开放平台-支付宝公钥" prop="pubKey">
                <el-tooltip class="item" effect="dark" content="支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。" placement="right">
                  <el-input type="textarea" :rows="5" v-model="pay.pubKey" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="10">
              <el-form-item label="异步回调地址" prop="notify_url">
                <el-tooltip class="item" effect="dark" content="支付成功后回调地址" placement="right">
                  <el-input type="text" v-model="pay.notify_url" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <div align="center">
              <el-col :span="10">
                <el-form-item>
                  <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                  <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
              </el-col>
            </div>
          </el-row>

        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "Pay_Set",
        data(){
            return{
                pay: {
                    appId:'',
                    priKey:'',
                    pubKey:'',
                    notify_url:'',
                },
                rules: {
                    appId:[
                        { required: true,  message: '请输入您的APPID', trigger: 'blur'}
                    ],
                    priKey: [
                        {required: true, message: '请输入应用私钥', trigger: 'blur'}
                    ],
                    pubKey: [
                        {required: true, message: '请输入支付宝公钥', trigger: 'blur'}
                    ],
                    notify_url: [
                        {required: true, message: '请输入异步回调地址', trigger: 'blur'}
                    ],
                }
            };
        },
        methods:{
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.pay.return_url=this.pay.notify_url;
                        this.axios({
                            method:"put",
                            url:"/pay",
                            data:this.pay
                        }).then(resp=>{
                            if(resp.data==="success"){
                                this.$message.success("修改成功");
                                this.$router.go(0);
                            }else{
                                this.$message.error("修改失败");
                            }
                        })
                    } else {
                        this.$message.error("输入修改内容有误");
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
        },
        created() {
            this.axios.get("/pay").then(resp=>{this.pay=resp.data})
        }
    }
</script>

<style scoped>

</style>
