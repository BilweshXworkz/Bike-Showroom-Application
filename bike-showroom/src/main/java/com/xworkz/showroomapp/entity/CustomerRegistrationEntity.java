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
@Table(name = "customer_table")

@NamedQuery(
        name = "fetchByEmail",
        query = "SELECT c FROM UserRegistrationEntity c WHERE c.emailId = :emailId"
)

public class CustomerRegistrationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "phone_number")
    private Long phoneNumber;
    @Column(name = "email_id", nullable = false)
    private String emailId;
    @Column(name = "password")
    private String password;
    @Column(name = "location")
    private String location;
    @Column(name = "gender")
    private String gender;
    @Column(name = "age")
    private Integer age;
    @Column(name = "date")
    private String date;
    @Column(name = "failed_attempts")
    private Integer failedAttempts;
    @Column(name = "account_locked_until")
    private LocalDateTime accountLockedUntil;
}
