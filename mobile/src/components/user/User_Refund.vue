<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>退款/售后</span>
      </div>
      <div>
      <el-row :gutter="2" align="center">
        <el-col :span="15">
          <el-form :inline="true"  class="demo-form-inline" size="mini">
            <el-form-item label="订单号">
              <el-input v-model="id" placeholder="请输入订单号" @keyup.enter.native="handleSearch" style="width: 120px"></el-input>
            </el-form-item>
            <el-form-item label="订单状态：">
              <el-select v-model="state" placeholder="请选择" style="width:100px">
                <el-option label="全部"
                           value="-1">
                </el-option>
                <el-option label="已完成"
                           value="3">
                </el-option>
                <el-option label="退款中"
                           value="-2">
                </el-option>
                <el-option label="已退款"
                           value="-2">
                </el-option>
                <el-option label="退款失败"
                           value="-4">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" @click="handleSearch">查询</el-button>
            </el-form-item>
          </el-form>
        </el-col>

        <el-col :span="6" align="right"><el-button type="primary" icon="el-icon-help" size="mini"
                           @click="saled">申请售后</el-button></el-col>
      </el-row>
      <el-row :gutter="10">
        <el-col :span="24">
          <el-table
            :data="pageInfo.list"
            border
            stripe
            size="small"
            style="width:1280px"
            :default-sort = "{prop: 'orderTime'}"
            >

            <el-table-column
              align="center"
              prop="id"
              label="订单号"
              width="150">
            </el-table-column>
            <el-table-column
              align="center"
              prop="goodPrice"
              label="下单金额"
              width="100">
            </el-table-column>
            <el-table-column
              align="center"
              label="订单状态"
              width="80">
              <template slot-scope="scope">
                <span v-if="scope.row.orderState==3" style="color: #67c23a">已完成</span>
                <span v-if="scope.row.orderState==-2" style="color: #dc8f03">退款申请</span>
                <span v-if="scope.row.orderState==-3" style="color: #ea6f5a">已退款</span>
                <span v-if="scope.row.orderState==-4" style="color: red">退款失败</span>
              </template>
            </el-table-column>
            <el-table-column
              align="center"
              prop="orderTime"
              sortable
              label="下单时间"
              width="180">
            </el-table-column>
            <el-table-column
              align="center"
              prop="address.name"
              label="收货人"
              width="100">
            </el-table-column>
            <el-table-column
              align="center"
              prop="address.address"
              label="收货地址"
              :formatter="stateFormat"
              width="180">
            </el-table-column>
            <el-table-column
              header-align="center"
              align="center"
              label="操作"
              width="200"
            >
              <template slot-scope="scope">
                <span v-if="scope.row.orderState==3">
                  <el-button type="warning" icon="el-icon-edit-outline" size="mini"
                             @click="backMoney(scope.row.id)">申请退款</el-button>
                </span>
                <span v-if="scope.row.orderState==3||scope.row.orderState==-3||scope.row.orderState==-4">
                  <el-button type="danger" icon="el-icon-delete" size="mini"
                             @click="handleRemove(scope.row.id)">删除</el-button>
                </span>

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
        name: "User_Refund",
        data() {
            return {
                //表格
                pageInfo: {},
                selections: [],
                //分页
                total: 0,
                currentPage: 1,
                pageSize: 6,
                state:'',
                id:'',
                userName: JSON.parse(window.localStorage.getItem('userName')).email,
            }
        },
        methods: {
            //搜索
            handleSearch() {
                let id = 0;
                if (this.id === '') {
                    id = 0;
                } else {
                    id = this.id;
                }
                let state=0;
                if (this.state === '') {
                    state = -1;
                } else {
                    state = this.state;
                }
                this.axios({
                    method: "get",
                    url: "/order/shouHou",
                    params: {
                        id,state,userName:this.userName
                    }
                }).then((resp) => {
                    this.pageInfo = resp.data;
                    this.total = resp.data.total;
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
            //查询
            selectByPage(pageNo, pageSize) {
                let id = 0;
                if (this.id === '') {
                    id = 0;
                } else {
                    id = this.id;
                }
                let state=0;
                if (this.state === '') {
                    state = -1;
                } else {
                    state = this.state;
                }
                this.axios({
                    method: "get",
                    url: "/order/shouHou",
                    params: {
                        pageNo, pageSize,id,state,userName:this.userName
                    }
                }).then((resp) => {
                    this.pageInfo = resp.data;
                    this.total = resp.data.total;
                })
            },
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
                this.$confirm('此操作将永久删除这些数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/order/many?ids="+this.selections,
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
                                    message: '这些商品下绑定其他信息暂时不能删除，可先下架过一段时间删除',
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
                this.$confirm('此操作将永久删除该订单, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/order?id=" + id
                    }).then(resp => {
                        if (resp.data==="success") {
                            this.$message({
                                type: 'success',
                                message: '删除成功!'
                            });
                            this.selectByPage(this.currentPage, this.pageSize);
                        } else {
                            this.$notify.error({
                                title: '删除失败',
                                message: '该订单绑定着其他信息，暂时不能删除,可以在空闲时间选择在数据库里批量删除',
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
            // 申请售后
            saled(){
                this.$alert('<span><span><img src="http://localhost:8181/assets/common/qq.png" /></span>&nbsp;<span style="color: red;font-size: 16px">476093718</span></span>&nbsp;&nbsp;' +
                    '<span><span><img src="http://localhost:8181/assets/common/wx.png" /></span>&nbsp;<span style="color: red;font-size: 16px">STY1570</span></span>&nbsp;&nbsp;' +
                    '<span><i class="el-icon-mobile-phone"></i>&nbsp;<span style="color: red;font-size: 16px">18240754289</span></span>', '商家联系方式', {
                    dangerouslyUseHTMLString: true,
                    center: true
                });
            },
            //申请退款
            backMoney(id){
                this.$confirm('是否申请退款?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios.get("/order/status",{params:{id,state:-2}}).then(resp=>{
                        if(resp.data==="success"){
                            this.$message({
                                type: 'success',
                                message: '操作成功!',
                                onClose:this.selectByPage(1,6)
                            });
                        }else {
                            this.$message({
                                type: 'error',
                                message: '操作失败',
                            });
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });
            },
            //改变状态
            handleState(id,state){
                var title="";
                if(state===2){
                    title='是否发货?'
                }else if(state===-4){
                    title='是否同意退款？'
                }else if(state===-5){
                    title='同意退款'
                }
                this.$confirm(title, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios.get("/order/status",{params:{id,state}}).then(resp=>{
                        if(resp.data==="success"){
                            this.$message({
                                type: 'success',
                                message: '操作成功!',
                                onClose:this.selectByPage(this.currentPage, this.pageSize)
                            });
                        }else {
                            this.$message({
                                type: 'error',
                                message: '操作失败',
                            });
                        }
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });
            },
            handleUpdate(row){
                this.$router.push({path:'/admin/order_detail',query:{id:row.id}})
            }
        },
        created() {
            this.selectByPage(1, 6);
        }
    }
</script>

<style scoped>

</style>
