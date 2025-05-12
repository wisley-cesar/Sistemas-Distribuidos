package com.example.demo.models.passageiro;

import com.example.demo.models.voo.Voo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record DadosCadastroPassageiro(
        @NotBlank(message = "Nome não pode ser em branco")
        String nome,

        @NotBlank(message = "CPF não pode ser em branco")
        String cpf,

        @NotNull(message = "Voo não pode ser nulo")
        Voo idVoo,

        @NotNull(message = "Status de Check-In não pode ser nulo")
        StatusCheckIn statusCheckIn
) {
}
