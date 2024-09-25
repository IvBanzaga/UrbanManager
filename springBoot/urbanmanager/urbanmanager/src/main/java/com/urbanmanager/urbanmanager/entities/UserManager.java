package com.urbanmanager.urbanmanager.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.urbanmanager.urbanmanager.enums.UserAuthentication;
import com.urbanmanager.urbanmanager.enums.UserSection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.Data;
import jakarta.persistence.*;
import org.hibernate.annotations.GenericGenerator;

import java.sql.Timestamp;
import java.util.UUID;

@Data

// entity sirve para indicar que la clase es una entidad de la base de datos
@Entity

@Table(name = "user")

public class UserManager {



    // GeneratedValue sirve para indicar que el valor de la clave primaria se generará automáticamente
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @GeneratedValue(generator = "UUID")


    private UUID id;

    private String firstname;
    private String lastname;
    private String second_lastname;
    private String address;
    private String phone;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
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
