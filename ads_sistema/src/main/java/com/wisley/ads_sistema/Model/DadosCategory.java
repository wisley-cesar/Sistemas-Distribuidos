package com.wisley.ads_sistema.Model;

import jakarta.validation.constraints.NotBlank;
import org.springframework.data.annotation.Id;

public record DadosCategory(
        @Id
        String id,
        @NotBlank(message = "O nome da categoria é obrigatório")
        String name,
        @NotBlank(message = "O slug da categoria é obrigatório")
        String slug
) {
}
