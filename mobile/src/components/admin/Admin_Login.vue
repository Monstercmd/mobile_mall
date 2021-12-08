<template>

    <div id="web_bg" style="background-image: url(http://localhost:8181/assets/bg.jpg);">
      <el-row :gutter="10" style="margin-top: 200px">
        <el-col :span="9">&nbsp;</el-col>
        <el-col :span="7" >
          <el-card class="box-card" style="background: rgba(255, 250, 250, 0.8)">
            <div slot="header" class="clearfix">
              <span style="font-size: 20px;color: #42b983;padding-left: 150px">后台登录</span>

            </div>
            <div>
              <el-form :model="login" :rules="rules" ref="login" label-width="100px" class="demo-login">
                <el-form-item label="登录账号" prop="name">
                  <el-input v-model="login.name"></el-input>
                </el-form-item>
                <el-form-item label="登录密码" prop="pwd">
                  <el-input @keyup.enter.native="submitForm('login')" type="password"  v-model="login.pwd" show-password></el-input>
                </el-form-item>

                <el-form-item style="margin-top: 15px">
                  <el-button type="primary" @click="submitForm('login')">立即登录</el-button>
                  <el-button @click="resetForm('login')">重置</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-card>

        </el-col>
      </el-row>

    </div>
</template>

<script>
    import {mapMutations} from "vuex";

    export default {
        name: "Admin_Login",
        data() {
            return {
                val: false,
                login: {
                    name: '',
                    pwd: '',
                },
                rules: {
                    name: [{ required: true, message: '账号不能为空'},
                        { type: 'string', message: '长度不能超过30位', trigger: 'blur', max: 30 }
                    ],
                    pwd: [
                        { required: true, message: '输入密码', trigger: 'blur' },
                        { type: 'string', message: '密码长度应保持在6-16之间', trigger: 'blur', min: 6,max:16 }
                    ]
                }
            };
        },
        methods: {
            ...mapMutations(['adminLogin']),
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.axios({
                            method: "get",
                            url: "/admin/login",
                            params: {
                                name: this.login.name,
                                pwd: this.login.pwd,
                            }
                        }).then(resp => {
                            //获取后端返回数据
                            let state = resp.data.status;
                            //打印token
                            console.log(resp.data.token);
                            //判断是否登录成功
                            if (state === "success") {
                                // 加入到全局变量中
                                this.adminLogin({
                                    myAdmin: resp.data.admin,
                                    Authorization: resp.data.token,
                                    signTime: new Date().getTime()
                                });
                                this.$message.success("登陆成功");
                                this.$router.push('/admin');
                            } else {
                                this.$message.error("用户名或密码错误");
                            }

                        });
                    }
                })
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
        }
    }
</script>

<style scoped>
  #web_bg{
    position:fixed;
    top: 0;
    left: 0;
    width:100%;
    height:100%;
    min-width: 1000px;
    z-index:-10;
    zoom: 1;
    background-color: #fff;
    background-repeat: no-repeat;
    background-size: cover;
    -webkit-background-size: cover;
    -o-background-size: cover;
    background-position: center 0;
  }
</style>
