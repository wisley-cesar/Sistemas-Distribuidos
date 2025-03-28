package com.wisley.ads_sistema.Repository;

import com.wisley.ads_sistema.Model.StatesModel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatesRepository extends MongoRepository<StatesModel, String> {
}
