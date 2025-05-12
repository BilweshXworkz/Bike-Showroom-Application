package com.xworkz.showroomapp.resetController;

import com.xworkz.showroomapp.repository.UserRegistrationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/signin") // Matches the AJAX URL in JSP
public class SignInResetController {

    @Autowired
    private UserRegistrationRepository repository;

    @GetMapping(value = "/{email}", produces = MediaType.TEXT_PLAIN_VALUE)
    @ResponseBody
    public String checkEmail(@PathVariable("email") String email) {
        boolean exists = repository.emailExists(email);
        return exists ? "" : "Email ID is not Registered.";
    }
}
