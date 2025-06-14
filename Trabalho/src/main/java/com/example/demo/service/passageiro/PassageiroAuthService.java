package com.example.demo.service.passageiro;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.models.passageiro.DadosLoginPassageiro;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.RespostaLoginPassageiro;
import com.example.demo.repository.PassageiroRepository;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;

import java.security.Key;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class PassageiroAuthService {

    private final PassageiroRepository passageiroRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${jwt.expiration}")
    private Long expiration;

    private final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS512);

    public RespostaLoginPassageiro login(DadosLoginPassageiro dados) {
        Passageiro passageiro = passageiroRepository.findByEmail(dados.email())
            .orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));

        if (!passwordEncoder.matches(dados.senha(), passageiro.getSenha())) {
            throw new RuntimeException("Senha incorreta");
        }

        String token = generateToken(passageiro);

        return new RespostaLoginPassageiro(
            token,
            passageiro.getId(),
            passageiro.getNome(),
            passageiro.getCpf(),
            passageiro.getIdVoo() != null ? passageiro.getIdVoo().getId() : null,
            passageiro.getStatusCheckIn()
        );
    }

    private String generateToken(Passageiro passageiro) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + expiration);

        return Jwts.builder()
                .setSubject(passageiro.getId())
                .claim("id", passageiro.getId())
                .claim("email", passageiro.getEmail())
                .claim("tipo", "PASSAGEIRO")
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String getPassageiroIdFromToken(String token) {
        return Jwts.parserBuilder()
            .setSigningKey(key)
            .build()
            .parseClaimsJws(token)
            .getBody()
            .get("id", String.class);
    }
} 