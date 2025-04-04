package com.wisley.ads_sistema.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    public Page<DadosCategory> listar (Pageable paginacao) {
        return categoryRepository.findAllByAtivoTrue(paginacao).map(DadosCategory::new);
    }

    @PutMapping
    public void atualizarInformacoesCategory(@RequestBody @Valid DadosCategory dadosCategory) {
        CategoryModel categoryModel = categoryRepository.findById(dadosCategory.id()).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        categoryModel.atualizarInformacoesCategory(dadosCategory);
        categoryRepository.save(categoryModel);
    }

    @DeleteMapping("/{id}")
    public void deletrar( @PathVariable String id) {
        CategoryModel categoryModel = categoryRepository.findById(id).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        categoryModel.excluir();
        categoryRepository.save(categoryModel);
    }

}
