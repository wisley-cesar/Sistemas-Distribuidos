package com.example.demo.models.passageiro;

public record RespostaCheckIn(
    String mensagem,
    PassageiroListagem passageiro,
    boolean sucesso
) {
    public static RespostaCheckIn sucesso(PassageiroListagem passageiro) {
        return new RespostaCheckIn(
            "Check-in realizado com sucesso! O passageiro está pronto para embarcar.",
            passageiro,
            true
        );
    }

    public static RespostaCheckIn erro(String mensagem) {
        return new RespostaCheckIn(
            mensagem,
            null,
            false
        );
    }
} 