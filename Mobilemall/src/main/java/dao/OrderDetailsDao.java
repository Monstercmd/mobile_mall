package dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import entity.OrderDetails;

public interface OrderDetailsDao extends BaseMapper<OrderDetails> {
    OrderDetails selectOne(String id);
    void deleteId(String id);
}
