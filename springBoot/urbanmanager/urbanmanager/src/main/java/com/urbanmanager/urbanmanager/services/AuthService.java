package com.urbanmanager.urbanmanager.services;

import com.urbanmanager.urbanmanager.entities.UserManager;


// Esta Interface define el método de autenticación de un usuario

public interface AuthService {
    UserManager login (String email, String password);
}
