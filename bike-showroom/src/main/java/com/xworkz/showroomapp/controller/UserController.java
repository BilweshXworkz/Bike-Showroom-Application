package com.xworkz.showroomapp.controller;

import com.xworkz.showroomapp.dto.AddBikeDto;
import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import com.xworkz.showroomapp.service.AdminService;
import com.xworkz.showroomapp.service.UserRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;


@Controller
@RequestMapping("/")
public class UserController {

    private static final File IMAGE_DIRECTORY = new File("E://bike-images//");
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
    public String userRegistration (@ModelAttribute UserRegistrationDto dto, Model model) {
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

    @RequestMapping ("updateProfile")
    public String updateAndSave(@ModelAttribute UserRegistrationDto dto, Model model){
        System.out.println("updateAndSave"+dto);
        Boolean updateUser = userRegistrationService.updateUser(dto);
        if (updateUser){
            model.addAttribute("success","User Data Updated Successfully");
        }else {
            model.addAttribute("error", "User Data Not Updated");
        }
        return "UpdateUserProfile";
    }

    @GetMapping ("exploreBikes")
    public String exploreBikes(@RequestParam ("modelName") String modelName, Model model) {
        AddBikeDto dto = adminService.fetchBike(modelName);
        model.addAttribute("model", dto);
        return "ExploreBikes";
    }


    @GetMapping("/bike-image/{imageName:.+}")
    public void getBikeImage(@PathVariable String imageName, HttpServletResponse response) throws IOException {
        File imageFile = new File(IMAGE_DIRECTORY + imageName);

        if (imageFile.exists()) {
            response.setContentType("image/png"); // You can change according to your image type (jpeg/png)
            FileInputStream fis = new FileInputStream(imageFile);
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, bytesRead);
            }
            fis.close();
            response.getOutputStream().flush();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}