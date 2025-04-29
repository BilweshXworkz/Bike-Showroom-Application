package com.xworkz.showroomapp.resetController;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
public class BikeImageController {

    private final String IMAGE_DIR = "E:/bike-image/";

    @GetMapping("/{imageName}")
    public ResponseEntity<Resource> getBikeImage(@PathVariable String imageName) {
        try {
            System.out.println("Requested Image: " + imageName);
            Path imagePath = Paths.get("E:/bike-image").resolve(imageName).normalize();
            System.out.println("Resolved Path: " + imagePath.toAbsolutePath());

            Resource resource = new UrlResource(imagePath.toUri());

            if (!resource.exists() || !resource.isReadable()) {
                System.out.println("Image not found: " + imagePath.toAbsolutePath());
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }

            // Dynamically determine Content-Type
            String contentType = "image/jpeg";
            if (imageName.toLowerCase().endsWith(".png")) {
                contentType = "image/png";
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}
