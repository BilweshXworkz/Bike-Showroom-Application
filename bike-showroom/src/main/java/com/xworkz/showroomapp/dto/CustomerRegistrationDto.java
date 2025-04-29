package com.xworkz.showroomapp.dto;

import com.xworkz.showroomapp.constants.LocationEnum;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class CustomerRegistrationDto {
    private Integer id;
    @NotNull(message = "The user name must not be null")
    @Size(min=3, max=10, message = "the name size must be 3 and less then 10")
    private String name;
    private Long phoneNumber;
    private String emailId;
    private String password;
    private String conformPassword;
    private LocationEnum location;
    private String gender;
    private Integer age;
    private String date;
    private Integer failedAttempts = -1;
    private MultipartFile multipartFile;
}
