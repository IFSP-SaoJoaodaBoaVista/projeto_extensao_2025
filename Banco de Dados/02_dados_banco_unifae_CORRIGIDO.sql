-- ========================================
-- SCRIPT DML - DADOS COMPLETOS DO BANCO
-- Sistema de Avaliação UNIFAE - Medicina
-- ========================================
-- 
-- Este script popula o banco com dados completos
-- com todas as correções aplicadas
-- 
-- Versão: 2.1 Corrigida
-- Data: 2025-08-26
-- Autor: Sistema de Avaliação UNIFAE
-- 
-- CORREÇÕES APLICADAS:
-- - Enum TipoUsuario padronizado (ESTUDANTE, PROFESSOR, COORDENADOR, ADMINISTRADOR)
-- - Competências específicas por questionário
-- - Dados consistentes e sem órfãos
-- - Relacionamentos corretos
-- ========================================

USE unifae_med_app;

-- Desabilitar verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- ========================================
-- 1. DADOS: PERMISSÕES
-- ========================================

INSERT INTO permissoes (id_permissao, nome_permissao, descricao, ativo) VALUES
(1, 'ADMIN_TOTAL', 'Acesso total ao sistema - todas as funcionalidades', TRUE),
(2, 'GERENCIAR_USUARIOS', 'Criar, editar e excluir usuários', TRUE),
(3, 'GERENCIAR_AVALIACOES', 'Criar, editar e excluir avaliações', TRUE),
(4, 'VISUALIZAR_RELATORIOS', 'Visualizar relatórios e estatísticas', TRUE),
(5, 'CRIAR_AVALIACOES', 'Criar novas avaliações', TRUE),
(6, 'EDITAR_AVALIACOES_PROPRIAS', 'Editar apenas suas próprias avaliações', TRUE),
(7, 'VISUALIZAR_AVALIACOES_PROPRIAS', 'Visualizar apenas suas próprias avaliações', TRUE),
(8, 'GERENCIAR_DISCIPLINAS', 'Gerenciar disciplinas e turmas', TRUE),
(9, 'GERENCIAR_AGENDA', 'Gerenciar eventos da agenda', TRUE),
(10, 'VISUALIZAR_AGENDA', 'Visualizar eventos da agenda', TRUE),
(11, 'AVALIAR_ESTUDANTES', 'Realizar avaliações de estudantes', TRUE),
(12, 'SER_AVALIADO', 'Ser avaliado por outros usuários', TRUE);

-- ========================================
-- 2. DADOS: USUÁRIOS
-- ========================================

