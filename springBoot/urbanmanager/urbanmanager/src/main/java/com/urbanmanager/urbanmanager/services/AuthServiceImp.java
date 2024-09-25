package com.urbanmanager.urbanmanager.services;


import com.google.common.hash.Hashing;
import com.urbanmanager.urbanmanager.entities.UserManager;
import com.urbanmanager.urbanmanager.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.List;

@Service

// Esta clase implementa el método de autenticación de un usuario

public class AuthServiceImp implements AuthService{

    private static final String SECRET_KEY = "UrbanManager";

    @Autowired
    private UserRepository userRepository;

    @Override

    // Este método recibe un email y una contraseña, la encripta y busca en la base de datos si existe un usuario con esos datos

    public UserManager login(String email, String password) {
        String originalString = password + SECRET_KEY;
        String sha256hex = Hashing.sha256()
                .hashString(originalString, StandardCharsets.UTF_8)
                .toString();

        List<UserManager> result = userRepository.findByEmailAndPassword(email, sha256hex);
        if (result.isEmpty()){
            return null;
        } else {
            return result.get(0);
        }
    }
}
