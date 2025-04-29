package com.xworkz.showroomapp.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity

@Table(name = "bike_table" )

public class AddBikeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "bike_id")
    private Integer bikeId;

    @Column(name = "model_name")
    private String modelName;

    @Column(name = "engine")
    private String engine;

    @Column(name = "price")
    private String price;

    @Column(name = "torque")
    private String torque;

    @Column(name = "brakes")
    private String brakes;

    @Column(name = "power")
    private String power;

    @Column(name = "mileage")
    private String mileage;

    @Column(name = "tyre_type")
    private String tyreType;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "bike_colours", joinColumns = @JoinColumn(name = "bike_id"))
    @Column(name = "colour")
    private List<String> bikeColours = new ArrayList<>();


    @Column(name = "front_image")
    private String frontImage;

    @Column(name = "back_image")
    private String backImage;

    @Column(name = "right_image")
    private String rightImage;

    @Column(name = "left_image")
    private String leftImage;

}
