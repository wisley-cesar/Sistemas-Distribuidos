package com.wisley.ads_sistema.Repository;

import com.wisley.ads_sistema.Model.CategoryModel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public interface CategoryRepository extends MongoRepository<CategoryModel, String> {
}
