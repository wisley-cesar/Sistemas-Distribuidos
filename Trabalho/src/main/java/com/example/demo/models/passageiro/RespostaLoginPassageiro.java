package com.example.demo.models.passageiro;

public record RespostaLoginPassageiro(
    String token,
    String id,
    String nome,
    String cpf,
    String idVoo,
    StatusCheckIn statusCheckIn
) {} 