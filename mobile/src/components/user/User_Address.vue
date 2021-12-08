<template>
  <div><el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>我的收货地址</span>
      <el-button style="float: right; padding: 3px 0" type="text" @click="dialogVisible=true">添加收货地址</el-button>
    </div>
    <div>
      <el-row :gutter="10">
        <el-col :span="24">
          <el-table
            :data="addresses"
            stripe
            style="width: 100%">
            <el-table-column
              prop="id"
              label="序号"
              width="80">
            </el-table-column>
            <el-table-column
              prop="name"
              label="收件人"
              width="120">
            </el-table-column>
            <el-table-column
              prop="mobile"
              label="手机号">
            </el-table-column>
            <el-table-column
              prop="address"
              label="地址">
            </el-table-column>
            <el-table-column
              prop="address"
              label="设置收货地址状态">
              <template slot-scope="scope">
                <span style="color: red" v-if="scope.row.sid==1">已设置默认</span>
                <span v-else>
                  <el-button type="text" icon="el-icon-edit" size="mini" @click="handleSet(scope.row)">设置默认</el-button>
               </span>

              </template>
            </el-table-column>
            <el-table-column
              header-align="center"
              align="center"
              label="操作"
              width="200px"
            >
              <template slot-scope="scope">
                <el-button type="primary" icon="el-icon-edit-outline" size="mini" @click="handleUpdate(scope.row)">修改</el-button>
                <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleRemove(scope.row.id)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-col>
      </el-row>
      <!--      弹出窗-->
      <el-dialog
        align="center"
        title="添加收货地址"
        :visible.sync="dialogVisible"
        width="30%"
      >
        <el-form ref="addAddress" :model="addAddress"
                 :rules="rules"
                 label-width="80px">
          <el-form-item label="收货人" prop="name">
            <el-input v-model="addAddress.name" placeholder="请输入收货人姓名"></el-input>
          </el-form-item>
          <el-form-item label="手机号" prop="mobile">
            <el-input  v-model="addAddress.mobile" placeholder="请输入收货人手机号"></el-input>
          </el-form-item>
          <el-form-item label="收货地址" prop="address">
            <el-input  type="textarea" :rows="2" v-model="addAddress.address" placeholder="请输入收货地址"></el-input>
          </el-form-item>

          <el-form-item align="center" style="margin-right: 70px">
            <el-button type="primary" @click="handleAdd">添加</el-button>
            <el-button type="info" @click="dialogVisible=false">取消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
      <!--      更新-->
      <el-dialog
        title="修改收货地址"
        align="center"
        :visible.sync="updateDialogVisible"
        width="30%"
      >
        <el-form ref="updateAddress" :model="updateAddress"
                 :rules="rules"
                 label-width="80px">
          <el-form-item label="收货人" prop="name">
            <el-input v-model="updateAddress.name" placeholder="请输入收货人姓名"></el-input>
          </el-form-item>
          <el-form-item label="手机号" prop="mobile">
            <el-input  v-model="updateAddress.mobile" placeholder="请输入收货人手机号"></el-input>
          </el-form-item>
          <el-form-item label="收货地址" prop="address">
            <el-input type="textarea" :rows="2" v-model="updateAddress.address" placeholder="请输入收货地址"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="update">更新</el-button>
            <el-button type="info" @click="updateDialogVisible=false">取消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
    </div>
  </el-card></div>
</template>

<script>

    export default {
        name: "User_Address",
        data() {
            return {
                addresses: [],
                dialogVisible: false,
                updateDialogVisible: false,
                addAddress: {
                    name: "",
                    mobile: "",
                    address: "",
                },
                updateAddress: {
                    id: "",
                    name: "",
                    mobile: "",
                    address: "",

                },
                rules: {
                    name: [
                        {required: true, message: "收货人不能为空", trigger: "blur"}
                    ],
                    mobile: [
                        {required: true, message: "收货人手机号不能为空", trigger: "blur"},
                        { type: 'string', message: '长度必须11位', trigger: 'blur', max: 11,min:11 }
                    ],
                    address: [
                        {required: true, message: "收货地址不能为空", trigger: "blur"}
                    ]
                }
            }
        },
        methods:{
            //添加校验
            handleAdd() {
                this.$refs["addAddress"].validate(valid => {
                    if (valid) {
                        this.addAddress.uid=JSON.parse(this.$store.state.userName).id;
                        // this.axios.post("/ebook/add.do",this.addBook)
                        this.axios({
                            method: "post",
                            url: "/address",
                            data: this.addAddress
                        }).then(resp => {
                            if(resp.data=="success"){
                                this.$message({
                                    type: 'success',
                                    message: '添加成功!'
                                });
                                this.addAddress = {};
                                this.dialogVisible = false;
                                this.select();
                            }else {
                                this.$message({
                                    type: 'error',
                                    message: '添加失败!'
                                });
                            }
                        }).catch(error => console.log(error))
                    } else {
                        alert("校验失败");
                    }
                })
            },
            //删除
            handleRemove(id) {
                this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method:"delete",
                        url:"/address/"+id
                    }).then(resp=>{
                        if(resp.data=="success"){
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.select();
                        }else {
                            this.$message({
                                type: 'error',
                                message: '删除失败!'
                            });
                        }
                    })

                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            //设置默认
            handleSet(row) {
               this.axios({
                   method:"put",
                   url:"/address/set",
                   params:{
                       uid:row.uid,id:row.id
                   }
               }).then(resp=>{
                   if(resp.data=="success"){
                       this.$message({
                           type: 'success',
                           message: '设置成功!'
                       });
                       this.select();
                   }else {
                       this.$message({
                           type: 'error',
                           message: '设置失败!'
                       });
                   }
               })
            },
        //修改
        handleUpdate(row) {
                this.axios({
                    method:"get",
                    url:"/address/one",
                    params:{id:row.id}
                }).then(resp=>{
                    this.updateAddress=resp.data;
                });

            this.updateDialogVisible = true;
        },
            //更新
            update(){
                this.axios({
                    method:"put",
                    url:"/address/update",
                   data:this.updateAddress
                }).then(resp=>{
                    if(resp.data=="success"){
                        this.$message({
                            type: 'success',
                            message: '更新成功!'
                        });
                        this.updateDialogVisible = false;
                        this.select();
                    }else {
                        this.$message({
                            type: 'error',
                            message: '更新失败!'
                        });
                    }
                })
            },
            //初始查询
            select(){
                this.axios({
                    method:"get",
                    url:"/address",
                    params:{uid:JSON.parse(this.$store.state.userName).id}
                }).then(resp=>{
                    this.addresses=resp.data;
                })
        }
        },
        created() {
            this.select();
        }
    }
</script>

<style scoped>

</style>
