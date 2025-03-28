package com.wisley.ads_sistema.Repository;

import com.wisley.ads_sistema.Model.UserModel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository  extends MongoRepository<UserModel, String> {
}
