package com.xworkz.showroomapp.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
@Table (name = "user_registration")


public class UserRegistrationEntity {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    @Column (name = "id")
    private Integer Id;
    @Lob
    @Column(name = "profile_image", columnDefinition = "LONGBLOB")
    private String profileImage;
    @Column (name = "full_name")
    private String fullName;
    @Column (name = "age")
    private Integer age;
    @Column (name = "phone_number")
    private Long phoneNumber;
    @Column (name = "email_id")
    private String emailId;
    @Column(name = "password")
    private String password;
    @Column (name = "address")
    private String address;
    @Column(name = "showroom_name")
    private String showroomName;
    @Column (name = "model_name")
    private String modelName;
    @Column (name = "date_time")
    private String dateTime;
    @Column(name = "date")
    private String date;
    @Column (name = "reason", nullable = true)
    private String reason;
    @Column (name = "schedule_task")
    private String scheduleTask;
    @Column (name = "dl_number")
    private String dlNumber;
    @Column(name = "failed_attempts")
    private Integer failedAttempts;
    @Column(name = "account_locked_until")
    private LocalDateTime accountLockedUntil;
}
