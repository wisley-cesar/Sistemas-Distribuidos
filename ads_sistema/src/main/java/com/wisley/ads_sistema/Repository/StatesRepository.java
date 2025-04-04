package com.wisley.ads_sistema.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.wisley.ads_sistema.Model.states.StatesModel;

@Repository
public interface StatesRepository extends MongoRepository<StatesModel, String> {

    Page<StatesModel> findAllByAtivoTrue(Pageable paginacao);
}
