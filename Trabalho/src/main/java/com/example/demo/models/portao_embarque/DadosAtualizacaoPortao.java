package com.example.demo.models.portao_embarque;


import jakarta.validation.constraints.NotNull;

public record DadosAtualizacaoPortao(
        @NotNull(message = "ID não pode ser nulo")
        String id,
        String codigo,
        Boolean disponivel,
        String statusVoo,
        String statusCheckIn
) {
}