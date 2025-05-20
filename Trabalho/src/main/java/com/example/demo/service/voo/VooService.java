package com.example.demo.service.voo;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.RelatorioPassageiroDTO;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.models.portao_embarque.Portao;
import com.example.demo.models.voo.RelatorioVooDTO;
import com.example.demo.models.voo.StatusVoo;
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.PassageiroRepository;
import com.example.demo.repository.PortaoRepository;
import com.example.demo.repository.VooRepository;

@Service
public class VooService {

    @Autowired
    private VooRepository vooRepository;

    @Autowired
    private PortaoRepository portaoRepository;

    @Autowired
    private PassageiroRepository passageiroRepository;

    public Voo alterarStatus(String idVoo, StatusVoo novoStatus) {
        System.out.println("Buscando voo com ID: " + idVoo);
        Voo voo = vooRepository.findById(idVoo)
                .orElseThrow(() -> new RuntimeException("Voo não encontrado"));

        // Validar se o status é válido
        if (novoStatus == null) {
            throw new IllegalArgumentException("Status não pode ser nulo.");
        }

        // Verificar se há passageiros com check-in realizado antes de permitir voltar para PROGRAMADO
        if (novoStatus == StatusVoo.PROGRAMADO) {
            List<Passageiro> passageirosComCheckIn = passageiroRepository.findAll().stream()
                .filter(p -> p.getIdVoo() != null && 
                           p.getIdVoo().getId().equals(voo.getId()) && 
                           p.getStatusCheckIn() == StatusCheckIn.REALIZADO)
                .collect(Collectors.toList());

            if (!passageirosComCheckIn.isEmpty()) {
                throw new RuntimeException("Não é possível voltar o voo para PROGRAMADO pois existem passageiros com check-in realizado.");
            }
        }

        // Se o novo status for EMBARQUE, verificar se o voo tem um portão vinculado
        if (novoStatus == StatusVoo.EMBARQUE) {
            if (voo.getIdPortao() == null) {
                throw new RuntimeException("Voo não possui portão de embarque vinculado.");
            }
        }

        // Se o novo status for CONCLUIDO, liberar o portão
        if (novoStatus == StatusVoo.CONCLUIDO) {
            if (voo.getIdPortao() != null) {
                Portao portao = portaoRepository.findById(voo.getIdPortao().getId())
                    .orElseThrow(() -> new RuntimeException("Portão não encontrado"));
                portao.setDisponivel(true);
                portaoRepository.save(portao);
            }
        }

        voo.setStatus(novoStatus);
        return vooRepository.save(voo);
    }

    public Voo cadastrarVoo(Voo voo) {
        if (voo.getIdPortao() != null) {
            Portao portao = portaoRepository.findById(voo.getIdPortao().getId())
                .orElseThrow(() -> new RuntimeException("Portão não encontrado"));

            // Verificar se o portão já está sendo usado por outro voo ativo
            List<Voo> voosComPortao = vooRepository.findAll().stream()
                .filter(v -> v.getIdPortao() != null && 
                           v.getIdPortao().getId().equals(portao.getId()) && 
                           v.isAtivo())
                .collect(Collectors.toList());

            if (!voosComPortao.isEmpty()) {
                throw new RuntimeException("Este portão já está sendo usado por outro voo ativo.");
            }

            // Marcar o portão como indisponível quando um voo é atribuído a ele
            portao.setDisponivel(false);
            portaoRepository.save(portao);
        }
        return vooRepository.save(voo);
    }

    public List<RelatorioVooDTO> gerarRelatorioVoosHoje() {
        LocalDate hoje = LocalDate.now();
        List<Voo> voos = vooRepository.findAll();
        return voos.stream()
            .filter(voo -> voo.getDataHoraPartida() != null && voo.getDataHoraPartida().startsWith(hoje.toString()))
            .map(voo -> {
                String portao = (voo.getIdPortao() != null) ? voo.getIdPortao().getCodigo() : null;
                List<RelatorioPassageiroDTO> passageiros = passageiroRepository.findAll().stream()
                    .filter(p -> p.getIdVoo() != null && p.getIdVoo().getId().equals(voo.getId()))
                    .map(p -> new RelatorioPassageiroDTO(p.getNome(), p.getCpf(), p.getStatusCheckIn()))
                    .collect(Collectors.toList());
                return new RelatorioVooDTO(
                    voo.getNumeroVoo(),
                    voo.getOrigem(),
                    voo.getDestino(),
                    voo.getDataHoraPartida(),
                    voo.getStatus(),
                    portao,
                    passageiros
                );
            })
            .collect(Collectors.toList());
    }
}

