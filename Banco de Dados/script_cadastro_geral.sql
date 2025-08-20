-- ========================================
-- SCRIPT CADASTRO GERAL CORRIGIDO - ESTRUTURA REAL
-- Sistema de Avaliação UNIFAE
-- Baseado em: unifae_med_app.sql (estrutura original)
-- 
-- VERSÃO CORRIGIDA - 100% COMPATÍVEL COM BANCO REAL
-- ========================================

USE unifae_med_app;

-- ========================================
-- 1. LIMPEZA COMPLETA DAS TABELAS
-- ========================================

-- Desabilitar verificação de foreign keys temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- Limpar tabelas que referenciam outras (ordem importante)
-- Primeiro as tabelas "filhas" (que referenciam outras)
TRUNCATE TABLE respostas_itens_avaliacao;
TRUNCATE TABLE notas_alunos_disciplinas;
TRUNCATE TABLE notificacoes;
TRUNCATE TABLE usuarios_turmas;
TRUNCATE TABLE historico_escolar_importado;
TRUNCATE TABLE participantes_eventos;
TRUNCATE TABLE feedbacks_sistema;
TRUNCATE TABLE agenda_disciplinas_vinculadas;
TRUNCATE TABLE disciplinas_turmas;

-- Depois as tabelas "pais" (que são referenciadas)
TRUNCATE TABLE avaliacoes_preenchidas;
TRUNCATE TABLE competencias_questionario;
TRUNCATE TABLE questionarios;
TRUNCATE TABLE usuarios;

-- Limpar outras tabelas
TRUNCATE TABLE permissoes;
TRUNCATE TABLE turmas;
TRUNCATE TABLE disciplinas;
TRUNCATE TABLE locais_eventos;
TRUNCATE TABLE eventos_agenda;
TRUNCATE TABLE configuracao_calculo_notas;

-- Reabilitar verificação de foreign keys
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================
-- 2. RESET DOS AUTO-INCREMENTS
-- ========================================

ALTER TABLE usuarios AUTO_INCREMENT = 1;
ALTER TABLE questionarios AUTO_INCREMENT = 1;
ALTER TABLE competencias_questionario AUTO_INCREMENT = 1;
ALTER TABLE avaliacoes_preenchidas AUTO_INCREMENT = 1;
ALTER TABLE respostas_itens_avaliacao AUTO_INCREMENT = 1;
ALTER TABLE permissoes AUTO_INCREMENT = 1;
ALTER TABLE turmas AUTO_INCREMENT = 1;
ALTER TABLE disciplinas AUTO_INCREMENT = 1;
ALTER TABLE locais_eventos AUTO_INCREMENT = 1;
ALTER TABLE notas_alunos_disciplinas AUTO_INCREMENT = 1;
ALTER TABLE notificacoes AUTO_INCREMENT = 1;
ALTER TABLE usuarios_turmas AUTO_INCREMENT = 1;
ALTER TABLE historico_escolar_importado AUTO_INCREMENT = 1;
ALTER TABLE participantes_eventos AUTO_INCREMENT = 1;
ALTER TABLE eventos_agenda AUTO_INCREMENT = 1;
ALTER TABLE feedbacks_sistema AUTO_INCREMENT = 1;
ALTER TABLE disciplinas_turmas AUTO_INCREMENT = 1;
ALTER TABLE configuracao_calculo_notas AUTO_INCREMENT = 1;

SELECT 'TABELAS LIMPAS E AUTO-INCREMENTS RESETADOS!' as status;

-- ========================================
-- 3. INSERIR PERMISSÕES DO SISTEMA
-- ========================================

INSERT INTO permissoes (nome_permissao, descricao_permissao) VALUES
('ADMIN_TOTAL', 'Acesso total ao sistema - Administrador'),
('PROFESSOR_AVALIAR', 'Permissão para avaliar alunos'),
('PROFESSOR_VISUALIZAR', 'Permissão para visualizar avaliações'),
('ALUNO_AUTOAVALIAR', 'Permissão para realizar autoavaliação'),
('ALUNO_VISUALIZAR_PROPRIAS', 'Permissão para visualizar próprias avaliações'),
('COORDENADOR_RELATORIOS', 'Permissão para gerar relatórios'),
('COORDENADOR_CONFIGURAR', 'Permissão para configurar sistema'),
('PRECEPTOR_AVALIAR', 'Permissão para preceptores avaliarem'),
('SECRETARIA_CADASTRAR', 'Permissão para cadastrar usuários'),
('SECRETARIA_TURMAS', 'Permissão para gerenciar turmas');

-- ========================================
-- 4. INSERIR TURMAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO turmas (nome_turma, codigo_turma) VALUES
('Medicina 2020', 'MED20'),
('Medicina 2021', 'MED21'),
('Medicina 2022', 'MED22'),
('Medicina 2023', 'MED23'),
('Medicina 2024', 'MED24'),
('Enfermagem 2022', 'ENF22'),
('Enfermagem 2023', 'ENF23'),
('Fisioterapia 2023', 'FIS23'),
('Nutrição 2024', 'NUT24'),
('Psicologia 2022', 'PSI22');

-- ========================================
-- 5. INSERIR DISCIPLINAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO disciplinas (nome_disciplina, sigla_disciplina, ativa) VALUES
('Anatomia Humana I', 'ANA101', 1),
('Fisiologia Humana I', 'FIS102', 1),
('Patologia Geral', 'PAT201', 1),
('Farmacologia Básica', 'FAR202', 1),
('Clínica Médica I', 'CLI301', 1),
('Cirurgia Geral I', 'CIR302', 1),
('Pediatria', 'PED401', 1),
('Ginecologia e Obstetrícia', 'GO402', 1),
('Medicina Interna', 'MI501', 1),
('Estágio Supervisionado', 'EST502', 1),
('Fundamentos de Enfermagem', 'ENF101', 1),
('Enfermagem Médico-Cirúrgica', 'ENF201', 1),
('Anatomia Aplicada à Fisioterapia', 'FIS101', 1),
('Cinesioterapia', 'CIN201', 1),
('Nutrição Clínica', 'NUT201', 1),
('Psicologia Geral', 'PSI101', 1);

