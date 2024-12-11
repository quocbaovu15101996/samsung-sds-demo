package com.example.backend.repository.user;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.backend.domain.user.User;

public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findAll();
}
