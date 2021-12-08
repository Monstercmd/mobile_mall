<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>订单列表</span>
      </div>
      <div style="margin-bottom: 30px">
        <el-row :gutter="10">
          <el-col :span="4">
            订单号：{{order.id}}
          </el-col>
          <el-col :span="6">
            下单账号：{{order1.user.email}}
          </el-col>
          <el-col :span="4">
            用户昵称：{{order1.user.nickName}}
          </el-col>
          <el-col :span="4">
            下单金额：<span style="color: #d8000f">{{order1.goodPrice}}元</span>
          </el-col>
          <el-col :span="6">
            下单时间：{{order1.orderTime}}
          </el-col>
        </el-row>
      </div>
      <div style="margin-bottom: 30px">
        <el-row :gutter="10">
          <el-col :span="4">
            收货人：{{order1.address.name}}
          </el-col>
          <el-col :span="8">
            收货地址：{{order1.address.address}}
          </el-col>
          <el-col :span="6">
            收货联系电话：{{order1.address.mobile}}
          </el-col>
          <el-col :span="4">
            订单状态：
            <span v-if="order1.orderState==0" style="color: #d8000f">未付款</span>
            <span v-if="order1.orderState==1" style="color: #fc903d">待发货</span>
          </el-col>
        </el-row>
      </div>
      <div>
        <el-row :gutter="10">
          <el-col :span="4">
            产品明细：
          </el-col>
          <el-col :span="20">
            <el-table
              :data="order.orderDetails"
              border
              stripe
              size="small"
              style="width:470px"
              :default-sort = "{prop: 'orderTime'}"
            >
              <el-table-column
                align="center"
                label="缩略图"
                width="80">
                <template slot-scope="scope">
                  <el-image
                    style="width: 50px; height: 50px"
                    :src="scope.row.product.image"
                    fit="cover"></el-image>
                    </template>
              </el-table-column>
              <el-table-column
                align="center"
                prop="product.proName"
                label="商品名"
                width="150">
              </el-table-column>
              <el-table-column
                align="center"
                prop="product.price"
                label="单价"
                width="100">
              </el-table-column>
              <el-table-column
                align="center"
                prop="count"
                label="购买数量"
                width="140">
              </el-table-column>
            </el-table>
          </el-col>
        </el-row>
      </div>
      <div style="margin-top: 20px">
        <el-row :gutter="10">
         <el-col :span="24" align="center">
           <el-button type="primary" @click="$router.back()">返回</el-button>
         </el-col>
        </el-row>
      </div>
    </el-card>
  </div>
</template>

<script>
    export default {
        name: "Order_Detail",
        data() {
            return {
                order:{},
                order1:{
                    user:{
                        email:'',
                        nickName:'',
                    },
                    address:{
                        name:'',
                        address:'',
                        mobile:''
                    }
                }
            }
        },
        methods: {

            //字数限制
            stateFormat(row, column, cellValue) {
                if (!cellValue) return '';
                if (cellValue.length > 6) {       //最长固定显示10个字符
                    return cellValue.slice(0, 6) + '...'
                }
                return cellValue
            },
        },
        created() {
            this.axios({
                method:"get",
                url:"/order/detail",
                params:{
                    id:this.$route.query.id
                }
            }).then(resp=>{
                this.order=resp.data.order;
                this.order1=resp.data.order1;
            })
        }
    }
</script>

<style scoped>

</style>
