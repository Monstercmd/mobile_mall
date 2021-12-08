<template>
 <div>
   <el-card class="box-card">
     <div slot="header" class="clearfix">
       <span>评论管理</span>
     </div>
     <div>
       <el-row :gutter="2" align="center">
         <el-col :span="3">
           <el-button type="primary" size="mini" @click="handleSelection">批量删除</el-button>
         </el-col>
         <el-form :inline="true"  class="demo-form-inline" size="mini">
           <el-form-item label="评论内容">
             <el-input v-model="comment" placeholder="请输入评论内容" style="width: 120px"></el-input>
           </el-form-item>
           <el-form-item>
             <el-button type="primary" icon="el-icon-search" @click="handleSearch">查询</el-button>
           </el-form-item>
         </el-form>
       </el-row>
       <el-row :gutter="10">
         <el-col :span="24">
           <el-table
             :data="pageInfo.list"
             stripe
             style="width: 100%"
             :default-sort = "{prop: 'orderTime'}"
             @selection-change="handleSelectionChange">
             <el-table-column
               header-align="center"
               align="center"
               type="selection"
             >
             </el-table-column>
             <el-table-column
               prop="id"
               label="序号"
               width="80">
             </el-table-column>
             <el-table-column
               prop="user.nickName"
               label="评论人"
               width="150">
             </el-table-column>
             <el-table-column
               prop="product.proName"
               label="商品名">
             </el-table-column>
             <el-table-column
               prop="rate"
               label="评分">
             </el-table-column>
             <el-table-column
               prop="content"
               label="评论内容"
               :formatter="stateFormat"
             >
             </el-table-column>
             <el-table-column
               align="center"
               prop="dateComment"
               sortable
               label="评论时间">
             </el-table-column>
             <el-table-column
               header-align="center"
               align="center"
               label="操作"
               width="200px"
             >
               <template slot-scope="scope">
                 <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleRemove(scope.row.id)">删除</el-button>
               </template>
             </el-table-column>
           </el-table>
           <el-pagination
             :page-size.sync="pageSize"
             :current-page.sync="currentPage"
             :page-sizes="[6,12,24]"
             layout="total,sizes, prev, pager, next, jumper"
             @current-change="handleCurrentChange"
             @size-change="handleSizeChange"
             :page-count="5"
             :total="total">
           </el-pagination>
         </el-col>
       </el-row>
     </div>
   </el-card>
 </div>
</template>

<script>
    export default {
        name: "Comment",
        data(){
          return{
              comment:'',
              pageInfo:{},
              selections:[],
              //分页
              total: 0,
              currentPage: 1,
              pageSize: 6,
          }
        },
        methods:{
            //搜索
            handleSearch() {
                this.axios({
                    method:'get',
                    url:'/comment',
                    params:{
                        comment:this.comment
                    }
                }).then(resp=>{
                    this.pageInfo=resp.data;
                    this.total=resp.data.total;
                })
            },
            // 分页相关
            //跳转或当前页改变
            handleCurrentChange(current) {
                this.selectByPage(current, this.pageSize);
            },
            //下拉框页数改变
            handleSizeChange(val) {
                this.selectByPage(this.currentPage, val);
            },
          selectByPage(pageNo,pageSize){
              this.axios({
                  method:'get',
                  url:'/comment',
                  params:{
                      pageNo,pageSize
                  }
              }).then(resp=>{
                  this.pageInfo=resp.data;
                  this.total=resp.data.total;
              })
          } ,
            //字数限制
            stateFormat(row, column, cellValue) {
                if (!cellValue) return '';
                if (cellValue.length > 6) {       //最长固定显示10个字符
                    return cellValue.slice(0, 6) + '...'
                }
                return cellValue
            },
            //批量删除
            handleSelectionChange(value) {
                for(let i=0;i<value.length;i++){
                    this.selections = value[i].id;
                }
                console.log(this.selections);
            },
            //多条删除
            handleSelection() {
                //获取到表格对象，从表格中获取到已经选择到的行
                this.$confirm('此操作将永久删除这些评论, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/comment/ids?ids="+this.selections,
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
                                    message: '无法删除',
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
            //单个删除
            handleRemove(id) {
                this.$confirm('此操作将永久删除该评论, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/comment?id=" + id
                    }).then(resp => {
                        if (resp.data === "success") {
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.selectByPage(this.currentPage, this.pageSize);
                        } else {
                            this.$notify.error({
                                title: '删除失败',
                                message: '该商品绑定着其他信息，暂时不能删除,可以先选择下架',
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

        },
        created() {
        this.selectByPage(1,6);
        }
    }
</script>

<style scoped>

</style>
