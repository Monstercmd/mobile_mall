<template>
 <div>
   <el-card class="box-card">
     <div slot="header" class="clearfix">
       <span>更新商品信息</span>
     </div>
     <div>
       <el-row :gutter="10">
         <el-form :model="updateGood" :rules="rules" ref="updateGood" label-width="100px" class="demo-updateGood">
           <el-col :span="8">
             <el-form-item label="商品图片">
               <div>
                 <el-upload
                   class="avatar-uploader"
                   name="myImg"
                   action="http://localhost:8181/Mobilemall_war_exploded/product/upload/"
                   :show-file-list="false"
                   :on-success="handleAvatarSuccess"
                   :before-upload="beforeAvatarUpload">
                   <img v-if="updateGood.image" :src="[updateGood.image]" class="avatar">
                   <i v-else class="el-icon-upload"></i>
                 </el-upload>
               </div>

             </el-form-item>
             <el-form-item label="商品名称" prop="proName">
               <el-input v-model="updateGood.proName"></el-input>
             </el-form-item>
             <el-form-item label="商品分类" prop="cid">
               <el-select v-model="updateGood.cid" placeholder="请选择">
                 <el-option
                   v-for="item in cates"
                   :key="item.id"
                   :label="item.name"
                   :value="item.id">
                 </el-option>
               </el-select>
             </el-form-item>
             <el-form-item label="商品价格" prop="price">
               <el-input v-model="updateGood.price"></el-input>
             </el-form-item>
             <el-form-item label="商品颜色">
               <el-input v-model="updateGood.color"></el-input>
             </el-form-item>
           </el-col>
           <el-col :span="8">
             <el-form-item label="商品内存">
               <el-input v-model="updateGood.ram"></el-input>
             </el-form-item>
             <el-form-item label="销售量">
               <el-input v-model="updateGood.saleNum"></el-input>
             </el-form-item>
             <el-form-item label="商品库存" prop="inventory">
               <el-input v-model="updateGood.inventory"></el-input>
             </el-form-item>
             <el-form-item label="商品描述" prop="color">
               <el-input  type="textarea"
                          :rows="3" v-model="updateGood.message"></el-input>
             </el-form-item>
             <el-form-item label="是否上架">
               <el-switch active-color="#13ce66" active-value="1"
                          inactive-value="0" v-model="state"></el-switch>
             </el-form-item>
             <el-form-item>
               <el-button type="primary" @click="submitForm('updateGood')">立即更新</el-button>
               <el-button @click="back">返回</el-button>
             </el-form-item>
           </el-col>
         </el-form>
       </el-row>
     </div>
   </el-card>
 </div>
</template>

<script>
    export default {
        name: "Goods_Update",
        data() {
            return {
                cates:[],
                state:'0',
                updateGood: {
                    proName: '',
                    cid:'',
                    price:'',
                    color:'',
                    inventory:'',
                    state:'',
                    ram:'',
                    saleNum:'',
                    message:''
                },
                rules: {
                    proName: [
                        { required:true, message: '商品名不能为空',trigger:'blur'},
                        { type: 'string', message: '长度不能超过30位', trigger: 'blur', max: 30 }
                    ],
                    cid: [
                        {required: true, message: '请选择分类', trigger: 'blur'}
                    ],
                    price: [
                        {required: true, message: '请选输入商品价格', trigger: 'blur'}
                    ],
                    inventory: [
                        {required: false, message: '请输入商品库存', trigger: 'blur'}
                    ],
                    color: [
                        {required: false, message: '请输入商品颜色', trigger: 'blur'}
                    ]

                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    this.updateGood.state=Number.parseInt(this.state);
                    if (valid) {
                        this.axios({
                            method:"put",
                            url:"/product",
                            data:this.updateGood
                        }).then(resp=>{
                            if(resp.data=="success"){
                                this.$message.success("更新成功");
                                this.$router.push("/admin/goods_check")
                            }else{
                                this.$message.error("更新失败");
                            }
                        })
                    } else {
                        this.$message.error("输入信息内容有误");
                        return false;
                    }
                });
            },
            back() {
                this.$router.go(-1);//返回上一层
            },
            //上传头像
            handleAvatarSuccess(res, file) {
                console.log(res);
                // this.user.avatar = URL.createObjectURL(file.raw);
                this.updateGood.image = res.avatarPath
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
        },
        created() {
            this.axios.get('/cate').then(resp=>{this.cates=resp.data});
            this.axios.get('/product/detail',{
                params:{id:this.$route.query.id}
            }).then(resp=>{
                this.updateGood=resp.data;
                this.state=resp.data.state.toString()
            })
        }

    }
</script>

<style scoped>
  .avatar-uploader .el-upload {
    border: 1px dashed #99a9bf;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .el-icon-upload {
    font-size: 48px;
    color: #99a9bf;
    width: 130px;
    height: 90px;
    line-height: 90px;
    text-align: center;
  }
  .avatar {
    width:130px;
    height: 90px;
    display: block;
  }
</style>
