package com.example.demo.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.models.funcionario.Funcionario;
import com.example.demo.service.funcionario.FuncionarioService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@RequiredArgsConstructor
public class AdminInterceptor implements HandlerInterceptor {

    private final FuncionarioService funcionarioService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        RequireAdmin requireAdmin = handlerMethod.getMethodAnnotation(RequireAdmin.class);
        
        if (requireAdmin == null) {
            requireAdmin = handlerMethod.getBeanType().getAnnotation(RequireAdmin.class);
        }

        if (requireAdmin != null) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                log.error("Usuário não autenticado tentando acessar rota admin");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuário não autenticado");
                return false;
            }

            Funcionario funcionario = (Funcionario) authentication.getPrincipal();
            String cargo = funcionario.getCargo().toUpperCase();
            log.info("Verificando cargo do usuário: {} para a rota: {}", cargo, request.getRequestURI());
            
            if (!"ADMIN".equals(cargo)) {
                log.error("Usuário não admin tentando acessar rota admin: {} (cargo: {})", funcionario.getEmail(), cargo);
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acesso negado: requer privilégios de administrador");
                return false;
            }
            
            log.info("Acesso admin permitido para: {}", funcionario.getEmail());
        }

        return true;
    }
} 