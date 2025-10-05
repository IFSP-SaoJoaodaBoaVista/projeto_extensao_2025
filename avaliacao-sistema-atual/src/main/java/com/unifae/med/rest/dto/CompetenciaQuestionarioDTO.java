package com.unifae.med.rest.dto;

public class CompetenciaQuestionarioDTO {

    private Integer idCompetenciaQuestionario;
    private String nomeCompetencia;
    private String tipoItem;
    private String descricaoPrompt;
    private Integer idQuestionario;

    public CompetenciaQuestionarioDTO() {
    }

    public CompetenciaQuestionarioDTO(Integer idCompetenciaQuestionario, String nomeCompetencia, String tipoItem, String descricaoPrompt, Integer idQuestionario) {
        this.idCompetenciaQuestionario = idCompetenciaQuestionario;
        this.nomeCompetencia = nomeCompetencia;
        this.tipoItem = tipoItem;
        this.descricaoPrompt = descricaoPrompt;
        this.idQuestionario = idQuestionario;
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

    public Integer getIdQuestionario() {
        return idQuestionario;
    }

    public void setIdQuestionario(Integer idQuestionario) {
        this.idQuestionario = idQuestionario;
    }
}

