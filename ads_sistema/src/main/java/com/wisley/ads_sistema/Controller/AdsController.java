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

import com.wisley.ads_sistema.Model.ads.DadadosAtualizacaoAds;
import com.wisley.ads_sistema.Model.ads.DadosModelAds;
import com.wisley.ads_sistema.Model.ads.ModelAds;
import com.wisley.ads_sistema.Repository.AdsRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping("ads")
public class AdsController {
    @Autowired
    private AdsRepository adsRepository;


    @PostMapping
    @Transactional
    public void cadastrar(@RequestBody @Valid DadosModelAds dadosModelAds){
        ModelAds ads = new ModelAds(dadosModelAds);
        adsRepository.save(ads);
    }

    @GetMapping
    public List<ModelAds> listar(){
        return  adsRepository.findAll();
    }

    @PutMapping
    @Transactional
    public void atualizar( @Valid @RequestBody DadadosAtualizacaoAds dadosAtualizacaoAds){
       ModelAds modelAds = adsRepository.findById(dadosAtualizacaoAds.id()).orElseThrow(()-> new RuntimeException("Id não encontrado"));
       modelAds.atualizarInformacoesAds(dadosAtualizacaoAds);
       adsRepository.save(modelAds);
    }






}