<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>订单详情</span>
      </div>
      <div>
        <el-row :gutter="10">
          <el-col :span="6">产品图片</el-col>
          <el-col :span="6">产品名称</el-col>
          <el-col :span="6">产品价格</el-col>
          <el-col :span="6">产品数量</el-col>
        </el-row>
      </div>
    </el-card>
    <div v-for="(order,i) in pageInfo.list" :key="i" >
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <el-row :gutter="10">
         <el-col :span="12"><span>订单号：{{order.id}}</span><span style="padding-left: 10px">创建时间：{{order.orderTime}}</span></el-col>
         <el-col :span="12" align="right"><span><el-button type="" size="mini" @click="checkDetail(order.id)">查看订单详情</el-button> </span></el-col>
        </el-row>
      </div>
      <div v-for="(o,index) in order.orderDetails" :key="index">
        <el-row :gutter="10" style="height: 100px">
          <el-col :span="6">
            <div>
              <el-image
                style="width: 100px; height: 90px;"
                :src="      o.product.image"
                fit="scale-down"
                :preview-src-list="[o.product.image]"></el-image>
            </div>

          </el-col>
          <el-col :span="6" style="margin-top: 30px">
            {{o.product.proName}}
          </el-col>
          <el-col :span="6" style="margin-top: 30px">
            {{o.product.price}}
          </el-col>
          <el-col :span="6" style="margin-top: 30px">
            {{o.count}}
          </el-col>
        </el-row>
        <div v-if="index===order.orderDetails.length-1">
          <el-divider></el-divider>
          <el-row :gutter="10">
            <el-col :span="12">
              <div>小计：<span style="color: red">{{order.goodPrice}}</span>元</div>
            </el-col>
            <el-col :span="12" align="right">
            <span v-if="order.orderState===0">
              <el-button type="warning" plain size="mini" @click="pay(order)">去付款</el-button><el-button @click="cancel(order.id)" size="mini" >取消订单</el-button>
            </span>
              <span v-if="order.orderState===1">
              <el-button type="info" disabled size="mini" >待发货</el-button><el-button type="danger" @click="backMoney(order.id,-2)" size="mini" >申请退款</el-button>
            </span>
              <span v-if="order.orderState===2">
              <el-button type="warning" disabled size="mini" >已发货</el-button><el-button @click="receive(order.id,3)" size="mini" >确认收货</el-button>
            </span>
              <span v-if="order.orderState===3">
              <el-button type="success" disabled size="mini" >交易完成</el-button>
            </span>
              <span v-if="order.orderState===-2">
              <el-button type="warning" disabled size="mini" >申请退款中</el-button>
            </span>
              <span v-if="order.orderState===-3">
              <el-button type="success" disabled size="mini" >已退款</el-button>
            </span>
              <span v-if="order.orderState===-4">
              <el-button type="danger" disabled size="mini" >拒绝退款</el-button>
            </span>
            </el-col>
          </el-row>

      </div>
      </div>
    </el-card>

    </div>

    <div align="center">
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
    </div>

  </div>
</template>

<script>
    export default {
        name: "Order_Info",
        data() {
            return {
                //分页
                total: 0,
                currentPage: 1,
                pageSize: 6,
                pageInfo:{},
            }
        },
        methods:{
            pay(order){
                let arr=order.orderDetails;
                let name="";
                arr.forEach(e=>{name+=e.product.proName});
                 window.open("http://localhost:8181//Mobilemall_war_exploded/alipay.trade.page.pay.jsp?WIDout_trade_no="+order.id
                     +"&WIDsubject="+name
                      +"&WIDtotal_amount="+order.goodPrice+"&WIDbody="+name);
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
                this.axios.get("/order",{
                    params:{
                        pageNo,pageSize,uid:JSON.parse(this.$store.state.userName).id}
                }).then(resp=>{
                    this.pageInfo=resp.data;
                    this.total=resp.data.total;

                })
    },
            //取消订单
            cancel(id){
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
            //申请退款
            backMoney(id,state){
                this.$confirm('是否申请退款?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios.get("/order/status",{params:{id,state}}).then(resp=>{
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
            receive(id,state){
                this.$confirm('是否确认收货?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios.get("/order/status",{params:{id,state}}).then(resp=>{
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
            checkDetail(id){
                this.$router.push({path:'/user/order_detail',query:{id:id}})
            },
        },
        created() {
           this.selectByPage(1,6);

        }
    }
</script>

<style scoped>
  .el-card {
    margin-bottom: 20px;
  }
</style>
