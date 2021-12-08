<template>
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>添加用户信息</span>
    </div>
    <div>
      <el-row :gutter="10">
       <el-col :span="8">
         <el-form :model="addUser" :rules="rules" ref="addUser" label-width="100px" class="demo-addUser">
           <el-form-item label="用户头像">
             <el-upload
               class="avatar-uploader"
               name="myImg"
               action="http://localhost:8181/Mobilemall_war_exploded/upload/"
               :show-file-list="false"
               :on-success="handleAvatarSuccess"
               :before-upload="beforeAvatarUpload">
               <img v-if="addUser.avatar" :src="addUser.avatar" class="avatar">
               <i v-else class="el-icon-plus avatar-uploader-icon"></i>
             </el-upload>
           </el-form-item>
           <el-form-item label="登录邮箱" prop="email">
             <el-input v-model="addUser.email"></el-input>
           </el-form-item>
           <el-form-item label="用户昵称" prop="nickName">
             <el-input v-model="addUser.nickName"></el-input>
           </el-form-item>
           <el-form-item label="登录密码" prop="pwd">
             <el-input v-model="addUser.pwd"></el-input>
           </el-form-item>
           <el-form-item label="年龄">
             <el-input v-model="addUser.age"></el-input>
           </el-form-item>
           <el-form-item label="性别" prop="sex">
             <el-radio-group v-model="addUser.sex">
               <el-radio label="男"></el-radio>
               <el-radio label="女"></el-radio>
             </el-radio-group>
           </el-form-item>
           <el-form-item label="电话" prop="phone">
             <el-input v-model="addUser.phone"></el-input>
           </el-form-item>
           <el-form-item label="激活状态">
             <el-switch active-color="#13ce66" v-model="state"></el-switch>
           </el-form-item>
           <el-form-item>
             <el-button type="primary" @click="submitForm('addUser')">立即创建</el-button>
             <el-button @click="resetForm('addUser')">重置</el-button>
           </el-form-item>
         </el-form>
       </el-col>
      </el-row>
    </div>
  </el-card>
</template>

<script>
    export default {
        name: "User_Add",
        data() {
            return {
                state: false,
                addUser: {
                    email: '',
                    avatar:'',
                    pwd:'',
                    phone:'',
                    nickName:'',
                    sex:'',
                    age:'',
                    state:'',
                },
                rules: {
                    email: [
                        { required:true, message: '邮箱不能为空',trigger:'blur'},
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
                    pwd:[
                        { required: true, message: '密码不能为空',trigger:'blur'},
                        { type: 'string', message: '长度不能低于', trigger: 'blur', min:6 }
                    ],
                    nickName: [
                        {required: true, message: '请输入昵称', trigger: 'blur'},
                        {min: 2, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur'}
                    ],
                    phone: [
                        {required: false, message: '请输入手机号', trigger: 'blur'}
                    ],
                    age: [
                        {required: false, message: '请输入年龄', trigger: 'blur'}
                    ],
                    avatar: [
                        {required: false, message: '请输入头像', trigger: 'blur'}
                    ],
                    sex: [
                        {required: false, message: '请输入性别', trigger: 'blur'}
                    ]

                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if(this.state){
                        this.addUser.state=1
                    }else {
                        this.addUser.state=0
                    }
                    if (valid) {
                        this.axios({
                            method:"post",
                            url:"/user/add",
                            data:this.addUser
                        }).then(resp=>{
                            if(resp.data=="success"){
                                this.$message.success("添加成功");
                                this.$router.push("/admin/user_set")
                            }else{
                                this.$message.error("添加失败");
                            }
                        })
                    } else {
                        this.$message.error("输入信息内容有误");
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            //上传头像
            handleAvatarSuccess(res, file) {
                // this.user.avatar = URL.createObjectURL(file.raw);
                console.log(res.avatarPath)
                this.addUser.avatar = res.avatarPath
            },
            beforeAvatarUpload(file) {
                var testmsg=file.name.substring(file.name.lastIndexOf('.')+1);
                const extension = testmsg === 'jpg';
                const extension2 = testmsg === 'png';
                const isLt2M = file.size / 1024 / 1024 < 10;
                if(!extension && !extension2) {
                    this.$message({
                        message: '上传图片只能是 jpg、png格式!',
                        type: 'warning'
                    });
                }
                if(!isLt2M) {
                    this.$message({
                        message: '上传图片大小不能超过 10MB!',
                        type: 'warning'
                    });
                }
                return extension || extension2 && isLt2M
            }
        }

    }
</script>

<style scoped>
  .avatar-uploader .el-upload {
    border: 1px dashed #c0ccda;
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
    color: #99a9bf;
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
