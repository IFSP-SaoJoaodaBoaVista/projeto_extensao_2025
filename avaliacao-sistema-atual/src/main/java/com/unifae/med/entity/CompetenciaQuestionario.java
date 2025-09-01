package com.unifae.med.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "competencias_questionario")
public class CompetenciaQuestionario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_competencia_questionario")
    private Integer idCompetenciaQuestionario;

    @NotBlank(message = "Nome da competência é obrigatório")
    @Size(max = 255, message = "Nome da competência deve ter no máximo 255 caracteres")
    @Column(name = "nome_competencia", nullable = false, length = 255)
    private String nomeCompetencia;

    @Size(max = 50, message = "Tipo do item deve ter no máximo 50 caracteres")
    @Column(name = "tipo_item", length = 50)
    private String tipoItem;

    @Column(name = "descricao_prompt", columnDefinition = "TEXT")
    private String descricaoPrompt;

    // Relacionamento com Questionario
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_questionario", nullable = false)
    private Questionario questionario;

    @OneToMany(mappedBy = "competenciaQuestionario", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RespostaItemAvaliacao> respostasItens;

    // Construtores
    public CompetenciaQuestionario() {
    }

    public CompetenciaQuestionario(String nomeCompetencia, String tipoItem, String descricaoPrompt) {
        this.nomeCompetencia = nomeCompetencia;
        this.tipoItem = tipoItem;
        this.descricaoPrompt = descricaoPrompt;
    }

    // Getters e Setters
    public Integer getIdCompetenciaQuestionario() {
        return idCompetenciaQuestionario;
    }

    public void setIdCompetenciaQuestionario(Integer idCompetenciaQuestionario) {
        this.idCompetenciaQuestionario = idCompetenciaQuestionario;
    }

    public String getNomeCompetencia() {
        return nomeCompetencia;
    }

    public void setNomeCompetencia(String nomeCompetencia) {
        this.nomeCompetencia = nomeCompetencia;
    }

    public String getTipoItem() {
        return tipoItem;
    }

    public void setTipoItem(String tipoItem) {
        this.tipoItem = tipoItem;
    }

    public String getDescricaoPrompt() {
        return descricaoPrompt;
    }

    public void setDescricaoPrompt(String descricaoPrompt) {
        this.descricaoPrompt = descricaoPrompt;
    }

    public List<RespostaItemAvaliacao> getRespostasItens() {
        return respostasItens;
    }

    public void setRespostasItens(List<RespostaItemAvaliacao> respostasItens) {
        this.respostasItens = respostasItens;
    }

    public Questionario getQuestionario() {
        return questionario;
    }

    public void setQuestionario(Questionario questionario) {
        this.questionario = questionario;
    }

    @Override
    public String toString() {
        return "CompetenciaQuestionario{"
                + "idCompetenciaQuestionario=" + idCompetenciaQuestionario
                + ", nomeCompetencia='" + nomeCompetencia + '\''
                + ", tipoItem='" + tipoItem + '\''
                + '}';
    }
}
