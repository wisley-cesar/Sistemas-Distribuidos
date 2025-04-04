package com.wisley.ads_sistema.Model.states;

import org.springframework.data.annotation.Id;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record ListagemStates(        
        @Id
        String id,
        @NotBlank
        String nome,
        @NotNull
        boolean ativo
) {

        public ListagemStates(StatesModel dados) {
                this(dados.getId(), dados.getNome(), dados.isAtivo());
        }
    
}
