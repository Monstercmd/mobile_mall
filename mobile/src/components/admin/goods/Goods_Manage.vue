<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>商品列表</span>
      </div>
      <div>
        <el-row :gutter="2" align="center">
          <el-col :span="3">
            <el-button type="primary" size="mini" @click="handleSelection">批量删除</el-button>
          </el-col>
          <el-form :inline="true"  class="demo-form-inline" size="mini">
            <el-form-item label="选择分类：">
              <el-select v-model="cid" placeholder="请选择" style="width:100px">
                <el-option
                  v-for="cate in cates"
                  :key="cate.id"
                  :label="cate.name"
                  :value="cate.id">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="商品名">
              <el-input v-model="name" placeholder="请输入商品名" style="width: 120px"></el-input>
            </el-form-item>
            <el-form-item label="价格区间">
              <el-input v-model="min" placeholder="请输入起始价" style="width: 120px"></el-input>
              <span class="line" >-</span>
              <el-input v-model="max" placeholder="请输入最高价" style="width: 120px"></el-input>
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
              border
              stripe
              size="small"
              style="width:1280px"
              @selection-change="handleSelectionChange">
              <el-table-column
                header-align="center"
                align="center"
                type="selection"
              >
              </el-table-column>
              <el-table-column
                align="center"
                label="缩略图"
                width="80">
                <template slot-scope="scope">
                  <el-image
                    style="width: 50px; height: 50px"
                    :src="scope.row.image"
                    fit="cover"></el-image>
                  <!--               <span v-if="scope.row.image==null"><el-avatar icon="el-icon-user-solid"></el-avatar></span>-->
                  <!--               <span v-else> <el-avatar :size="size"  :src="[scope.row.image]"></el-avatar></span>-->
                </template>
              </el-table-column>
              <el-table-column
                align="center"
                prop="proName"
                label="商品名"
                width="150">
              </el-table-column>
              <el-table-column
                align="center"
                prop="category.name"
                label="分类"
                width="80">
              </el-table-column>
              <el-table-column
                align="center"
                prop="ram"
                label="内存"
                width="60">
              </el-table-column>
              <el-table-column
                align="center"
                prop="message"
                label="商品描述"
                :formatter="stateFormat"
                width="120">
              </el-table-column>
              <el-table-column
                align="center"
                prop="inventory"
                label="库存"
                width="60">
              </el-table-column>
              <el-table-column
                align="center"
                prop="saleNum"
                label="销量"
                width="60">
              </el-table-column>
              <el-table-column
                align="center"
                prop="price"
                label="价格(元)"
                width="80">
              </el-table-column>
              <el-table-column
                align="center"
                label="状态"
                width="80">
                <template slot-scope="scope">
                  <span v-if="scope.row.state==1" style="color: #13ce66">上架中</span>
                  <span v-if="scope.row.state==0" style="color: #d8000f">已下架</span>
                </template>
              </el-table-column>
              <el-table-column
                align="center"
                prop="groundingDate"
                label="上次更新日期"
                width="180">
              </el-table-column>
              <el-table-column
                header-align="center"
                align="center"
                label="操作"
                width="220"
              >
                <template slot-scope="scope">

                  <el-button type="" size="mini" @click="handleState(scope.row)">
                    <span v-if="scope.row.state==0" style="color:green">上架</span>
                    <span v-if="scope.row.state==1" style="color: #df5000">下架</span>
                  </el-button>

                  <el-button type="primary" icon="el-icon-edit-outline" size="mini"
                             @click="handleUpdate(scope.row)"></el-button>
                  <el-button type="danger" icon="el-icon-delete" size="mini"
                             @click="handleRemove(scope.row.id)"></el-button>
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
        name: "Goods",
        data() {
            return {
                //弹窗
                centerDialogVisible: false,
                //分类
                cates: [],
                size: "",
                //表格
                pageInfo: {},
                selections: [],
                ids:[],
                //分页
                total: 0,
                cid: '',
                name:'',
                min:'',
                max:'',
                currentPage: 1,
                pageSize: 6,
                updateState:{
                    id:'',
                    state:''
                }
            }
        },
        methods: {
            //搜索
            handleSearch() {
                let fid = 0;
                if (this.cid === '') {
                    fid = 0;
                } else {
                    fid = this.cid;
                }
                let min=0;
                if (this.min === '') {
                    min = 0;
                } else {
                    min = this.min;
                }
                let max=0;
                if (this.max === '') {
                    max = 0;
                } else {
                    max = this.max;
                }
                this.axios({
                    method: "get",
                    url: "/product",
                    params: {
                        cid: fid,
                        min,max,name:this.name
                    }
                }).then(resp => {
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
                let fid = 0;
                if (this.cid === '') {
                    fid = 0;
                } else {
                    fid = this.cid;
                }
                let min=0;
                if (this.min === '') {
                    min = 0;
                } else {
                    min = this.min;
                }
                let max=0;
                if (this.max === '') {
                    max = 0;
                } else {
                    max = this.max;
                }
                this.axios({
                    method: "get",
                    url: "/product",
                    params: {
                        pageNo, pageSize, cid: fid,min,max,name:this.name
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
                console.log(value);
                this.selections = value;
                for(let i=0;i<this.selections.length;i++){
                    this.ids[i]=this.selections[i].id
                }
            },
            //多条删除
            handleSelection() {
                //获取到表格对象，从表格中获取到已经选择到的行
                this.$confirm('此操作将永久删除这些商品数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/product/many?ids="+this.ids,
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
                this.$confirm('此操作将永久删除该商品, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.axios({
                        method: "delete",
                        url: "/product?id=" + id
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
            //改变状态
            handleState(product){
                let state=0;
                if(product.state===0){
                    state=1;
                }else {
                    state=0
                }
                this.updateState.id=product.id;
                this.updateState.state=state;
                this.axios({
                    method:"put",
                    url:"/product/state",
                    data:this.updateState
                }).then(resp=>{
                    if (resp.data == "success") {
                        this.$message({
                            type: 'success',
                            message: '操作成功!'
                        });
                        this.selectByPage(this.currentPage, this.pageSize);
                    } else {
                        this.$message({
                            type: 'error',
                            message: '操作失败'
                        });
                    }
                })
            },
            handleUpdate(row){
                this.$router.push({path:'/admin/goods_update',query:{id:row.id}})
    }
        },
        created() {
            this.selectByPage(1, 6);
            this.axios({
                method: 'get',
                url: '/cate'
            }).then(resp => {
                this.cates = resp.data;
            })
        }
    }
</script>

<style scoped>

</style>
