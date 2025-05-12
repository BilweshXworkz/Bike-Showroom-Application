package com.xworkz.showroomapp.service;

import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.AdminEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import com.xworkz.showroomapp.repository.UserRegistrationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.*;


@Service
public class UserRegistrationServiceImpl implements UserRegistrationService{

    @Autowired
    UserRegistrationRepository repository;

    @Override
    public String registerUser(UserRegistrationDto dto) throws IOException {
        String error;

        if ((error = validateName(dto.getFullName())) != null){
            return "Name is not valid" +error;
        }

        if ((error = validatePhoneNumber(dto.getPhoneNumber())) != null) {
            return "Phone number is not valid: " + error;
        }

        if ((error = validateEmail(dto.getEmailId())) != null) {
            return "Email Id is not valid: " + error;
        }

        if (dto.getAge() <18){
            return "Sorry we can't give you a ride";
        }

        if (dto.getDlNumber() == null || dto.getDlNumber().isEmpty()){
            return "Sorry You can't ride";
        }

        UserRegistrationEntity entity = new UserRegistrationEntity();
        BeanUtils.copyProperties(dto, entity);

//        String folderPath = "E:\\bike-image\\";
//        if (dto.getProfileImage() != null && !dto.getProfileImage().isEmpty()) {
//            String profileName = System.currentTimeMillis() + "_" + dto.getProfileImage().getOriginalFilename();
//            Path frontPath = Paths.get(folderPath + profileName);
//            Files.write(frontPath, dto.getProfileImage().getBytes());
//            entity.setProfileImage(profileName);
//        }

        repository.registerUser(entity);

        return "Registered";
    }

    @Override
    public List<UserRegistrationEntity> getAllUser() {
        return repository.fetchAllUser();
    }

    @Override
    public void updateReasonById(Integer id, String reason, String dateTime) {
        UserRegistrationEntity user = repository.findById(id);
        if (user != null) {
            String currentReason = user.getReason();
            String updatedReason = (currentReason == null || currentReason.isEmpty())
                    ? reason
                    : currentReason + ", " + reason;

            repository.update(id, updatedReason, dateTime);
        }
    }

    @Override
    public UserRegistrationEntity getUserById(Integer id) {
        return repository.findById(id);
    }

    @Override
    public List<UserRegistrationEntity> getTestRide(int i) {
        return repository.findByScheduleTask(0);
    }

    @Override
    public void updateUserDetails(Integer id, String reason, String dateTime) {
        UserRegistrationEntity user = repository.findById(id);
        if (user != null) {
            // Update Reason field
            String currentReason = user.getReason();
            String updatedReason = (currentReason == null || currentReason.isEmpty())
                    ? reason
                    : currentReason + ", " + reason;

            user.setReason(updatedReason);

            // Update DateTime field - append new dateTime to existing ones with a comma
            String currentDateTime = user.getDateTime();
            String updatedDateTime = (currentDateTime == null || currentDateTime.isEmpty())
                    ? dateTime
                    : currentDateTime + ", " + dateTime;

            user.setDateTime(updatedDateTime);  // Set the updated dateTime

            // Persist the changes
            repository.update(id, user.getReason(), user.getDateTime());
        }
    }

    @Override
    public UserRegistrationEntity fetctByEmail(String emailId) {
        if (emailId != null){
            UserRegistrationDto dto = new UserRegistrationDto();
            UserRegistrationEntity entity = repository.fetchEmail(emailId);
            try {
                BeanUtils.copyProperties(entity, dto);
                return entity;
            } catch (BeansException e) {
                System.out.println(e.getMessage());
            }
        }
        return null;
    }



    @Override
    public List<UserRegistrationEntity> getBooking(int i) {
        return repository.findByScheduleTask(1);
    }


