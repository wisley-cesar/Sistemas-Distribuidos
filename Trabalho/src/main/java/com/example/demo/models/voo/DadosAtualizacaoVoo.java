package com.example.demo.models.voo;

import com.example.demo.models.portao_embarque.Portao;

import jakarta.validation.constraints.NotNull;

public record DadosAtualizacaoVoo(
    @NotNull(message = "ID não pode ser nulo")
    String id,
    Integer numeroVoo,
    String origem,
    String destino,
    String dataHoraPartida,
    Portao idPortao,
    StatusVoo status
) {
    
}
