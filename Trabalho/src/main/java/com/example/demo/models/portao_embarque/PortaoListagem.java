package com.example.demo.models.portao_embarque;

public record PortaoListagem(
        String id,
        String codigo,
        Boolean disponivel
) {
    public PortaoListagem(Portao portao) {
        this(portao.getId(), portao.getCodigo(), portao.isDisponivel());
    }
}
