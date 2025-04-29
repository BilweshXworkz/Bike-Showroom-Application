package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.dto.AddBikeToShowroomDto;
import com.xworkz.showroomapp.entity.AddBikeEntity;
import com.xworkz.showroomapp.entity.AddBikeToShowroomEntity;
import com.xworkz.showroomapp.entity.AddShowroomEntity;
import com.xworkz.showroomapp.entity.AdminEntity;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Repository
public class AdminRepositoryImpl implements AdminRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Optional<AdminEntity> findByEmail(String email) {
        try {
            AdminEntity admin = entityManager.createQuery(
                            "SELECT a FROM AdminEntity a WHERE a.adminEmail = :email", AdminEntity.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(admin);
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    @Transactional
    @Override
    public void updateOtp(String email, String otp, LocalDateTime currentTime) {
        try {
            entityManager.createQuery(
                            "UPDATE AdminEntity a SET a.adminOtp = :otp, a.otpGeneratedTime = :currentTime WHERE a.adminEmail = :email")
                    .setParameter("otp", otp)
                    .setParameter("currentTime", currentTime)
                    .setParameter("email", email)
                    .executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Transactional
    @Override
    public Boolean AddShowroom(AddShowroomEntity entity) {
        try {
            entityManager.persist(entity);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    @Override
    public AddShowroomEntity findByShowroomName(String showroomName) {
        try {
            List<AddShowroomEntity> showrooms = entityManager.createQuery(
                            "SELECT s FROM AddShowroomEntity s WHERE s.showroomName = :name", AddShowroomEntity.class)
                    .setParameter("name", showroomName)
                    .getResultList();

            if (!showrooms.isEmpty()) {
                return showrooms.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Transactional
    @Override
    public AddBikeEntity findByModelName(String modelName) {
        try {
            List<AddBikeEntity> bikes = entityManager.createQuery(
                            "SELECT b FROM AddBikeEntity b WHERE b.modelName = :modelName", AddBikeEntity.class)
                    .setParameter("modelName", modelName)
                    .getResultList();

            if (!bikes.isEmpty()) {
                return bikes.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Transactional
    @Override
    public int countByShowroomShowroomName(String showroomName) {
        try {
            Long count = entityManager.createQuery(
                            "SELECT COUNT(b) FROM AddBikeToShowroomEntity b WHERE b.showroom.showroomName = :name", Long.class)
                    .setParameter("name", showroomName)
                    .getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Transactional
    @Override
    public boolean existsByShowroomShowroomIdAndBikeBikeId(String showroomName, String modelName) {
        try {
            Long count = entityManager.createQuery(
                            "SELECT COUNT(b) FROM AddBikeToShowroomEntity b " +
                                    "WHERE b.showroom.showroomName = :name " +
                                    "AND b.bike.modelName = :modelName", Long.class)
                    .setParameter("name", showroomName)
                    .setParameter("modelName", modelName)
                    .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    @Override
    public void addBikeToShowroom(AddBikeToShowroomEntity entity) {
        try {
            entityManager.persist(entity);
            System.out.println("Bike added to showroom successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Transactional
    @Override
    public boolean existsByLocation(String location) {
        try {
            Long count = entityManager.createQuery(
                            "SELECT COUNT(s) FROM AddShowroomEntity s WHERE s.location = :location", Long.class)
                    .setParameter("location", location)
                    .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Transactional
    @Override
    public List<String> getShowroom() {
        try {
            return entityManager.createQuery(
                            "SELECT s.showroomName FROM AddShowroomEntity s", String.class)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    @Override
    public List<AddShowroomEntity> getShowrooms() {
        return entityManager.createQuery(
                        "SELECT s FROM AddShowroomEntity s", AddShowroomEntity.class)
                .getResultList();
    }

    @Override
    public List<AddBikeEntity> getBikes() {
        return entityManager.createQuery(
                "SELECT DISTINCT b FROM AddBikeEntity b LEFT JOIN FETCH b.bikeColours ", AddBikeEntity.class)
                .getResultList();
    }

    @Override
    public List<AddBikeEntity> findBikesByShowroomName(String showroomName) {
        return entityManager.createQuery(
                        "SELECT b.bike FROM AddBikeToShowroomEntity b WHERE b.showroom.showroomName = :showroomName", AddBikeEntity.class)
                .setParameter("showroomName", showroomName)
                .getResultList();
    }

    @Transactional
    @Override
    public boolean deleteBikeFromShowroom(String showroomName, String bikeModel) {
        try {
            AddBikeToShowroomEntity mapping = entityManager.createQuery(
                            "SELECT ab FROM AddBikeToShowroomEntity ab " +
                                    "WHERE ab.showroom.showroomName = :showroomName " +
                                    "AND ab.bike.modelName = :bikeModel", AddBikeToShowroomEntity.class)
                    .setParameter("showroomName", showroomName)
                    .setParameter("bikeModel", bikeModel)
                    .getSingleResult();

            mapping = entityManager.merge(mapping);
            entityManager.remove(mapping);
            return true;
        } catch (NoResultException e) {
            System.out.println("No matching mapping found for showroom: " + showroomName + " and model: " + bikeModel);
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public AddBikeEntity fetchBike(String modelName) {
        if (modelName == null || modelName.trim().isEmpty()) {
            System.out.println("Invalid emailId provided.");
            return null;
        }
        try {
            return entityManager.createQuery("SELECT b FROM AddBikeEntity b WHERE b.modelName = :modelName", AddBikeEntity.class)
                    .setParameter("modelName", modelName)
                    .getSingleResult();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<String> getBikeByShowroom() {
        try {
            return entityManager.createQuery(
                            "SELECT b.modelName FROM AddBikeEntity b WHERE b.showroom.name = :name", String.class)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<String> getBike() {
        try {
            return entityManager.createQuery(
                    "SELECT b.modelName FROM AddBikeEntity b", String.class)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    @Override
    public List<AddBikeToShowroomDto> findAllMappings() {
        List<AddBikeToShowroomEntity> entities = entityManager.createQuery(
                "FROM AddBikeToShowroomEntity", AddBikeToShowroomEntity.class).getResultList();

        List<AddBikeToShowroomDto> dtos = new ArrayList<>();
        for (AddBikeToShowroomEntity entity : entities) {
            AddBikeToShowroomDto dto = new AddBikeToShowroomDto();
            dto.setShowroomName(entity.getShowroom().getShowroomName());
            dto.setModelName(entity.getBike().getModelName());
            dtos.add(dto);
            System.out.println(dto);
        }
        return dtos;
    }


    @Override
    public List<String> getBikeByShowroomName(String showroomName) {
        List<String> bikes = entityManager.createQuery(
                        "SELECT ab.bike.modelName FROM AddBikeToShowroomEntity ab " +
                                "WHERE ab.showroom.showroomName = :name", String.class)
                .setParameter("name", showroomName)
                .getResultList();

        System.out.println("Fetched models for showroom '" + showroomName + "': " + bikes);

        return bikes;
    }

    @Override
    public boolean existsByBikeBikeId(Integer bikeId) {
        String jpql = "SELECT COUNT(abts) FROM AddBikeToShowroomEntity abts WHERE abts.bike.bikeId = :bikeId";
        Long count = entityManager.createQuery(jpql, Long.class)
                .setParameter("bikeId", bikeId)
                .getSingleResult();
        return count > 0;
    }


    @Transactional
    @Override
    public Boolean AddBike(AddBikeEntity entity) {
        try {
            entityManager.persist(entity);
            entityManager.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
