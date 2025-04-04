package com.wisley.ads_sistema.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wisley.ads_sistema.Model.category.CategoryModel;
import com.wisley.ads_sistema.Model.category.DadosCategory;
import com.wisley.ads_sistema.Repository.CategoryRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    @PostMapping
    @Transactional

    public void cadastrar(@RequestBody @Valid DadosCategory dadosCategory) {

        CategoryModel categoryModel = new CategoryModel(dadosCategory);
        categoryRepository.save(categoryModel);
    }

    @GetMapping
    public List<CategoryModel> listar (){
        return categoryRepository.findAll();
    }

    @PutMapping
    public void atualizarInformacoesCategory(@RequestBody @Valid DadosCategory dadosCategory) {
        CategoryModel categoryModel = categoryRepository.findById(dadosCategory.id()).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        categoryModel.atualizarInformacoesCategory(dadosCategory);
        categoryRepository.save(categoryModel);
    }

}
