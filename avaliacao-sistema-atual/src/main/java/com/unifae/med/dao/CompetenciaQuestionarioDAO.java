package com.unifae.med.dao;

import com.unifae.med.entity.CompetenciaQuestionario;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class CompetenciaQuestionarioDAO extends GenericDAO<CompetenciaQuestionario, Integer> {
    
    public CompetenciaQuestionarioDAO() {
        super(CompetenciaQuestionario.class);
    }
    
    /**
     * Busca competências específicas de um questionário
     * @param questionarioId ID do questionário
     * @return Lista de competências do questionário específico
     */
    public List<CompetenciaQuestionario> findByQuestionario(Integer questionarioId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT cq FROM CompetenciaQuestionario cq " +
                         "WHERE cq.questionario.idQuestionario = :questionarioId " +
                         "ORDER BY cq.idCompetenciaQuestionario";
            TypedQuery<CompetenciaQuestionario> query = em.createQuery(jpql, CompetenciaQuestionario.class);
            query.setParameter("questionarioId", questionarioId);
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar competências por questionário: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
    
    public List<CompetenciaQuestionario> findByTipoItem(String tipoItem) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT c FROM CompetenciaQuestionario c WHERE c.tipoItem = :tipoItem ORDER BY c.nomeCompetencia";
            TypedQuery<CompetenciaQuestionario> query = em.createQuery(jpql, CompetenciaQuestionario.class);
            query.setParameter("tipoItem", tipoItem);
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar competências por tipo de item: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
    
    public List<CompetenciaQuestionario> findByNomeCompetenciaContaining(String nome) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT c FROM CompetenciaQuestionario c WHERE LOWER(c.nomeCompetencia) LIKE LOWER(:nome) ORDER BY c.nomeCompetencia";
            TypedQuery<CompetenciaQuestionario> query = em.createQuery(jpql, CompetenciaQuestionario.class);
            query.setParameter("nome", "%" + nome + "%");
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar competências por nome: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
    
    public boolean existsByNomeCompetencia(String nomeCompetencia) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(c) FROM CompetenciaQuestionario c WHERE c.nomeCompetencia = :nomeCompetencia";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("nomeCompetencia", nomeCompetencia);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao verificar existência de competência: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}

