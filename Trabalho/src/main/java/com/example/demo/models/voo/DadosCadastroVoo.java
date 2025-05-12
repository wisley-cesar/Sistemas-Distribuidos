package com.example.demo.models.voo;

import com.example.demo.models.portao_embarque.Portao;

public record DadosCadastroVoo(
    Integer numeroVoo,
    String origem,
    String destino,
    String dataHoraPartida,
    Portao idPortao,
    StatusVoo status
) {

    
}
