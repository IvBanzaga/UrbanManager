package com.urbanmanager.urbanmanager.services;

import com.urbanmanager.urbanmanager.models.UserManager;

import java.util.List;
import java.util.UUID;

public interface UserService {

    // Devolver un cliente específico
    UserManager getUser(UUID id);

    // Devolver todos los clientes
    List<UserManager> getAllUsers();

    // Eliminar Cliente
    void deleteUser(UUID id);

    // Agregar Cliente
    void addUser(UserManager user);

    // Modificar Cliente
    void updateUser(UUID id, UserManager updateUser);

    // Buscar Cliente
    List<UserManager> searchUser(String email, String phone, String address, String firstname, String lastname);
}
