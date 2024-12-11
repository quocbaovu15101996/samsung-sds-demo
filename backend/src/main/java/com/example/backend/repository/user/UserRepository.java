package com.example.backend.repository.user;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.backend.domain.user.User;

public interface UserRepository extends JpaRepository<User, Long> {
}
