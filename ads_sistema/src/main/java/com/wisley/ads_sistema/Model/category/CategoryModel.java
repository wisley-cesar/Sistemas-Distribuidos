package com.wisley.ads_sistema.Model.category;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document("Category")
public class CategoryModel {
    @Id
    private String id;

    private String name;

    private  String slug;

    public CategoryModel() {
    }

    public CategoryModel(DadosCategory dadosCategory) {
        this.id = dadosCategory.id();
        this.name = dadosCategory.name();
        this.slug = dadosCategory.slug();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public void atualizarInformacoesCategory(DadosCategory dadosCategory) {
        if (dadosCategory.name() != null) {
            this.name = dadosCategory.name();
        }
        if (dadosCategory.slug() != null) {
            this.slug = dadosCategory.slug();
        }
    }
}
