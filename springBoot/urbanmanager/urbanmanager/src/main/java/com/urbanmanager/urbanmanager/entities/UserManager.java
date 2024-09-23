package com.urbanmanager.urbanmanager.entities;

import com.urbanmanager.urbanmanager.enums.UserAuthentication;
import com.urbanmanager.urbanmanager.enums.UserSection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.Data;
import jakarta.persistence.*;

import java.sql.Timestamp;
import java.util.UUID;

@Data

// entity sirve para indicar que la clase es una entidad de la base de datos
@Entity

@Table(name = "user")

public class UserManager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private UUID id;

    private String firstname;
    private String lastname;
    private String second_lastname;
    private String address;
    private String phone;
    private String password;

    @Enumerated(EnumType.STRING)
    private UserAuthentication authentication;

    private String email;
    private boolean confidentiality;

    @Enumerated(EnumType.STRING)
    private UserSection section;

    private UUID role_id;
    private UUID city_id;
    private UUID postcode_id;
    private UUID country_id;
    private Timestamp date_created;
    private Timestamp date_deleted;
    private String dni;
}
