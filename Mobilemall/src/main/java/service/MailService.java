package service;

import entity.Mail;

public interface MailService {
    Mail selectById(int id);
    void updateById(Mail mail);
}
