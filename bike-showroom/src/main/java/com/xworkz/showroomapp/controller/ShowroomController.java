package com.xworkz.showroomapp.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
import com.xworkz.showroomapp.entity.AddBikeEntity;
import com.xworkz.showroomapp.entity.AddShowroomEntity;
import com.xworkz.showroomapp.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@RequestMapping ("/")
public class ShowroomController {

    @Autowired
    AdminService adminService;

    @GetMapping("/explore")
    public String  exploreShowroom (Model model) {
        List<AddShowroomEntity> showrooms = adminService.getAllShowroom();
        model.addAttribute("showrooms",showrooms);
        return "Showroom";
    }

    @GetMapping("showroomUser")
    public String  showroomUser (Model model) {
        List<AddShowroomEntity> showrooms = adminService.getAllShowroom();
        model.addAttribute("showrooms",showrooms);
        return "ShowroomUser";
    }

    @GetMapping("exploreBike")
    public String exploreBike (Model model) {
        List<AddBikeEntity> bikes = adminService.getAllBike();
        model.addAttribute("bikes", bikes);
        return "Bikes";
    }

    @GetMapping("exploreShowroomBikesUser")
    public String exploreShowroomBikesUser (@RequestParam String showroomName, Model model) {
        List<AddBikeEntity> bikes = adminService.getBikesByShowroomNames(showroomName);
        model.addAttribute("bikes", bikes);
        return "BikesUser";
    }

    @GetMapping ("exploreShowroomBikes")
    public String exploreBikesByShowroom(@RequestParam String showroomName, Model model) {
        List<AddBikeEntity> bikes = adminService.getBikesByShowroomNames(showroomName);
        model.addAttribute("bikes", bikes);
        return "Bikes";
    }
}
