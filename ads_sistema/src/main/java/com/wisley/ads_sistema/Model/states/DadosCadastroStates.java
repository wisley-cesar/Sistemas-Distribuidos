package com.wisley.ads_sistema.Model.states;

import org.springframework.data.annotation.Id;

import jakarta.validation.constraints.NotBlank;

public record DadosCadastroStates(
        @Id
        String id,
        @NotBlank
        String nome
) {

}
