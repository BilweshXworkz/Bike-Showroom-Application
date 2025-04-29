package com.xworkz.showroomapp.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class AdminDto {
    private Integer id;
    private String adminName;
    private Integer adminOtp;
}
