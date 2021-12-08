<template>
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>用户列表</span>
    </div>
    <div>
      <el-row :gutter="2" align="center">
        <el-col :span="3">
          <el-button type="primary" size="mini" @click="handleSelection">批量删除</el-button>
        </el-col>
        <el-form :inline="true"  class="demo-form-inline" size="mini">
          <el-form-item label="选择状态：">
            <el-select v-model="state" placeholder="请选择" style="width:100px">
              <el-option label="请选择" value="-1"></el-option>
              <el-option label="未激活" value="0"></el-option>
              <el-option label="已激活" value="1"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="用户名">
            <el-input v-model="name" placeholder="请输入用户名" style="width: 120px"></el-input>
          </el-form-item>
          <el-form-item label="注册日期区间">
            <el-date-picker
              v-model="time"
              type="datetimerange"
              value-format="yyyy-MM-dd HH:mm:ss"
              :picker-options="pickerOptions"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              style="width: 350px"
              align="right">
            </el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="handleSearch">查询</el-button>
          </el-form-item>
        </el-form>
      </el-row>
      <el-table
        :data="pageInfo.list"
        border
        stripe
        style="width:1200px"
        @selection-change="handleSelectionChange">
        <el-table-column
          header-align="center"
          align="center"
          type="selection"
        >
        </el-table-column>
        <el-table-column
          align="center"
          label="头像"
          width="70">
          <template slot-scope="scope">
            <span v-if="scope.row.avatar==null || scope.row.avatar==''"><el-avatar icon="el-icon-user-solid"></el-avatar></span>
            <span v-else> <el-avatar :src="scope.row.avatar"></el-avatar></span>
          </template>
        </el-table-column>
        <el-table-column
          align="center"
          prop="email"
          label="用户名"
          width="200">
        </el-table-column>
        <el-table-column
          align="center"
          prop="nickName"
          label="昵称"
          width="90">
        </el-table-column>
        <el-table-column
          align="center"
          prop="age"
          label="年龄"
          width="80">
        </el-table-column>
        <el-table-column
          align="center"
          prop="sex"
          label="性别"
          width="50">
        </el-table-column>
        <el-table-column
          align="center"
          prop="phone"
          label="手机号"
          width="180">
        </el-table-column>
        <el-table-column
          align="center"
          prop="createTime"
          label="注册日期"
          width="180">
        </el-table-column>
        <el-table-column
          align="center"
          label="注册状态"
          width="80"
        >
          <template slot-scope="scope">
            <span style="color:red;" v-if="scope.row.state==0">未激活</span>
            <span style="color:green;" v-else>已激活</span>
          </template>
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="操作"
          width="220"
        >
          <template slot-scope="scope">
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="handleUpdate(scope.row)">编辑</el-button>
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleRemove(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        :page-size.sync="pageSize"
        :current-page.sync="currentPage"
        :page-sizes="[4,6,8]"
        layout="total,sizes, prev, pager, next, jumper"
        @current-change="handleCurrentChange"
        @size-change="handleSizeChange"
        :total="total">
      </el-pagination>
    </div>
  </el-card>
</template>

<script>
    export default {
        name: "User_Manage",
        data() {
            return {
                // circleUrl:"http://localhost:8181/assets/avatar/5.jpg",
                pageInfo:{},
                total: 0,
                currentPage: 1,
                pageSize: 4,
                selections: [],
                ids:[],
                //搜索
                state:'',
                name:'',
                //日期
                time:[],
                begin:'',
                end:'',
                pickerOptions: {
                    shortcuts: [{
                        text: '最近一周',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近一个月',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                            picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近三个月',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                            picker.$emit('pick', [start, end]);
                        }
                    }]
                },

            }
        },
        methods:{
            //搜索
            handleSearch() {
                this.begin=this.time[0];
                this.end=this.time[1];
                let state=0;
                if(this.state===''){
                    state=-1;
                }else{
                    state=this.state
                }
                console.log(this.begin)
                console.log(this.end)
                this.axios({
                    method: "get",
                    url: "/user",
                    params: {
                       name:this.name,begin:this.begin,end:this.end,state
                    }
                }).then(resp => {
                    this.pageInfo = resp.data;
                    this.total = resp.data.total;
                })
            },
            // 分页相关
            //跳转或当前页改变
            handleCurrentChange(current) {
                this.currentPage=current;
                this.selectByPage(current, this.pageSize);
            },
            //下拉框页数改变
            handleSizeChange(val) {
                this.pageSize=val;
                this.selectByPage(this.currentPage, val);
            },
            //查询
            selectByPage(pageNo, pageSize) {
                let state=0;
                if(this.state===''){
                    state=-1;
                }else{
                    state=this.state
                }
                this.axios({
                    method: "get",
                    url: "/user",
                    params: {
                        pageNo, pageSize,name:this.name,begin:this.begin,end:this.end,state
                    }
                }).then((resp) => {
                    this.pageInfo = resp.data;
                    this.total = resp.data.total;
                })
            },
            // 查看详情
            handleUpdate(row) {
               this.$router.push({path:'/admin/user_update',query:{id:row.id}})
            },
            //删除
            handleRemove(id) {
                this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/user?id="+id,
                    }).then(resp => {
                        if (resp.data === "success") {
                            this.$message({
                                type: 'success',
                                message: '删除成功',
                                onClose: () => {
                                    this.selectByPage(this.pageNo,this.pageSize);
                                }
                            });
                        } else {
                            this.$notify.error({
                                title: '删除失败',
                                message: '该用户下绑定其他信息暂时不能删除',
                                showClose: false
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
//批量删除
            //批量删除
            handleSelectionChange(value) {
                console.log(value);
                this.selections = value;
                for(let i=0;i<this.selections.length;i++){
                    this.ids[i]=this.selections[i].id
                }
            },
            //多条删除
            handleSelection() {
                //获取到表格对象，从表格中获取到已经选择到的行
                this.$confirm('此操作将永久删除这些用户, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {

                    this.axios({
                        method: "delete",
                        url: "/user/many?ids="+this.ids,
                    }).then(
                        resp => {
                            if (resp.data === "success") {
                                this.$message({
                                    type: 'success',
                                    message: '删除成功!'
                                });
                                this.selectByPage(this.currentPage, this.pageSize);
                            } else {
                                this.$notify.error({
                                    title: '删除失败',
                                    message: '这些用户中含有激活用户并且绑定这其他数据！',
                                    showClose: false
                                });
                            }
                        }
                    )
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
        },
        created() {
            this.selectByPage(1,4);
        }
    }
</script>

<style scoped>

</style>
