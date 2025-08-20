package com.unifae.med.dao;

import com.unifae.med.entity.Questionario;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

public class QuestionarioDAO extends GenericDAO<Questionario, Integer> {
    
    public QuestionarioDAO() {
        super(Questionario.class);
    }
    
    public Optional<Questionario> findByNomeModelo(String nomeModelo) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT q FROM Questionario q WHERE q.nomeModelo = :nomeModelo";
            TypedQuery<Questionario> query = em.createQuery(jpql, Questionario.class);
            query.setParameter("nomeModelo", nomeModelo);
            Questionario questionario = query.getSingleResult();
            return Optional.of(questionario);
        } catch (NoResultException e) {
            return Optional.empty();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar questionário por nome do modelo: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
    
    public List<Questionario> findByNomeModeloContaining(String nome) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT q FROM Questionario q WHERE LOWER(q.nomeModelo) LIKE LOWER(:nome) ORDER BY q.nomeModelo";
            TypedQuery<Questionario> query = em.createQuery(jpql, Questionario.class);
            query.setParameter("nome", "%" + nome + "%");
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar questionários por nome: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
    
    public boolean existsByNomeModelo(String nomeModelo) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(q) FROM Questionario q WHERE q.nomeModelo = :nomeModelo";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("nomeModelo", nomeModelo);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao verificar existência de questionário: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}

