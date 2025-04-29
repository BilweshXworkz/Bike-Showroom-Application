package com.xworkz.showroomapp.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class AddShowroomDto {
    private Integer showroomId;
    private String showroomName;
    private String location;
    private Long contact;
    private String email;
}
