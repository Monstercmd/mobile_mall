package service.impl;

import dao.MailDao;
import entity.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.MailService;
@Service
public class MailServiceImpl implements MailService {
    @Autowired
    private MailDao md;
    @Override
    public Mail selectById(int id) {
        return md.selectById(id);
    }

    @Override
    public void updateById(Mail mail) {
       md.updateById(mail);
    }
}
