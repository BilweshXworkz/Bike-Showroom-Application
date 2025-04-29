package com.xworkz.showroomapp.dto;

import com.sun.javafx.iio.ImageFrame;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class AddBikeDto {
    private Integer bikeId;
    private String showroomName;
    private String modelName;
    private String engine;
    private String price;
    private String torque;
    private String brakes;
    private String power;
    private String mileage;
    private String tyreType;
    private String[] bikeColours;
    private MultipartFile frontImage;
    private MultipartFile backImage;
    private MultipartFile leftImage;
    private MultipartFile rightImage;
}
