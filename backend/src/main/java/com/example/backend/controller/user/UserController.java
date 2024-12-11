package com.example.backend.controller.user;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.backend.domain.user.User;
import com.example.backend.dto.user.CreateUserRequest;
import com.example.backend.service.UserService;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping()
    public ResponseEntity<User> create(@RequestBody CreateUserRequest request) throws Exception {
        return ResponseEntity.ok(userService.createUser(request));
    }

    @GetMapping()
    public ResponseEntity<List<User>> getUsers() throws Exception {
        return ResponseEntity.ok(userService.getAllUser());
    }

}
