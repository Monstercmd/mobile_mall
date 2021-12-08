<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>分类管理</span>
        <el-button style="float: right;background-color:#009688" size="mini" icon="el-icon-plus" @click="add" type="primary">添加</el-button>
      </div>
      <div>
        <el-table
          :data="pageInfo.list"
          style="width: 100%">
          <el-table-column
            prop="id"
            label="序号"
            width="300">
          </el-table-column>
          <el-table-column
            prop="name"
            label="类别名"
            width="300">
          </el-table-column>
          <el-table-column
            align="center"
            prop="count"
            label="商品数量"
            width="300">
          </el-table-column>
          <el-table-column
            header-align="center"
            align="center"
            label="操作"
            width="320"
          >
            <template slot-scope="scope">
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="open(scope.row)">更新</el-button>
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleRemove(scope.row.id)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <div style="padding-top: 5px">
          <el-pagination
            :page-size.sync="pageSize"
            :current-page.sync="currentPage"
            :page-sizes="[5,7,9]"
            layout="total,sizes, prev, pager, next, jumper"
            @current-change="handleCurrentChange"
            @size-change="handleSizeChange"
            :total="total">
          </el-pagination>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "Cate_Manage",
        data(){
          return{
              //分页
              pageInfo:{},
              total: 0,
              currentPage: 1,
              pageSize: 4,

              updateCate: {
                  name: "",
              },
             cate:{}
          }
        },
        methods: {
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
                this.axios({
                    method: "get",
                    url: "/cate/count",
                    params: {
                        pageNo, pageSize
                    }
                }).then((resp) => {
                    this.pageInfo = resp.data;
                    this.total = resp.data.total;
                })
            },
            // 添加分类
            add(){
                this.$prompt('分类名称', '添加分类', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                }).then(data=> {
                    this.cate.name=data.value;
                    this.axios({
                        method:"post",
                        url:"/cate",
                        data:this.cate
                    }).then(resp=>{
                        if(resp.data=="success"){
                            this.$message({
                                type: 'success',
                                message: '添加成功',
                                onClose:()=>{
                                    this.selectByPage(this.currentPage,this.pageSize);
                                }
                            });
                        }else {
                            this.$message({
                                type: 'error',
                                message: '添加失败',

                            });
                        }
                    })

                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });
            },
            // 更新
            open(index) {
                this.$prompt('分类名称', '更新分类', {
                    inputValue:index.name,
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                }).then(data=> {
                    this.cate.id=index.id;
                    this.cate.name=data.value;
                    this.axios({
                        method:"put",
                        url:"/cate",
                        data:this.cate
                    }).then(resp=>{
                        if(resp.data=="success"){
                            this.$message({
                                type: 'success',
                                message: '更新成功',
                                onClose:()=>{
                                    this.selectByPage(this.currentPage,this.pageSize);
                                }
                            });
                        }else {
                            this.$message({
                                type: 'error',
                                message: '更新失败',

                            });
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });
            },
            //删除
            handleRemove(id) {
                this.$confirm('此操作将永久删除该分类, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/cate",
                        data: id
                    }).then(resp => {
                        if (resp.data == "success") {
                            this.$message({
                                type: 'success',
                                message: '删除成功',
                                onClose: () => {
                                    this.selectByPage(this.currentPage,this.pageSize);
                                }
                            });
                        } else {
                            this.$message({
                                type: 'error',
                                message: '删除失败',

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

        },
        created() {
            this.selectByPage(1,5)
        }
    }
</script>

<style scoped>

</style>
