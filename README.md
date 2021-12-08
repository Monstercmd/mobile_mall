# mobile_mall
基于SSM+Vue的手机商城销售系统项目

技术栈：Spring+SpringMVC+MybatisPlus+mysql8+vue

## 捐赠

支付宝QQ微信打赏

[![oR1BND.png](https://s4.ax1x.com/2021/12/08/oR1BND.png)](https://imgtu.com/i/oR1BND)

如有技术性问题，联系QQ:7940758,备注：github

## 前端介绍

**mobile**:是前端文件夹，下载到本地后进入该目录。

执行**npm install**下载对应的依赖

完成后输入**npm run dev**启动项目

### 注意事项

如果你的项目启动端口是8080，那么后端的过滤器里面配置的是8081，你要改成8080,因为这个项目前端启动的端口是8081，所以后端配置跨域和发信的端口都是8081，或者你前端进行设置指定开启8081端口，则这些可以不用管

[![oReavT.png](https://s4.ax1x.com/2021/12/08/oReavT.png)](https://imgtu.com/i/oReavT)

[![oReg8x.png](https://s4.ax1x.com/2021/12/08/oReg8x.png)](https://imgtu.com/i/oReg8x)

[![oReRxK.png](https://s4.ax1x.com/2021/12/08/oReRxK.png)](https://imgtu.com/i/oReRxK)

## 后端介绍

后端配置的tomcat端口号是8181，这也就意味着你要修改如果你配置其他端口，就需要对前后端整体替换掉这个端口号包括sql文件里的，建议你还是用8181，这样就可以不用修改

### 静态资源配置

静态文件夹的配置地址就是指向到前端的**mobile\src\assets**目录下

[![oRmLk9.md.png](https://s4.ax1x.com/2021/12/08/oRmLk9.md.png)](https://imgtu.com/i/oRmLk9)

**上传图片路径修改**

H:\\mobile\\src\\assets改成你的地址，前端mobile文件夹我是放到了H盘目录，建议使用notepad++对路径一键替换

[![oRnJ10.md.png](https://s4.ax1x.com/2021/12/08/oRnJ10.md.png)](https://imgtu.com/i/oRnJ10)



### 支付宝沙箱配置

登录支付宝开放平台申请开发者账号

https://open.alipay.com/dev/workspace

下拉找到开发工具推荐

[![oRuN8I.md.png](https://s4.ax1x.com/2021/12/08/oRuN8I.md.png)](https://imgtu.com/i/oRuN8I)

点进入申请沙箱环境

[![oRKpIH.md.png](https://s4.ax1x.com/2021/12/08/oRKpIH.md.png)](https://imgtu.com/i/oRKpIH)

点击右侧进入沙箱环境接入指导，然后下载密匙生成工具获取密匙，生成支付宝公钥

[![oRKQWn.md.png](https://s4.ax1x.com/2021/12/08/oRKQWn.md.png)](https://imgtu.com/i/oRKQWn)

将上面的三个信息填入这里

![oRZW7j.png](https://s4.ax1x.com/2021/12/08/oRZW7j.png)

### 数据库配置

在你的mysql建立一个名字为mobile_mall的数据库，导入**mobile_mall.sql**即可，后端配置数据库的文件路径是

Mobilemall\src\main\resources下的**common.properties**改成你自己的数据库账号密码即可

### 邮箱发信配置

采用的是QQ邮箱发信设置，配置也很简单，打开QQ邮箱，进入如下界面

[![oRlVL6.md.png](https://s4.ax1x.com/2021/12/08/oRlVL6.md.png)](https://imgtu.com/i/oRlVL6)

[![oRl1SA.md.png](https://s4.ax1x.com/2021/12/08/oRl1SA.md.png)](https://imgtu.com/i/oRl1SA)



开启这两个会得到每次开启都会得到密码，第二个记录一下，然后打开数据库，找到邮箱mail表,将里面的QQ邮箱和密码换成自己的（工具navicat)

[![oRlffJ.md.png](https://s4.ax1x.com/2021/12/08/oRlffJ.md.png)](https://imgtu.com/i/oRlffJ)

