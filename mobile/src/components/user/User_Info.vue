<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>信息设置</span>
      </div>
      <div>
        <el-form :model="user" :rules="rules" ref="user" label-width="100px"
                 class="demo-user">
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="用户编号" prop="id">
                  <el-input v-model="user.id" disabled=""></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="登录账号" prop="email">
                  <el-input v-model="user.email" disabled=""></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="用户头像">
                  <el-upload
                    name="myImg"
                    class="avatar-uploader"
                    action="http://localhost:8181/Mobilemall_war_exploded/upload/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="user.avatar" :src="user.avatar" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="用户昵称" prop="nickName">
                  <el-input v-model="user.nickName"></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="年龄" prop="age">
                  <el-input v-model="user.age"></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="性别" prop="sex">
                  <el-radio-group v-model="user.sex">
                    <el-radio label="男"></el-radio>
                    <el-radio label="女"></el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="电话" prop="phone">
                  <el-input v-model="user.phone"></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="10">
            <el-col :span="6">
              <div>
                <el-form-item label="注册时间" prop="address">
                  <el-input v-model="user.createTime" disabled=""></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-form-item>
            <el-button type="primary" @click="submitForm('user')">立即修改</el-button>
            <el-button @click="resetForm()">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script>
    import {mapState} from 'vuex';
    import {mapMutations} from 'vuex';
    export default {
        name: "UserInfo",
        data() {
            return {
                user: {
                    id:'',
                    email: '',
                    nickName: '',
                    createTime:'',
                    avatar:'',
                    sex:'',
                    age:'',
                phone:'',
                },
                rules: {
                    nickName: [
                        {required: true, message: '请输入昵称', trigger: 'blur'},
                        {min: 2, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur'}
                    ],
                    phone: [
                        {required: true, message: '请输入手机号', trigger: 'blur'}
                    ],
                    age: [
                        {required: true, message: '请输入年龄', trigger: 'blur'}
                    ],
                    avatar: [
                        {required: true, message: '请输入头像', trigger: 'blur'}
                    ],
                    sex: [
                        {required: true, message: '请输入性别', trigger: 'blur'}
                    ]
                }
            };
        },
        methods: {
            //调用全局mutations
            ...mapMutations(['loginChange']),
            submitForm(user) {
                this.$refs[user].validate((valid) => {
                    if (valid) {
                        this.axios({
                            method:"post",
                            url:"/user/update",
                            data:this.user
                        }).then(resp=>{
                            if(resp.data.status=="success"){
                                this.loginChange({
                                    userName:resp.data.user
                                });
                                this.$message.success("修改成功");
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
            resetForm(user) {
                this.$refs[user].resetFields();
            },
            //上传头像
            handleAvatarSuccess(res, file) {
                this.user.avatar = res.avatarPath
            },
            beforeAvatarUpload(file) {
                var testmsg=file.name.substring(file.name.lastIndexOf('.')+1);
                const extension = testmsg === 'jpg';
                const extension2 = testmsg === 'png';
                const isLt2M = file.size / 1024 / 1024 < 10;
                if(!extension && !extension2) {
                    this.$message({
                        message: '上传头像图片只能是 JPG,PNG 格式!',
                        type: 'warning'
                    });
                }
                if(!isLt2M) {
                    this.$message({
                        message: '上传文件大小不能超过 10MB!',
                        type: 'warning'
                    });
                }  return extension || extension2 && isLt2M

            }
        },
        computed: {
        ...mapState(['userName'])
        },
        created() {
           this.user=JSON.parse(this.userName)
        }
    }
</script>

<style scoped>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 78px;
    height: 78px;
    line-height: 78px;
    text-align: center;
  }
  .avatar {
    width: 78px;
    height: 78px;
    display: block;
  }
</style>
