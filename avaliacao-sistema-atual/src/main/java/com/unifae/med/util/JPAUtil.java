package com.unifae.med.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * JPAUTIL - CLASSE UTILITÁRIA PARA GERENCIAMENTO JPA
 * ===================================================
 * 
 * Esta classe implementa o padrão Singleton para gerenciar o EntityManagerFactory
 * e fornecer EntityManagers para acesso ao banco de dados em todo o sistema.
 * 
 * RESPONSABILIDADES:
 * - Inicializar EntityManagerFactory uma única vez (Singleton)
 * - Fornecer EntityManagers para DAOs e Servlets
 * - Gerenciar ciclo de vida da conexão JPA
 * - Tratar erros de inicialização
 * 
 * PADRÕES IMPLEMENTADOS:
 * - Singleton: Uma única instância de EntityManagerFactory
 * - Factory: Cria EntityManagers sob demanda
 * - Resource Management: Controla abertura/fechamento de recursos
 * 
 * RELACIONAMENTO COM OUTROS ARQUIVOS:
 * - persistence.xml: Configuração lida na inicialização
 * - DAOs (dao/*.java): Usam getEntityManager() para acesso a dados
 * - Servlets (servlet/*.java): Podem usar para transações manuais
 * - Entidades (entity/*.java): Gerenciadas pelos EntityManagers criados aqui
 * 
 * FLUXO DE USO TÍPICO:
 * 1. Aplicação inicia → static block cria EntityManagerFactory
 * 2. DAO precisa de dados → chama JPAUtil.getEntityManager()
 * 3. DAO executa operações → fecha EntityManager
 * 4. Aplicação termina → chama closeEntityManagerFactory()
 * 
 * @author Sistema de Avaliação UNIFAE
 * @version 1.0
 */
public class JPAUtil {
    
    /**
     * NOME DA UNIDADE DE PERSISTÊNCIA
     * ================================
     * Deve corresponder ao nome definido em persistence.xml.
     * Usado para localizar a configuração JPA correta.
     */
    private static final String PERSISTENCE_UNIT_NAME = "unifae-med-pu";
    
    /**
     * FACTORY DE ENTITYMANAGERS (SINGLETON)
     * ======================================
     * Instância única compartilhada por toda aplicação.
     * Criação é custosa, por isso mantemos uma única instância.
     * Thread-safe por design do JPA.
     */
    private static EntityManagerFactory entityManagerFactory;
    
    /**
     * BLOCO DE INICIALIZAÇÃO ESTÁTICA
     * ================================
     * Executado uma única vez quando a classe é carregada pela JVM.
     * Garante que EntityManagerFactory seja criado antes de qualquer uso.
     * 
     * TRATAMENTO DE ERROS:
     * - Captura exceções de inicialização
     * - Registra erro no console para debug
     * - Lança ExceptionInInitializerError para falha rápida
     */
    static {
        try {
            // Cria factory usando configuração do persistence.xml
            entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Exception e) {
            // Log do erro para facilitar debug
            System.err.println("Erro ao criar EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();
            
            // Falha rápida - aplicação não pode funcionar sem JPA
            throw new ExceptionInInitializerError(e);
        }
    }
    
    /**
     * OBTER ENTITYMANAGER
     * ===================
     * Método principal usado pelos DAOs para obter acesso ao banco.
     * 
     * IMPORTANTE:
     * - Cada EntityManager deve ser fechado após uso
     * - Não é thread-safe - cada thread deve ter seu próprio EM
     * - Representa uma sessão de trabalho com o banco
     * 
     * EXEMPLO DE USO:
     * EntityManager em = JPAUtil.getEntityManager();
     * try {
     *     em.getTransaction().begin();
     *     // operações com banco
     *     em.getTransaction().commit();
     * } finally {
     *     em.close();
     * }
     * 
     * @return EntityManager novo para operações de banco
     * @throws IllegalStateException se EntityManagerFactory não foi inicializado
     */
    public static EntityManager getEntityManager() {
        // Validação de segurança
        if (entityManagerFactory == null) {
            throw new IllegalStateException("EntityManagerFactory não foi inicializado");
        }
        
        // Cria novo EntityManager para esta sessão
        return entityManagerFactory.createEntityManager();
    }
    
    /**
     * FECHAR ENTITYMANAGERFACTORY
     * ============================
     * Método para limpeza de recursos quando aplicação termina.
     * 
     * QUANDO USAR:
     * - Shutdown da aplicação
     * - Testes unitários (cleanup)
     * - Reconfiguração do sistema
     * 
     * EFEITOS:
     * - Fecha todas as conexões de banco
     * - Libera recursos do pool de conexões
     * - Invalida todos os EntityManagers criados
     */
    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }
    
    /**
     * VERIFICAR STATUS DO ENTITYMANAGERFACTORY
     * =========================================
     * Método utilitário para verificar se o factory ainda está ativo.
     * 
     * USOS:
     * - Diagnóstico de problemas
     * - Validação em testes
     * - Monitoramento de saúde da aplicação
     * 
     * @return true se EntityManagerFactory está aberto e funcional
     */
    public static boolean isEntityManagerFactoryOpen() {
        return entityManagerFactory != null && entityManagerFactory.isOpen();
    }
}

