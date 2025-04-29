package com.xworkz.showroomapp.service;

import com.xworkz.showroomapp.dto.AddBikeDto;
import com.xworkz.showroomapp.dto.AddBikeToShowroomDto;
import com.xworkz.showroomapp.dto.AddShowroomDto;
import com.xworkz.showroomapp.entity.AddBikeEntity;
import com.xworkz.showroomapp.entity.AddShowroomEntity;

import java.util.List;

public interface AdminService {
    boolean sendOtpToEmail(String email);
    boolean verifyOtp(String email, String otp);
    String AddShowroom(AddShowroomDto dto);
    String addBikes(AddBikeDto dto);
    String addBikeToShowroom(String showroomName, String modelName);
    List<String> getShowroomName();
    List<String> getBikeModel();
    List<String> getBikeByShowroom();
    List<String> getBikesByShowroomName(String showroomName);
    List<AddBikeToShowroomDto> getAllMappings();
    List<AddShowroomEntity> getAllShowroom();
    List<AddBikeEntity> getAllBike();
    List<AddBikeEntity> getBikesByShowroomNames(String showroomName);
    boolean deleteBikeFromShowroom(String showroomName, String bikeModel);
    AddBikeDto fetchBike(String modelName);
}
