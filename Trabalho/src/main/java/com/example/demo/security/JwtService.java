package com.example.demo.security;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.models.funcionario.Funcionario;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class JwtService {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private Long expiration;

    public String generateToken(Funcionario funcionario) {
        log.info("Gerando token para funcionário: {} com cargo: {}", funcionario.getEmail(), funcionario.getCargo());
        Map<String, Object> claims = new HashMap<>();
        claims.put("cargo", funcionario.getCargo());
        claims.put("nome", funcionario.getNome());
        claims.put("email", funcionario.getEmail());
        
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(funcionario.getEmail())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    private SecretKey getSigningKey() {
        byte[] keyBytes = secret.getBytes();
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // ... existing code ...
} 