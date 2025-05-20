package com.example.demo.models.portao_embarque;

public record PortaoListagem(
        String codigo,
        Boolean disponivel
) {
    public PortaoListagem(Portao portao) {
        this(portao.getCodigo(), portao.isDisponivel());
    }

    
}
