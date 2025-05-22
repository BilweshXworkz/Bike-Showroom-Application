package com.xworkz.showroomapp.controller;

import com.xworkz.showroomapp.constants.ShowroomConst;
import com.xworkz.showroomapp.dto.AddBikeDto;
import com.xworkz.showroomapp.dto.AddBikeToShowroomDto;
import com.xworkz.showroomapp.dto.AddShowroomDto;
import com.xworkz.showroomapp.entity.AddBikeEntity;
import com.xworkz.showroomapp.service.AdminService;
import org.apache.taglibs.standard.extra.spath.Step;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminService adminService;

    @GetMapping("admin")
    public String adminPage() {
        return "admin/admin";
    }

    @PostMapping("/sendOtp")
    public String sendOtp(@RequestParam("email") String email, HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (adminService.sendOtpToEmail(email)) {
            session.setAttribute("otpSent", true);
            session.setAttribute("otpStartTime", System.currentTimeMillis());
            session.setAttribute("email", email);
            request.setAttribute("message", "OTP sent successfully to your email!");
        } else {
            request.setAttribute("error", "Invalid email or email not registered!");
        }
        return "admin/admin";
    }

    @PostMapping("/verifyOtp")
    public String verifyOtp(@RequestParam("otp") String otp, HttpServletRequest request){
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Long otpStartTime = (Long) session.getAttribute("otpStartTime");

        if (email == null || otpStartTime == null) {
            request.setAttribute("error", "Session expired! Please request OTP again.");
            return "admin/admin";
        }

        long elapsedMillis = System.currentTimeMillis() - otpStartTime;
        if (elapsedMillis > 5 * 60 * 1000) {
            session.removeAttribute("otpSent");
            request.setAttribute("error", "OTP expired! Please request a new one.");
            return "admin/admin";
        }

        if (adminService.verifyOtp(email, otp)) {
            session.setAttribute("isAuthenticated", true);
            session.removeAttribute("otpSent");
            return "admin/adminPage";
        } else {
            request.setAttribute("error", "Invalid OTP! Please try again.");
            return "admin/admin";
        }
    }

    @GetMapping("/GoAddShowroom")
    public String GoAddShowroom(Model model){
        model.addAttribute("showroomList", ShowroomConst.values());
        return "admin/addShowroom";
    }

    @PostMapping("/addShowroom")
    public String addShowroom(@ModelAttribute @Valid AddShowroomDto dto, Model model){
        Map<String, String> errorMap = new HashMap<>();
        if (dto.getShowroomName() == null || dto.getShowroomName().isEmpty()){
            errorMap.put("name", "Showroom Name is required");
        }
        String errorMessage = adminService.AddShowroom(dto);
        if (errorMessage != null){
            model.addAttribute("error", errorMessage);
            return "admin/addShowroom";
        }else {
            model.addAttribute("success", "Added successfully!");
        }
        return "admin/addShowroom";
    }

    @GetMapping("GoAddBike")
    public String GoAddBike(){
        return "admin/addBike";
    }

    @PostMapping("addBike")
    public String addBike(@ModelAttribute @Valid AddBikeDto dto, Model model){
        Map<String, String> errorMap = new HashMap<>();
        System.out.println(dto);

        if (dto.getModelName() == null || dto.getModelName().isEmpty()){
            errorMap.put("name", "Bike Model is Required");
            model.addAttribute("error", "Bike Model is Required");
            return "admin/addBike";
        }
        String message = adminService.addBikes(dto);

        if (message != null) {
            model.addAttribute("error", message);
            return "admin/addBike";
        }else {
            model.addAttribute("success", "Added successfully!");
        }
        return "/admin/addBike";
    }

    @GetMapping("bikeToShowroom")
    public String bikeToShowroom(Model model){
        List<String> showroomName = adminService.getShowroomName();
        List<String> modelName = adminService.getBikeModel();
        List<AddBikeToShowroomDto> mappingList = adminService.getAllMappings();

        Map<String, List<String>> showroomBikeMap = new LinkedHashMap<>();
        for (String showroom : showroomName) {
            List<String> modelsInShowroom = mappingList.stream()
                    .filter(m -> showroom.equals(m.getShowroomName()))
                    .map(AddBikeToShowroomDto::getModelName)
                    .collect(Collectors.toList());
            showroomBikeMap.put(showroom, modelsInShowroom);
        }

        model.addAttribute("showroomBikeMap", showroomBikeMap);
        return "admin/addBikeToShowroom";
    }

    @GetMapping("/addBikeToShowroomPage")
    public String addBikeToShowroomPage(@RequestParam("showroomName") String showroomName, Model model) {
        model.addAttribute("showroomName", showroomName);

        List<String> allBikeModels = adminService.getBikeModel();
        model.addAttribute("bikeModels", allBikeModels);

        return "admin/addBikeToSelectedShowroom";
    }


    @PostMapping("addBikeToShowroom")
    public String addBikeToShowroom(HttpServletRequest request, Model model){
        String showroomName = request.getParameter("showroomName");
        String modelName = request.getParameter("modelName");

        String result = adminService.addBikeToShowroom(showroomName, modelName);
        if ("Bike already mapped to this showroom".equals(result)) {
            model.addAttribute("error", result);
        } else {
            model.addAttribute("success", result);
        }
        return "admin/addBikeToSelectedShowroom";
    }

    @PostMapping("/removeMapping")
    public String removeBike(@RequestParam("showroomName") String showroomName, Model model){
        List<AddBikeEntity> bikes = adminService.getBikesByShowroomNames(showroomName);
        model.addAttribute("bikes", bikes);
        model.addAttribute("showroomName", showroomName);
        return "admin/removeBike";
    }

    @PostMapping("/deleteBike")
    public String deleteBikeFromShowroom(@RequestParam("showroomName") String showroomName,
                                         @RequestParam("bikeModel") String bikeModel,
                                         Model model) {
        boolean deleted = adminService.deleteBikeFromShowroom(showroomName, bikeModel);
        if (deleted) {
            model.addAttribute("success", "Bike removed successfully.");
        } else {
            model.addAttribute("error", "Failed to remove bike.");
        }

        List<AddBikeEntity> bikes = adminService.getBikesByShowroomNames(showroomName);
        model.addAttribute("bikes", bikes);
        model.addAttribute("showroomName", showroomName);
        return "admin/removeBike";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/index.jsp";
    }

}
