package com.example.demo.models.passageiro;

import org.hibernate.validator.constraints.br.CPF;

import com.example.demo.models.voo.Voo;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record DadosCadastroPassageiro(
        @NotBlank(message = "Nome não pode ser em branco")
        String nome,

        @NotBlank(message = "Email não pode ser em branco")
        @Email(message = "Email inválido")
        String email,

        @NotBlank(message = "Senha não pode ser em branco")
        String senha,

        @NotBlank(message = "CPF não pode ser em branco")
        @CPF(message = "CPF inválido")
        String cpf,

        @NotNull(message = "Voo não pode ser nulo")
        Voo idVoo,

        @NotNull(message = "Status de Check-In não pode ser nulo")
        StatusCheckIn statusCheckIn
) {
}
