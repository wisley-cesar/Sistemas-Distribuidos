package com.example.demo.service.passageiro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.models.passageiro.DadosCadastroPassageiro;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.PassageiroRepository;
import com.example.demo.repository.PortaoRepository;
import com.example.demo.repository.VooRepository;

@Service
public class PassageiroService {

    private final PassageiroRepository passageiroRepository;
    private final VooRepository vooRepository;
    private final PortaoRepository portaoRepository;

    @Autowired
    public PassageiroService(PassageiroRepository passageiroRepository, VooRepository vooRepository, PortaoRepository portaoRepository) {
        this.passageiroRepository = passageiroRepository;
        this.vooRepository = vooRepository;
        this.portaoRepository = portaoRepository;
    }

    public Passageiro atualizarStatusCheckIn(String idPassageiro, StatusCheckIn novoStatus) {
        Passageiro passageiro = passageiroRepository.findById(idPassageiro)
            .orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));

        // Validação: só permite check-in se o voo estiver com status EMBARQUE
        if (novoStatus == StatusCheckIn.REALIZADO) {
            if (passageiro.getIdVoo() == null) {
                throw new RuntimeException("Passageiro não está associado a nenhum voo.");
            }
            
            // Buscar o voo atualizado do banco de dados
            Voo vooAtualizado = vooRepository.findById(passageiro.getIdVoo().getId())
                .orElseThrow(() -> new RuntimeException("Voo não encontrado"));
            
            if (!vooAtualizado.getStatus().equals(com.example.demo.models.voo.StatusVoo.EMBARQUE)) {
                throw new RuntimeException("Check-in só pode ser realizado se o voo estiver com status EMBARQUE.");
            }
            
            // Atualizar a referência do voo no passageiro
            passageiro.setIdVoo(vooAtualizado);
        }

        passageiro.setStatusCheckIn(novoStatus);
        return passageiroRepository.save(passageiro);
    }

    public Passageiro cadastrarPassageiro(DadosCadastroPassageiro dados) {
        if (passageiroRepository.findByCpf(dados.cpf()).isPresent()) {
            throw new RuntimeException("Já existe passageiro com esse CPF.");
        }
        // Validação: voo deve existir
        String idVoo = dados.idVoo().getId();
        Voo voo = vooRepository.findById(idVoo)
            .orElseThrow(() -> new RuntimeException("Voo não encontrado para o passageiro."));
        Passageiro passageiro = new Passageiro(dados);
        passageiro.setIdVoo(voo); // garanta que está setando o objeto Voo correto
        return passageiroRepository.save(passageiro);
    }
}
