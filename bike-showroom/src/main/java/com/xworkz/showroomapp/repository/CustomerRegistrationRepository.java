package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.entity.CustomerRegistrationEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


public interface CustomerRegistrationRepository {
    Boolean save(UserRegistrationEntity entity);
    List<UserRegistrationEntity> findAll();
    UserRegistrationEntity fetchEmail(String emailId);
    void updateFailedAttemps(String emailId);
    void resetFailedAttempts(UserRegistrationEntity user);
    void passwordUpdate(String emailId, String newPassword);
    Optional<UserRegistrationEntity> findByEmail(String emailId);
    void update(UserRegistrationEntity user);
}
