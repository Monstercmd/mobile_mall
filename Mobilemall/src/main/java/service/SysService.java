package service;

import entity.Sys;

public interface SysService {
    Sys selectById(int id);
    void update(Sys system);
}
