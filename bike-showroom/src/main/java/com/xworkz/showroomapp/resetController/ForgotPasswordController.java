package com.xworkz.showroomapp.resetController;

import com.xworkz.showroomapp.repository.UserRegistrationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/forgotPassword")
public class ForgotPasswordController {

    @Autowired
    private UserRegistrationRepository repository;

    @GetMapping(value = "/emailId/{email}", produces = MediaType.TEXT_PLAIN_VALUE)
    @ResponseBody
    public String checkEmailForReset(@PathVariable("email") String email) {
        boolean exists = repository.emailExists(email);
        return exists ? "" : "Email ID not registered.";
    }

}