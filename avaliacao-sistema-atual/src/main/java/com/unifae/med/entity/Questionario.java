package com.unifae.med.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "questionarios")
public class Questionario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_questionario")
    private Integer idQuestionario;

    @NotBlank(message = "Nome do modelo é obrigatório")
    @Size(max = 255, message = "Nome do modelo deve ter no máximo 255 caracteres")
    @Column(name = "nome_modelo", nullable = false, length = 255)
    private String nomeModelo;

    @Column(name = "descricao", columnDefinition = "TEXT")
    private String descricao;

    @OneToMany(mappedBy = "questionario", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<AvaliacaoPreenchida> avaliacoesPreenchidas;

    // Construtores
    public Questionario() {
    }

    public Questionario(String nomeModelo, String descricao) {
        this.nomeModelo = nomeModelo;
        this.descricao = descricao;
    }

    // Getters e Setters
    public Integer getIdQuestionario() {
        return idQuestionario;
    }

    public void setIdQuestionario(Integer idQuestionario) {
        this.idQuestionario = idQuestionario;
    }

    public String getNomeModelo() {
        return nomeModelo;
    }

    public void setNomeModelo(String nomeModelo) {
        this.nomeModelo = nomeModelo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public List<AvaliacaoPreenchida> getAvaliacoesPreenchidas() {
        return avaliacoesPreenchidas;
    }

    public void setAvaliacoesPreenchidas(List<AvaliacaoPreenchida> avaliacoesPreenchidas) {
        this.avaliacoesPreenchidas = avaliacoesPreenchidas;
    }

    @Override
    public String toString() {
        return "Questionario{"
                + "idQuestionario=" + idQuestionario
                + ", nomeModelo='" + nomeModelo + '\''
                + ", descricao='" + descricao + '\''
                + '}';
    }
}
