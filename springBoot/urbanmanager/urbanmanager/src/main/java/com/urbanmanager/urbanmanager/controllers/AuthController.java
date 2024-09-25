package com.urbanmanager.urbanmanager.controllers;

import com.urbanmanager.urbanmanager.dto.RequestLogin;
import com.urbanmanager.urbanmanager.entities.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.urbanmanager.urbanmanager.services.AuthService;
import com.urbanmanager.urbanmanager.utils.JwtUtil;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins ="*")

public class AuthController {

    @Autowired
    private AuthService service;

    // Este método recibe un objeto y devuelve un token
    @PostMapping("/auth/login")
    public String login(@RequestBody RequestLogin request) {
        String email = request.getEmail();
        String password = request.getPassword();
        UserManager user = service.login(email, password);
        String token = JwtUtil.generateToken(user);
        return token;
    }
}
