<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>更改密码</span>
      </div>
      <div>
        <div style="margin-top: 15px">
          <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-row :gutter="10">
              <el-col :span="8">
                <el-form-item label="原来的密码" prop="prePass">
                  <el-input type="password" v-model="ruleForm.prePass" autocomplete="off"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="10">
              <el-col :span="8">
                <el-form-item label="现在的密码" prop="pass">
                  <el-input type="password" v-model="ruleForm.pass" autocomplete="off"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="10">
              <el-col :span="8">
                <el-form-item label="再次输入密码" prop="checkPass">
                  <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
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
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        data() {
            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                }else if(value!==JSON.parse(this.$store.state.userName).pwd){
                    callback(new Error('密码错误'));
                }
                else {
                    if (this.ruleForm.checkPass !== '') {
                        this.$refs.ruleForm.validateField('checkPass');
                    }
                    callback();
                }
            };
            var validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.ruleForm.pass) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            var newPass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                } else {
                    callback();
                }
            };
            return {
                user:{},
                ruleForm: {
                    prePass: '',
                    pass: '',
                    checkPass: '',
                },
                rules: {
                    prePass: [
                        {validator: validatePass, trigger: 'blur'}

                    ],
                    pass: [
                        {validator: newPass, trigger: 'blur'}
                    ],
                    checkPass: [
                        {validator: validatePass2, trigger: 'blur'}
                    ]
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.user.email=JSON.parse(this.$store.state.userName).email;
                        this.user.pwd=this.ruleForm.pass;
                        this.axios.put("/user/pwd",{data:this.user}).then(resp=>{
                            if (resp.data === "success") {
                                this.$message({
                                    type: 'success',
                                    message: '修改成功!'
                                });
                            } else {
                                this.$message({
                                    type: 'error',
                                    message: '修改失败!'
                                });
                            }
                        })
                    } else {
                        this.$message({
                            type: 'error',
                            message: '输入不符合要求！'
                        });
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },


        }
    }
</script>

<style scoped>

</style>
