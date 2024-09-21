package com.urbanmanager.urbanmanager.controllers;

import com.urbanmanager.urbanmanager.services.UserServiceImp;
import com.urbanmanager.urbanmanager.models.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequestMapping("/api")
@RestController

// CrossOrigin sirve para permitir que los recursos de una página web se puedan cargar desde otro dominio
@CrossOrigin(origins = "*", methods= {RequestMethod.GET,RequestMethod.POST,RequestMethod.PUT,RequestMethod.DELETE})

public class UserController {
    @Autowired

    private UserServiceImp userService;

    // Traer uno específico
    @GetMapping("/user/{id}")
    public UserManager getUser(@PathVariable UUID id) {
        return userService.getUser(id);
    }

    // Traer todos
    @GetMapping("/user")
    public List<UserManager> getAllUsers(String token) {
        return userService.getAllUsers();
    }

    // Eliminar
    @DeleteMapping("/user/{id}")
    public void deleteUser(@PathVariable UUID id) {
        userService.deleteUser(id);
    }

    // Agregar
    @PostMapping("/user")
    public void addUser(@RequestBody UserManager user) {
        userService.addUser(user);
    }

    // Modificar
    @PutMapping("/user/{id}")
    public void updateUser(@PathVariable UUID id, @RequestBody UserManager updateUser) {
        userService.updateUser(id, updateUser);
    }

    // Buscar
    @GetMapping("/user/search")
    public List<UserManager> searchUser(@RequestParam(name = "email", required = false) String email,
                                        @RequestParam(name = "phone", required = false) String phone,
                                        @RequestParam(name = "address", required = false) String address,
                                        @RequestParam(name = "firstname", required = false) String firstname,
                                        @RequestParam(name = "lastname", required = false) String lastname) {
        return userService.searchUser(email, phone, address, firstname, lastname);
    }
}
