package com.example.demo.models.passageiro;

import com.example.demo.models.voo.Voo;

import jakarta.validation.constraints.NotNull;

public record DadosAtualizacaoPassageiro(
        @NotNull(message = "ID não pode ser nulo")
        String id,
        String nome,
        String cpf,
        Voo idVoo,
        StatusCheckIn statusCheckIn
) {
    
}
