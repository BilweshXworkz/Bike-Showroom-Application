package com.xworkz.showroomapp.controller;

import com.xworkz.showroomapp.dto.AddBikeDto;
import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import com.xworkz.showroomapp.service.AdminService;
import com.xworkz.showroomapp.service.UserRegistrationService;
import org.hibernate.engine.jdbc.StreamUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;


@Controller
@RequestMapping("/")
public class UserController {

//    private static final String IMAGE_DIRECTORY = "E:\\bike-image";
    @Autowired
    AdminService adminService;

    @Autowired
    UserRegistrationService userRegistrationService;

    @GetMapping("user")
    public String user(Model model) {
        List<String> modelName = adminService.getBikeByShowroom();
        List<String> showroomName = adminService.getShowroomName();
        model.addAttribute("bikeList", modelName);
        model.addAttribute("showroomList", showroomName );
        return "user/userRegistration";
    }

    @GetMapping(value = "/getBikesByShowroom",  produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getBikesByShowroom(@RequestParam String showroomName) {
        System.out.println("Showroom received: " + showroomName);
        List<String> list = adminService.getBikesByShowroomName(showroomName);
        System.out.println("Models: " + list);
        return list;
    }

    @PostMapping ("userRegistration")
    public String userRegistration (@ModelAttribute UserRegistrationDto dto, Model model) throws IOException {
        String userdetails = userRegistrationService.registerUser(dto);
        System.out.println(userdetails);
        if (!userdetails.equals("success")) {
            model.addAttribute("error", userdetails);
            return "user/userRegistration";
        }else {
            model.addAttribute("success", "Added successfully!");
        }
        return "user/userRegistration";
    }

    @GetMapping ("userForm")
    public String userForm (Model model) {
        List<UserRegistrationEntity> userList = userRegistrationService.getAllUser();
        model.addAttribute("usersRegistrationForm", userList);
        return "user/UserForm";
    }

    @GetMapping ("fetchById")
    public String updateById(@RequestParam("Id") Integer id, Model model) {
        UserRegistrationEntity user = userRegistrationService.getUserById(id);
        model.addAttribute("user", user);
        return "user/UpdateUser";
    }

    @GetMapping ("viewById")
    public String viewById(@RequestParam("Id") Integer id, Model model) {
        UserRegistrationEntity user = userRegistrationService.getUserById(id);
        model.addAttribute("user", user);

        List<String> reasonsList = new ArrayList<>();
        List<String> dateTimeList = new ArrayList<>();

        if (user.getReason() != null) {
            reasonsList = Arrays.asList(user.getReason().split("\\s*,\\s*"));
        }
        if (user.getDateTime() != null) {
            dateTimeList = Arrays.asList(user.getDateTime().split("\\s*,\\s*"));
        }

        List<Map<String, String>> reasonDateList = new ArrayList<>();
        for (int i = 0; i < reasonsList.size(); i++) {
            Map<String, String> entry = new HashMap<>();
            entry.put("reason", reasonsList.get(i));
            entry.put("date", i < dateTimeList.size() ? dateTimeList.get(i) : "N/A");
            reasonDateList.add(entry);
        }

        model.addAttribute("reasonDateList", reasonDateList);
        model.addAttribute("user", user);

        return "user/ViewUser";
    }

    @GetMapping ("getTestRide")
    public String gteTestRide(@RequestParam("scheduleTask") String scheduleTaskStr, Model model) {
        Integer scheduleTask = Integer.parseInt(scheduleTaskStr);
        List<UserRegistrationEntity> testRide = userRegistrationService.getTestRide(scheduleTask);
        model.addAttribute("usersRegistrationForm", testRide);
        return  "user/TestRide";
    }

    @GetMapping ("getBooking")
    public String getBooking(@RequestParam("scheduleTask") int scheduleTask, Model model) {
        List<UserRegistrationEntity> bookings = userRegistrationService.getBooking(scheduleTask);
        model.addAttribute("usersRegistrationForm", bookings);
        System.out.println(bookings);
        return "user/BookingDetails";
    }


    @PostMapping("updateUser")
    public String updateUser(@RequestParam("id") Integer id,
                             @RequestParam("reason") String reason,
                             @RequestParam("dateTime") String dateTime) {
        userRegistrationService.updateUserDetails(id, reason, dateTime);
        return "user/UpdateUser";
    }

    @GetMapping("/editProfile")
    public String editProfilePage(Model model, HttpSession session) {
        String email = (String) session.getAttribute("loggedInUser");
        if (email != null) {
            UserRegistrationEntity user = userRegistrationService.fetctByEmail(email);
            List<String> showroomList = adminService.getShowroomName();
            model.addAttribute("user", user);
            model.addAttribute("showroomList", showroomList);
            return "UpdateUserProfile";
        }
        return "redirect:/login";
    }

    @GetMapping("/getBikesByShowroomName")
    @ResponseBody
    public List<String> getBikesByShowroomNames(@RequestParam String showroomName) {
        return adminService.getBikesByShowroomName(showroomName);
    }

    @GetMapping("exploreBikes")
    public String exploreBikes(@RequestParam("modelName") String modelName, Model model) {
        AddBikeDto dto = adminService.fetchBike(modelName);
        model.addAttribute("model", dto);
        return "ExploreBikes";
    }


    @GetMapping("/bike-image/{side}/{modelName}")
    public void loadBikeImage(@PathVariable String side,
                              @PathVariable String modelName,
                              HttpServletResponse response) throws IOException {
        AddBikeDto dto = adminService.fetchBike(modelName);

        String imageName = null;
        switch (side.toLowerCase()) {
            case "front":
                imageName = dto.getFrontImage().getOriginalFilename();
                break;
            case "back":
                imageName = dto.getBackImage().getOriginalFilename();
                break;
            case "left":
                imageName = dto.getLeftImage().getOriginalFilename();
                break;
            case "right":
                imageName = dto.getRightImage().getOriginalFilename();
                break;
            default:
                imageName = null;
        }

        if (imageName != null) {
            File imageFile = new File("E:/bike-image/" + imageName);
            if (imageFile.exists()) {
                System.out.println(imageFile);
                response.setContentType(Files.probeContentType(imageFile.toPath()));
                StreamUtils.copy(Files.newInputStream(imageFile.toPath()), response.getOutputStream());
            } else {
                System.out.println("Image not found: " + imageFile.getAbsolutePath());
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }


}