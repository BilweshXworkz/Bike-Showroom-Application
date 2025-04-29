package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.entity.UserRegistrationEntity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface UserRegistrationRepository {
    void registerUser(UserRegistrationEntity entity);
    boolean nameExists(String fullName);
    boolean phoneNumberExists(Long contact);
    boolean emailExists(String emailId);
    boolean modelExists(String modelName);
    boolean ShowroomNameExists(String showroomName);
    boolean emailIdExists(String email);
    public List<UserRegistrationEntity> fetchAllUser();
    UserRegistrationEntity findById(Integer id);
    void update(Integer id, String reason, String dateTime);
    List<UserRegistrationEntity> findByScheduleTask(int i);
    boolean locationExists(String location);
    UserRegistrationEntity fetchEmail(String emailId);
    UserRegistrationEntity findByEmailId(String emailId);
    void updateUser(UserRegistrationEntity entity);
    Optional<UserRegistrationEntity> findByEmail(String email);
    void updateOtp(String email, String otp);
    void save(UserRegistrationEntity userRegistrationEntity);
}
