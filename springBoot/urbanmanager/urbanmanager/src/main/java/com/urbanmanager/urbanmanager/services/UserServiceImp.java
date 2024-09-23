package com.urbanmanager.urbanmanager.services;

import com.urbanmanager.urbanmanager.entities.UserManager;
import com.urbanmanager.urbanmanager.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserServiceImp implements UserService {

    @Autowired
    private UserRepository userRepository;

    private final RestTemplate restTemplate = new RestTemplate();

    // Obtener datos remotos
    public String getRemoteData(String url) {
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        return response.getBody();
    }

    // Devolver un cliente específico
    public UserManager getUser(UUID id) {
        Optional<UserManager> user = userRepository.findById(id);
        return user.orElse(null);
    }

    // Devolver todos los clientes
    public List<UserManager> getAllUsers() {
        List<UserManager> list = new ArrayList<>();
        Iterable<UserManager> users = userRepository.findAll();
        for (UserManager user : users) {
            list.add(user);
        }
        return list;
    }

    // Eliminar Cliente
    public void deleteUser(UUID id) {
        userRepository.deleteById(id);
    }

    // Agregar Cliente
    public void addUser(UserManager user) {
        userRepository.save(user);
    }

    // Modificar Cliente
    public void updateUser(UUID id, UserManager updateUser) {
        updateUser.setId(id);
        userRepository.save(updateUser);
    }

    // Buscar Cliente
    public List<UserManager> searchUser(String email, String phone, String address, String firstname, String lastname) {
        return userRepository.findByEmailContainingOrPhoneContainingOrAddressContainingOrFirstnameContainingOrLastnameContaining(
                email, phone, address, firstname, lastname);
    }
}

