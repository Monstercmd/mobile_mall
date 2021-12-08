<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>发信邮箱SMTP设置</span>
      </div>
      <div>
        <el-form :model="mail" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="发信邮箱" prop="email">
                <el-tooltip class="item" effect="dark" content="发送邮件的邮箱，例如xx.@qq.com" placement="right">
                  <el-input type="text" v-model="mail.email" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="发信人昵称" prop="nickName">
                <el-tooltip class="item" effect="dark" content="向收件人展示的名字" placement="right">
                  <el-input type="text" v-model="mail.nickName" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="邮件服务器" prop="host">
                <el-tooltip class="item" effect="dark" content="请填写SMTP服务器地址，例如smtp.qq.com" placement="right">
                  <el-input type="text" v-model="mail.host" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="服务器端口" prop="port">
                <el-tooltip class="item" effect="dark" content="请填写SMTP服务器端口，例如QQ的是：587" placement="right">
                  <el-input type="text" v-model="mail.port" autocomplete="off"></el-input>
                </el-tooltip>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="邮箱授权码" prop="pwd">
                <el-tooltip class="item" effect="dark" placement="right">
                  <div slot="content">请填写SMTP服务器邮箱密码，<br/>特别注意：QQ邮箱的密码在账户设置，最底下，<br/>是独立生成的授权码，而不是qq密码和邮箱密码</div>
                  <el-input type="text" v-model="mail.pwd" autocomplete="off"></el-input>
                </el-tooltip>

              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <div align="center">
              <el-col :span="8">
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
        name: "Mail_Set",
        data(){
            return{
                mail: {
                    email:'',
                    nickName:'',
                    host:'',
                    port:'',
                    pwd: '',
                },
                rules: {
                    email:[
                        { required: true, message: '邮箱不能为空'},
                        { type: 'string',
                            message: '邮箱格式不正确',
                            trigger: 'blur',
                            transform (value) {
                                if (!/^\w+((-\w+)|(\.\w+))*@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(value)) {
                                    return true
                                }else{
                                }
                            }
                        },
                        { type: 'string', message: '长度不能超过30位', trigger: 'blur', max: 30 }
                    ],
                    nickName: [
                        {required: true, message: '请输入昵称', trigger: 'blur'}
                    ],
                    port: [
                        {required: true, message: '请输入端口号', trigger: 'blur'}
                    ],
                    host: [
                        {required: true, message: '请输入SMTP服务器地址', trigger: 'blur'}
                    ],
                    pwd: [
                        {required: true, message: '请输入密码', trigger: 'blur'}
                    ],
                }
            };
        },
        methods:{
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.axios({
                            method:"put",
                            url:"/smtp",
                            data:this.mail
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
            this.axios.get("/smtp").then(resp=>{this.mail=resp.data})
        }
    }
</script>

<style scoped>
  .item {
    margin: 4px;
  }
</style>
