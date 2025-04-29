package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.entity.AdminEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Repository
public class UserRegistrationRepositoryImpl implements UserRegistrationRepository{

    @PersistenceContext
    EntityManager entityManager;

    @Transactional
    @Override
    public void registerUser(UserRegistrationEntity entity) {
        try{
            entityManager.persist(entity);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @Transactional
    @Override
    public boolean nameExists(String fullName) {
        return entityManager.createQuery("SELECT COUNT(u) FROM UserRegistrationEntity u WHERE u.fullName = :fullName", Long.class)
                .setParameter("fullName", fullName)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public boolean phoneNumberExists(Long contact) {
        return entityManager.createQuery("SELECT COUNT(u) FROM AddShowroomEntity  u WHERE u.contact = :contact", Long.class)
                .setParameter("contact",contact)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public boolean emailExists(String emailId) {
        return entityManager.createQuery("SELECT COUNT(u) FROM UserRegistrationEntity u WHERE u.emailId = :emailId", Long.class)
                .setParameter("emailId",emailId)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public boolean modelExists(String modelName) {
        return entityManager.createQuery("SELECT COUNT(u) FROM AddBikeEntity u WHERE u.modelName = :modelName", Long.class)
                .setParameter("modelName",modelName)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public boolean ShowroomNameExists(String showroomName) {
        return entityManager.createQuery("SELECT COUNT(u) FROM AddShowroomEntity u WHERE u.showroomName = :showroomName", Long.class)
                .setParameter("showroomName",showroomName)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public boolean emailIdExists(String email) {
        return entityManager.createQuery("SELECT COUNT(u) FROM AddShowroomEntity u WHERE u.email = :email", Long.class)
                .setParameter("email",email)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public List<UserRegistrationEntity> fetchAllUser() {
        return entityManager.createQuery("FROM UserRegistrationEntity", UserRegistrationEntity.class)
                .getResultList();
    }

    @Transactional
    @Override
    public UserRegistrationEntity findById(Integer id) {
        return entityManager.createQuery("SELECT u FROM UserRegistrationEntity u WHERE u.id = :id",UserRegistrationEntity.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    @Transactional
    @Override
    public void update(Integer id, String reason, String dateTime) {
        UserRegistrationEntity user = entityManager.find(UserRegistrationEntity.class, id);
        if (user != null) {
            String currentReason = user.getReason();
            String updatedReason = (currentReason == null || currentReason.isEmpty())
                    ? reason
                    : currentReason + ", " + reason;
            user.setReason(updatedReason);
            user.setDateTime(dateTime);
        }
    }

    @Transactional
    @Override
    public List<UserRegistrationEntity> findByScheduleTask(int i) {
         return entityManager.createQuery("SELECT u FROM UserRegistrationEntity u WHERE u.scheduleTask = :scheduleTask", UserRegistrationEntity.class)
                .setParameter("scheduleTask", String.valueOf(i))  // convert int to String
                .getResultList();

    }

    @Transactional
    @Override
    public boolean locationExists(String location) {
        return entityManager.createQuery("SELECT COUNT(u) FROM AddShowroomEntity u WHERE u.location = :location", Long.class)
                .setParameter("location",location)
                .getSingleResult() > 0;
    }

    @Transactional
    @Override
    public UserRegistrationEntity fetchEmail(String emailId) {
        if (emailId == null || emailId.trim().isEmpty()) {
            System.out.println("Invalid emailId provided.");
            return null;
        }
        try {
            return entityManager.createNamedQuery("fetchByEmail", UserRegistrationEntity.class)
                    .setParameter("emailId", emailId.trim().toLowerCase())
                    .getSingleResult();
        } catch (NoResultException e) {
            System.out.println("No user found with email: " + emailId);
            return null;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }
    @Transactional
    @Override
    public UserRegistrationEntity findByEmailId(String emailId) {
        try {
            return entityManager.createQuery("SELECT u FROM UserRegistrationEntity u WHERE u.emailId = :emailId", UserRegistrationEntity.class)
                    .setParameter("emailId", emailId)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Transactional
    @Override
    public void updateUser(UserRegistrationEntity entity) {
        entityManager.merge(entity);
    }

    @Transactional
    @Override
    public Optional<UserRegistrationEntity> findByEmail(String email) {
        try {
            UserRegistrationEntity admin = entityManager.createQuery("SELECT a FROM UserRegistrationEntity a WHERE a.emailId = :email", UserRegistrationEntity.class)
                    .setParameter("emailId", email)
                    .getSingleResult();
            return Optional.of(admin);
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    @Transactional
    @Override
    public void updateOtp(String email, String otp) {
        try {
            entityManager.createQuery("UPDATE UserRegistrationEntity a SET a.password = :otp WHERE a.emailId = :email", UserRegistrationEntity.class)
                    .setParameter("otp", otp)
                    .setParameter("email", email)
                    .executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Transactional
    @Override
    public void save(UserRegistrationEntity userRegistrationEntity) {
        entityManager.merge(userRegistrationEntity);
    }
}