    private String validateName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) return "Name cannot be empty";
        fullName = fullName.trim();
        if (fullName.length() < 3) return "Name should be more than 3 characters";
        if (!fullName.matches(".*[A-Z].*")) return "Name must contain at least one uppercase letter";
        if (!fullName.matches("[A-Za-z ]+")) return "Name should not have any special characters or numbers";
        return null;
    }

    private String validatePhoneNumber(Long phoneNumber) {
        if (phoneNumber == null) return "Phone number cannot be null";
        String phno = String.valueOf(phoneNumber);
        if (phno.length() != 10) return "Phone number must be 10 digits.";
        char startDigit = phno.charAt(0);
        if (startDigit != '9' && startDigit != '8' && startDigit != '7') {
            return "Phone number should start with 9, 8, or 7";
        }
        return null;
    }

    @Override
    public Boolean updateUser(UserRegistrationDto dto) {
        UserRegistrationEntity entity = repository.findByEmailId(dto.getEmailId());

        if (entity != null) {
            // Update fields
            entity.setFullName(dto.getFullName());
            entity.setAge(dto.getAge());
            entity.setPhoneNumber(dto.getPhoneNumber());
            entity.setAddress(dto.getAddress());
            entity.setDlNumber(dto.getDlNumber());

            if (dto.getProfileImage() != null && !dto.getProfileImage().isEmpty()) {
                try {
                    String folderPath = "E:\\bike-image\\profile image";
                    String profileName = System.currentTimeMillis() + "_" + dto.getProfileImage().getOriginalFilename();
                    Path frontPath = Paths.get(folderPath + profileName);
                    Files.write(frontPath, dto.getProfileImage().getBytes());
                    entity.setProfileImage(profileName.getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                    return false;
                }
            }

            // Save updated entity
            repository.updateUser(entity);
            return true;
        } else {
            System.out.println("User not found with email: " + dto.getEmailId());
            return false;
        }
    }

    @Override
    public Boolean generateOtp(String email) {
        Optional<UserRegistrationEntity> admin = repository.findByEmail(email);
        if (admin.isPresent()) {
            String otp = userGenerateOtp();
            repository.updateOtp(email, otp);
            return sendEmail(email, otp);
        }
        return false;
    }

    private String userGenerateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    @Override
    public Boolean verifyOtp(String email, String otp) {
        Optional<UserRegistrationEntity> admin = repository.findByEmail(email);

        if (admin.isPresent() && admin.get().getPassword().equals(otp)) {
            return true;
        }
        return false;
    }

    @Override
    public Boolean resetPassword(String email, String otp, String newPassword) {
        Optional<UserRegistrationEntity> user = repository.findByEmail(email);

        if (user.isPresent() && user.get().getPassword().equals(otp)) {
            user.get().setPassword(newPassword);
            repository.save(user.get());
            return true;
        }
        return false;
    }

    @Override
    public boolean updateUsers(UserRegistrationEntity user, MultipartFile file) {
        try {
            // 1. Fetch existing user by email or ID (whichever is present)
            UserRegistrationEntity existing = repository.findByEmailId(user.getEmailId());
            if (existing == null) {
                return false;
            }

            // 2. Update only the required fields
            existing.setFullName(user.getFullName());
            existing.setAge(user.getAge());
            existing.setPhoneNumber(user.getPhoneNumber());
            existing.setAddress(user.getAddress());
            existing.setDlNumber(user.getDlNumber());
            existing.setShowroomName(user.getShowroomName());
            existing.setModelName(user.getModelName());

            // 3. Update image only if a new one is uploaded
            if (!file.isEmpty()) {
                byte[] imageBytes = file.getBytes();
                existing.setProfileImage(imageBytes);
            }

            // 4. Save updated user
            repository.updateUser(existing);
            return true;

        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Boolean sendEmail(String email, String otp) {
        final String from = "bilweshbinay1025@gmail.com";
        final String password = "svdg oahn hluo sjhf"; // Be sure to use a secure way to store the password

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));  // Corrected to use 'email'
            message.setSubject("Your OTP for Admin Login");
            message.setText("Your OTP is: " + otp);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }




    private String validateEmail(String email) {
    if (email == null || email.trim().isEmpty()) return "Email cannot be empty";
    String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    if (!email.matches(emailRegex)) {
        return "Invalid Email: Must contain a number, and a special character (@ or .)";
    }
        return null;
    }


}
