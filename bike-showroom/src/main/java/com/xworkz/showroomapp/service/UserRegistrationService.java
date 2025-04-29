package com.xworkz.showroomapp.service;

import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;

import java.time.LocalDateTime;
import java.util.List;

public interface UserRegistrationService {
    String registerUser(UserRegistrationDto dto);
    List<UserRegistrationEntity> getAllUser();
    void updateReasonById(Integer id, String reason, String dateTime);
    UserRegistrationEntity getUserById(Integer id);
    List<UserRegistrationEntity> getBooking(int i);
    List<UserRegistrationEntity> getTestRide(int i);
    void updateUserDetails(Integer id, String reason, String dateTime);
    UserRegistrationEntity fetctByEmail(String emailId);
    Boolean updateUser(UserRegistrationDto dto);
    Boolean generateOtp(String email);
    Boolean verifyOtp(String email, String otp);
    Boolean resetPassword(String email, String otp, String newPassword);
}
