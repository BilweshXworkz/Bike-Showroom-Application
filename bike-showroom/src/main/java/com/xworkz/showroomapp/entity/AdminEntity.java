package com.xworkz.showroomapp.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@ToString
@Entity
@Table(name = "showroom_admin")

public class AdminEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "admin_name")
    private String adminName;
    @Column(name = "admin_email", unique = true, nullable = false)
    private String adminEmail;
    @Column(name = "admin_otp")
    private String  adminOtp;
    @Column(nullable = true)
    private LocalDateTime otpGeneratedTime;
}
