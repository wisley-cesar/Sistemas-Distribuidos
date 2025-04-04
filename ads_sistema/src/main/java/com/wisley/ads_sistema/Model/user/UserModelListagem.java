package com.wisley.ads_sistema.Model.user;

public record UserModelListagem(
        String id,
        String userName,
        String email,
        String password,
        String token,
        boolean ativo
) {
    public UserModelListagem(UserModel userModel) {
        this(userModel.getId(), userModel.getUserName(), userModel.getEmail(), userModel.getPassword(), userModel.getToken(), userModel.isAtivo());
    
    }
}
