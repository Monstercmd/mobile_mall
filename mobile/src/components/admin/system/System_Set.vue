<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>系统设置</span>
      </div>
      <div>
        <el-row :gutter="10">
          <el-col :span="12">
            <el-form :label-position="labelPosition" label-width="180px" :model="system">
              <el-form-item label="网站标题(title)">
                <el-input v-model="system.title"></el-input>
              </el-form-item>
              <el-form-item label="网站关键词(SEO)">
                <el-input v-model="system.keyWord"></el-input>
              </el-form-item>
              <el-form-item label="网站描述(description)">
                <el-input type="textarea" rows="4" v-model="system.description"></el-input>
              </el-form-item>
              <el-form-item label="图标(favicon.ico)">

                <el-row :gutter="10">
                  <el-col :span="8">
                    <el-upload
                      style="height: 60px;width: 60px"
                      class="avatar-uploader"
                      name="myImg"
                      action="http://localhost:8181/Mobilemall_war_exploded/ico"
                      :show-file-list="false"
                      :on-success="handleAvatarSuccess"
                      :before-upload="beforeAvatarUpload">
                      <img v-if="system.ico" :src="['http://localhost:8181/assets/'+system.ico]" class="avatar">
                      <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>

                  </el-col>
                </el-row>

              </el-form-item>
              <el-form-item label="网站logo">
                <el-row :gutter="10">
                  <el-col :span="10">
                    <el-upload
                      name="myImg1"
                      class="avatar-uploader"
                      action="http://localhost:8181/Mobilemall_war_exploded/logo"
                      :show-file-list="false"
                      :on-success="handleAvatarSuccess2"
                      :before-upload="beforeAvatarUpload">
                      <img v-if="system.logo" :src="['http://localhost:8181/assets/'+system.logo]" class="avatar-logo">
                      <i v-else class="el-icon-plus avatar-uploader-logo"></i>
                    </el-upload>

                  </el-col>
                </el-row>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="onSubmit">立即修改</el-button>
                <el-button>取消</el-button>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "System_Set",
        data() {
            return {
                labelPosition: 'left',
                system: {
                    title: '',
                    keyWord: '',
                    description: '',
                    ico:'',
                    logo:'',
                }
            };
        },
        methods: {
            onSubmit() {
               this.axios({
                   method:"put",
                   url:"/sys",
                   data:this.system
               }).then(resp=>{
                   if(resp.data=="success"){
                       this.$message.success("修改成功");
                   }else{
                       this.$message.error("修改失败");
                   }
               })
            },
            // 图片上传
            handleAvatarSuccess(res, file) {
               // this.ico = URL.createObjectURL(file.raw);
                this.system.ico=res

            },
            handleAvatarSuccess2(res, file) {
                // this.ico = URL.createObjectURL(file.raw);
                this.system.logo=res

            },
            beforeAvatarUpload(file) {
                var testmsg=file.name.substring(file.name.lastIndexOf('.')+1);
                const extension = testmsg === 'ico';
                const extension2 = testmsg === 'png';
                const isLt2M = file.size / 1024 / 1024 < 10;
                if(!extension && !extension2) {
                    this.$message({
                        message: '上传图片只能是 ico或者png格式!',
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
        },
        created() {
            this.axios({
                method:"get",
                url:"/sys"
            }).then(resp=>{
                this.system=resp.data;
            })
        }
    }
</script>

<style scoped>
  .avatar-uploader {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 60px;
    height: 60px;
    line-height: 61px;
    text-align: center;
  }
  .avatar {
    width: 60px;
    height: 60px;
    display: block;
  }
  .avatar-uploader-logo {
    font-size: 28px;
    color: #8c939d;
    width: 160px;
    height: 60px;
    line-height: 60px;
    text-align: center;
  }
  .avatar-logo {
    width: 160px;
    height: 60px;
    display: block;
  }
</style>
