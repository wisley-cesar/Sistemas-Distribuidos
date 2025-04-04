package com.wisley.ads_sistema.Model.category;

import org.springframework.data.annotation.Id;

import jakarta.validation.constraints.NotBlank;

public record DadosCategory(
        @Id
        String id,
        @NotBlank(message = "O nome da categoria é obrigatório")
        String name,
        @NotBlank(message = "O slug da categoria é obrigatório")
        String slug
) {
}
