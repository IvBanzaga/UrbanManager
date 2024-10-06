package com.urbanmanager.urbanmanager.controllers;

import com.urbanmanager.urbanmanager.services.UserServiceImp;
import com.urbanmanager.urbanmanager.entities.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

@RequestMapping("/api")
@RestController

// CrossOrigin sirve para permitir que los recursos de una página web se puedan cargar desde otro dominio
//@CrossOrigin(origins = "*", methods= {RequestMethod.GET,RequestMethod.POST,RequestMethod.PUT,RequestMethod.DELETE})
@CrossOrigin (value= "http://localhost:5173")
public class UserController {
    @Autowired

    private UserServiceImp userService;
    private static final Logger logger = Logger.getLogger(UserController.class.getName());
    // Trae un usuario por id
    @GetMapping("/user/{id}")
    public UserManager getUser(@PathVariable UUID id) {
        return userService.getUser(id);
    }

    // Traer todos los usuarios
    @GetMapping("/user")
    public List<UserManager> getAllUsers(String token) {
        return userService.getAllUsers();
    }

    // Eliminar usuario
    @DeleteMapping("/user/{id}")
    public void deleteUser(@PathVariable UUID id) {
        userService.deleteUser(id);
    }

    // Agregar usuario
    @PostMapping("/user")
    public void addUser(@RequestBody UserManager user) {
        userService.addUser(user);
    }

    // Modificar usuario
    @PutMapping("/user/{id}")
    public void updateUser(@PathVariable UUID id, @RequestBody UserManager updateUser) {
        userService.updateUser(id, updateUser);
    }

    // Buscar usuario
    @GetMapping("/user/search")
    public List<UserManager> searchUser(@RequestParam(name = "email", required = false) String email,
                                        @RequestParam(name = "phone", required = false) String phone,
                                        @RequestParam(name = "address", required = false) String address,
                                        @RequestParam(name = "firstname", required = false) String firstname,
                                        @RequestParam(name = "lastname", required = false) String lastname) {
        return userService.searchUser(email, phone, address, firstname, lastname);
    }
}
