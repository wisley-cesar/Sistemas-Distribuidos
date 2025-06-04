package com.example.demo.models.funcionario;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record DadosCadastroFuncionario(
    @NotBlank(message = "Nome é obrigatório")
    String nome,
    
    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email inválido")
    String email,
    
    @NotBlank(message = "Senha é obrigatória")
    String senha,
    
    @NotBlank(message = "Cargo é obrigatório")
    String cargo
) {} 