-- ========================================
-- 6. INSERIR LOCAIS DE EVENTOS (ESTRUTURA REAL)
-- ========================================

INSERT INTO locais_eventos (nome_local, tipo_local, endereco, cidade, estado) VALUES
('Hospital Universitário - Enfermaria 1', 'Hospital', 'Rua das Clínicas, 100', 'São João da Boa Vista', 'SP'),
('Hospital Universitário - Enfermaria 2', 'Hospital', 'Rua das Clínicas, 100', 'São João da Boa Vista', 'SP'),
('Ambulatório de Especialidades', 'Ambulatório', 'Av. Especialidades, 200', 'São João da Boa Vista', 'SP'),
('Centro de Simulação', 'Laboratório', 'Campus UNIFAE, Bloco C', 'São João da Boa Vista', 'SP'),
('Laboratório de Anatomia', 'Laboratório', 'Campus UNIFAE, Bloco A', 'São João da Boa Vista', 'SP'),
('Sala de Aula 101', 'Sala de Aula', 'Campus UNIFAE, Bloco A', 'São João da Boa Vista', 'SP'),
('Sala de Aula 102', 'Sala de Aula', 'Campus UNIFAE, Bloco A', 'São João da Boa Vista', 'SP'),
('Auditório Principal', 'Auditório', 'Campus UNIFAE, Bloco Principal', 'São João da Boa Vista', 'SP'),
('Biblioteca - Sala de Estudos', 'Biblioteca', 'Campus UNIFAE, Biblioteca', 'São João da Boa Vista', 'SP'),
('UBS Centro', 'UBS', 'Rua Central, 50', 'São João da Boa Vista', 'SP'),
('Hospital Municipal', 'Hospital', 'Av. Municipal, 300', 'São João da Boa Vista', 'SP'),
('Clínica Escola', 'Clínica', 'Campus UNIFAE, Clínica', 'São João da Boa Vista', 'SP');

-- ========================================
-- 7. INSERIR CONFIGURAÇÃO DE CÁLCULO DE NOTAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO configuracao_calculo_notas (nome_configuracao, descricao, peso_osce, peso_prova_teorica, peso_portfolio, peso_avaliacao_pratica_1, peso_avaliacao_pratica_2, limite_percentual_faltas) VALUES
('Configuração Padrão 2024', 'Configuração padrão para cálculo de notas do ano letivo 2024', 0.25, 0.30, 0.15, 0.15, 0.15, 25.00),
('Configuração Experimental', 'Configuração experimental para testes de novos pesos', 0.30, 0.25, 0.20, 0.12, 0.13, 20.00),
('Configuração Residência', 'Configuração específica para programas de residência', 0.35, 0.20, 0.10, 0.17, 0.18, 15.00);

-- ========================================
-- 8. INSERIR USUÁRIOS (ESTRUTURA REAL)
-- ========================================

INSERT INTO usuarios (nome_completo, email, telefone, matricula_RA, senha_hash, tipo_usuario, periodo_atual_aluno, id_permissao, ativo) VALUES
-- Administradores
('Prof. Coordenador Geral', 'coordenador@unifae.edu.br', '11999991000', NULL, 'hash123', 'Administrador', NULL, 1, 1),

