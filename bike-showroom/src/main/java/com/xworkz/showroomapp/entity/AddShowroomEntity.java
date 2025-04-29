package com.xworkz.showroomapp.entity;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity

@Table(name = "showroom_table" )

public class AddShowroomEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "showroom_id")
    private Integer showroomId;
    @Column(name = "showroom_name", unique = true)
    private String showroomName;
    @Column(name = "location", unique = true, nullable = false)
    private String location;
    @Column(name = "contact")
    private Long contact;
    @Column(name = "email")
    private String email;
}
