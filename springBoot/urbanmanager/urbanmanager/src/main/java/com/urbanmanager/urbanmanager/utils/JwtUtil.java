package com.urbanmanager.urbanmanager.utils;

import com.urbanmanager.urbanmanager.entities.UserManager;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.util.Date;

public class JwtUtil {
    private static final String SECRET_KEY = "UrbanManager";
    private static final Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);

    public static String generateToken (UserManager user) {

        String token = JWT.create()
                .withIssuer("UrbanManager")
                .withExpiresAt(getExpiresDate())
                .withClaim("uderId", user.getId().toString())
                .withIssuedAt(new Date())
                .withExpiresAt(getExpiresDate())
                .sign(algorithm);

        return token;
    }

    private static Date getExpiresDate() {
        return new Date(System.currentTimeMillis() + (1000L * 60 * 60 * 24));
    }

    public static String getUserByToken (String token) {
        JWTVerifier verifier = JWT.require(algorithm)
                .withIssuer("UrbanManager")
                .build();

        // Verificando el Token
        DecodedJWT decoded = verifier.verify(token);
        String userId = decoded.getClaim("userId").toString();
        return userId;
    }
}