package com.wisley.ads_sistema.Model.category;

import org.springframework.data.annotation.Id;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record DadosCategory(
        @Id
        String id,
        @NotBlank(message = "O nome da categoria é obrigatório")
        String name,
        @NotBlank(message = "O slug da categoria é obrigatório")
        String slug,
        @NotNull
        boolean ativo
) {
        public DadosCategory(CategoryModel dados){
                this(dados.getId(), dados.getName(), dados.getSlug(), dados.isAtivo());
        }
}
