package com.urbanmanager.urbanmanager.services;

import com.google.common.hash.Hashing;
import com.urbanmanager.urbanmanager.entities.UserManager;
import com.urbanmanager.urbanmanager.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserServiceImp implements UserService {

    private static final String SECRET_KEY = "UrbanManager";

    @Autowired
    private UserRepository userRepository;

    private final RestTemplate restTemplate = new RestTemplate();

    // Obtener datos remotos
    public String getRemoteData(String url) {
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        return response.getBody();
    }

    // Devolver un usuario específico
    public UserManager getUser(UUID id) {
        Optional<UserManager> user = userRepository.findById(id);
        return user.orElse(null);
    }

    // Devolver todos los usuario
    public List<UserManager> getAllUsers() {
        List<UserManager> list = new ArrayList<>();
        Iterable<UserManager> users = userRepository.findAll();
        for (UserManager user : users) {
            list.add(user);
        }
        return list;
    }

    // Eliminar usuario
    public void deleteUser(UUID id) {
        userRepository.deleteById(id);
    }

    // Agregar usuario
    public void addUser(UserManager user) {
        String originalString = user.getPassword() + SECRET_KEY;
        String sha256hex = Hashing.sha256()
                .hashString(originalString, StandardCharsets.UTF_8)
                .toString();
        user.setPassword(sha256hex);
        userRepository.save(user);
    }

    // Modificar usuario
    public void updateUser(UUID id, UserManager updateUser) {
        UserManager user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setEmail(updateUser.getEmail());
            user.setFirstname(updateUser.getFirstname());
            user.setLastname(updateUser.getLastname());
            user.setPhone(updateUser.getPhone());
            user.setAddress(updateUser.getAddress());
            if (updateUser.getPassword() != null && !updateUser.getPassword().isEmpty()) {
                String originalString = updateUser.getPassword() + SECRET_KEY;
                String sha256hex = Hashing.sha256()
                        .hashString(originalString, StandardCharsets.UTF_8)
                        .toString();
                user.setPassword(sha256hex);
            }
            userRepository.save(user);
        }
    }

    // Buscar usuario
    public List<UserManager> searchUser(String email, String phone, String address, String firstname, String lastname) {
        return userRepository.findByEmailContainingOrPhoneContainingOrAddressContainingOrFirstnameContainingOrLastnameContaining(
                email, phone, address, firstname, lastname);
    }
}