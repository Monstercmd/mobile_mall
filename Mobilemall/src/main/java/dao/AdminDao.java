package dao;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import entity.Admin;
import org.apache.ibatis.annotations.Param;
public interface AdminDao extends BaseMapper<Admin> {
    Admin selectByNameAndPwd(@Param("name")String name,@Param("pwd")String pwd);

}
