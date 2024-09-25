package com.urbanmanager.urbanmanager.services;

import com.urbanmanager.urbanmanager.entities.UserManager;

import java.util.List;
import java.util.UUID;

// Esta Interface define los métodos que se pueden realizar sobre un usuario

public interface UserService {

    // Devolver un usuario específico
    UserManager getUser(UUID id);

    // Devolver todos los usuarios
    List<UserManager> getAllUsers();

    // Eliminar un usuario
    void deleteUser(UUID id);

    // Agregar un usuario
    void addUser(UserManager user);

    // Modificar un usuario
    void updateUser(UUID id, UserManager updateUser);

    // Buscar un usuario
    List<UserManager> searchUser(String email, String phone, String address, String firstname, String lastname);
}
