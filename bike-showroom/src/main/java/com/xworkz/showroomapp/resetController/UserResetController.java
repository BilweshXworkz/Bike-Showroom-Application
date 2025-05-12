package com.xworkz.showroomapp.resetController;

import com.xworkz.showroomapp.repository.UserRegistrationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/")
public class UserResetController {
    @Autowired
    private UserRegistrationRepository repository;

    @GetMapping(value = "fullName/{fullName}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String validateName(@PathVariable String fullName) {
        return repository.nameExists(fullName) ? "Name Exists" : "";
    }

    @GetMapping(value = "contact/{contact}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String validatePhoneNumber(@PathVariable Long contact) {
        try {
            boolean exists = repository.phoneNumberExists(contact); // now this will work
            return exists ? "Phone number already registered!" : "";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error occurred while checking phone.";
        }
    }

    @GetMapping(value = "emailId/{emailId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String  validateEmailId (@PathVariable String emailId) {
        return repository.emailExists(emailId) ? "EmailId Exists" : "";
    }

    @GetMapping(value = "modelName/{modelName}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String validateModel (@PathVariable String modelName) {
        return repository.modelExists(modelName) ? "Model Exists" : "";
    }

    @GetMapping(value = "showroomName/{showroomName}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String validateShowroomName(@PathVariable String showroomName) {
        return repository.ShowroomNameExists(showroomName) ? "ShowroomName Exists":"";
    }

    @GetMapping(value = "email/{email}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String validateShowroomEmailId(@PathVariable String email) {
        return repository.emailIdExists(email) ? "EmailId Exists":"";
    }

    @GetMapping(value = "location/{location}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String validateShowroomlocation(@PathVariable String location) {
        return repository.locationExists(location) ? "EmailId Exists":"";
    }


}
