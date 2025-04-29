package com.xworkz.showroomapp.service;


import com.xworkz.showroomapp.dto.CustomerRegistrationDto;
import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.CustomerRegistrationEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;

public interface CustomerRegistrationService {
    String validAndSave(UserRegistrationDto dto);
    UserRegistrationEntity authenticateUser(String emailId, String password);
    String updatePassword(String email, String currentPassword, String newPassword);
    boolean updatePasswords(String emailId, String newPassword);
    UserRegistrationDto fetctByEmail(String emailId);
}
