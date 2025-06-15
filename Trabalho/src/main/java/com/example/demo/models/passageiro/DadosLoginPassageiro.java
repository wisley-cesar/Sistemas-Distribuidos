package com.example.demo.models.passageiro;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record DadosLoginPassageiro(
    @NotBlank(message = "Email não pode ser em branco")
    @Email(message = "Email inválido")
    String email,

    @NotBlank(message = "Senha não pode ser em branco")
    String senha
) {} 