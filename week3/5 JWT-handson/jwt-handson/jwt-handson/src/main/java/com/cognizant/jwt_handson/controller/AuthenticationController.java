package com.cognizant.jwt_handson.controller;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
public class AuthenticationController {

    @GetMapping("/authenticate")
    public Map<String, String> authenticate(
            @RequestHeader("Authorization") String authHeader) {

        String user = getUser(authHeader);

        Map<String, String> map = new HashMap<>();
        map.put("token", generateJwt(user));

        return map;
    }

    private String getUser(String authHeader) {

        String encoded = authHeader.substring("Basic ".length());

        byte[] decodedBytes = Base64.getDecoder().decode(encoded);

        String decoded = new String(decodedBytes, StandardCharsets.UTF_8);

        return decoded.split(":")[0];
    }

    private String generateJwt(String user) {

        String secret = "abcdefghijklmnopqrstuvwxyz123456";

        return Jwts.builder()
                .setSubject(user)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1200000))
                .signWith(
                        SignatureAlgorithm.HS256,
                        secret.getBytes(StandardCharsets.UTF_8)
                )
                .compact();
    }
}