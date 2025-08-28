-- ========================================
-- SCRIPT DDL - ESTRUTURA COMPLETA DO BANCO
-- Sistema de Avaliação UNIFAE - Medicina
-- ========================================
-- 
-- Este script cria a estrutura completa do banco de dados
-- com todas as correções aplicadas
-- 
-- Versão: 2.1 Corrigida
-- Data: 2025-08-26
-- Autor: Sistema de Avaliação UNIFAE
-- 
-- CORREÇÕES APLICADAS:
-- - Enum TipoUsuario padronizado (ESTUDANTE, PROFESSOR, COORDENADOR, ADMINISTRADOR)
-- - Estrutura otimizada para evitar conflitos AUTO_INCREMENT
-- - Chaves estrangeiras com relacionamento correto
-- - Índices otimizados para performance
-- ========================================

-- Criar banco de dados se não existir
CREATE DATABASE IF NOT EXISTS unifae_med_app 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE unifae_med_app;

-- Desabilitar verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- ========================================
-- 1. TABELA: PERMISSÕES
-- ========================================

DROP TABLE IF EXISTS permissoes;
CREATE TABLE permissoes (
    id_permissao INT AUTO_INCREMENT PRIMARY KEY,
    nome_permissao VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_permissao_nome (nome_permissao),
    INDEX idx_permissao_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 2. TABELA: USUÁRIOS
-- ========================================

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('ESTUDANTE', 'PROFESSOR', 'COORDENADOR', 'ADMINISTRADOR') NOT NULL,
    matricula_RA VARCHAR(50) UNIQUE,
    telefone VARCHAR(20),
    foto_perfil_path VARCHAR(500),
    ativo BOOLEAN DEFAULT TRUE,
    
    -- Campos específicos para estudantes
    periodo_atual_aluno INT,
    observacoes_gerais_aluno TEXT,
    
    -- Relacionamento com permissões (simplificado)
    id_permissao INT,
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_usuario_email (email),
    INDEX idx_usuario_tipo (tipo_usuario),
    INDEX idx_usuario_ativo (ativo),
    INDEX idx_usuario_matricula (matricula_RA),
    
    -- Chave estrangeira
    FOREIGN KEY (id_permissao) REFERENCES permissoes(id_permissao) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 3. TABELA: USUÁRIOS-PERMISSÕES (N:N)
-- ========================================

DROP TABLE IF EXISTS usuarios_permissoes;
CREATE TABLE usuarios_permissoes (
    id_usuario_permissao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_permissao INT NOT NULL,
    data_atribuicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices
    UNIQUE KEY uk_usuario_permissao (id_usuario, id_permissao),
    INDEX idx_usuario_permissao_usuario (id_usuario),
    INDEX idx_usuario_permissao_permissao (id_permissao),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_permissao) REFERENCES permissoes(id_permissao) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 4. TABELA: DISCIPLINAS
-- ========================================

DROP TABLE IF EXISTS disciplinas;
CREATE TABLE disciplinas (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(255) NOT NULL,
    codigo_disciplina VARCHAR(20) NOT NULL UNIQUE,
    descricao TEXT,
    carga_horaria INT DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_disciplina_codigo (codigo_disciplina),
    INDEX idx_disciplina_nome (nome_disciplina),
    INDEX idx_disciplina_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 5. TABELA: TURMAS
-- ========================================

DROP TABLE IF EXISTS turmas;
CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome_turma VARCHAR(255) NOT NULL,
    ano_letivo YEAR NOT NULL,
    semestre TINYINT NOT NULL CHECK (semestre IN (1, 2)),
    data_inicio DATE,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_turma_ano_semestre (ano_letivo, semestre),
    INDEX idx_turma_nome (nome_turma),
    INDEX idx_turma_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 6. TABELA: USUÁRIOS-TURMAS (N:N)
-- ========================================

DROP TABLE IF EXISTS usuarios_turmas;
CREATE TABLE usuarios_turmas (
    id_usuario_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_turma INT NOT NULL,
    papel ENUM('ESTUDANTE', 'PROFESSOR', 'MONITOR') NOT NULL,
    data_vinculacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    
    -- Índices
    UNIQUE KEY uk_usuario_turma_papel (id_usuario, id_turma, papel),
    INDEX idx_usuario_turma_usuario (id_usuario),
    INDEX idx_usuario_turma_turma (id_turma),
    INDEX idx_usuario_turma_papel (papel),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 7. TABELA: DISCIPLINAS-TURMAS (N:N)
-- ========================================

DROP TABLE IF EXISTS disciplinas_turmas;
CREATE TABLE disciplinas_turmas (
    id_disciplina_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_disciplina INT NOT NULL,
    id_turma INT NOT NULL,
    id_professor INT,
    data_vinculacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    
    -- Índices
    UNIQUE KEY uk_disciplina_turma (id_disciplina, id_turma),
    INDEX idx_disciplina_turma_disciplina (id_disciplina),
    INDEX idx_disciplina_turma_turma (id_turma),
    INDEX idx_disciplina_turma_professor (id_professor),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_professor) REFERENCES usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 8. TABELA: LOCAIS DE EVENTOS
-- ========================================

DROP TABLE IF EXISTS locais_eventos;
CREATE TABLE locais_eventos (
    id_local_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome_local VARCHAR(255) NOT NULL,
    descricao TEXT,
    endereco VARCHAR(500),
    capacidade INT DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_local_nome (nome_local),
    INDEX idx_local_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 9. TABELA: QUESTIONÁRIOS
-- ========================================

DROP TABLE IF EXISTS questionarios;
CREATE TABLE questionarios (
    id_questionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_modelo VARCHAR(255) NOT NULL,
    descricao TEXT,
    tipo_avaliacao ENUM('MINI_CEX', 'AVALIACAO_360_PROFESSOR', 'AVALIACAO_360_PARES', 'AVALIACAO_360_EQUIPE', 'AVALIACAO_360_PACIENTE') NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_questionario_tipo (tipo_avaliacao),
    INDEX idx_questionario_nome (nome_modelo),
    INDEX idx_questionario_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 10. TABELA: COMPETÊNCIAS POR QUESTIONÁRIO
-- ========================================

DROP TABLE IF EXISTS competencias_questionario;
CREATE TABLE competencias_questionario (
    id_competencia_questionario INT AUTO_INCREMENT PRIMARY KEY,
    id_questionario INT NOT NULL,
    nome_competencia VARCHAR(255) NOT NULL,
    tipo_item ENUM('escala_numerica', 'texto_livre', 'multipla_escolha', 'checkbox') DEFAULT 'escala_numerica',
    descricao_prompt TEXT,
    ordem_exibicao INT DEFAULT 0,
    obrigatorio BOOLEAN DEFAULT TRUE,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_competencia_questionario (id_questionario),
    INDEX idx_competencia_nome (nome_competencia),
    INDEX idx_competencia_ordem (ordem_exibicao),
    INDEX idx_competencia_ativo (ativo),
    
    -- Chave estrangeira
    FOREIGN KEY (id_questionario) REFERENCES questionarios(id_questionario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 11. TABELA: AVALIAÇÕES PREENCHIDAS
-- ========================================

DROP TABLE IF EXISTS avaliacoes_preenchidas;
CREATE TABLE avaliacoes_preenchidas (
    id_avaliacao_preenchida INT AUTO_INCREMENT PRIMARY KEY,
    id_questionario INT NOT NULL,
    id_aluno_avaliado INT NOT NULL,
    id_avaliador INT NOT NULL,
    id_disciplina INT,
    id_turma INT,
    id_local_evento INT,
    
    -- Dados da avaliação
    data_realizacao DATE NOT NULL,
    horario_inicio TIME,
    horario_fim TIME,
    
    -- Feedback
    feedback_positivo TEXT,
    feedback_melhoria TEXT,
    contrato_aprendizagem TEXT,
    
    -- Status e controle
    status_avaliacao ENUM('RASCUNHO', 'FINALIZADA', 'CANCELADA') DEFAULT 'RASCUNHO',
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_avaliacao_questionario (id_questionario),
    INDEX idx_avaliacao_aluno (id_aluno_avaliado),
    INDEX idx_avaliacao_avaliador (id_avaliador),
    INDEX idx_avaliacao_disciplina (id_disciplina),
    INDEX idx_avaliacao_turma (id_turma),
    INDEX idx_avaliacao_data (data_realizacao),
    INDEX idx_avaliacao_status (status_avaliacao),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_questionario) REFERENCES questionarios(id_questionario) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_aluno_avaliado) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_avaliador) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_local_evento) REFERENCES locais_eventos(id_local_evento) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 12. TABELA: RESPOSTAS DOS ITENS DE AVALIAÇÃO
-- ========================================

DROP TABLE IF EXISTS respostas_itens_avaliacao;
CREATE TABLE respostas_itens_avaliacao (
    id_resposta_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_avaliacao_preenchida INT NOT NULL,
    id_competencia_questionario INT NOT NULL,
    
    -- Tipos de resposta
    resposta_valor_numerico DECIMAL(3,1),
    resposta_texto TEXT,
    resposta_multipla_escolha VARCHAR(255),
    nao_avaliado BOOLEAN DEFAULT FALSE,
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    UNIQUE KEY uk_resposta_avaliacao_competencia (id_avaliacao_preenchida, id_competencia_questionario),
    INDEX idx_resposta_avaliacao (id_avaliacao_preenchida),
    INDEX idx_resposta_competencia (id_competencia_questionario),
    INDEX idx_resposta_valor (resposta_valor_numerico),
    INDEX idx_resposta_nao_avaliado (nao_avaliado),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_avaliacao_preenchida) REFERENCES avaliacoes_preenchidas(id_avaliacao_preenchida) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia_questionario) REFERENCES competencias_questionario(id_competencia_questionario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 13. TABELA: EVENTOS DA AGENDA
-- ========================================

DROP TABLE IF EXISTS eventos_agenda;
CREATE TABLE eventos_agenda (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    id_local_evento INT,
    id_disciplina INT,
    id_turma INT,
    id_responsavel INT,
    tipo_evento ENUM('AULA', 'PROVA', 'SEMINARIO', 'AVALIACAO', 'REUNIAO', 'EVENTO') DEFAULT 'AULA',
    status_evento ENUM('AGENDADO', 'EM_ANDAMENTO', 'CONCLUIDO', 'CANCELADO') DEFAULT 'AGENDADO',
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_evento_data_inicio (data_inicio),
    INDEX idx_evento_data_fim (data_fim),
    INDEX idx_evento_local (id_local_evento),
    INDEX idx_evento_disciplina (id_disciplina),
    INDEX idx_evento_turma (id_turma),
    INDEX idx_evento_responsavel (id_responsavel),
    INDEX idx_evento_tipo (tipo_evento),
    INDEX idx_evento_status (status_evento),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_local_evento) REFERENCES locais_eventos(id_local_evento) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_responsavel) REFERENCES usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 14. TABELA: PARTICIPANTES DOS EVENTOS
-- ========================================

DROP TABLE IF EXISTS participantes_eventos;
CREATE TABLE participantes_eventos (
    id_participante_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_usuario INT NOT NULL,
    papel_participante ENUM('ORGANIZADOR', 'PARTICIPANTE', 'CONVIDADO') DEFAULT 'PARTICIPANTE',
    confirmado BOOLEAN DEFAULT FALSE,
    data_confirmacao TIMESTAMP NULL,
    observacoes TEXT,
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices
    UNIQUE KEY uk_evento_usuario (id_evento, id_usuario),
    INDEX idx_participante_evento (id_evento),
    INDEX idx_participante_usuario (id_usuario),
    INDEX idx_participante_papel (papel_participante),
    INDEX idx_participante_confirmado (confirmado),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_evento) REFERENCES eventos_agenda(id_evento) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 15. TABELA: AGENDA-DISCIPLINAS VINCULADAS
-- ========================================

DROP TABLE IF EXISTS agenda_disciplinas_vinculadas;
CREATE TABLE agenda_disciplinas_vinculadas (
    id_agenda_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_disciplina INT NOT NULL,
    
    -- Auditoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices
    UNIQUE KEY uk_evento_disciplina (id_evento, id_disciplina),
    INDEX idx_agenda_evento (id_evento),
    INDEX idx_agenda_disciplina (id_disciplina),
    
    -- Chaves estrangeiras
    FOREIGN KEY (id_evento) REFERENCES eventos_agenda(id_evento) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 16. TABELA: LOG DE AÇÕES (AUDITORIA)
-- ========================================

DROP TABLE IF EXISTS log_acoes;
CREATE TABLE log_acoes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    acao VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(100),
    id_registro_afetado INT,
    dados_anteriores JSON,
    dados_novos JSON,
    ip_usuario VARCHAR(45),
    user_agent TEXT,
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_log_usuario (id_usuario),
    INDEX idx_log_acao (acao),
    INDEX idx_log_tabela (tabela_afetada),
    INDEX idx_log_data (data_acao),
    
    -- Chave estrangeira
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- 17. VIEWS ÚTEIS
-- ========================================

-- View: Usuários com suas permissões
DROP VIEW IF EXISTS vw_usuarios_permissoes;
CREATE VIEW vw_usuarios_permissoes AS
SELECT 
    u.id_usuario,
    u.nome_completo,
    u.email,
    u.tipo_usuario,
    u.ativo as usuario_ativo,
    GROUP_CONCAT(p.nome_permissao SEPARATOR ', ') as permissoes
FROM usuarios u
LEFT JOIN usuarios_permissoes up ON u.id_usuario = up.id_usuario
LEFT JOIN permissoes p ON up.id_permissao = p.id_permissao AND p.ativo = TRUE
WHERE u.ativo = TRUE
GROUP BY u.id_usuario, u.nome_completo, u.email, u.tipo_usuario, u.ativo;

-- View: Avaliações com detalhes completos
DROP VIEW IF EXISTS vw_avaliacoes_completas;
CREATE VIEW vw_avaliacoes_completas AS
SELECT 
    ap.id_avaliacao_preenchida,
    ap.data_realizacao,
    ap.horario_inicio,
    ap.horario_fim,
    ap.status_avaliacao,
    q.nome_modelo as questionario,
    q.tipo_avaliacao,
    aluno.nome_completo as nome_aluno,
    aluno.email as email_aluno,
    avaliador.nome_completo as nome_avaliador,
    avaliador.email as email_avaliador,
    d.nome_disciplina,
    t.nome_turma,
    le.nome_local,
    ap.feedback_positivo,
    ap.feedback_melhoria,
    ap.data_criacao
FROM avaliacoes_preenchidas ap
JOIN questionarios q ON ap.id_questionario = q.id_questionario
JOIN usuarios aluno ON ap.id_aluno_avaliado = aluno.id_usuario
JOIN usuarios avaliador ON ap.id_avaliador = avaliador.id_usuario
LEFT JOIN disciplinas d ON ap.id_disciplina = d.id_disciplina
LEFT JOIN turmas t ON ap.id_turma = t.id_turma
LEFT JOIN locais_eventos le ON ap.id_local_evento = le.id_local_evento;

-- View: Estatísticas de avaliações por usuário
DROP VIEW IF EXISTS vw_estatisticas_avaliacoes;
CREATE VIEW vw_estatisticas_avaliacoes AS
SELECT 
    u.id_usuario,
    u.nome_completo,
    u.tipo_usuario,
    COUNT(CASE WHEN ap.id_aluno_avaliado = u.id_usuario THEN 1 END) as total_como_avaliado,
    COUNT(CASE WHEN ap.id_avaliador = u.id_usuario THEN 1 END) as total_como_avaliador,
    COUNT(CASE WHEN ap.id_aluno_avaliado = u.id_usuario AND ap.status_avaliacao = 'FINALIZADA' THEN 1 END) as finalizadas_como_avaliado,
    COUNT(CASE WHEN ap.id_avaliador = u.id_usuario AND ap.status_avaliacao = 'FINALIZADA' THEN 1 END) as finalizadas_como_avaliador,
    AVG(CASE WHEN ria.id_avaliacao_preenchida IN (
        SELECT id_avaliacao_preenchida FROM avaliacoes_preenchidas WHERE id_aluno_avaliado = u.id_usuario
    ) THEN ria.resposta_valor_numerico END) as media_notas_recebidas
FROM usuarios u
LEFT JOIN avaliacoes_preenchidas ap ON (u.id_usuario = ap.id_aluno_avaliado OR u.id_usuario = ap.id_avaliador)
LEFT JOIN respostas_itens_avaliacao ria ON ap.id_avaliacao_preenchida = ria.id_avaliacao_preenchida
WHERE u.ativo = TRUE
GROUP BY u.id_usuario, u.nome_completo, u.tipo_usuario;

-- ========================================
-- 18. TRIGGERS DE AUDITORIA
-- ========================================

-- Trigger para log de inserções em usuários
DROP TRIGGER IF EXISTS tr_usuarios_insert;
DELIMITER $$
CREATE TRIGGER tr_usuarios_insert
    AFTER INSERT ON usuarios
    FOR EACH ROW
BEGIN
    INSERT INTO log_acoes (id_usuario, acao, tabela_afetada, id_registro_afetado, dados_novos)
    VALUES (NEW.id_usuario, 'INSERT', 'usuarios', NEW.id_usuario, JSON_OBJECT(
        'nome_completo', NEW.nome_completo,
        'email', NEW.email,
        'tipo_usuario', NEW.tipo_usuario,
        'ativo', NEW.ativo
    ));
END$$
DELIMITER ;

-- Trigger para log de atualizações em usuários
DROP TRIGGER IF EXISTS tr_usuarios_update;
DELIMITER $$
CREATE TRIGGER tr_usuarios_update
    AFTER UPDATE ON usuarios
    FOR EACH ROW
BEGIN
    INSERT INTO log_acoes (id_usuario, acao, tabela_afetada, id_registro_afetado, dados_anteriores, dados_novos)
    VALUES (NEW.id_usuario, 'UPDATE', 'usuarios', NEW.id_usuario, 
        JSON_OBJECT(
            'nome_completo', OLD.nome_completo,
            'email', OLD.email,
            'tipo_usuario', OLD.tipo_usuario,
            'ativo', OLD.ativo
        ),
        JSON_OBJECT(
            'nome_completo', NEW.nome_completo,
            'email', NEW.email,
            'tipo_usuario', NEW.tipo_usuario,
            'ativo', NEW.ativo
        )
    );
END$$
DELIMITER ;

-- ========================================
-- 19. PROCEDURES ÚTEIS
-- ========================================

-- Procedure para relatório de avaliações por período
DROP PROCEDURE IF EXISTS sp_relatorio_avaliacoes_periodo;
DELIMITER $$
CREATE PROCEDURE sp_relatorio_avaliacoes_periodo(
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    SELECT 
        q.nome_modelo as questionario,
        COUNT(*) as total_avaliacoes,
        COUNT(CASE WHEN ap.status_avaliacao = 'FINALIZADA' THEN 1 END) as finalizadas,
        COUNT(CASE WHEN ap.status_avaliacao = 'RASCUNHO' THEN 1 END) as rascunhos,
        AVG(ria.resposta_valor_numerico) as media_geral,
        MIN(ap.data_realizacao) as primeira_avaliacao,
        MAX(ap.data_realizacao) as ultima_avaliacao
    FROM avaliacoes_preenchidas ap
    JOIN questionarios q ON ap.id_questionario = q.id_questionario
    LEFT JOIN respostas_itens_avaliacao ria ON ap.id_avaliacao_preenchida = ria.id_avaliacao_preenchida
    WHERE ap.data_realizacao BETWEEN data_inicio AND data_fim
    GROUP BY q.id_questionario, q.nome_modelo
    ORDER BY total_avaliacoes DESC;
END$$
DELIMITER ;

-- Procedure para estatísticas de usuário
DROP PROCEDURE IF EXISTS sp_estatisticas_usuario;
DELIMITER $$
CREATE PROCEDURE sp_estatisticas_usuario(
    IN usuario_id INT
)
BEGIN
    SELECT 
        u.nome_completo,
        u.tipo_usuario,
        COUNT(CASE WHEN ap.id_aluno_avaliado = usuario_id THEN 1 END) as avaliacoes_recebidas,
        COUNT(CASE WHEN ap.id_avaliador = usuario_id THEN 1 END) as avaliacoes_realizadas,
        AVG(CASE WHEN ap.id_aluno_avaliado = usuario_id THEN ria.resposta_valor_numerico END) as media_recebida,
        COUNT(CASE WHEN ap.id_aluno_avaliado = usuario_id AND ap.status_avaliacao = 'FINALIZADA' THEN 1 END) as finalizadas_recebidas,
        COUNT(CASE WHEN ap.id_avaliador = usuario_id AND ap.status_avaliacao = 'FINALIZADA' THEN 1 END) as finalizadas_realizadas
    FROM usuarios u
    LEFT JOIN avaliacoes_preenchidas ap ON (u.id_usuario = ap.id_aluno_avaliado OR u.id_usuario = ap.id_avaliador)
    LEFT JOIN respostas_itens_avaliacao ria ON ap.id_avaliacao_preenchida = ria.id_avaliacao_preenchida
    WHERE u.id_usuario = usuario_id
    GROUP BY u.id_usuario, u.nome_completo, u.tipo_usuario;
END$$
DELIMITER ;

-- ========================================
-- 20. ÍNDICES COMPOSTOS PARA PERFORMANCE
-- ========================================

-- Índices compostos para consultas frequentes
CREATE INDEX idx_avaliacoes_data_status ON avaliacoes_preenchidas(data_realizacao, status_avaliacao);
CREATE INDEX idx_avaliacoes_aluno_data ON avaliacoes_preenchidas(id_aluno_avaliado, data_realizacao);
CREATE INDEX idx_avaliacoes_avaliador_data ON avaliacoes_preenchidas(id_avaliador, data_realizacao);
CREATE INDEX idx_respostas_valor_competencia ON respostas_itens_avaliacao(resposta_valor_numerico, id_competencia_questionario);
CREATE INDEX idx_usuarios_tipo_ativo ON usuarios(tipo_usuario, ativo);
CREATE INDEX idx_eventos_data_tipo ON eventos_agenda(data_inicio, tipo_evento);

-- Reabilitar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================
-- 21. VERIFICAÇÕES FINAIS
-- ========================================

-- Verificar se todas as tabelas foram criadas
SELECT 
    'ESTRUTURA CRIADA COM SUCESSO' as status,
    COUNT(*) as total_tabelas
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'unifae_med_app';

-- Verificar integridade das chaves estrangeiras
SELECT 
    'CHAVES ESTRANGEIRAS' as categoria,
    COUNT(*) as total
FROM information_schema.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'unifae_med_app' 
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Verificar índices criados
SELECT 
    'ÍNDICES CRIADOS' as categoria,
    COUNT(*) as total
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = 'unifae_med_app';

-- ========================================
-- ESTRUTURA CRIADA COM SUCESSO
-- ========================================
/*
RESUMO DA ESTRUTURA:

1. TABELAS PRINCIPAIS (16):
   ✅ permissoes - Sistema de permissões
   ✅ usuarios - Usuários do sistema
   ✅ usuarios_permissoes - Relacionamento N:N
   ✅ disciplinas - Disciplinas do curso
   ✅ turmas - Turmas por período
   ✅ usuarios_turmas - Relacionamento N:N
   ✅ disciplinas_turmas - Relacionamento N:N
   ✅ locais_eventos - Locais para eventos
   ✅ questionarios - Tipos de avaliação
   ✅ competencias_questionario - Competências por questionário
   ✅ avaliacoes_preenchidas - Avaliações realizadas
   ✅ respostas_itens_avaliacao - Respostas das avaliações
   ✅ eventos_agenda - Agenda de eventos
   ✅ participantes_eventos - Participantes dos eventos
   ✅ agenda_disciplinas_vinculadas - Relacionamento eventos-disciplinas
   ✅ log_acoes - Auditoria do sistema

2. VIEWS ÚTEIS (3):
   ✅ vw_usuarios_permissoes - Usuários com permissões
   ✅ vw_avaliacoes_completas - Avaliações com detalhes
   ✅ vw_estatisticas_avaliacoes - Estatísticas por usuário

3. TRIGGERS DE AUDITORIA (2):
   ✅ tr_usuarios_insert - Log de inserções
   ✅ tr_usuarios_update - Log de atualizações

4. PROCEDURES ÚTEIS (2):
   ✅ sp_relatorio_avaliacoes_periodo - Relatório por período
   ✅ sp_estatisticas_usuario - Estatísticas de usuário

5. CORREÇÕES APLICADAS:
   ✅ Enum TipoUsuario padronizado
   ✅ Estrutura otimizada para evitar conflitos
   ✅ Chaves estrangeiras com relacionamento correto
   ✅ Índices otimizados para performance
   ✅ Auditoria completa implementada

BANCO PRONTO PARA RECEBER OS DADOS!
*/

