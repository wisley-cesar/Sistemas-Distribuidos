package com.example.demo.models.passageiro;

import com.example.demo.models.voo.Voo;

public record PassageiroListagem(
    String id,
    String nome,
    String cpf,
    Voo idVoo,
    StatusCheckIn statusCheckIn
) {
    public PassageiroListagem(Passageiro passageiro) {
        this(passageiro.getId(), passageiro.getNome(), passageiro.getCpf(), passageiro.getIdVoo(), passageiro.getStatusCheckIn());
    }
    
}
