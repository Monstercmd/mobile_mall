package util;

import cn.hutool.extra.mail.MailAccount;
import entity.Mail;
import java.util.ArrayList;
import java.util.List;
public class Mailutil {
    public static void sendMail(String accptor, Mail ms){
        try {
            MailAccount account = new MailAccount();
            account.setHost(ms.getHost());//qq邮箱的协议,固定的不用改
            account.setPort(ms.getPort());//qq邮箱的端口号,不用改
            account.setAuth(true);//验证规则
            account.setFrom(ms.getEmail());//发件人的邮箱地址
            account.setUser(ms.getNickName());//发件人的邮箱昵称
            account.setPass(ms.getPwd()); //邮箱设置获取到的授权码,可以在qq邮箱设置里面获取
            List<String> acceptor=new ArrayList<>();
            acceptor.add(accptor);//收件人的邮箱地址.要封装到一个list集合里面
//五个参数,第一个是发件人信息,第二个是收件人,第三个是邮件的主题,第四个是邮件的内容.
// 第五个是邮件内容是否以html格式展示
            cn.hutool.extra.mail.MailUtil.send(account,acceptor ,
                    "天狼星手机商城激活","欢迎注册天狼星商城的会员，点击链接完成注册激活，祝您在天狼星手机商城购物愉快！激活链接：<a href='http://localhost:8081/#/reg_ok''>点击激活</a>", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
