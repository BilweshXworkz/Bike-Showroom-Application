package com.xworkz.showroomapp.repository;

import com.xworkz.showroomapp.entity.CustomerRegistrationEntity;
import com.xworkz.showroomapp.entity.UserRegistrationEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Repository
public class CustomerRegistrationRepositoryImpl implements CustomerRegistrationRepository{

    @PersistenceContext
    EntityManager entityManager;

    @Transactional
    @Override
    public Boolean save(UserRegistrationEntity entity) {
        try {
            entityManager.persist(entity);
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // Shows exact DB error
            throw new RuntimeException("Failed to save entity", e); // Let Spring roll back
        }
    }

    @Transactional
    @Override
    public List<UserRegistrationEntity> findAll() {
        try {
            return entityManager.createQuery("SELECT u FROM UserRegistrationEntity u", UserRegistrationEntity.class)
                    .getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Transactional
    @Override
    public UserRegistrationEntity fetchEmail(String emailId) {
        if (emailId == null || emailId.trim().isEmpty()) {
            System.out.println("Invalid emailId provided.");
            return null;
        }
        try {
            return entityManager.createQuery("SELECT u FROM UserRegistrationEntity u WHERE u.emailId = :emailId", UserRegistrationEntity.class)
                    .setParameter("emailId", emailId.trim().toLowerCase())
                    .getSingleResult();
        } catch (NoResultException e) {
            System.out.println("No user found with email: " + emailId);
            return null;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }


    @Transactional
    @Override
    public void updateFailedAttemps(String emailId) {
        try {
            UserRegistrationEntity user = fetchEmail(emailId);
            if (user != null) {
                user = entityManager.merge(user);
                user.setFailedAttempts(user.getFailedAttempts() + 1);
                if (user.getFailedAttempts() >= 3) {
                    user.setAccountLockedUntil(LocalDateTime.now().plusHours(1));
                }
            } else {
                System.out.println("User not found for failed attempt update.");
            }
        } catch (Exception e) {
            System.out.println("Error updating failed attempts: " + e.getMessage());
            throw new RuntimeException(e); // Rethrow to allow rollback
        }
    }

    @Transactional
    @Override
    public void resetFailedAttempts(UserRegistrationEntity user) {
        try {
            user = entityManager.merge(user);
            user.setFailedAttempts(0);
            user.setAccountLockedUntil(null);
        } catch (Exception e) {
            System.out.println("Error resetting failed attempts: " + e.getMessage());
            // No manual rollback needed
        }
    }

    @Transactional
    @Override
    public void passwordUpdate(String emailId, String newPassword) {
        try {
            UserRegistrationEntity user = fetchEmail(emailId);

            if (user != null) {
                if (user.getFailedAttempts() != null && user.getFailedAttempts() == -1) {
                    user.setFailedAttempts(0);
                }

                user.setPassword(newPassword); // Assuming there's a setPassword method
                entityManager.merge(user);
            } else {
                System.out.println("User not found with email: " + emailId);
            }
        } catch (Exception e) {
            System.out.println("Error updating password and attempts: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    @Transactional
    @Override
    public Optional<UserRegistrationEntity> findByEmail(String emailId) {
        String query = "SELECT u FROM UserRegistrationEntity u WHERE u.emailId = :emailId";
        try {
            UserRegistrationEntity user = entityManager.createQuery(query, UserRegistrationEntity.class)
                    .setParameter("emailId", emailId)
                    .getSingleResult();
            return Optional.of(user);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Transactional
    @Override
    public void update(UserRegistrationEntity user) {
        entityManager.merge(user);
    }
}
