package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.dto.AddBikeToShowroomDto;
import com.xworkz.showroomapp.entity.AddBikeEntity;
import com.xworkz.showroomapp.entity.AddBikeToShowroomEntity;
import com.xworkz.showroomapp.entity.AddShowroomEntity;
import com.xworkz.showroomapp.entity.AdminEntity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface AdminRepository{
    Optional<AdminEntity> findByEmail(String email);
    void updateOtp(String email, String otp, LocalDateTime currentTime);
    Boolean AddShowroom(AddShowroomEntity entity);
    Boolean AddBike(AddBikeEntity entity);
    AddShowroomEntity findByShowroomName(String showroomName);
    AddBikeEntity findByModelName(String modelName);
    int countByShowroomShowroomName(String showroomName);
    boolean existsByShowroomShowroomIdAndBikeBikeId(String showroomName, String modelName);
    void addBikeToShowroom(AddBikeToShowroomEntity entity);
    boolean existsByLocation(String location);
    List<String> getShowroom();
    List<String> getBike();
    List<String> getBikeByShowroom();
    List<String> getBikeByShowroomName(String showroomName);
    boolean existsByBikeBikeId(Integer bikeId);
    List<AddBikeToShowroomDto> findAllMappings();
    List<AddShowroomEntity> getShowrooms();
    List<AddBikeEntity> getBikes();
    List<AddBikeEntity> findBikesByShowroomName(String showroomName);
    boolean deleteBikeFromShowroom(String showroomName, String bikeModel);
    AddBikeEntity fetchBike(String modelName);
}
