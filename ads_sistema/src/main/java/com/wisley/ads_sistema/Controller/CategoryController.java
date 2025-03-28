package com.wisley.ads_sistema.Controller;

import com.wisley.ads_sistema.Model.CategoryModel;
import com.wisley.ads_sistema.Model.DadosCategory;
import com.wisley.ads_sistema.Repository.CategoryRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

}
