<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>更新信息</span>
      </div>
      <div>
        <el-form :model="admin" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="管理员头像">
                  <el-upload
                    name="myImg"
                    class="avatar-uploader"
                    action="http://localhost:8181/Mobilemall_war_exploded/admin/upload/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img  v-if="admin.avatar" :src="admin.avatar" class="img avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="管理员昵称" prop="nickName">
                <el-input type="text" v-model="admin.nickName" autocomplete="off"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="管理员账号" prop="name">
                <el-input type="text" v-model="admin.name" autocomplete="off"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="8">
              <el-form-item label="登录密码" prop="pwd">
                <el-input type="password" v-model="admin.pwd"  show-password></el-input>
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
        name: "Admin_Security",
        data() {
            return{
                admin: {
                    name:'',
                    nickName:'',
                    avatar:'',
                    pwd: '',
                },
                rules: {
                    nickName: [
                        {required: true, message: '请输入昵称', trigger: 'blur'}
                    ],
                    name: [
                        {required: true, message: '请输入账号', trigger: 'blur'}
                    ],
                    pwd: [
                        {required: true, message: '请输入密码', trigger: 'blur'}
                    ],
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                        if (valid) {
                            this.axios({
                                method:"put",
                                url:"/admin",
                                data:this.admin
                            }).then(resp=>{
                                if(resp.data==="success"){
                                   window.sessionStorage.setItem("admin",this.admin);
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
            //上传头像
            handleAvatarSuccess(res, file) {
                this.user.avatar = res.avatarPath
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 2;

                if (!isJPG) {
                    this.$message.error('上传头像图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            }

        },created() {
            if(this.$store.state.myAdmin){
                this.admin=JSON.parse(this.$store.state.myAdmin)
                console.log('管理员头像'+this.admin.avatar)
            }

        }
    }
</script>

<style scoped>
  .img {
    height: 80px;
    padding-top: 5px;

  }
</style>
