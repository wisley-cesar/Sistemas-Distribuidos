package com.wisley.ads_sistema.Repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.wisley.ads_sistema.Model.user.UserModel;

@Repository
public interface UserRepository  extends MongoRepository<UserModel, String> {

    Page<UserModel> findAllByAtivoTrue(Pageable paginacao);
}
