package controller;

import entity.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import service.MailService;

@RestController
public class MailController {
    @Autowired
    private MailService ms;
    @GetMapping("/smtp")
    public Mail sel(){
        return ms.selectById(1);
    }
    @PutMapping("/smtp")
    public String update(@RequestBody Mail mail){
        String status="";
        try {
            status="success";
            ms.updateById(mail);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
