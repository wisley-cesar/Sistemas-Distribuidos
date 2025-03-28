package com.wisley.ads_sistema.Model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import org.springframework.data.mongodb.core.mapping.DBRef;

import java.time.LocalDateTime;

public record DadosModelAds(
        @NotBlank(message = "A imagem é obrigatória")
        String image,

        @DBRef
        @NotNull(message = "O usuário é obrigatório")
        UserModel iduser,


        LocalDateTime createdAt,


        @DBRef
        @NotNull(message = "O estado é obrigatório")
        StatesModel statesModel,


        @NotBlank(message = "O título é obrigatório")
        String title,

        @NotBlank(message = "A descrição é obrigatória")
        String description,

        @NotBlank(message = "A categoria é obrigatória")
        String category,

        @NotNull(message = "O preço é obrigatório")
        @Positive(message = "O preço deve ser maior que zero")
        String price,

        @NotNull(message = "O campo 'preço negociável' é obrigatório")
        Boolean preciNegoTiable,

        @Min(value = 0, message = "As visualizações não podem ser negativas")
        int views


) {

}
