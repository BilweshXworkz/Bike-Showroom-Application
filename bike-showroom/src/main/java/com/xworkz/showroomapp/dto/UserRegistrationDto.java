package com.xworkz.showroomapp.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class UserRegistrationDto {
    private Integer Id;
    private String fullName;
    private Integer age;
    private Long phoneNumber;
    private String emailId;
    private String password;
    private String address;
    private String showroomName;
    private String modelName;
    private String dateTime;
    private String scheduleTask;
    private String reason;
    private String dlNumber;
    private Integer failedAttempts = -1;
    private MultipartFile multipartFile;
}
