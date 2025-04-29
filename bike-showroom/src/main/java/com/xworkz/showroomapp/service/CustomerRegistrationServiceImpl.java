package com.xworkz.showroomapp.service;

import com.xworkz.showroomapp.dto.CustomerRegistrationDto;
import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.CustomerRegistrationEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import com.xworkz.showroomapp.repository.CustomerRegistrationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CustomerRegistrationServiceImpl implements CustomerRegistrationService{

    private static final String SECRET_KEY = "MySecretKey12345";

    @Autowired
    CustomerRegistrationRepository repository;

    @Override
    public String validAndSave(UserRegistrationDto dto) {
        String error;
        List<UserRegistrationEntity> allUsers = repository.findAll();

        if ((error = validateName(dto.getFullName())) != null){
            return "Name is not valid" +error;
        }

        List<String> duplicateFields = new ArrayList<>();
        for (UserRegistrationEntity user : allUsers) {
            if (user.getFullName().equalsIgnoreCase(dto.getFullName())) duplicateFields.add("Name");
            if (user.getEmailId().equalsIgnoreCase(dto.getEmailId())) duplicateFields.add("Email ID");
            if (user.getPhoneNumber() == (dto.getPhoneNumber())) duplicateFields.add("Phone Number");
        }

        if (!duplicateFields.isEmpty()) {
            return "User already exists with " + String.join(", ", duplicateFields);
        }

        String randomPassword = generateRandomNumber();

        if ((error = validatePassword(randomPassword)) != null) {
            return "Generated password is invalid: " + error;
        }

        System.out.println("Generated Password: " + randomPassword);

        String encryptedPassword = encryptPassword(randomPassword);

        UserRegistrationEntity entity = new UserRegistrationEntity();
        BeanUtils.copyProperties(dto, entity);
        entity.setPassword(encryptedPassword);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String formattedDate = LocalDateTime.now().format(formatter);

        entity.setFailedAttempts(dto.getFailedAttempts() != null ? dto.getFailedAttempts() : 0);
        entity.setDate(formattedDate);
        repository.save(entity);
        sendAuthenticateEmail(dto.getEmailId(), randomPassword);
        return "Your account is created successfully. Use this password to log in: " + randomPassword;
    }

    @Override
    public UserRegistrationEntity authenticateUser(String emailId, String password) {
        UserRegistrationEntity user = repository.fetchEmail(emailId);
        if (user == null) {
            System.out.println("User not found");
            return null;
        }
        if (user.getFailedAttempts() != null && user.getFailedAttempts() == -1) {
            System.out.println("User needs to reset password.");
            return new UserRegistrationEntity();
        }

        if (user.getAccountLockedUntil() != null && user.getAccountLockedUntil().isAfter(LocalDateTime.now())) {
            System.out.println("Account is locked until " + user.getAccountLockedUntil());
            return null;
        }
        String decryptedPassword = decryptPassword(user.getPassword());
        if (!password.equals(decryptedPassword)) {
            System.out.println("Invalid credentials");
            repository.updateFailedAttemps(emailId);
            return null;
        }

        repository.resetFailedAttempts(user);
        return user;
    }

    @Override
    public String updatePassword(String emailId, String currentPassword, String newPassword) {
        Optional<UserRegistrationEntity> userOptional = repository.findByEmail(emailId);

        if (userOptional.isPresent()) {
            UserRegistrationEntity user = userOptional.get();

            String decryptedPassword = decryptPassword(user.getPassword());

            if (!decryptedPassword.equals(currentPassword)) {
                return "Current password is incorrect.";
            }

            String encryptedNewPassword = encryptPassword(newPassword);
            user.setPassword(encryptedNewPassword);

            repository.passwordUpdate(emailId, encryptedNewPassword);

            return "Password updated successfully.";
        } else {
            return "User not found with email: " + emailId;
        }
    }

    @Override
    public boolean updatePasswords(String emailId, String newPassword) {
        Optional<UserRegistrationEntity> user = repository.findByEmail(emailId);

        if (user.isPresent()) {
            String encryptedPassword = encryptPassword(newPassword);
            user.get().setPassword(encryptedPassword);
            repository.update(user.get());
            return true;
        }
        return false;
    }

    @Override
    public UserRegistrationDto fetctByEmail(String emailId) {
        if (emailId != null){
            UserRegistrationDto dto = new UserRegistrationDto();
            UserRegistrationEntity entity = repository.fetchEmail(emailId);
            try {
                BeanUtils.copyProperties(entity, dto);
                return dto;
            } catch (BeansException e) {
                System.out.println(e.getMessage());
            }
        }
        return null;
    }

    private String validateName(String name) {
        if (name == null || name.trim().isEmpty()) return "Name cannot be empty";
        name = name.trim();
        if (name.length() < 3) return "Name should be more than 3 characters";
        if (!name.matches(".*[A-Z].*")) return "Name must contain at least one uppercase letter";
        if (!name.matches("[A-Za-z ]+")) return "Name should not have any special characters or numbers";
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

    private String validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) return "Email cannot be empty";
//        String emailRegex = "^(?=.*[a-z])(?=.*\\d)(?=.*[@.])[a-z\\d@.]+@[a-z]+\\.[a-z]{2,6}$";
        String emailRegex = "^(?=.*[a-z])(?=.*\\d)(?=.*[@.])[a-z\\d@.]+@[a-z]+\\.[a-z]$";
        if (!email.matches(emailRegex)) {
            return "Invalid Email: Must contain a number, an uppercase letter, and a special character (@ or .)";
        }
        return null;
    }

    private String generateRandomNumber() {
        int num = 8;
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String digits = "0123456789";
        String specialChars = "@#$%^&+=!";
        String allChars = upperCase + lowerCase + digits + specialChars;

        Random random = new Random();
        StringBuilder password = new StringBuilder();

        password.append(upperCase.charAt(random.nextInt(upperCase.length())));
        password.append(digits.charAt(random.nextInt(digits.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));

        for (int i = 3; i < num; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }

        List<Character> passwordChars = password.chars().mapToObj(c -> (char) c).collect(Collectors.toList());
        Collections.shuffle(passwordChars);

        return passwordChars.stream().map(String::valueOf).collect(Collectors.joining());
    }

    public String validatePassword(String password) {
        if (password == null || password.length() < 6)
            return "Password must be at least 6 characters long";

        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{6,}$";
        if (!password.matches(passwordRegex)) {
            return "Password must contain at least one uppercase letter, one number, and one special character";
        }
        return null;
    }

    private String encryptPassword(String password) {
        try {
            Cipher cipher = Cipher.getInstance("AES");
            SecretKey secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            byte[] encryptedBytes = cipher.doFinal(password.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            throw new RuntimeException("Error encrypting password", e);
        }
    }

    private String decryptPassword(String encryptedPassword) {
        try {
            Cipher cipher = Cipher.getInstance("AES");
            SecretKey secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedPassword));
            return new String(decryptedBytes);
        } catch (Exception e) {
            throw new RuntimeException("Error decrypting password", e);
        }
    }

    public static void sendAuthenticateEmail(String emailId, String randomPassword) {

        final String username = "bilweshbinay1025@gmail.com";
        final String password = "svdg oahn hluo sjhf";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            if (emailId == null || emailId.isEmpty()) {
                throw new IllegalArgumentException("Recipient email cannot be null or empty");
            }

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailId));
            message.setSubject("This message for OTP");
            message.setText("Your Password : - " +randomPassword);

            System.out.println("Send email to : "+emailId);
            Transport.send(message);
            System.out.println("Email sent successfully");

            System.out.println("Done");

        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }
    }

}
