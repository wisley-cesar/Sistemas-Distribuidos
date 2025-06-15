package com.example.demo.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.repository.PassageiroRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@RequiredArgsConstructor
public class PassageiroAuthInterceptor implements HandlerInterceptor {

    private final PassageiroRepository passageiroRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        RequirePassageiroAuth requirePassageiroAuth = handlerMethod.getMethodAnnotation(RequirePassageiroAuth.class);
        
        if (requirePassageiroAuth == null) {
            requirePassageiroAuth = handlerMethod.getBeanType().getAnnotation(RequirePassageiroAuth.class);
        }

        if (requirePassageiroAuth != null) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                log.error("Passageiro não autenticado tentando acessar rota protegida");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Passageiro não autenticado");
                return false;
            }

            Passageiro passageiro = (Passageiro) authentication.getPrincipal();
            if (!passageiro.isAtivo()) {
                log.error("Passageiro inativo tentando acessar rota protegida: {}", passageiro.getEmail());
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Conta de passageiro inativa");
                return false;
            }
            
            log.info("Acesso de passageiro permitido para: {}", passageiro.getEmail());
        }

        return true;
    }
} 