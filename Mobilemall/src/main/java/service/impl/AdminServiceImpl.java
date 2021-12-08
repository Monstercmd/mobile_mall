package service.impl;

import dao.AdminDao;
import entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.AdminService;
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao ad;

    @Override
    public boolean login(String name, String pwd) {
        Admin admin = ad.selectByNameAndPwd(name, pwd);
        if(admin!=null){
            return true;
        }else {
            return false;
        }
    }
//登录
    @Override
    public Admin selectByNameAndPwd(String name, String pwd) {
        return ad.selectByNameAndPwd(name, pwd);
    }

    @Override
    public Admin selectById(int id) {
        return ad.selectById(id);
    }

    @Override
    public void updateById(Admin admin) {
ad.updateById(admin);
    }
}
