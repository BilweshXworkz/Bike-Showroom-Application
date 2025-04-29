package com.xworkz.showroomapp.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "add_bike_to_showroom")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class AddBikeToShowroomEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "showroom_id", nullable = false)
    private AddShowroomEntity showroom;

    @ManyToOne
    @JoinColumn(name = "bike_id", nullable = false)
    private AddBikeEntity bike;
}
