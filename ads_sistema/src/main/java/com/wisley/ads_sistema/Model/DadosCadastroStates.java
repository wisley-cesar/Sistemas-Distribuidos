package com.wisley.ads_sistema.Model;

import jakarta.validation.constraints.NotBlank;
import org.springframework.data.annotation.Id;

public record DadosCadastroStates(
        @Id
        String id,
        @NotBlank
        String nome
) {

}
