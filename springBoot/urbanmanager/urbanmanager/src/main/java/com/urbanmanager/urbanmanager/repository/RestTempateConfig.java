package com.urbanmanager.urbanmanager.repository;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration

// Esta clase es para configurar el RestTemplate, que es una clase que nos permite hacer peticiones HTTP a un servidor
// externo. En este caso, se usa para hacer peticiones a la API de OpenWeatherMap.

public class RestTempateConfig {
    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder){
        return builder.build();
    }
}

