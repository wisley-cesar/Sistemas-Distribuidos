package com.wisley.ads_sistema.Model.category;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Document("Category")
public class CategoryModel {
    @Id
    private String id;

    private String name;

    private  String slug;

    private boolean ativo;

    public CategoryModel() {
    }

    public CategoryModel(DadosCategory dadosCategory) {
        this.id = dadosCategory.id();
        this.name = dadosCategory.name();
        this.slug = dadosCategory.slug();
    }


    public void atualizarInformacoesCategory(DadosCategory dadosCategory) {
        if (dadosCategory.name() != null) {
            this.name = dadosCategory.name();
        }
        if (dadosCategory.slug() != null) {
            this.slug = dadosCategory.slug();
        }
    }


    public void excluir() {
      this.ativo = false;
    }
}
