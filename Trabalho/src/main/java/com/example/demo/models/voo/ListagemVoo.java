package com.example.demo.models.voo;

import com.example.demo.models.portao_embarque.Portao;

public record ListagemVoo(
    String id,
    Integer numeroVoo,
    String origem,
    String destino,
    String dataHoraPartida,
    Portao idPortao,
    StatusVoo status
) {
    public ListagemVoo(Voo voo) {
        this(voo.getId(), voo.getNumeroVoo(), voo.getOrigem(), voo.getDestino(), voo.getDataHoraPartida(), voo.getIdPortao(), voo.getStatus());
    }
    
}
