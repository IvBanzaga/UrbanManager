package com.urbanmanager.urbanmanager.repository;

import com.urbanmanager.urbanmanager.entities.UserManager;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;



@Repository

// Se utiliza para la creación de consultas personalizadas en la base de datos de la aplicación web
public interface UserRepository extends CrudRepository<UserManager, UUID> {

    // Este método busca usuarios cuyo email, teléfono, dirección, nombre o apellido contengan las cadenas proporcionadas.
    List<UserManager> findByEmailContainingOrPhoneContainingOrAddressContainingOrFirstnameContainingOrLastnameContaining(
            String email, String phone, String address, String firstname, String lastname);

    // Este método utiliza una consulta JPQL personalizada para buscar usuarios por email y contraseña.
    @Query("select u from UserManager u where u.email = :email and u.password = :password")
    List<UserManager> findByEmailAndPassword(String email, String password);
}