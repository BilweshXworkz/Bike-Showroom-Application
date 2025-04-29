package com.xworkz.showroomapp.service;

import com.xworkz.showroomapp.dto.AddBikeDto;
import com.xworkz.showroomapp.dto.AddBikeToShowroomDto;
import com.xworkz.showroomapp.dto.AddShowroomDto;
import com.xworkz.showroomapp.entity.*;
import com.xworkz.showroomapp.repository.AdminRepository;
import com.xworkz.showroomapp.repository.UserRegistrationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;
import javax.validation.*;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class AdminServiceImpl implements AdminService{
    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    UserRegistrationRepository repository;

    @Transactional
    @Override
    public boolean sendOtpToEmail(String email) {
        Optional<AdminEntity> admin = adminRepository.findByEmail(email);
        if (admin.isPresent()) {
            String otp = generateOtp();
            adminRepository.updateOtp(email, otp, LocalDateTime.now());
            return sendEmail(email, otp);
        }
        return false;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        Optional<AdminEntity> admin = adminRepository.findByEmail(email);

        if (admin.isPresent() && admin.get().getAdminOtp().equals(otp)) {
            return true;
        }
        return false;
    }

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    private boolean sendEmail(String to, String otp) {
        final String from = "bilweshbinay1025@gmail.com";
        final String password = "svdg oahn hluo sjhf";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Your OTP for Admin Login");
            message.setText("Your OTP is: " + otp);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String AddShowroom(AddShowroomDto dto) {
        if (adminRepository.existsByLocation(dto.getLocation())) {
            return "Showroom location already exists!";
        }
        AddShowroomEntity entity = new AddShowroomEntity();
        try {
            BeanUtils.copyProperties(dto, entity);
            Boolean isAdded = adminRepository.AddShowroom(entity);
            return "Successfully Added";
        } catch (BeansException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String addBikes(AddBikeDto dto) {
        try {
            AddBikeEntity entity = new AddBikeEntity();
            BeanUtils.copyProperties(dto, entity);

            entity.setBikeColours(dto.getBikeColours() != null ? Arrays.asList(dto.getBikeColours()) : new ArrayList<>());

            String folderPath = "E:\\bike-image\\";

            // Front Image
            if (dto.getFrontImage() != null && !dto.getFrontImage().isEmpty()) {
                String frontName = System.currentTimeMillis() + "_" + dto.getFrontImage().getOriginalFilename();
                Path frontPath = Paths.get(folderPath + frontName);
                Files.write(frontPath, dto.getFrontImage().getBytes());
                entity.setFrontImage(frontName);
            }

            // Back Image
            if (dto.getBackImage() != null && !dto.getBackImage().isEmpty()) {
                String backName = System.currentTimeMillis() + "_" + dto.getBackImage().getOriginalFilename();
                Path backPath = Paths.get(folderPath + backName);
                Files.write(backPath, dto.getBackImage().getBytes());
                entity.setBackImage(backName);
            }

            // Right Image
            if (dto.getRightImage() != null && !dto.getRightImage().isEmpty()) {
                String rightName = System.currentTimeMillis() + "_" + dto.getRightImage().getOriginalFilename();
                Path rightPath = Paths.get(folderPath + rightName);
                Files.write(rightPath, dto.getRightImage().getBytes());
                entity.setRightImage(rightName);
            }

            // Left Image
            if (dto.getLeftImage() != null && !dto.getLeftImage().isEmpty()) {
                String leftName = System.currentTimeMillis() + "_" + dto.getLeftImage().getOriginalFilename();
                Path leftPath = Paths.get(folderPath + leftName);
                Files.write(leftPath, dto.getLeftImage().getBytes());
                entity.setLeftImage(leftName);
            }

            adminRepository.AddBike(entity);
            return "Showroom successfully added!";
        } catch (BeansException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

        @Override
    public String addBikeToShowroom(String showroomName, String modelName) {

        AddShowroomEntity showroom = adminRepository.findByShowroomName(showroomName);
        if (showroom == null) {
            return "Showroom not found!";
        }

        AddBikeEntity bike = adminRepository.findByModelName(modelName);
        if (bike == null) {
            return "Bike not found!";
        }

        boolean isBikeAssignedToAnyShowroom = adminRepository.existsByBikeBikeId(bike.getBikeId());
        if (isBikeAssignedToAnyShowroom) {
            return "This bike is already assigned to another showroom!";
        }

        int bikeCount = adminRepository.countByShowroomShowroomName(showroom.getShowroomName());
        if (bikeCount >= 5) {
            return "Showroom already has 5 bikes!";
        }

        boolean exists = adminRepository.existsByShowroomShowroomIdAndBikeBikeId(
                showroom.getShowroomName(), bike.getModelName());
        if (exists) {
            return "This bike is already in this showroom!";
        }

        AddBikeToShowroomEntity entity = new AddBikeToShowroomEntity();
        entity.setShowroom(showroom);
        entity.setBike(bike);
        adminRepository.addBikeToShowroom(entity);

        return "Bike added to showroom successfully!";
    }

    @Override
    public List<String> getShowroomName() {
        return adminRepository.getShowroom();
    }

    @Override
    public List<String> getBikeModel() {
        return adminRepository.getBike();
    }

    @Override
    public List<AddBikeToShowroomDto> getAllMappings() {
        return adminRepository.findAllMappings();
    }

    @Override
    public List<AddShowroomEntity> getAllShowroom() {
        return adminRepository.getShowrooms();
    }

    @Override
    public List<AddBikeEntity> getAllBike() {
        return adminRepository.getBikes();
    }

    @Override
    public List<AddBikeEntity> getBikesByShowroomNames(String showroomName) {
        return adminRepository.findBikesByShowroomName(showroomName);
    }

    @Override
    public boolean deleteBikeFromShowroom(String showroomName, String bikeModel) {
        return adminRepository.deleteBikeFromShowroom(showroomName, bikeModel);
    }

    @Override
    public AddBikeDto fetchBike(String modelName) {
        if (modelName != null) {
            AddBikeDto dto =new AddBikeDto();
            AddBikeEntity entity = adminRepository.fetchBike(modelName);
            try{
                BeanUtils.copyProperties(entity, dto);
                return dto;
            } catch (BeansException e) {
                throw new RuntimeException(e);
            }
        }
        return null;
    }

    @Override
    public List<String> getBikeByShowroom() {
        return adminRepository.getBikeByShowroom();
    }

    @Override
    public List<String> getBikesByShowroomName(String showroomName) {
        return adminRepository.getBikeByShowroomName(showroomName);
    }

}
