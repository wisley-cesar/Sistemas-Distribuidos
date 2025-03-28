package com.wisley.ads_sistema.Repository;

import com.wisley.ads_sistema.Model.ModelAds;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdsRepository extends MongoRepository<ModelAds, String>{

}