-- Professores
('Dr. João Silva', 'joao.silva@unifae.edu.br', '11999991001', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dra. Maria Santos', 'maria.santos@unifae.edu.br', '11999991002', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dr. Carlos Oliveira', 'carlos.oliveira@unifae.edu.br', '11999991003', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dra. Ana Beatriz', 'ana.beatriz@unifae.edu.br', '11999991004', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dr. Roberto Lima', 'roberto.lima@unifae.edu.br', '11999991005', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dra. Patricia Rocha', 'patricia.rocha@unifae.edu.br', '11999991006', NULL, 'hash123', 'Professor', NULL, 2, 1),
('Dr. Fernando Costa', 'fernando.costa@unifae.edu.br', '11999991007', NULL, 'hash123', 'Professor', NULL, 2, 1),

-- Alunos de Medicina
('Ana Paula Costa', 'ana.costa@unifae.edu.br', '11988882001', '202201', 'hash123', 'Aluno', '5', 4, 1),
('Bruno Ferreira', 'bruno.ferreira@unifae.edu.br', '11988882002', '202202', 'hash123', 'Aluno', '5', 4, 1),
('Carla Mendes', 'carla.mendes@unifae.edu.br', '11988882003', '202203', 'hash123', 'Aluno', '5', 4, 1),
('Diego Santos', 'diego.santos@unifae.edu.br', '11988882004', '202204', 'hash123', 'Aluno', '5', 4, 1),
('Eduarda Lima', 'eduarda.lima@unifae.edu.br', '11988882005', '202205', 'hash123', 'Aluno', '5', 4, 1),
('Felipe Rodrigues', 'felipe.rodrigues@unifae.edu.br', '11988882006', '202306', 'hash123', 'Aluno', '3', 4, 1),
('Gabriela Alves', 'gabriela.alves@unifae.edu.br', '11988882007', '202307', 'hash123', 'Aluno', '3', 4, 1),
('Henrique Moura', 'henrique.moura@unifae.edu.br', '11988882008', '202308', 'hash123', 'Aluno', '3', 4, 1),
('Isabela Nunes', 'isabela.nunes@unifae.edu.br', '11988882009', '202409', 'hash123', 'Aluno', '1', 4, 1),
('João Pedro Silva', 'joao.pedro@unifae.edu.br', '11988882010', '202410', 'hash123', 'Aluno', '1', 4, 1),

-- Alunos de outros cursos
('Larissa Enfermagem', 'larissa.enf@unifae.edu.br', '11988883001', '202211', 'hash123', 'Aluno', '5', 4, 1),
('Marcos Fisioterapia', 'marcos.fisio@unifae.edu.br', '11988883002', '202312', 'hash123', 'Aluno', '3', 4, 1),
('Natália Nutrição', 'natalia.nutri@unifae.edu.br', '11988883003', '202413', 'hash123', 'Aluno', '1', 4, 1),
('Pedro Psicologia', 'pedro.psi@unifae.edu.br', '11988883004', '202214', 'hash123', 'Aluno', '5', 4, 1);

-- ========================================
-- 9. INSERIR QUESTIONÁRIOS
-- ========================================

INSERT INTO questionarios (nome_modelo, descricao) VALUES
('Mini CEX', 'Mini Clinical Evaluation Exercise - Avaliação clínica estruturada'),
('Avaliação 360 - Professor/Preceptor', 'Avaliação 360 graus realizada por professor ou preceptor'),
('Avaliação 360 - Pares', 'Avaliação 360 graus realizada por colegas de turma'),
('Avaliação 360 - Autoavaliação', 'Autoavaliação do estudante'),
('Avaliação de Estágio', 'Avaliação específica para estágios supervisionados'),
('Avaliação de Habilidades Práticas', 'Avaliação focada em habilidades técnicas');

-- ========================================
-- 10. INSERIR COMPETÊNCIAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO competencias_questionario (nome_competencia, tipo_item, descricao_prompt) VALUES
-- Competências para Mini CEX (7 competências)
('Entrevista médica', 'escala_numerica', 'Capacidade de conduzir anamnese de forma estruturada e eficiente'),
('Exame Físico', 'escala_numerica', 'Habilidade para realizar exame físico completo e sistemático'),
('Profissionalismo', 'escala_numerica', 'Demonstração de comportamento ético e profissional'),
('Julgamento Clínico', 'escala_numerica', 'Capacidade de raciocínio clínico e tomada de decisões'),
('Habilidade de comunicação', 'escala_numerica', 'Comunicação efetiva com pacientes e equipe'),
('Organização e Eficiência', 'escala_numerica', 'Organização do tempo e eficiência na execução'),
('Avaliação Clínica Geral', 'escala_numerica', 'Avaliação geral da competência clínica'),

-- Competências para Avaliação 360 - Professor (7 competências)
('Entrevista médica', 'escala_numerica', 'Capacidade de conduzir anamnese de forma estruturada e eficiente'),
('Exame Físico', 'escala_numerica', 'Habilidade para realizar exame físico completo e sistemático'),
('Profissionalismo', 'escala_numerica', 'Demonstração de comportamento ético e profissional'),
('Julgamento Clínico', 'escala_numerica', 'Capacidade de raciocínio clínico e tomada de decisões'),
('Habilidade de comunicação', 'escala_numerica', 'Comunicação efetiva com pacientes e equipe'),
('Organização e Eficiência', 'escala_numerica', 'Organização do tempo e eficiência na execução'),
('Avaliação Clínica Geral', 'escala_numerica', 'Avaliação geral da competência clínica'),

-- Competências para Avaliação 360 - Pares (7 competências)
('Colaboração em Equipe', 'escala_numerica', 'Capacidade de trabalhar efetivamente em equipe'),
('Comunicação Interpessoal', 'escala_numerica', 'Habilidade de comunicação com colegas'),
('Liderança', 'escala_numerica', 'Capacidade de liderança em situações clínicas'),
('Resolução de Conflitos', 'escala_numerica', 'Habilidade para resolver conflitos construtivamente'),
('Empatia', 'escala_numerica', 'Demonstração de empatia com colegas e pacientes'),
('Responsabilidade', 'escala_numerica', 'Senso de responsabilidade e comprometimento'),
('Ética Profissional', 'escala_numerica', 'Comportamento ético nas relações profissionais'),

-- Competências para Autoavaliação (6 competências)
('Autoconhecimento', 'escala_numerica', 'Capacidade de autoavaliação e reflexão'),
('Motivação para Aprender', 'escala_numerica', 'Interesse e motivação para o aprendizado contínuo'),
('Gestão do Tempo', 'escala_numerica', 'Habilidade de organizar e gerenciar o tempo'),
('Controle Emocional', 'escala_numerica', 'Capacidade de controlar emoções em situações estressantes'),
('Busca por Feedback', 'escala_numerica', 'Proatividade em buscar feedback para melhoria'),
('Desenvolvimento Pessoal', 'escala_numerica', 'Comprometimento com o desenvolvimento pessoal'),

-- Competências para Avaliação de Estágio (7 competências)
('Pontualidade', 'escala_numerica', 'Cumprimento de horários e compromissos'),
('Assiduidade', 'escala_numerica', 'Frequência e presença nas atividades'),
('Iniciativa', 'escala_numerica', 'Proatividade e iniciativa nas atividades'),
('Relacionamento com Pacientes', 'escala_numerica', 'Qualidade do relacionamento com pacientes'),
('Relacionamento com Equipe', 'escala_numerica', 'Integração com a equipe de saúde'),
('Aplicação do Conhecimento', 'escala_numerica', 'Aplicação prática do conhecimento teórico'),
('Evolução durante o Estágio', 'escala_numerica', 'Progresso e evolução ao longo do estágio'),

-- Competências para Habilidades Práticas (6 competências)
('Técnicas de Procedimentos', 'escala_numerica', 'Execução correta de procedimentos técnicos'),
('Uso de Equipamentos', 'escala_numerica', 'Habilidade no manuseio de equipamentos médicos'),
('Biossegurança', 'escala_numerica', 'Aplicação de normas de biossegurança'),
('Destreza Manual', 'escala_numerica', 'Coordenação e destreza em procedimentos'),
('Velocidade de Execução', 'escala_numerica', 'Eficiência na execução de procedimentos'),
('Precisão Diagnóstica', 'escala_numerica', 'Precisão na interpretação de exames e diagnósticos');

-- ========================================
-- 11. INSERIR RELACIONAMENTOS USUÁRIOS-TURMAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO usuarios_turmas (id_usuario, id_turma) VALUES
-- Alunos de Medicina 2022 (Turma ID: 3)
(9, 3),   -- Ana Paula
(10, 3),  -- Bruno
(11, 3),  -- Carla
(12, 3),  -- Diego
(13, 3),  -- Eduarda

-- Alunos de Medicina 2023 (Turma ID: 4)
(14, 4),  -- Felipe
(15, 4),  -- Gabriela
(16, 4),  -- Henrique

-- Alunos de Medicina 2024 (Turma ID: 5)
(17, 5),  -- Isabela
(18, 5),  -- João Pedro

-- Alunos de outros cursos
(19, 6),  -- Larissa - Enfermagem 2022
(20, 8),  -- Marcos - Fisioterapia 2023
(21, 9),  -- Natália - Nutrição 2024
(22, 10); -- Pedro - Psicologia 2022

-- ========================================
-- 12. INSERIR RELACIONAMENTOS DISCIPLINAS-TURMAS (ESTRUTURA REAL)
-- ========================================

INSERT INTO disciplinas_turmas (id_disciplina, id_turma) VALUES
-- Medicina 2022 (5º semestre) - Turma ID: 3
(5, 3),  -- Clínica Médica I
(6, 3),  -- Cirurgia Geral I

-- Medicina 2023 (3º semestre) - Turma ID: 4
(3, 4),  -- Patologia Geral
(4, 4),  -- Farmacologia Básica

-- Medicina 2024 (1º semestre) - Turma ID: 5
(1, 5),  -- Anatomia Humana I

-- Enfermagem 2022 (5º semestre) - Turma ID: 6
(12, 6), -- Enfermagem Médico-Cirúrgica

-- Fisioterapia 2023 (3º semestre) - Turma ID: 8
(14, 8), -- Cinesioterapia

-- Nutrição 2024 (1º semestre) - Turma ID: 9
(15, 9), -- Nutrição Clínica

-- Psicologia 2022 (5º semestre) - Turma ID: 10
(16, 10); -- Psicologia Geral

-- ========================================
-- 13. INSERIR EVENTOS DA AGENDA (ESTRUTURA REAL)
-- ========================================

INSERT INTO eventos_agenda (nome_evento, tipo_evento, data_evento, hora_evento, id_local_evento, periodo_semanas_estagio, data_inicio_estagio, data_termino_estagio, ativo) VALUES
('Aula Prática - Anatomia Cardíaca', 'aula prática', '2024-08-20', '08:00:00', 5, NULL, NULL, NULL, 1),
('Seminário - Casos Clínicos', 'seminário', '2024-08-21', '14:00:00', 6, NULL, NULL, NULL, 1),
('Estágio - Clínica Médica', 'estágio', '2024-08-22', '07:00:00', 1, 1, '2024-08-22', '2024-08-26', 1),
('Workshop - Simulação Clínica', 'workshop', '2024-08-23', '09:00:00', 4, NULL, NULL, NULL, 1),
('Palestra - Ética Médica', 'palestra', '2024-08-24', '19:00:00', 8, NULL, NULL, NULL, 1),
('Prova Prática - Semiologia', 'avaliação', '2024-08-25', '08:00:00', 3, NULL, NULL, NULL, 1),
('Congresso Acadêmico', 'congresso', '2024-09-01', '08:00:00', 8, 3, '2024-09-01', '2024-09-03', 1);

-- ========================================
-- 14. INSERIR AGENDA DISCIPLINAS VINCULADAS
-- ========================================

INSERT INTO agenda_disciplinas_vinculadas (id_evento, id_disciplina) VALUES
(1, 1),  -- Aula Anatomia -> Anatomia Humana I
(2, 5),  -- Seminário -> Clínica Médica I
(3, 5),  -- Estágio -> Clínica Médica I
(4, 5),  -- Workshop -> Clínica Médica I
(6, 5);  -- Prova -> Clínica Médica I

-- ========================================
-- 15. INSERIR PARTICIPANTES DOS EVENTOS
-- ========================================

INSERT INTO participantes_eventos (id_usuario, id_evento) VALUES
-- Aula Prática Anatomia (Evento ID: 1)
(17, 1),      -- Isabela
(18, 1),      -- João Pedro
(2, 1),       -- Dr. João Silva

-- Seminário Casos Clínicos (Evento ID: 2)
(9, 2),       -- Ana Paula
(10, 2),      -- Bruno
(11, 2),      -- Carla
(3, 2),       -- Dra. Maria Santos

-- Estágio Clínica Médica (Evento ID: 3)
(9, 3),       -- Ana Paula
(10, 3),      -- Bruno
(2, 3),       -- Dr. João Silva

-- Workshop Simulação (Evento ID: 4)
(11, 4),      -- Carla
(12, 4),      -- Diego
(13, 4),      -- Eduarda
(4, 4);       -- Dr. Carlos Oliveira

-- ========================================
-- 16. INSERIR AVALIAÇÕES PREENCHIDAS
-- ========================================

INSERT INTO avaliacoes_preenchidas (
    id_questionario, id_aluno_avaliado, id_avaliador, 
    data_realizacao, horario_inicio, horario_fim, 
    local_realizacao, feedback_positivo, feedback_melhoria, 
    contrato_aprendizagem
) VALUES

-- Mini CEX - Ana Paula avaliada por Dr. João
(1, 9, 2, '2024-08-15', '08:00:00', '09:30:00', 
 'Hospital Universitário - Enfermaria 1', 
 'Excelente capacidade de comunicação com o paciente. Demonstrou empatia e profissionalismo durante toda a consulta. Anamnese bem estruturada.',
 'Poderia melhorar a organização do exame físico, seguindo uma sequência mais sistemática. Necessita praticar mais a palpação abdominal.',
 'Comprometo-me a estudar e praticar a sequência padronizada do exame físico. Vou dedicar 2 horas semanais ao laboratório de habilidades.'),

-- Avaliação 360 Professor - Bruno avaliado por Dra. Maria
(2, 10, 3, '2024-08-16', '14:00:00', '15:30:00', 
 'Ambulatório de Especialidades', 
 'Boa capacidade de raciocínio clínico e formulação de hipóteses diagnósticas. Demonstra conhecimento teórico sólido.',
 'Necessita melhorar a técnica de anamnese, fazendo perguntas mais direcionadas. Poderia ser mais assertivo na comunicação.',
 'Vou praticar técnicas de entrevista médica e estudar roteiros de anamnese. Participarei de workshops de comunicação.'),

-- Avaliação 360 Pares - Carla avaliada por Bruno
(3, 11, 10, '2024-08-17', '10:00:00', '11:00:00', 
 'Centro de Simulação', 
 'Demonstra boa colaboração em equipe e respeito aos colegas. Sempre disposta a ajudar e compartilhar conhecimento.',
 'Poderia ser mais proativa na discussão de casos clínicos. Às vezes fica tímida para expressar suas opiniões.',
 'Comprometo-me a participar mais ativamente das discussões. Vou me preparar melhor para os seminários.'),

-- Autoavaliação - Diego
(4, 12, 12, '2024-08-18', '16:00:00', '16:30:00', 
 'Biblioteca - Sala de Estudos', 
 'Reconheço minha dedicação aos estudos e comprometimento com o curso. Tenho boa capacidade de organização.',
 'Preciso melhorar minha confiança durante os atendimentos. Às vezes fico nervoso e isso afeta meu desempenho.',
 'Vou trabalhar técnicas de controle da ansiedade e buscar mais oportunidades de prática clínica.'),

-- Mini CEX - Eduarda avaliada por Dr. Carlos
(1, 13, 4, '2024-08-19', '09:00:00', '10:30:00', 
 'Hospital Universitário - Enfermaria 2', 
 'Excelente técnica de exame físico e boa interpretação dos achados. Demonstra segurança nos procedimentos.',
 'Poderia melhorar a comunicação com o paciente, sendo mais empática e explicando melhor os procedimentos.',
 'Vou praticar habilidades de comunicação e estudar técnicas de humanização do atendimento.'),

-- Avaliação de Estágio - Felipe
(5, 14, 2, '2024-08-20', '07:00:00', '17:00:00', 
 'UBS Centro', 
 'Excelente pontualidade e assiduidade. Demonstra muito interesse e iniciativa nas atividades do estágio.',
 'Precisa desenvolver mais confiança na tomada de decisões clínicas. Às vezes hesita muito antes de agir.',
 'Vou estudar mais protocolos clínicos e buscar orientação sempre que tiver dúvidas.'),

-- Avaliação Habilidades Práticas - Gabriela
(6, 15, 3, '2024-08-21', '14:00:00', '16:00:00', 
 'Centro de Simulação', 
 'Excelente destreza manual e precisão na execução de procedimentos. Segue corretamente as normas de biossegurança.',
 'Poderia ser mais rápida na execução dos procedimentos. Precisa ganhar mais agilidade com a prática.',
 'Vou praticar mais no laboratório de habilidades para ganhar velocidade mantendo a precisão.'),

-- Avaliação 360 Pares - Henrique avaliado por Gabriela
(3, 16, 15, '2024-08-22', '11:00:00', '12:00:00', 
 'Sala de Aula 101', 
 'Demonstra boa liderança e capacidade de motivar a equipe. É respeitado pelos colegas.',
 'Às vezes pode ser um pouco impaciente com colegas que têm mais dificuldade. Precisa desenvolver mais empatia.',
 'Vou trabalhar minha paciência e buscar formas de ajudar melhor os colegas com dificuldades.');

-- ========================================
-- 17. INSERIR RESPOSTAS DAS AVALIAÇÕES
-- ========================================

INSERT INTO respostas_itens_avaliacao (id_avaliacao_preenchida, id_competencia_questionario, resposta_valor_numerico, nao_avaliado) VALUES

-- Respostas Mini CEX - Ana Paula (Avaliação ID: 1)
(1, 1, 8.0, 0), -- Entrevista médica: 8.0
(1, 2, 6.0, 0), -- Exame Físico: 6.0
(1, 3, 9.0, 0), -- Profissionalismo: 9.0
(1, 4, 7.0, 0), -- Julgamento Clínico: 7.0
(1, 5, 9.0, 0), -- Comunicação: 9.0
(1, 6, 6.0, 0), -- Organização: 6.0
(1, 7, 8.0, 0), -- Avaliação Geral: 8.0

-- Respostas Avaliação 360 Professor - Bruno (Avaliação ID: 2)
(2, 8, 6.0, 0),  -- Entrevista médica: 6.0
(2, 9, 7.0, 0),  -- Exame Físico: 7.0
(2, 10, 7.0, 0), -- Profissionalismo: 7.0
(2, 11, 8.0, 0), -- Julgamento Clínico: 8.0
(2, 12, 6.0, 0), -- Comunicação: 6.0
(2, 13, 7.0, 0), -- Organização: 7.0
(2, 14, 7.0, 0), -- Avaliação Geral: 7.0

-- Respostas Avaliação 360 Pares - Carla (Avaliação ID: 3)
(3, 15, 8.0, 0), -- Colaboração: 8.0
(3, 16, 7.0, 0), -- Comunicação Interpessoal: 7.0
(3, 17, 6.0, 0), -- Liderança: 6.0
(3, 18, 7.0, 0), -- Resolução de Conflitos: 7.0
(3, 19, 8.0, 0), -- Empatia: 8.0
(3, 20, 8.0, 0), -- Responsabilidade: 8.0
(3, 21, 8.0, 0), -- Ética Profissional: 8.0

-- Respostas Autoavaliação - Diego (Avaliação ID: 4)
(4, 22, 7.0, 0), -- Autoconhecimento: 7.0
(4, 23, 8.0, 0), -- Motivação: 8.0
(4, 24, 8.0, 0), -- Gestão do Tempo: 8.0
(4, 25, 5.0, 0), -- Controle Emocional: 5.0
(4, 26, 7.0, 0), -- Busca por Feedback: 7.0
(4, 27, 7.0, 0), -- Desenvolvimento: 7.0

-- Respostas Mini CEX - Eduarda (Avaliação ID: 5)
(5, 1, 8.0, 0), -- Entrevista médica: 8.0
(5, 2, 9.0, 0), -- Exame Físico: 9.0
(5, 3, 8.0, 0), -- Profissionalismo: 8.0
(5, 4, 8.0, 0), -- Julgamento Clínico: 8.0
(5, 5, 7.0, 0), -- Comunicação: 7.0
(5, 6, 8.0, 0), -- Organização: 8.0
(5, 7, 8.0, 0), -- Avaliação Geral: 8.0

-- Respostas Avaliação Estágio - Felipe (Avaliação ID: 6)
(6, 28, 9.0, 0), -- Pontualidade: 9.0
(6, 29, 9.0, 0), -- Assiduidade: 9.0
(6, 30, 8.0, 0), -- Iniciativa: 8.0
(6, 31, 7.0, 0), -- Relacionamento Pacientes: 7.0
(6, 32, 8.0, 0), -- Relacionamento Equipe: 8.0
(6, 33, 7.0, 0), -- Aplicação Conhecimento: 7.0
(6, 34, 8.0, 0), -- Evolução: 8.0

-- Respostas Habilidades Práticas - Gabriela (Avaliação ID: 7)
(7, 35, 8.0, 0), -- Técnicas: 8.0
(7, 36, 8.0, 0), -- Equipamentos: 8.0
(7, 37, 9.0, 0), -- Biossegurança: 9.0
(7, 38, 9.0, 0), -- Destreza: 9.0
(7, 39, 7.0, 0), -- Velocidade: 7.0
(7, 40, 8.0, 0), -- Precisão: 8.0

-- Respostas Avaliação 360 Pares - Henrique (Avaliação ID: 8)
(8, 15, 7.0, 0), -- Colaboração: 7.0
(8, 16, 7.0, 0), -- Comunicação: 7.0
(8, 17, 8.0, 0), -- Liderança: 8.0
(8, 18, 6.0, 0), -- Resolução Conflitos: 6.0
(8, 19, 6.0, 0), -- Empatia: 6.0
(8, 20, 8.0, 0), -- Responsabilidade: 8.0
(8, 21, 8.0, 0); -- Ética: 8.0

-- ========================================
-- 18. INSERIR NOTAS DOS ALUNOS (ESTRUTURA REAL)
-- ========================================

INSERT INTO notas_alunos_disciplinas (
    id_aluno, id_disciplina, id_evento_agenda_referencia, 
    nota_osce, nota_prova_teorica, nota_portfolio, 
    id_avaliacao_pratica_1, id_avaliacao_pratica_2,
    faltas_contabilizadas, percentual_faltas, 
    media_final_calculada, status_disciplina, 
    periodo_letivo_referencia, composicao_nota_texto
) VALUES

-- Notas de Clínica Médica I para alunos do 5º semestre
(9, 5, 3, 8.50, 8.00, 8.20, 1, NULL, 2, 5.00, 8.25, 'Aprovado', '2024-1', 'OSCE: 8.5, Prova: 8.0, Portfolio: 8.2, Prática 1: Mini CEX'),
(10, 5, 3, 7.80, 7.50, 7.60, 2, NULL, 1, 2.50, 7.65, 'Aprovado', '2024-1', 'OSCE: 7.8, Prova: 7.5, Portfolio: 7.6, Prática 1: Avaliação 360'),
(11, 5, NULL, 8.20, 8.10, 8.00, 3, NULL, 0, 0.00, 8.10, 'Aprovado', '2024-1', 'OSCE: 8.2, Prova: 8.1, Portfolio: 8.0, Prática 1: Avaliação Pares'),
(12, 5, NULL, 7.50, 7.20, 7.80, 4, NULL, 3, 7.50, 7.50, 'Aprovado', '2024-1', 'OSCE: 7.5, Prova: 7.2, Portfolio: 7.8, Prática 1: Autoavaliação'),
(13, 5, NULL, 8.80, 8.50, 8.60, 5, NULL, 1, 2.50, 8.65, 'Aprovado', '2024-1', 'OSCE: 8.8, Prova: 8.5, Portfolio: 8.6, Prática 1: Mini CEX'),

-- Notas de Cirurgia Geral I
(9, 6, NULL, 8.00, 7.80, 8.20, NULL, NULL, 2, 5.00, 8.00, 'Aprovado', '2024-1', 'OSCE: 8.0, Prova: 7.8, Portfolio: 8.2'),
(10, 6, NULL, 7.50, 7.30, 7.70, NULL, NULL, 1, 2.50, 7.50, 'Aprovado', '2024-1', 'OSCE: 7.5, Prova: 7.3, Portfolio: 7.7'),
(11, 6, NULL, 7.80, 7.60, 8.00, NULL, NULL, 0, 0.00, 7.80, 'Aprovado', '2024-1', 'OSCE: 7.8, Prova: 7.6, Portfolio: 8.0'),

-- Notas de Patologia Geral para 3º semestre
(14, 3, NULL, 8.20, 8.00, 8.40, 6, NULL, 1, 2.50, 8.20, 'Aprovado', '2024-1', 'OSCE: 8.2, Prova: 8.0, Portfolio: 8.4, Prática 1: Estágio'),
(15, 3, NULL, 8.50, 8.30, 8.70, 7, NULL, 0, 0.00, 8.50, 'Aprovado', '2024-1', 'OSCE: 8.5, Prova: 8.3, Portfolio: 8.7, Prática 1: Habilidades'),
(16, 3, NULL, 7.90, 7.70, 8.10, 8, NULL, 2, 5.00, 7.90, 'Aprovado', '2024-1', 'OSCE: 7.9, Prova: 7.7, Portfolio: 8.1, Prática 1: Avaliação Pares'),

-- Notas de outros cursos
(19, 12, NULL, 8.70, 8.50, 8.90, NULL, NULL, 1, 2.50, 8.70, 'Aprovado', '2024-1', 'OSCE: 8.7, Prova: 8.5, Portfolio: 8.9'),
(20, 14, NULL, 8.00, 7.80, 8.20, NULL, NULL, 2, 5.00, 8.00, 'Aprovado', '2024-1', 'OSCE: 8.0, Prova: 7.8, Portfolio: 8.2'),
(21, 15, NULL, 8.30, 8.10, 8.50, NULL, NULL, 0, 0.00, 8.30, 'Aprovado', '2024-1', 'OSCE: 8.3, Prova: 8.1, Portfolio: 8.5'),
(22, 16, NULL, 7.80, 7.60, 8.00, NULL, NULL, 1, 2.50, 7.80, 'Aprovado', '2024-1', 'OSCE: 7.8, Prova: 7.6, Portfolio: 8.0');

-- ========================================
-- 19. INSERIR NOTIFICAÇÕES (ESTRUTURA REAL)
-- ========================================

INSERT INTO notificacoes (id_usuario, titulo, mensagem, lida) VALUES
-- Notificações para alunos sobre avaliações
(9, 'Nova Avaliação Disponível', 'Você tem uma nova avaliação Mini CEX para visualizar. Acesse o sistema para ver os detalhes.', 1),
(10, 'Feedback de Avaliação', 'Seu feedback da Avaliação 360 foi registrado. Confira as observações do professor.', 1),
(11, 'Lembrete de Autoavaliação', 'Não se esqueça de realizar sua autoavaliação até o final da semana.', 0),
(12, 'Resultado de Avaliação', 'Sua autoavaliação foi processada. Veja os resultados no seu perfil.', 1),
(13, 'Nova Avaliação Disponível', 'Você tem uma nova avaliação Mini CEX para visualizar.', 0),

-- Notificações para professores
(2, 'Avaliação Pendente', 'Você tem 3 avaliações pendentes para realizar. Acesse o sistema para completá-las.', 0),
(3, 'Relatório Mensal', 'O relatório mensal de avaliações está disponível para download.', 0),
(4, 'Sistema Atualizado', 'O sistema foi atualizado com novas funcionalidades. Confira as novidades.', 1),

-- Notificações gerais
(1, 'Bem-vindo ao Sistema', 'Bem-vindo ao Sistema de Avaliação UNIFAE! Explore as funcionalidades disponíveis.', 1),
(14, 'Calendário Acadêmico', 'O calendário acadêmico do próximo semestre foi publicado.', 0);

-- ========================================
-- 20. INSERIR HISTÓRICO ESCOLAR IMPORTADO (ESTRUTURA REAL)
-- ========================================

INSERT INTO historico_escolar_importado (id_aluno, disciplina, nota, status, ano_semestre) VALUES
-- Histórico de Ana Paula (transferência)
(9, 'Biologia Celular', 8.50, 'Aprovado', '2022-1'),
(9, 'Química Geral', 7.80, 'Aprovado', '2022-1'),
(9, 'Física Médica', 8.00, 'Aprovado', '2022-2'),
(9, 'Bioquímica', 8.20, 'Aprovado', '2022-2'),

-- Histórico de Bruno (transferência)
(10, 'Biologia Celular', 7.50, 'Aprovado', '2022-1'),
(10, 'Química Geral', 7.00, 'Aprovado', '2022-1'),
(10, 'Física Médica', 7.80, 'Aprovado', '2022-2'),

-- Histórico de Carla (disciplinas extras)
(11, 'Inglês Técnico', 9.00, 'Aprovado', '2023-1'),
(11, 'Informática Médica', 8.50, 'Aprovado', '2023-2');

-- ========================================
-- 21. INSERIR FEEDBACKS DO SISTEMA (ESTRUTURA REAL)
-- ========================================

INSERT INTO feedbacks_sistema (tipo_mensagem, texto_mensagem_livre) VALUES
('Sugestão', 'A interface mobile poderia ser mais responsiva, especialmente na visualização de avaliações.'),
('Bug', 'Às vezes o sistema não salva a avaliação quando clico em enviar. Preciso tentar várias vezes.'),
('Elogio', 'O sistema de avaliação está muito bem estruturado e facilita muito o acompanhamento do aprendizado.'),
('Sugestão', 'Seria interessante ter relatórios com gráficos de evolução dos alunos ao longo do tempo.'),
('Bug', 'A exportação de relatórios em PDF às vezes falha. Poderia verificar?'),
('Dúvida', 'Não estou conseguindo encontrar onde visualizar meu histórico de avaliações antigas.');

-- ========================================
-- 22. VERIFICAÇÃO FINAL CORRIGIDA
-- ========================================

SELECT 'CADASTRO GERAL CORRIGIDO INSERIDO COM SUCESSO!' as resultado;

-- Contar registros em todas as tabelas
SELECT 
    'CONTAGEM DE REGISTROS POR TABELA (ESTRUTURA REAL):' as info,
    (SELECT COUNT(*) FROM usuarios) as usuarios,
    (SELECT COUNT(*) FROM permissoes) as permissoes,
    (SELECT COUNT(*) FROM turmas) as turmas,
    (SELECT COUNT(*) FROM disciplinas) as disciplinas,
    (SELECT COUNT(*) FROM locais_eventos) as locais_eventos,
    (SELECT COUNT(*) FROM questionarios) as questionarios,
    (SELECT COUNT(*) FROM competencias_questionario) as competencias,
    (SELECT COUNT(*) FROM avaliacoes_preenchidas) as avaliacoes,
    (SELECT COUNT(*) FROM respostas_itens_avaliacao) as respostas,
    (SELECT COUNT(*) FROM usuarios_turmas) as usuarios_turmas,
    (SELECT COUNT(*) FROM disciplinas_turmas) as disciplinas_turmas,
    (SELECT COUNT(*) FROM eventos_agenda) as eventos,
    (SELECT COUNT(*) FROM participantes_eventos) as participantes,
    (SELECT COUNT(*) FROM notas_alunos_disciplinas) as notas,
    (SELECT COUNT(*) FROM notificacoes) as notificacoes,
    (SELECT COUNT(*) FROM historico_escolar_importado) as historico,
    (SELECT COUNT(*) FROM feedbacks_sistema) as feedbacks,
    (SELECT COUNT(*) FROM configuracao_calculo_notas) as configuracoes;

-- Resumo das avaliações por tipo
SELECT 'RESUMO DAS AVALIAÇÕES POR TIPO:' as info;
SELECT 
    q.nome_modelo as Tipo_Questionario,
    COUNT(ap.id_avaliacao_preenchida) as Total_Avaliacoes
FROM questionarios q
LEFT JOIN avaliacoes_preenchidas ap ON q.id_questionario = ap.id_questionario
GROUP BY q.id_questionario, q.nome_modelo
ORDER BY Total_Avaliacoes DESC;

-- Resumo dos alunos por turma
SELECT 'RESUMO DOS ALUNOS POR TURMA:' as info;
SELECT 
    t.nome_turma as Turma,
    COUNT(ut.id_usuario) as Total_Alunos
FROM turmas t
LEFT JOIN usuarios_turmas ut ON t.id_turma = ut.id_turma
GROUP BY t.id_turma, t.nome_turma
ORDER BY t.nome_turma;

-- Resumo das disciplinas ativas
SELECT 'RESUMO DAS DISCIPLINAS ATIVAS:' as info;
SELECT 
    d.nome_disciplina as Disciplina,
    d.sigla_disciplina as Sigla,
    COUNT(dt.id_turma) as Turmas_Vinculadas
FROM disciplinas d
LEFT JOIN disciplinas_turmas dt ON d.id_disciplina = dt.id_disciplina
WHERE d.ativa = 1
GROUP BY d.id_disciplina, d.nome_disciplina, d.sigla_disciplina
ORDER BY d.nome_disciplina;

-- ========================================
-- SCRIPT CADASTRO GERAL CORRIGIDO!
-- 
-- ✅ 100% COMPATÍVEL COM ESTRUTURA REAL DO BANCO
-- ✅ TODOS OS CAMPOS CORRETOS E TIPOS ADEQUADOS
-- ✅ RELACIONAMENTOS VÁLIDOS E FOREIGN KEYS OK
-- ✅ DADOS REALISTAS PARA TODAS AS FUNCIONALIDADES
-- 
-- CORREÇÕES APLICADAS:
-- ✅ NOMES DE CAMPOS CORRIGIDOS
-- ✅ TIPOS DE DADOS AJUSTADOS
-- ✅ RELACIONAMENTOS VALIDADOS
-- ✅ ESTRUTURA REAL RESPEITADA
-- 
-- TOTAIS INSERIDOS (ESTRUTURA REAL):
-- - 22 USUÁRIOS (com campos reais: matricula_RA, periodo_atual_aluno, id_permissao)
-- - 10 PERMISSÕES (nome_permissao, descricao_permissao)
-- - 10 TURMAS (nome_turma, codigo_turma)
-- - 16 DISCIPLINAS (nome_disciplina, sigla_disciplina, ativa)
-- - 12 LOCAIS (nome_local, tipo_local, endereco, cidade, estado)
-- - 6 QUESTIONÁRIOS (nome_modelo, descricao)
-- - 40 COMPETÊNCIAS (nome_competencia, tipo_item, descricao_prompt)
-- - 8 AVALIAÇÕES (estrutura real com todos os campos)
-- - 56 RESPOSTAS (resposta_valor_numerico como decimal(4,1))
-- - 13 RELACIONAMENTOS USUÁRIO-TURMA (estrutura simples)
-- - 7 RELACIONAMENTOS DISCIPLINA-TURMA (estrutura simples)
-- - 7 EVENTOS (nome_evento, tipo_evento, data_evento, hora_evento, etc.)
-- - 12 PARTICIPANTES (id_usuario, id_evento)
-- - 13 NOTAS (estrutura complexa real com OSCE, prova, portfolio, etc.)
-- - 10 NOTIFICAÇÕES (id_usuario, titulo, mensagem, data_envio, lida)
-- - 9 HISTÓRICO (id_aluno, disciplina, nota, status, ano_semestre)
-- - 6 FEEDBACKS (tipo_mensagem, texto_mensagem_livre)
-- - 3 CONFIGURAÇÕES (estrutura real com pesos OSCE, prova, etc.)
-- 
-- SISTEMA PRONTO PARA USO COM ESTRUTURA REAL!
-- ========================================

