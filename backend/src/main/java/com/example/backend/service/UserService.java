package com.example.backend.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.backend.domain.user.User;
import com.example.backend.dto.user.CreateUserRequest;
import com.example.backend.dto.user.UpdateUserRequest;
import com.example.backend.repository.user.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public List<User> getUsers() throws Exception {
        return userRepository.findAll();
    }

    public User create(CreateUserRequest request) throws Exception {
        User user = User.from(request);
        User userResponse = userRepository.save(user);
        return userResponse;
    }

    @Transactional(rollbackFor = Exception.class)
    public User update(Long id, UpdateUserRequest request) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));

        if (!request.getFirstName().isEmpty()) {
            existingUser.setFirstName(request.getFirstName());
        }
        if (!request.getLastName().isEmpty()) {
            existingUser.setLastName(request.getLastName());
        }
        if (!request.getEmail().isEmpty()) {
            existingUser.setEmail(request.getEmail());
        }
        if (!request.getPhone().isEmpty()) {
            existingUser.setPhone(request.getPhone());
        }
        if (!request.getZipCode().isEmpty()) {
            existingUser.setZipCode(request.getZipCode());
        }

        return userRepository.save(existingUser);
    }

    @Transactional(rollbackFor = Exception.class)
    public Boolean delete(Long id) throws Exception {
        userRepository.deleteById(id);
        return true;
    }

    public User getDetail(Long id) throws Exception {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
    }
}
