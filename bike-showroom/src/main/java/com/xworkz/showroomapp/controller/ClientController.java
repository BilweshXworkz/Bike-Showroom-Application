package com.xworkz.showroomapp.controller;

import com.xworkz.showroomapp.constants.LocationEnum;
import com.xworkz.showroomapp.dto.CustomerRegistrationDto;
import com.xworkz.showroomapp.dto.UserRegistrationDto;
import com.xworkz.showroomapp.entity.CustomerRegistrationEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import com.xworkz.showroomapp.service.AdminService;
import com.xworkz.showroomapp.service.CustomerRegistrationService;
import com.xworkz.showroomapp.service.UserRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/")
public class ClientController {
    @Autowired
    CustomerRegistrationService service;

    @Autowired
    AdminService adminService;

    @Autowired
    UserRegistrationService userRegistrationService;

    @GetMapping("exploreShowroom")
    public String exploreShowroom(){
        return "exploreShowroom";
    }

//    @RequestMapping ("signup")
//    public String SignUp(Model model){
//        List<LocationEnum> locations = Arrays.asList(LocationEnum.values());
//        model.addAttribute("locations", locations);
//        return "signUp";
//    }
//
    @RequestMapping ("addCustomer")
    public String addUser(@ModelAttribute @Valid UserRegistrationDto dto, Model model) throws IOException {
        Map<String, String> errorMap = new HashMap<>();
        System.out.println(dto);

        if (dto.getFullName() == null || dto.getFullName().isEmpty()) {
            errorMap.put("name", "Name is required");
        }

        String errorMessage = service.validAndSave(dto);
        if (errorMessage != null){
            model.addAttribute("error", errorMessage);
            return "userRegistration";
        }
        return "userRegistration";
    }

    @GetMapping("signin")
    public String signin(){
        return "signIn";
    }

    private String generateRandomText(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    @RequestMapping("generateCaptcha")
    public ResponseEntity<byte[]> generateCaptcha(HttpServletRequest request) {
        String captchaText = generateRandomText(6);
        request.getSession().setAttribute("captcha", captchaText);

        BufferedImage image = new BufferedImage(120, 40, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, 0, 120, 40);
        g.setColor(Color.BLACK);
        g.setFont(new Font("Arial", Font.BOLD, 22));
        g.drawString(captchaText, 20, 30);

        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "png", baos);
            return ResponseEntity.ok()
                    .header("Content-Type", "image/png")
                    .body(baos.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }

    private boolean verifyRecaptcha(String recaptchaResponse) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            String verifyUrl = "https://www.google.com/recaptcha/api/siteverify?secret=YOUR_SECRET_KEY&response=" + recaptchaResponse;
            Map<String, Object> response = restTemplate.getForObject(verifyUrl, Map.class);
            return response != null && (Boolean) response.get("success");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @PostMapping("login")
    public ModelAndView loginUser(@RequestParam("emailId") String emailId,
                                  @RequestParam("password") String password,
                                  @RequestParam(value = "captchaInput") String captchaInput, Model model,
                                  @RequestParam(value = "g-recaptcha-response", required = false) String recaptchaResponse,
                                  HttpServletRequest request){

        String storedCaptcha = (String) request.getSession().getAttribute("captcha");

        if (storedCaptcha == null || !storedCaptcha.equalsIgnoreCase(captchaInput)) {
            return new ModelAndView("signIn", "errorMessage", "Invalid CAPTCHA!");
        }

        UserRegistrationEntity user = service.authenticateUser(emailId, password);

        if (user != null) {
            if (user.getEmailId() == null) {
                return new ModelAndView("resetPassword");
            }
            return new ModelAndView("welcome", "user", user);
        }
        return new ModelAndView("signIn", "errorMessage", "Invalid Email or Password.");
    }

    @GetMapping("/getBikesByShowroomNames")
    @ResponseBody
    public List<String> getBikeModels(@RequestParam String showroomName) {
        return adminService.getBikesByShowroomName(showroomName); // Fetch bike models
    }

    @GetMapping ("fetchByEmail")
    public String fetchByEmail(@RequestParam("emailId") String emailId, Model model) {
        UserRegistrationDto user = service.fetctByEmail(emailId);
        List<String> showroomList = adminService.getShowroomName(); // You need this method
        model.addAttribute("user", user);
        model.addAttribute("showroomList", showroomList);
        return "UpdateUserProfile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute UserRegistrationEntity user, @RequestParam("updateProfile") MultipartFile file, RedirectAttributes attributes) {
        boolean updated = userRegistrationService.updateUsers(user, file);
        if (updated) {
            attributes.addFlashAttribute("success", "Profile updated successfully.");
        } else {
            attributes.addFlashAttribute("error", "Failed to update profile.");
        }
        return "UpdateUserProfile";
    }

    @RequestMapping("resetPassword")
    public String resetPassword(@RequestParam("emailId") String emailId,
                                @RequestParam("password") String currentPassword,
                                @RequestParam("newPassword") String newPassword,
                                @RequestParam("confirmPassword") String confirmPassword,
                                Model model) {

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("errorMessage", "New password and confirm password do not match.");
            return "welcome";
        }

        String isUpdated = service.updatePassword(emailId, currentPassword, newPassword);

        if (isUpdated.equals("Current password is incorrect.") || isUpdated.startsWith("User not found")) {
            model.addAttribute("errorMessage", isUpdated);
            return "resetPassword";
        }

        model.addAttribute("message", "Password successfully updated!");
        return "signIn";
    }

    @GetMapping("forgotPassword")
    public String forgotPassword() {
        return "forgetPassword";
    }

    @PostMapping("updatePassword")
    public String changePassword( @RequestParam("emailId") String emailId,
                                  @RequestParam("newPassword") String newPassword,
                                  Model model) {
        boolean isUpdated = service.updatePasswords(emailId, newPassword);

        if (isUpdated) {
            model.addAttribute("message", "Password successfully updated! Please login.");
            return "signIn"; // success - go to login page
        } else {
            model.addAttribute("error", "Failed to update password. Please check your email ID.");
            return "resetPassword"; // failure - stay on reset page
        }
    }

}
