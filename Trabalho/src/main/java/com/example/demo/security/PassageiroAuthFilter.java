package com.example.demo.security;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.repository.PassageiroRepository;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PassageiroAuthFilter extends OncePerRequestFilter {

    private final PassageiroRepository passageiroRepository;

    public PassageiroAuthFilter(PassageiroRepository passageiroRepository) {
        this.passageiroRepository = passageiroRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        String token = getTokenFromRequest(request);
        
        if (token != null) {
            try {
                String passageiroId = getPassageiroIdFromToken(token);
                Passageiro passageiro = passageiroRepository.findById(passageiroId).orElse(null);
                
                if (passageiro != null) {
                    UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                        passageiro, null, null);
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            } catch (Exception e) {
                // Token inválido, continua sem autenticação
            }
        }
        
        filterChain.doFilter(request, response);
    }

    private String getTokenFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }

    private String getPassageiroIdFromToken(String token) {
        // Implementação simplificada - em produção, use uma biblioteca JWT adequada
        // Aqui estamos apenas extraindo o ID do token de forma básica
        return token.split("\\.")[1]; // Não use isso em produção!
    }
} 