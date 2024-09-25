package com.urbanmanager.urbanmanager.dto;

import lombok.Data;

@Data

// Esta clase se encarga de recibir los datos de la petición de login

public class RequestLogin {
    private String email;
    private String password;
}