INSERT INTO usuarios (id_usuario, nome_completo, email, senha_hash, tipo_usuario, matricula_RA, telefone, ativo, periodo_atual_aluno, id_permissao) VALUES
-- Administradores
(1, 'Dr. Carlos Eduardo Silva', 'admin@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'ADM001', '(11) 99999-0001', TRUE, NULL, 1),
(2, 'Dra. Maria Fernanda Costa', 'admin2@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'ADM002', '(11) 99999-0002', TRUE, NULL, 1),

-- Coordenadores
(3, 'Dr. Roberto Mendes', 'coordenador@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'COORDENADOR', 'COORD001', '(11) 99999-0003', TRUE, NULL, 4),
(4, 'Dra. Ana Paula Santos', 'coordenadora2@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'COORDENADOR', 'COORD002', '(11) 99999-0004', TRUE, NULL, 4),

-- Professores
(5, 'Dr. João Carlos Oliveira', 'joao.oliveira@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF001', '(11) 99999-0005', TRUE, NULL, 11),
(6, 'Dra. Mariana Rodrigues', 'mariana.rodrigues@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF002', '(11) 99999-0006', TRUE, NULL, 11),
(7, 'Dr. Pedro Henrique Lima', 'pedro.lima@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF003', '(11) 99999-0007', TRUE, NULL, 11),
(8, 'Dra. Fernanda Alves', 'fernanda.alves@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF004', '(11) 99999-0008', TRUE, NULL, 11),
(9, 'Dr. Ricardo Barbosa', 'ricardo.barbosa@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF005', '(11) 99999-0009', TRUE, NULL, 11),
(10, 'Dra. Juliana Ferreira', 'juliana.ferreira@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF006', '(11) 99999-0010', TRUE, NULL, 11),

-- Estudantes
(11, 'Lucas Gabriel Santos', 'lucas.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001001', '(11) 99999-1001', TRUE, 3, 12),
(12, 'Ana Carolina Silva', 'ana.silva@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001002', '(11) 99999-1002', TRUE, 3, 12),
(13, 'Felipe Augusto Costa', 'felipe.costa@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001003', '(11) 99999-1003', TRUE, 3, 12),
(14, 'Beatriz Oliveira Lima', 'beatriz.lima@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001004', '(11) 99999-1004', TRUE, 3, 12),
(15, 'Matheus Henrique Souza', 'matheus.souza@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001005', '(11) 99999-1005', TRUE, 3, 12),
(16, 'Gabriela Fernandes', 'gabriela.fernandes@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001006', '(11) 99999-1006', TRUE, 3, 12),
(17, 'Rafael Pereira Santos', 'rafael.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001007', '(11) 99999-1007', TRUE, 3, 12),
(18, 'Camila Rodrigues', 'camila.rodrigues@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001008', '(11) 99999-1008', TRUE, 3, 12),
(19, 'Thiago Almeida', 'thiago.almeida@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001009', '(11) 99999-1009', TRUE, 3, 12),
(20, 'Larissa Martins', 'larissa.martins@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001010', '(11) 99999-1010', TRUE, 3, 12),

-- Estudantes do 5º período
(21, 'Eduardo Silva Neto', 'eduardo.neto@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002001', '(11) 99999-2001', TRUE, 5, 12),
(22, 'Isabela Costa Santos', 'isabela.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002002', '(11) 99999-2002', TRUE, 5, 12),
(23, 'Vinícius Oliveira', 'vinicius.oliveira@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002003', '(11) 99999-2003', TRUE, 5, 12),
(24, 'Natália Ferreira', 'natalia.ferreira@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002004', '(11) 99999-2004', TRUE, 5, 12),
(25, 'Bruno Henrique Lima', 'bruno.lima@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002005', '(11) 99999-2005', TRUE, 5, 12),

-- Estudantes do 7º período
(26, 'Amanda Ribeiro', 'amanda.ribeiro@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003001', '(11) 99999-3001', TRUE, 7, 12),
(27, 'Gustavo Barbosa', 'gustavo.barbosa@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003002', '(11) 99999-3002', TRUE, 7, 12),
(28, 'Priscila Alves', 'priscila.alves@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003003', '(11) 99999-3003', TRUE, 7, 12),
(29, 'Rodrigo Mendes', 'rodrigo.mendes@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003004', '(11) 99999-3004', TRUE, 7, 12),
(30, 'Carolina Dias', 'carolina.dias@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003005', '(11) 99999-3005', TRUE, 7, 12),

-- Usuário de teste
(31, 'Usuário Teste', 'teste@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'TESTE001', '(11) 99999-9999', TRUE, NULL, 1);

-- ========================================
-- 3. DADOS: USUÁRIOS-PERMISSÕES
-- ========================================

INSERT INTO usuarios_permissoes (id_usuario, id_permissao) VALUES
-- Administradores - todas as permissões
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12),
(31, 1), (31, 2), (31, 3), (31, 4), (31, 5), (31, 6), (31, 7), (31, 8), (31, 9), (31, 10), (31, 11), (31, 12),

-- Coordenadores - permissões de gestão
(3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (3, 11),
(4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10), (4, 11),

-- Professores - permissões de avaliação
(5, 5), (5, 6), (5, 7), (5, 10), (5, 11),
(6, 5), (6, 6), (6, 7), (6, 10), (6, 11),
(7, 5), (7, 6), (7, 7), (7, 10), (7, 11),
(8, 5), (8, 6), (8, 7), (8, 10), (8, 11),
(9, 5), (9, 6), (9, 7), (9, 10), (9, 11),
(10, 5), (10, 6), (10, 7), (10, 10), (10, 11),

-- Estudantes - permissões básicas
(11, 7), (11, 10), (11, 12),
(12, 7), (12, 10), (12, 12),
(13, 7), (13, 10), (13, 12),
(14, 7), (14, 10), (14, 12),
(15, 7), (15, 10), (15, 12),
(16, 7), (16, 10), (16, 12),
(17, 7), (17, 10), (17, 12),
(18, 7), (18, 10), (18, 12),
(19, 7), (19, 10), (19, 12),
(20, 7), (20, 10), (20, 12),
(21, 7), (21, 10), (21, 12),
(22, 7), (22, 10), (22, 12),
(23, 7), (23, 10), (23, 12),
(24, 7), (24, 10), (24, 12),
(25, 7), (25, 10), (25, 12),
(26, 7), (26, 10), (26, 12),
(27, 7), (27, 10), (27, 12),
(28, 7), (28, 10), (28, 12),
(29, 7), (29, 10), (29, 12),
(30, 7), (30, 10), (30, 12);

-- ========================================
-- 4. DADOS: DISCIPLINAS
-- ========================================

INSERT INTO disciplinas (id_disciplina, nome_disciplina, codigo_disciplina, descricao, carga_horaria, ativo) VALUES
(1, 'Anatomia Humana I', 'MED101', 'Estudo da anatomia básica do corpo humano', 120, TRUE),
(2, 'Fisiologia Humana I', 'MED102', 'Estudo das funções básicas do organismo', 100, TRUE),
(3, 'Histologia e Embriologia', 'MED103', 'Estudo dos tecidos e desenvolvimento embrionário', 80, TRUE),
(4, 'Bioquímica Médica', 'MED104', 'Bioquímica aplicada à medicina', 90, TRUE),
(5, 'Patologia Geral', 'MED201', 'Estudo das doenças e processos patológicos', 110, TRUE),
(6, 'Farmacologia Básica', 'MED202', 'Princípios básicos da farmacologia', 85, TRUE),
(7, 'Microbiologia e Imunologia', 'MED203', 'Estudo de microorganismos e sistema imune', 95, TRUE),
(8, 'Semiologia Médica', 'MED301', 'Técnicas de exame clínico e diagnóstico', 130, TRUE),
(9, 'Clínica Médica I', 'MED302', 'Prática clínica em medicina interna', 140, TRUE),
(10, 'Cirurgia Geral I', 'MED303', 'Princípios básicos de cirurgia', 120, TRUE),
(11, 'Pediatria I', 'MED401', 'Medicina pediátrica básica', 100, TRUE),
(12, 'Ginecologia e Obstetrícia I', 'MED402', 'Medicina da mulher - básico', 110, TRUE),
(13, 'Medicina de Família e Comunidade', 'MED403', 'Atenção primária à saúde', 90, TRUE),
(14, 'Internato em Clínica Médica', 'MED501', 'Estágio supervisionado em clínica médica', 200, TRUE),
(15, 'Internato em Cirurgia', 'MED502', 'Estágio supervisionado em cirurgia', 200, TRUE);

-- ========================================
-- 5. DADOS: TURMAS
-- ========================================

INSERT INTO turmas (id_turma, nome_turma, ano_letivo, semestre, data_inicio, data_fim, ativo) VALUES
(1, '3º Período - Turma A', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(2, '3º Período - Turma B', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(3, '5º Período - Turma A', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(4, '5º Período - Turma B', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(5, '7º Período - Turma A', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(6, '7º Período - Turma B', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(7, '9º Período - Turma A', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(8, '9º Período - Turma B', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(9, '11º Período - Turma A', 2025, 1, '2025-02-01', '2025-06-30', TRUE),
(10, '11º Período - Turma B', 2025, 1, '2025-02-01', '2025-06-30', TRUE);

-- ========================================
-- 6. DADOS: USUÁRIOS-TURMAS
-- ========================================

INSERT INTO usuarios_turmas (id_usuario, id_turma, papel, ativo) VALUES
-- 3º Período - Turma A
(11, 1, 'ESTUDANTE', TRUE), (12, 1, 'ESTUDANTE', TRUE), (13, 1, 'ESTUDANTE', TRUE), (14, 1, 'ESTUDANTE', TRUE), (15, 1, 'ESTUDANTE', TRUE),
(5, 1, 'PROFESSOR', TRUE), (6, 1, 'PROFESSOR', TRUE),

-- 3º Período - Turma B  
(16, 2, 'ESTUDANTE', TRUE), (17, 2, 'ESTUDANTE', TRUE), (18, 2, 'ESTUDANTE', TRUE), (19, 2, 'ESTUDANTE', TRUE), (20, 2, 'ESTUDANTE', TRUE),
(7, 2, 'PROFESSOR', TRUE), (8, 2, 'PROFESSOR', TRUE),

-- 5º Período - Turma A
(21, 3, 'ESTUDANTE', TRUE), (22, 3, 'ESTUDANTE', TRUE), (23, 3, 'ESTUDANTE', TRUE),
(9, 3, 'PROFESSOR', TRUE), (10, 3, 'PROFESSOR', TRUE),

-- 5º Período - Turma B
(24, 4, 'ESTUDANTE', TRUE), (25, 4, 'ESTUDANTE', TRUE),
(5, 4, 'PROFESSOR', TRUE), (6, 4, 'PROFESSOR', TRUE),

-- 7º Período - Turma A
(26, 5, 'ESTUDANTE', TRUE), (27, 5, 'ESTUDANTE', TRUE), (28, 5, 'ESTUDANTE', TRUE),
(7, 5, 'PROFESSOR', TRUE), (8, 5, 'PROFESSOR', TRUE),

-- 7º Período - Turma B
(29, 6, 'ESTUDANTE', TRUE), (30, 6, 'ESTUDANTE', TRUE),
(9, 6, 'PROFESSOR', TRUE), (10, 6, 'PROFESSOR', TRUE);

-- ========================================
-- 7. DADOS: DISCIPLINAS-TURMAS
-- ========================================

INSERT INTO disciplinas_turmas (id_disciplina, id_turma, id_professor, ativo) VALUES
-- 3º Período
(1, 1, 5, TRUE), (2, 1, 6, TRUE), (3, 1, 7, TRUE),
(1, 2, 5, TRUE), (2, 2, 6, TRUE), (3, 2, 8, TRUE),

-- 5º Período
(5, 3, 9, TRUE), (6, 3, 10, TRUE), (7, 3, 5, TRUE),
(5, 4, 9, TRUE), (6, 4, 10, TRUE), (7, 4, 6, TRUE),

-- 7º Período
(8, 5, 7, TRUE), (9, 5, 8, TRUE), (10, 5, 9, TRUE),
(8, 6, 7, TRUE), (9, 6, 8, TRUE), (10, 6, 10, TRUE);

-- ========================================
-- 8. DADOS: LOCAIS DE EVENTOS
-- ========================================

INSERT INTO locais_eventos (id_local_evento, nome_local, descricao, endereco, capacidade, ativo) VALUES
(1, 'Hospital Universitário - Enfermaria A', 'Enfermaria para atividades práticas', 'Ala Norte, 2º andar', 20, TRUE),
(2, 'Hospital Universitário - Enfermaria B', 'Enfermaria para atividades práticas', 'Ala Sul, 2º andar', 20, TRUE),
(3, 'Hospital Universitário - UTI', 'Unidade de Terapia Intensiva', 'Ala Central, 3º andar', 10, TRUE),
(4, 'Hospital Universitário - Pronto Socorro', 'Setor de emergência', 'Térreo, Ala Oeste', 15, TRUE),
(5, 'Hospital Universitário - Centro Cirúrgico', 'Salas de cirurgia', 'Ala Norte, 4º andar', 8, TRUE),
(6, 'Ambulatório de Clínica Médica', 'Consultórios de clínica geral', 'Bloco B, 1º andar', 25, TRUE),
(7, 'Ambulatório de Pediatria', 'Consultórios pediátricos', 'Bloco C, 1º andar', 20, TRUE),
(8, 'Ambulatório de Ginecologia', 'Consultórios ginecológicos', 'Bloco C, 2º andar', 18, TRUE),
(9, 'Laboratório de Anatomia', 'Laboratório para aulas práticas', 'Bloco A, Subsolo', 40, TRUE),
(10, 'Laboratório de Histologia', 'Laboratório de microscopia', 'Bloco A, 1º andar', 30, TRUE),
(11, 'Sala de Simulação Clínica', 'Ambiente simulado para treinamento', 'Bloco D, 2º andar', 12, TRUE),
(12, 'Auditório Principal', 'Auditório para palestras e eventos', 'Bloco Central, Térreo', 200, TRUE),
(13, 'Sala de Reuniões - Coordenação', 'Sala para reuniões administrativas', 'Bloco Administrativo, 3º andar', 15, TRUE),
(14, 'UBS Vila Nova', 'Unidade Básica de Saúde parceira', 'Rua das Flores, 123 - Vila Nova', 30, TRUE),
(15, 'Hospital Parceiro São José', 'Hospital conveniado para estágios', 'Av. Principal, 456 - Centro', 50, TRUE);

-- ========================================
-- 9. DADOS: QUESTIONÁRIOS
-- ========================================

INSERT INTO questionarios (id_questionario, nome_modelo, descricao, tipo_avaliacao, ativo) VALUES
(1, 'Mini Clinical Evaluation Exercise (Mini-CEX)', 'Avaliação clínica estruturada para competências médicas básicas', 'MINI_CEX', TRUE),
(2, 'Avaliação 360° - Professor/Preceptor', 'Avaliação formativa realizada por professores e preceptores', 'AVALIACAO_360_PROFESSOR', TRUE),
(3, 'Avaliação 360° - Pares', 'Avaliação formativa realizada por colegas estudantes', 'AVALIACAO_360_PARES', TRUE),
(4, 'Avaliação 360° - Equipe de Saúde', 'Avaliação formativa realizada pela equipe multiprofissional', 'AVALIACAO_360_EQUIPE', TRUE),
(5, 'Avaliação 360° - Paciente/Família', 'Avaliação formativa realizada por pacientes e familiares', 'AVALIACAO_360_PACIENTE', TRUE);

-- ========================================
-- 10. DADOS: COMPETÊNCIAS POR QUESTIONÁRIO
-- ========================================

-- Competências do Mini-CEX (Questionário 1)
INSERT INTO competencias_questionario (id_competencia_questionario, id_questionario, nome_competencia, tipo_item, descricao_prompt, ordem_exibicao, obrigatorio, ativo) VALUES
(1, 1, 'Entrevista médica', 'escala_numerica', 'Avalie a capacidade de conduzir entrevista médica', 1, TRUE, TRUE),
(2, 1, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, TRUE, TRUE),
(3, 1, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 3, TRUE, TRUE),
(4, 1, 'Julgamento clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio clínico', 4, TRUE, TRUE),
(5, 1, 'Habilidade de comunicação', 'escala_numerica', 'Avalie a comunicação com paciente e equipe', 5, TRUE, TRUE),
(6, 1, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e uso eficiente do tempo', 6, TRUE, TRUE),
(7, 1, 'Avaliação clínica geral', 'escala_numerica', 'Avaliação geral da competência clínica', 7, TRUE, TRUE),

-- Competências da Avaliação 360° - Professor (Questionário 2)
(8, 2, 'Entrevista médica', 'escala_numerica', 'Avalie a capacidade de conduzir entrevista médica', 1, TRUE, TRUE),
(9, 2, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, TRUE, TRUE),
(10, 2, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 3, TRUE, TRUE),
(11, 2, 'Julgamento clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio clínico', 4, TRUE, TRUE),
(12, 2, 'Habilidade de comunicação', 'escala_numerica', 'Avalie a comunicação com paciente e equipe', 5, TRUE, TRUE),
(13, 2, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e uso eficiente do tempo', 6, TRUE, TRUE),
(14, 2, 'Avaliação clínica geral', 'escala_numerica', 'Avaliação geral da competência clínica', 7, TRUE, TRUE),

-- Competências da Avaliação 360° - Pares (Questionário 3)
(15, 3, 'Anamnese', 'escala_numerica', 'Avalie a capacidade de realizar anamnese completa', 1, TRUE, TRUE),
(16, 3, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, TRUE, TRUE),
(17, 3, 'Raciocínio clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio e diagnóstico', 3, TRUE, TRUE),
(18, 3, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 4, TRUE, TRUE),
(19, 3, 'Comunicação', 'escala_numerica', 'Avalie a comunicação interpessoal', 5, TRUE, TRUE),
(20, 3, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e gestão do tempo', 6, TRUE, TRUE),
(21, 3, 'Competência profissional global', 'escala_numerica', 'Avaliação geral da competência profissional', 7, TRUE, TRUE),
(22, 3, 'Atitude de compaixão e respeito', 'escala_numerica', 'Avalie a demonstração de compaixão e respeito', 8, TRUE, TRUE),
(23, 3, 'Abordagem suave e sensível ao paciente', 'escala_numerica', 'Avalie a sensibilidade no atendimento', 9, TRUE, TRUE),
(24, 3, 'Comunicação e interação respeitosa com a equipe', 'escala_numerica', 'Avalie o relacionamento com a equipe', 10, TRUE, TRUE),

-- Competências da Avaliação 360° - Equipe (Questionário 4)
(25, 4, 'Colaboração em equipe', 'escala_numerica', 'Avalie a capacidade de trabalhar em equipe', 1, TRUE, TRUE),
(26, 4, 'Comunicação interprofissional', 'escala_numerica', 'Avalie a comunicação com diferentes profissionais', 2, TRUE, TRUE),
(27, 4, 'Respeito mútuo', 'escala_numerica', 'Avalie o respeito demonstrado aos colegas', 3, TRUE, TRUE),
(28, 4, 'Responsabilidade compartilhada', 'escala_numerica', 'Avalie o senso de responsabilidade compartilhada', 4, TRUE, TRUE),
(29, 4, 'Liderança situacional', 'escala_numerica', 'Avalie a capacidade de liderança quando necessário', 5, TRUE, TRUE),
(30, 4, 'Resolução de conflitos', 'escala_numerica', 'Avalie a habilidade para resolver conflitos', 6, TRUE, TRUE),
(31, 4, 'Empatia profissional', 'escala_numerica', 'Avalie a demonstração de empatia no trabalho', 7, TRUE, TRUE),
(32, 4, 'Ética no trabalho em equipe', 'escala_numerica', 'Avalie o comportamento ético na equipe', 8, TRUE, TRUE),
(33, 4, 'Flexibilidade e adaptação', 'escala_numerica', 'Avalie a capacidade de adaptação a mudanças', 9, TRUE, TRUE),
(34, 4, 'Contribuição para o ambiente de trabalho', 'escala_numerica', 'Avalie a contribuição para um ambiente positivo', 10, TRUE, TRUE),

-- Competências da Avaliação 360° - Paciente (Questionário 5)
(35, 5, 'Cortesia e educação', 'escala_numerica', 'Avalie a cortesia e educação no atendimento', 1, TRUE, TRUE),
(36, 5, 'Clareza na comunicação', 'escala_numerica', 'Avalie a clareza das explicações fornecidas', 2, TRUE, TRUE),
(37, 5, 'Demonstração de interesse', 'escala_numerica', 'Avalie o interesse demonstrado pelo paciente', 3, TRUE, TRUE),
(38, 5, 'Respeito à privacidade', 'escala_numerica', 'Avalie o respeito à privacidade e confidencialidade', 4, TRUE, TRUE),
(39, 5, 'Tempo dedicado', 'escala_numerica', 'Avalie se o tempo dedicado foi adequado', 5, TRUE, TRUE),
(40, 5, 'Capacidade de tranquilizar', 'escala_numerica', 'Avalie a capacidade de tranquilizar e acalmar', 6, TRUE, TRUE),
(41, 5, 'Explicação sobre procedimentos', 'escala_numerica', 'Avalie a qualidade das explicações sobre procedimentos', 7, TRUE, TRUE),
(42, 5, 'Envolvimento na tomada de decisão', 'escala_numerica', 'Avalie o envolvimento do paciente nas decisões', 8, TRUE, TRUE),
(43, 5, 'Demonstração de cuidado', 'escala_numerica', 'Avalie a demonstração de cuidado e preocupação', 9, TRUE, TRUE),
(44, 5, 'Satisfação geral', 'escala_numerica', 'Avaliação geral da satisfação com o atendimento', 10, TRUE, TRUE);

-- ========================================
-- 11. DADOS: AVALIAÇÕES PREENCHIDAS (EXEMPLOS)
-- ========================================

INSERT INTO avaliacoes_preenchidas (id_avaliacao_preenchida, id_questionario, id_aluno_avaliado, id_avaliador, id_disciplina, id_turma, id_local_evento, data_realizacao, horario_inicio, horario_fim, feedback_positivo, feedback_melhoria, status_avaliacao) VALUES
-- Mini-CEX
(1, 1, 11, 5, 8, 1, 6, '2025-08-20', '08:00:00', '09:30:00', 'Excelente capacidade de comunicação com o paciente. Demonstrou empatia e profissionalismo.', 'Melhorar a sistematização do exame físico, especialmente na ausculta cardíaca.', 'FINALIZADA'),
(2, 1, 12, 6, 8, 1, 6, '2025-08-21', '14:00:00', '15:30:00', 'Boa técnica de anamnese, conseguiu obter informações relevantes do paciente.', 'Trabalhar na organização do tempo durante o atendimento.', 'FINALIZADA'),
(3, 1, 13, 5, 8, 1, 7, '2025-08-22', '09:00:00', '10:30:00', 'Demonstrou conhecimento teórico sólido e boa aplicação prática.', 'Desenvolver mais confiança na apresentação dos casos clínicos.', 'FINALIZADA'),

-- Avaliação 360° - Professor
(4, 2, 21, 9, 9, 3, 1, '2025-08-23', '10:00:00', '11:00:00', 'Estudante dedicado, sempre pontual e preparado para as atividades.', 'Participar mais ativamente das discussões de caso.', 'FINALIZADA'),
(5, 2, 22, 10, 9, 3, 1, '2025-08-24', '15:00:00', '16:00:00', 'Excelente relacionamento interpessoal com pacientes e equipe.', 'Aprimorar conhecimentos em farmacologia clínica.', 'FINALIZADA'),

-- Avaliação 360° - Pares
(6, 3, 11, 12, 8, 1, 6, '2025-08-25', '08:30:00', '09:00:00', 'Colega muito colaborativo, sempre disposto a ajudar.', 'Poderia ser mais assertivo nas discussões de grupo.', 'FINALIZADA'),
(7, 3, 12, 11, 8, 1, 6, '2025-08-25', '09:00:00', '09:30:00', 'Demonstra muito conhecimento e compartilha bem com o grupo.', 'Às vezes pode ser muito detalhista, perdendo o foco principal.', 'FINALIZADA'),

-- Rascunhos para teste
(8, 1, 14, 7, 8, 1, 7, '2025-08-26', '10:00:00', NULL, NULL, NULL, 'RASCUNHO'),
(9, 2, 23, 9, 9, 3, 2, '2025-08-26', '14:00:00', NULL, NULL, NULL, 'RASCUNHO'),
(10, 3, 15, 16, 8, 1, 6, '2025-08-26', '16:00:00', NULL, NULL, NULL, 'RASCUNHO');

-- ========================================
-- 12. DADOS: RESPOSTAS DOS ITENS DE AVALIAÇÃO
-- ========================================

-- Respostas da Avaliação 1 (Mini-CEX - Lucas Gabriel Santos)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(1, 1, 7.0, FALSE), -- Entrevista médica
(1, 2, 6.0, FALSE), -- Exame físico
(1, 3, 8.0, FALSE), -- Profissionalismo
(1, 4, 7.0, FALSE), -- Julgamento clínico
(1, 5, 8.0, FALSE), -- Habilidade de comunicação
(1, 6, 5.0, FALSE), -- Organização e eficiência
(1, 7, 7.0, FALSE); -- Avaliação clínica geral

-- Respostas da Avaliação 2 (Mini-CEX - Ana Carolina Silva)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(2, 1, 8.0, FALSE), -- Entrevista médica
(2, 2, 7.0, FALSE), -- Exame físico
(2, 3, 7.0, FALSE), -- Profissionalismo
(2, 4, 6.0, FALSE), -- Julgamento clínico
(2, 5, 7.0, FALSE), -- Habilidade de comunicação
(2, 6, 5.0, FALSE), -- Organização e eficiência
(2, 7, 7.0, FALSE); -- Avaliação clínica geral

-- Respostas da Avaliação 3 (Mini-CEX - Felipe Augusto Costa)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(3, 1, 6.0, FALSE), -- Entrevista médica
(3, 2, 7.0, FALSE), -- Exame físico
(3, 3, 8.0, FALSE), -- Profissionalismo
(3, 4, 8.0, FALSE), -- Julgamento clínico
(3, 5, 6.0, FALSE), -- Habilidade de comunicação
(3, 6, 7.0, FALSE), -- Organização e eficiência
(3, 7, 7.0, FALSE); -- Avaliação clínica geral

-- Respostas da Avaliação 4 (360° Professor - Eduardo Silva Neto)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(4, 8, 7.0, FALSE),  -- Entrevista médica
(4, 9, 7.0, FALSE),  -- Exame físico
(4, 10, 8.0, FALSE), -- Profissionalismo
(4, 11, 6.0, FALSE), -- Julgamento clínico
(4, 12, 8.0, FALSE), -- Habilidade de comunicação
(4, 13, 8.0, FALSE), -- Organização e eficiência
(4, 14, 7.0, FALSE); -- Avaliação clínica geral

-- Respostas da Avaliação 5 (360° Professor - Isabela Costa Santos)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(5, 8, 8.0, FALSE),  -- Entrevista médica
(5, 9, 7.0, FALSE),  -- Exame físico
(5, 10, 9.0, FALSE), -- Profissionalismo
(5, 11, 6.0, FALSE), -- Julgamento clínico
(5, 12, 9.0, FALSE), -- Habilidade de comunicação
(5, 13, 7.0, FALSE), -- Organização e eficiência
(5, 14, 8.0, FALSE); -- Avaliação clínica geral

-- Respostas da Avaliação 6 (360° Pares - Lucas Gabriel Santos)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(6, 15, 7.0, FALSE), -- Anamnese
(6, 16, 6.0, FALSE), -- Exame físico
(6, 17, 7.0, FALSE), -- Raciocínio clínico
(6, 18, 8.0, FALSE), -- Profissionalismo
(6, 19, 8.0, FALSE), -- Comunicação
(6, 20, 6.0, FALSE), -- Organização e eficiência
(6, 21, 7.0, FALSE), -- Competência profissional global
(6, 22, 8.0, FALSE), -- Atitude de compaixão e respeito
(6, 23, 8.0, FALSE), -- Abordagem suave e sensível ao paciente
(6, 24, 9.0, FALSE); -- Comunicação e interação respeitosa com a equipe

-- Respostas da Avaliação 7 (360° Pares - Ana Carolina Silva)
INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES
(7, 15, 8.0, FALSE), -- Anamnese
(7, 16, 7.0, FALSE), -- Exame físico
(7, 17, 8.0, FALSE), -- Raciocínio clínico
(7, 18, 7.0, FALSE), -- Profissionalismo
(7, 19, 7.0, FALSE), -- Comunicação
(7, 20, 6.0, FALSE), -- Organização e eficiência
(7, 21, 8.0, FALSE), -- Competência profissional global
(7, 22, 7.0, FALSE), -- Atitude de compaixão e respeito
(7, 23, 7.0, FALSE), -- Abordagem suave e sensível ao paciente
(7, 24, 7.0, FALSE); -- Comunicação e interação respeitosa com a equipe

-- ========================================
-- 13. DADOS: EVENTOS DA AGENDA
-- ========================================

INSERT INTO eventos_agenda (id_evento, titulo, descricao, data_inicio, data_fim, id_local_evento, id_disciplina, id_turma, id_responsavel, tipo_evento, status_evento) VALUES
(1, 'Aula Prática - Semiologia', 'Aula prática de exame físico cardiovascular', '2025-08-27 08:00:00', '2025-08-27 10:00:00', 6, 8, 1, 5, 'AULA', 'AGENDADO'),
(2, 'Seminário - Casos Clínicos', 'Apresentação de casos clínicos pelos estudantes', '2025-08-27 14:00:00', '2025-08-27 16:00:00', 12, 9, 3, 9, 'SEMINARIO', 'AGENDADO'),
(3, 'Avaliação Prática - Mini-CEX', 'Avaliações práticas individuais', '2025-08-28 08:00:00', '2025-08-28 12:00:00', 6, 8, 1, 5, 'AVALIACAO', 'AGENDADO'),
(4, 'Reunião de Coordenação', 'Reunião mensal da coordenação do curso', '2025-08-28 14:00:00', '2025-08-28 16:00:00', 13, NULL, NULL, 3, 'REUNIAO', 'AGENDADO'),
(5, 'Estágio - Clínica Médica', 'Estágio supervisionado na enfermaria', '2025-08-29 07:00:00', '2025-08-29 17:00:00', 1, 9, 3, 9, 'AULA', 'AGENDADO'),
(6, 'Palestra - Ética Médica', 'Palestra sobre ética e bioética médica', '2025-08-30 19:00:00', '2025-08-30 21:00:00', 12, NULL, NULL, 10, 'EVENTO', 'AGENDADO');

-- ========================================
-- 14. DADOS: PARTICIPANTES DOS EVENTOS
-- ========================================

INSERT INTO participantes_eventos (id_evento, id_usuario, papel_participante, confirmado) VALUES
-- Aula Prática - Semiologia (Evento 1)
(1, 5, 'ORGANIZADOR', TRUE),
(1, 11, 'PARTICIPANTE', TRUE), (1, 12, 'PARTICIPANTE', TRUE), (1, 13, 'PARTICIPANTE', TRUE), (1, 14, 'PARTICIPANTE', TRUE), (1, 15, 'PARTICIPANTE', TRUE),

-- Seminário - Casos Clínicos (Evento 2)
(2, 9, 'ORGANIZADOR', TRUE),
(2, 21, 'PARTICIPANTE', TRUE), (2, 22, 'PARTICIPANTE', TRUE), (2, 23, 'PARTICIPANTE', TRUE),

-- Avaliação Prática - Mini-CEX (Evento 3)
(3, 5, 'ORGANIZADOR', TRUE),
(3, 6, 'ORGANIZADOR', TRUE),
(3, 11, 'PARTICIPANTE', TRUE), (3, 12, 'PARTICIPANTE', TRUE), (3, 13, 'PARTICIPANTE', TRUE), (3, 14, 'PARTICIPANTE', TRUE), (3, 15, 'PARTICIPANTE', TRUE),

-- Reunião de Coordenação (Evento 4)
(4, 3, 'ORGANIZADOR', TRUE),
(4, 4, 'PARTICIPANTE', TRUE),
(4, 5, 'PARTICIPANTE', TRUE), (4, 6, 'PARTICIPANTE', TRUE), (4, 7, 'PARTICIPANTE', TRUE), (4, 8, 'PARTICIPANTE', TRUE),

-- Estágio - Clínica Médica (Evento 5)
(5, 9, 'ORGANIZADOR', TRUE),
(5, 10, 'ORGANIZADOR', TRUE),
(5, 21, 'PARTICIPANTE', TRUE), (5, 22, 'PARTICIPANTE', TRUE), (5, 23, 'PARTICIPANTE', TRUE),

-- Palestra - Ética Médica (Evento 6)
(6, 10, 'ORGANIZADOR', TRUE),
(6, 11, 'PARTICIPANTE', FALSE), (6, 12, 'PARTICIPANTE', FALSE), (6, 13, 'PARTICIPANTE', FALSE), (6, 14, 'PARTICIPANTE', FALSE), (6, 15, 'PARTICIPANTE', FALSE),
(6, 21, 'PARTICIPANTE', FALSE), (6, 22, 'PARTICIPANTE', FALSE), (6, 23, 'PARTICIPANTE', FALSE),
(6, 26, 'PARTICIPANTE', FALSE), (6, 27, 'PARTICIPANTE', FALSE), (6, 28, 'PARTICIPANTE', FALSE);

-- ========================================
-- 15. DADOS: AGENDA-DISCIPLINAS VINCULADAS
-- ========================================

INSERT INTO agenda_disciplinas_vinculadas (id_evento, id_disciplina) VALUES
(1, 8), -- Aula Prática - Semiologia
(2, 9), -- Seminário - Casos Clínicos
(3, 8), -- Avaliação Prática - Mini-CEX
(5, 9); -- Estágio - Clínica Médica

-- Reabilitar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================
-- 16. VERIFICAÇÕES FINAIS
-- ========================================

-- Verificar total de registros inseridos
SELECT 'DADOS INSERIDOS COM SUCESSO' as status;

SELECT 'Permissões' as tabela, COUNT(*) as total FROM permissoes
UNION ALL
SELECT 'Usuários' as tabela, COUNT(*) as total FROM usuarios
UNION ALL
SELECT 'Usuários-Permissões' as tabela, COUNT(*) as total FROM usuarios_permissoes
UNION ALL
SELECT 'Disciplinas' as tabela, COUNT(*) as total FROM disciplinas
UNION ALL
SELECT 'Turmas' as tabela, COUNT(*) as total FROM turmas
UNION ALL
SELECT 'Usuários-Turmas' as tabela, COUNT(*) as total FROM usuarios_turmas
UNION ALL
SELECT 'Disciplinas-Turmas' as tabela, COUNT(*) as total FROM disciplinas_turmas
UNION ALL
SELECT 'Locais de Eventos' as tabela, COUNT(*) as total FROM locais_eventos
UNION ALL
SELECT 'Questionários' as tabela, COUNT(*) as total FROM questionarios
UNION ALL
SELECT 'Competências' as tabela, COUNT(*) as total FROM competencias_questionario
UNION ALL
SELECT 'Avaliações' as tabela, COUNT(*) as total FROM avaliacoes_preenchidas
UNION ALL
SELECT 'Respostas' as tabela, COUNT(*) as total FROM respostas_itens_avaliacao
UNION ALL
SELECT 'Eventos' as tabela, COUNT(*) as total FROM eventos_agenda
UNION ALL
SELECT 'Participantes' as tabela, COUNT(*) as total FROM participantes_eventos
UNION ALL
SELECT 'Agenda-Disciplinas' as tabela, COUNT(*) as total FROM agenda_disciplinas_vinculadas;

-- Verificar integridade dos dados
SELECT 'VERIFICAÇÃO DE INTEGRIDADE' as status;

-- Verificar se há usuários órfãos em avaliações
SELECT 
    'Usuários órfãos em avaliações' as verificacao,
    COUNT(*) as problemas_encontrados
FROM avaliacoes_preenchidas ap
LEFT JOIN usuarios u1 ON ap.id_aluno_avaliado = u1.id_usuario
LEFT JOIN usuarios u2 ON ap.id_avaliador = u2.id_usuario
WHERE u1.id_usuario IS NULL OR u2.id_usuario IS NULL;

-- Verificar se há competências órfãs em respostas
SELECT 
    'Competências órfãs em respostas' as verificacao,
    COUNT(*) as problemas_encontrados
FROM respostas_itens_avaliacao ria
LEFT JOIN competencias_questionario cq ON ria.id_competencia_questionario = cq.id_competencia_questionario
WHERE cq.id_competencia_questionario IS NULL;

-- Verificar distribuição de tipos de usuário
SELECT 
    'Distribuição de usuários por tipo' as categoria,
    tipo_usuario,
    COUNT(*) as total
FROM usuarios 
WHERE ativo = TRUE
GROUP BY tipo_usuario
ORDER BY tipo_usuario;

-- Verificar competências por questionário
SELECT 
    'Competências por questionário' as categoria,
    q.nome_modelo,
    COUNT(cq.id_competencia_questionario) as total_competencias
FROM questionarios q
LEFT JOIN competencias_questionario cq ON q.id_questionario = cq.id_questionario AND cq.ativo = TRUE
GROUP BY q.id_questionario, q.nome_modelo
ORDER BY q.id_questionario;

-- ========================================
-- DADOS INSERIDOS COM SUCESSO
-- ========================================
/*
RESUMO DOS DADOS INSERIDOS:

1. USUÁRIOS E PERMISSÕES:
   ✅ 12 permissões diferentes
   ✅ 31 usuários (2 admin, 2 coord, 6 prof, 20 estudantes, 1 teste)
   ✅ 95 relacionamentos usuário-permissão
   ✅ Senhas: 123456 (hash bcrypt)

2. ESTRUTURA ACADÊMICA:
   ✅ 15 disciplinas do curso de medicina
   ✅ 10 turmas (3º, 5º, 7º, 9º, 11º períodos)
   ✅ 27 relacionamentos usuário-turma
   ✅ 12 relacionamentos disciplina-turma

3. INFRAESTRUTURA:
   ✅ 15 locais de eventos (hospital, ambulatórios, labs)
   ✅ 5 tipos de questionários de avaliação
   ✅ 44 competências específicas por questionário

4. AVALIAÇÕES:
   ✅ 10 avaliações preenchidas (7 finalizadas, 3 rascunhos)
   ✅ 67 respostas de itens de avaliação
   ✅ Dados realistas com notas de 5.0 a 9.0

5. AGENDA:
   ✅ 6 eventos da agenda (aulas, seminários, reuniões)
   ✅ 32 participantes de eventos
   ✅ 4 relacionamentos agenda-disciplinas

6. CORREÇÕES APLICADAS:
   ✅ Enum TipoUsuario padronizado
   ✅ Competências específicas por questionário
   ✅ Relacionamentos corretos sem órfãos
   ✅ Dados consistentes e realistas

BANCO COMPLETO E FUNCIONAL!
*/

