package service;

import entity.Pay;

public interface PayService {
    Pay selectPay();
    void updatePay(Pay pay);
}
