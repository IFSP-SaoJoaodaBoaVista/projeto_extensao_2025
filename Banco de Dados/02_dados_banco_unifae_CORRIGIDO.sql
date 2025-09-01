-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01/09/2025 às 03:52
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `unifae_med_app`
--
CREATE DATABASE IF NOT EXISTS `unifae_med_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `unifae_med_app`;

--
-- Despejando dados para a tabela `agenda_disciplinas_vinculadas`
--

INSERT INTO `agenda_disciplinas_vinculadas` (`id_agenda_disciplina`, `id_evento`, `id_disciplina`, `data_criacao`) VALUES
(1, 1, 8, '2025-08-26 22:30:06'),
(2, 2, 9, '2025-08-26 22:30:06'),
(3, 3, 8, '2025-08-26 22:30:06'),
(4, 5, 9, '2025-08-26 22:30:06');

--
-- Despejando dados para a tabela `avaliacoes_preenchidas`
--

INSERT INTO `avaliacoes_preenchidas` (`id_avaliacao_preenchida`, `id_questionario`, `id_aluno_avaliado`, `id_avaliador`, `id_disciplina`, `id_turma`, `id_local_evento`, `data_realizacao`, `horario_inicio`, `horario_fim`, `feedback_positivo`, `feedback_melhoria`, `contrato_aprendizagem`, `status_avaliacao`, `data_criacao`, `data_atualizacao`, `local_realizacao`, `nome_avaliador_nao_usuario`, `tipo_avaliador_nao_usuario`) VALUES
(1, 1, 11, 5, 8, 1, 6, '2025-08-20', '08:00:00', '09:30:00', 'Excelente capacidade de comunicação com o paciente. Demonstrou empatia e profissionalismo.', 'Melhorar a sistematização do exame físico, especialmente na ausculta cardíaca.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(2, 1, 12, 6, 8, 1, 6, '2025-08-21', '14:00:00', '15:30:00', 'Boa técnica de anamnese, conseguiu obter informações relevantes do paciente.', 'Trabalhar na organização do tempo durante o atendimento.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(3, 1, 13, 5, 8, 1, 7, '2025-08-22', '09:00:00', '10:30:00', 'Demonstrou conhecimento teórico sólido e boa aplicação prática.', 'Desenvolver mais confiança na apresentação dos casos clínicos.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(4, 2, 21, 9, 9, 3, 1, '2025-08-23', '10:00:00', '11:00:00', 'Estudante dedicado, sempre pontual e preparado para as atividades.', 'Participar mais ativamente das discussões de caso.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(5, 2, 22, 10, 9, 3, 1, '2025-08-24', '15:00:00', '16:00:00', 'Excelente relacionamento interpessoal com pacientes e equipe.', 'Aprimorar conhecimentos em farmacologia clínica.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(6, 3, 11, 12, 8, 1, 6, '2025-08-25', '08:30:00', '09:00:00', 'Colega muito colaborativo, sempre disposto a ajudar.', 'Poderia ser mais assertivo nas discussões de grupo.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(7, 3, 12, 11, 8, 1, 6, '2025-08-25', '09:00:00', '09:30:00', 'Demonstra muito conhecimento e compartilha bem com o grupo.', 'Às vezes pode ser muito detalhista, perdendo o foco principal.', NULL, 'FINALIZADA', '2025-08-26 22:30:06', '2025-08-26 22:30:06', NULL, NULL, NULL),
(11, 3, 11, 12, NULL, NULL, NULL, '2025-08-25', '08:30:00', '09:00:00', 'Colega muito colaborativo, sempre disposto a ajudar.', 'Poderia ser mais assertivo nas discussões de grupo.', NULL, 'RASCUNHO', '2025-08-26 22:56:07', '2025-08-26 22:56:07', 'Ambulatório de Clínica Médica', NULL, NULL),
(12, 3, 12, 11, NULL, NULL, NULL, '2025-08-25', '09:00:00', '09:30:00', 'Demonstra muito conhecimento e compartilha bem com o grupo.', 'Às vezes pode ser muito detalhista, perdendo o foco principal.', NULL, 'RASCUNHO', '2025-08-30 19:53:32', '2025-08-30 19:53:32', 'Ambulatório de Ginecologia', NULL, NULL),
(13, 3, 11, 12, NULL, NULL, NULL, '2025-08-25', '08:30:00', '09:00:00', 'Colega muito colaborativo, sempre disposto a ajudar.', 'Poderia ser mais assertivo nas discussões de grupo.', NULL, 'RASCUNHO', '2025-08-30 19:54:17', '2025-08-30 19:54:17', 'Ambulatório de Ginecologia', NULL, NULL),
(14, 2, 22, 10, NULL, NULL, NULL, '2025-08-24', '15:00:00', '16:00:00', 'Excelente relacionamento interpessoal com pacientes e equipe.', 'Aprimorar conhecimentos em farmacologia clínica.', 'teste', 'RASCUNHO', '2025-08-30 19:55:07', '2025-08-30 19:55:07', 'Ambulatório de Clínica Médica', NULL, 'Professor/Preceptor'),
(15, 3, 13, 14, NULL, NULL, NULL, '2025-09-02', '16:57:00', '19:57:00', 'Preenchimento de teste', 'Preenchimento de teste', NULL, 'RASCUNHO', '2025-08-30 19:58:01', '2025-08-30 19:58:01', 'Hospital Universitário - Enfermaria A', NULL, NULL),
(19, 5, 12, NULL, NULL, NULL, NULL, '2025-09-01', '16:16:00', '16:16:00', 'A atenção com o paciente.', 'Explicar com mais calma.', NULL, 'RASCUNHO', '2025-08-31 19:17:01', '2025-08-31 19:17:01', 'Sala de Simulação Clínica', '', 'Paciente'),
(23, 4, 11, NULL, NULL, NULL, NULL, '2025-09-02', '22:05:00', '00:05:00', 'Teste de feedback do estudante.', 'Teste de melhoria pelo feedback.', NULL, 'RASCUNHO', '2025-09-01 00:06:19', '2025-09-01 00:06:19', 'Sala de Simulação Clínica', 'João da Silva', 'Tecnico de Enfermagem'),
(24, 4, 12, NULL, NULL, NULL, NULL, '2025-09-02', '00:56:00', '08:00:00', 'Preenchimento de teste para equipes.', 'Preenchimento de teste para equipes a ser melhorado.', NULL, 'RASCUNHO', '2025-09-01 00:13:11', '2025-09-01 00:13:11', 'Hospital Universitário - UTI', 'Maria de Fátima', 'Psicologia'),
(25, 5, 11, NULL, NULL, NULL, NULL, '2025-09-02', '00:00:00', '01:00:00', 'Feedback positivo.', 'Melhorar é preciso.', NULL, 'RASCUNHO', '2025-09-01 01:01:21', '2025-09-01 01:01:21', 'Sala de Simulação Clínica', 'Paulo da Silva', 'Familiar'),
(26, 4, 14, NULL, NULL, NULL, NULL, '2025-09-02', '23:31:00', '02:31:00', 'Teste feedback.', 'Teste feedback melhorias.', NULL, 'RASCUNHO', '2025-09-01 01:32:47', '2025-09-01 01:32:47', 'Hospital Universitário - Pronto Socorro', 'Cláudia Romano', 'Enfermagem');

--
-- Despejando dados para a tabela `competencias_questionario`
--

INSERT INTO `competencias_questionario` (`id_competencia_questionario`, `id_questionario`, `nome_competencia`, `tipo_item`, `descricao_prompt`, `ordem_exibicao`, `obrigatorio`, `ativo`, `data_criacao`, `data_atualizacao`) VALUES
(1, 1, 'Entrevista médica', 'escala_numerica', 'Avalie a capacidade de conduzir entrevista médica', 1, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(2, 1, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(3, 1, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 3, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(4, 1, 'Julgamento clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio clínico', 4, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(5, 1, 'Habilidade de comunicação', 'escala_numerica', 'Avalie a comunicação com paciente e equipe', 5, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(6, 1, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e uso eficiente do tempo', 6, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(7, 1, 'Avaliação clínica geral', 'escala_numerica', 'Avaliação geral da competência clínica', 7, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(8, 2, 'Entrevista médica', 'escala_numerica', 'Avalie a capacidade de conduzir entrevista médica', 1, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(9, 2, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(10, 2, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 3, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(11, 2, 'Julgamento clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio clínico', 4, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(12, 2, 'Habilidade de comunicação', 'escala_numerica', 'Avalie a comunicação com paciente e equipe', 5, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(13, 2, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e uso eficiente do tempo', 6, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(14, 2, 'Avaliação clínica geral', 'escala_numerica', 'Avaliação geral da competência clínica', 7, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(15, 3, 'Anamnese', 'escala_numerica', 'Avalie a capacidade de realizar anamnese completa', 1, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(16, 3, 'Exame físico', 'escala_numerica', 'Avalie a técnica e sistematização do exame físico', 2, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(17, 3, 'Raciocínio clínico', 'escala_numerica', 'Avalie a capacidade de raciocínio e diagnóstico', 3, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(18, 3, 'Profissionalismo', 'escala_numerica', 'Avalie o comportamento profissional e ético', 4, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(19, 3, 'Comunicação', 'escala_numerica', 'Avalie a comunicação interpessoal', 5, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(20, 3, 'Organização e eficiência', 'escala_numerica', 'Avalie a organização e gestão do tempo', 6, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(21, 3, 'Competência profissional global', 'escala_numerica', 'Avaliação geral da competência profissional', 7, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(22, 3, 'Atitude de compaixão e respeito', 'escala_numerica', 'Avalie a demonstração de compaixão e respeito', 8, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(23, 3, 'Abordagem suave e sensível ao paciente', 'escala_numerica', 'Avalie a sensibilidade no atendimento', 9, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(24, 3, 'Comunicação e interação respeitosa com a equipe', 'escala_numerica', 'Avalie o relacionamento com a equipe', 10, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(25, 4, 'Colaboração em equipe', 'escala_numerica', 'Avalie a capacidade de trabalhar em equipe', 1, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(26, 4, 'Comunicação interprofissional', 'escala_numerica', 'Avalie a comunicação com diferentes profissionais', 2, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(27, 4, 'Respeito mútuo', 'escala_numerica', 'Avalie o respeito demonstrado aos colegas', 3, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(28, 4, 'Responsabilidade compartilhada', 'escala_numerica', 'Avalie o senso de responsabilidade compartilhada', 4, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(29, 4, 'Liderança situacional', 'escala_numerica', 'Avalie a capacidade de liderança quando necessário', 5, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(30, 4, 'Resolução de conflitos', 'escala_numerica', 'Avalie a habilidade para resolver conflitos', 6, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(31, 4, 'Empatia profissional', 'escala_numerica', 'Avalie a demonstração de empatia no trabalho', 7, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(32, 4, 'Ética no trabalho em equipe', 'escala_numerica', 'Avalie o comportamento ético na equipe', 8, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(33, 4, 'Flexibilidade e adaptação', 'escala_numerica', 'Avalie a capacidade de adaptação a mudanças', 9, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(34, 4, 'Contribuição para o ambiente de trabalho', 'escala_numerica', 'Avalie a contribuição para um ambiente positivo', 10, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(35, 5, 'Cortesia e educação', 'escala_numerica', 'Avalie a cortesia e educação no atendimento', 1, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(36, 5, 'Clareza na comunicação', 'escala_numerica', 'Avalie a clareza das explicações fornecidas', 2, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(37, 5, 'Demonstração de interesse', 'escala_numerica', 'Avalie o interesse demonstrado pelo paciente', 3, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(38, 5, 'Respeito à privacidade', 'escala_numerica', 'Avalie o respeito à privacidade e confidencialidade', 4, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(39, 5, 'Tempo dedicado', 'escala_numerica', 'Avalie se o tempo dedicado foi adequado', 5, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(40, 5, 'Capacidade de tranquilizar', 'escala_numerica', 'Avalie a capacidade de tranquilizar e acalmar', 6, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(41, 5, 'Explicação sobre procedimentos', 'escala_numerica', 'Avalie a qualidade das explicações sobre procedimentos', 7, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(42, 5, 'Envolvimento na tomada de decisão', 'escala_numerica', 'Avalie o envolvimento do paciente nas decisões', 8, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(43, 5, 'Demonstração de cuidado', 'escala_numerica', 'Avalie a demonstração de cuidado e preocupação', 9, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(44, 5, 'Satisfação geral', 'escala_numerica', 'Avaliação geral da satisfação com o atendimento', 10, 1, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06');

--
-- Despejando dados para a tabela `disciplinas`
--

INSERT INTO `disciplinas` (`id_disciplina`, `nome_disciplina`, `codigo_disciplina`, `descricao`, `carga_horaria`, `ativo`, `data_criacao`, `data_atualizacao`, `ativa`, `sigla_disciplina`) VALUES
(1, 'Anatomia Humana I', 'MED101', 'Estudo da anatomia básica do corpo humano', 120, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(2, 'Fisiologia Humana I', 'MED102', 'Estudo das funções básicas do organismo', 100, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(3, 'Histologia e Embriologia', 'MED103', 'Estudo dos tecidos e desenvolvimento embrionário', 80, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(4, 'Bioquímica Médica', 'MED104', 'Bioquímica aplicada à medicina', 90, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(5, 'Patologia Geral', 'MED201', 'Estudo das doenças e processos patológicos', 110, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(6, 'Farmacologia Básica', 'MED202', 'Princípios básicos da farmacologia', 85, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(7, 'Microbiologia e Imunologia', 'MED203', 'Estudo de microorganismos e sistema imune', 95, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(8, 'Semiologia Médica', 'MED301', 'Técnicas de exame clínico e diagnóstico', 130, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(9, 'Clínica Médica I', 'MED302', 'Prática clínica em medicina interna', 140, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(10, 'Cirurgia Geral I', 'MED303', 'Princípios básicos de cirurgia', 120, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(11, 'Pediatria I', 'MED401', 'Medicina pediátrica básica', 100, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(12, 'Ginecologia e Obstetrícia I', 'MED402', 'Medicina da mulher - básico', 110, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(13, 'Medicina de Família e Comunidade', 'MED403', 'Atenção primária à saúde', 90, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(14, 'Internato em Clínica Médica', 'MED501', 'Estágio supervisionado em clínica médica', 200, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL),
(15, 'Internato em Cirurgia', 'MED502', 'Estágio supervisionado em cirurgia', 200, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', b'0', NULL);

--
-- Despejando dados para a tabela `disciplinas_turmas`
--

INSERT INTO `disciplinas_turmas` (`id_disciplina_turma`, `id_disciplina`, `id_turma`, `id_professor`, `data_vinculacao`, `ativo`) VALUES
(1, 1, 1, 5, '2025-08-26 22:30:06', 1),
(2, 2, 1, 6, '2025-08-26 22:30:06', 1),
(3, 3, 1, 7, '2025-08-26 22:30:06', 1),
(4, 1, 2, 5, '2025-08-26 22:30:06', 1),
(5, 2, 2, 6, '2025-08-26 22:30:06', 1),
(6, 3, 2, 8, '2025-08-26 22:30:06', 1),
(7, 5, 3, 9, '2025-08-26 22:30:06', 1),
(8, 6, 3, 10, '2025-08-26 22:30:06', 1),
(9, 7, 3, 5, '2025-08-26 22:30:06', 1),
(10, 5, 4, 9, '2025-08-26 22:30:06', 1),
(11, 6, 4, 10, '2025-08-26 22:30:06', 1),
(12, 7, 4, 6, '2025-08-26 22:30:06', 1),
(13, 8, 5, 7, '2025-08-26 22:30:06', 1),
(14, 9, 5, 8, '2025-08-26 22:30:06', 1),
(15, 10, 5, 9, '2025-08-26 22:30:06', 1),
(16, 8, 6, 7, '2025-08-26 22:30:06', 1),
(17, 9, 6, 8, '2025-08-26 22:30:06', 1),
(18, 10, 6, 10, '2025-08-26 22:30:06', 1);

--
-- Despejando dados para a tabela `eventos_agenda`
--

INSERT INTO `eventos_agenda` (`id_evento`, `titulo`, `descricao`, `data_inicio`, `data_fim`, `id_local_evento`, `id_disciplina`, `id_turma`, `id_responsavel`, `tipo_evento`, `status_evento`, `data_criacao`, `data_atualizacao`) VALUES
(1, 'Aula Prática - Semiologia', 'Aula prática de exame físico cardiovascular', '2025-08-27 08:00:00', '2025-08-27 10:00:00', 6, 8, 1, 5, 'AULA', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(2, 'Seminário - Casos Clínicos', 'Apresentação de casos clínicos pelos estudantes', '2025-08-27 14:00:00', '2025-08-27 16:00:00', 12, 9, 3, 9, 'SEMINARIO', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(3, 'Avaliação Prática - Mini-CEX', 'Avaliações práticas individuais', '2025-08-28 08:00:00', '2025-08-28 12:00:00', 6, 8, 1, 5, 'AVALIACAO', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(4, 'Reunião de Coordenação', 'Reunião mensal da coordenação do curso', '2025-08-28 14:00:00', '2025-08-28 16:00:00', 13, NULL, NULL, 3, 'REUNIAO', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(5, 'Estágio - Clínica Médica', 'Estágio supervisionado na enfermaria', '2025-08-29 07:00:00', '2025-08-29 17:00:00', 1, 9, 3, 9, 'AULA', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(6, 'Palestra - Ética Médica', 'Palestra sobre ética e bioética médica', '2025-08-30 19:00:00', '2025-08-30 21:00:00', 12, NULL, NULL, 10, 'EVENTO', 'AGENDADO', '2025-08-26 22:30:06', '2025-08-26 22:30:06');

--
-- Despejando dados para a tabela `locais_eventos`
--

INSERT INTO `locais_eventos` (`id_local_evento`, `nome_local`, `descricao`, `endereco`, `capacidade`, `ativo`, `data_criacao`, `data_atualizacao`, `cidade`, `estado`, `tipo_local`) VALUES
(1, 'Hospital Universitário - Enfermaria A', 'Enfermaria para atividades práticas', 'Ala Norte, 2º andar', 20, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(2, 'Hospital Universitário - Enfermaria B', 'Enfermaria para atividades práticas', 'Ala Sul, 2º andar', 20, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(3, 'Hospital Universitário - UTI', 'Unidade de Terapia Intensiva', 'Ala Central, 3º andar', 10, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(4, 'Hospital Universitário - Pronto Socorro', 'Setor de emergência', 'Térreo, Ala Oeste', 15, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(5, 'Hospital Universitário - Centro Cirúrgico', 'Salas de cirurgia', 'Ala Norte, 4º andar', 8, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(6, 'Ambulatório de Clínica Médica', 'Consultórios de clínica geral', 'Bloco B, 1º andar', 25, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(7, 'Ambulatório de Pediatria', 'Consultórios pediátricos', 'Bloco C, 1º andar', 20, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(8, 'Ambulatório de Ginecologia', 'Consultórios ginecológicos', 'Bloco C, 2º andar', 18, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(9, 'Laboratório de Anatomia', 'Laboratório para aulas práticas', 'Bloco A, Subsolo', 40, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(10, 'Laboratório de Histologia', 'Laboratório de microscopia', 'Bloco A, 1º andar', 30, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(11, 'Sala de Simulação Clínica', 'Ambiente simulado para treinamento', 'Bloco D, 2º andar', 12, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(12, 'Auditório Principal', 'Auditório para palestras e eventos', 'Bloco Central, Térreo', 200, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(13, 'Sala de Reuniões - Coordenação', 'Sala para reuniões administrativas', 'Bloco Administrativo, 3º andar', 15, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(14, 'UBS Vila Nova', 'Unidade Básica de Saúde parceira', 'Rua das Flores, 123 - Vila Nova', 30, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', ''),
(15, 'Hospital Parceiro São José', 'Hospital conveniado para estágios', 'Av. Principal, 456 - Centro', 50, 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06', '', '', '');

--
-- Despejando dados para a tabela `log_acoes`
--

INSERT INTO `log_acoes` (`id_log`, `id_usuario`, `acao`, `tabela_afetada`, `id_registro_afetado`, `dados_anteriores`, `dados_novos`, `ip_usuario`, `user_agent`, `data_acao`) VALUES
(1, 1, 'INSERT', 'usuarios', 1, NULL, '{\"nome_completo\": \"Dr. Carlos Eduardo Silva\", \"email\": \"admin@unifae.br\", \"tipo_usuario\": \"ADMINISTRADOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(2, 2, 'INSERT', 'usuarios', 2, NULL, '{\"nome_completo\": \"Dra. Maria Fernanda Costa\", \"email\": \"admin2@unifae.br\", \"tipo_usuario\": \"ADMINISTRADOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(3, 3, 'INSERT', 'usuarios', 3, NULL, '{\"nome_completo\": \"Dr. Roberto Mendes\", \"email\": \"coordenador@unifae.br\", \"tipo_usuario\": \"COORDENADOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(4, 4, 'INSERT', 'usuarios', 4, NULL, '{\"nome_completo\": \"Dra. Ana Paula Santos\", \"email\": \"coordenadora2@unifae.br\", \"tipo_usuario\": \"COORDENADOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(5, 5, 'INSERT', 'usuarios', 5, NULL, '{\"nome_completo\": \"Dr. João Carlos Oliveira\", \"email\": \"joao.oliveira@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(6, 6, 'INSERT', 'usuarios', 6, NULL, '{\"nome_completo\": \"Dra. Mariana Rodrigues\", \"email\": \"mariana.rodrigues@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(7, 7, 'INSERT', 'usuarios', 7, NULL, '{\"nome_completo\": \"Dr. Pedro Henrique Lima\", \"email\": \"pedro.lima@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(8, 8, 'INSERT', 'usuarios', 8, NULL, '{\"nome_completo\": \"Dra. Fernanda Alves\", \"email\": \"fernanda.alves@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(9, 9, 'INSERT', 'usuarios', 9, NULL, '{\"nome_completo\": \"Dr. Ricardo Barbosa\", \"email\": \"ricardo.barbosa@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(10, 10, 'INSERT', 'usuarios', 10, NULL, '{\"nome_completo\": \"Dra. Juliana Ferreira\", \"email\": \"juliana.ferreira@unifae.br\", \"tipo_usuario\": \"PROFESSOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(11, 11, 'INSERT', 'usuarios', 11, NULL, '{\"nome_completo\": \"Lucas Gabriel Santos\", \"email\": \"lucas.santos@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(12, 12, 'INSERT', 'usuarios', 12, NULL, '{\"nome_completo\": \"Ana Carolina Silva\", \"email\": \"ana.silva@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(13, 13, 'INSERT', 'usuarios', 13, NULL, '{\"nome_completo\": \"Felipe Augusto Costa\", \"email\": \"felipe.costa@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(14, 14, 'INSERT', 'usuarios', 14, NULL, '{\"nome_completo\": \"Beatriz Oliveira Lima\", \"email\": \"beatriz.lima@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(15, 15, 'INSERT', 'usuarios', 15, NULL, '{\"nome_completo\": \"Matheus Henrique Souza\", \"email\": \"matheus.souza@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(16, 16, 'INSERT', 'usuarios', 16, NULL, '{\"nome_completo\": \"Gabriela Fernandes\", \"email\": \"gabriela.fernandes@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(17, 17, 'INSERT', 'usuarios', 17, NULL, '{\"nome_completo\": \"Rafael Pereira Santos\", \"email\": \"rafael.santos@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(18, 18, 'INSERT', 'usuarios', 18, NULL, '{\"nome_completo\": \"Camila Rodrigues\", \"email\": \"camila.rodrigues@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(19, 19, 'INSERT', 'usuarios', 19, NULL, '{\"nome_completo\": \"Thiago Almeida\", \"email\": \"thiago.almeida@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(20, 20, 'INSERT', 'usuarios', 20, NULL, '{\"nome_completo\": \"Larissa Martins\", \"email\": \"larissa.martins@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(21, 21, 'INSERT', 'usuarios', 21, NULL, '{\"nome_completo\": \"Eduardo Silva Neto\", \"email\": \"eduardo.neto@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(22, 22, 'INSERT', 'usuarios', 22, NULL, '{\"nome_completo\": \"Isabela Costa Santos\", \"email\": \"isabela.santos@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(23, 23, 'INSERT', 'usuarios', 23, NULL, '{\"nome_completo\": \"Vinícius Oliveira\", \"email\": \"vinicius.oliveira@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(24, 24, 'INSERT', 'usuarios', 24, NULL, '{\"nome_completo\": \"Natália Ferreira\", \"email\": \"natalia.ferreira@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(25, 25, 'INSERT', 'usuarios', 25, NULL, '{\"nome_completo\": \"Bruno Henrique Lima\", \"email\": \"bruno.lima@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(26, 26, 'INSERT', 'usuarios', 26, NULL, '{\"nome_completo\": \"Amanda Ribeiro\", \"email\": \"amanda.ribeiro@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(27, 27, 'INSERT', 'usuarios', 27, NULL, '{\"nome_completo\": \"Gustavo Barbosa\", \"email\": \"gustavo.barbosa@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(28, 28, 'INSERT', 'usuarios', 28, NULL, '{\"nome_completo\": \"Priscila Alves\", \"email\": \"priscila.alves@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(29, 29, 'INSERT', 'usuarios', 29, NULL, '{\"nome_completo\": \"Rodrigo Mendes\", \"email\": \"rodrigo.mendes@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(30, 30, 'INSERT', 'usuarios', 30, NULL, '{\"nome_completo\": \"Carolina Dias\", \"email\": \"carolina.dias@aluno.unifae.br\", \"tipo_usuario\": \"ESTUDANTE\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05'),
(31, 31, 'INSERT', 'usuarios', 31, NULL, '{\"nome_completo\": \"Usuário Teste\", \"email\": \"teste@unifae.br\", \"tipo_usuario\": \"ADMINISTRADOR\", \"ativo\": 1}', NULL, NULL, '2025-08-26 22:30:05');

--
-- Despejando dados para a tabela `participantes_eventos`
--

INSERT INTO `participantes_eventos` (`id_participante_evento`, `id_evento`, `id_usuario`, `papel_participante`, `confirmado`, `data_confirmacao`, `observacoes`, `data_criacao`) VALUES
(1, 1, 5, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(2, 1, 11, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(3, 1, 12, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(4, 1, 13, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(5, 1, 14, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(6, 1, 15, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(7, 2, 9, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(8, 2, 21, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(9, 2, 22, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(10, 2, 23, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(11, 3, 5, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(12, 3, 6, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(13, 3, 11, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(14, 3, 12, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(15, 3, 13, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(16, 3, 14, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(17, 3, 15, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(18, 4, 3, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(19, 4, 4, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(20, 4, 5, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(21, 4, 6, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(22, 4, 7, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(23, 4, 8, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(24, 5, 9, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(25, 5, 10, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(26, 5, 21, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(27, 5, 22, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(28, 5, 23, 'PARTICIPANTE', 1, NULL, NULL, '2025-08-26 22:30:06'),
(29, 6, 10, 'ORGANIZADOR', 1, NULL, NULL, '2025-08-26 22:30:06'),
(30, 6, 11, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(31, 6, 12, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(32, 6, 13, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(33, 6, 14, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(34, 6, 15, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(35, 6, 21, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(36, 6, 22, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(37, 6, 23, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(38, 6, 26, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(39, 6, 27, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06'),
(40, 6, 28, 'PARTICIPANTE', 0, NULL, NULL, '2025-08-26 22:30:06');

--
-- Despejando dados para a tabela `permissoes`
--

INSERT INTO `permissoes` (`id_permissao`, `nome_permissao`, `descricao`, `ativo`, `data_criacao`, `data_atualizacao`, `descricao_permissao`) VALUES
(1, 'ADMIN_TOTAL', 'Acesso total ao sistema - todas as funcionalidades', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(2, 'GERENCIAR_USUARIOS', 'Criar, editar e excluir usuários', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(3, 'GERENCIAR_AVALIACOES', 'Criar, editar e excluir avaliações', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(4, 'VISUALIZAR_RELATORIOS', 'Visualizar relatórios e estatísticas', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(5, 'CRIAR_AVALIACOES', 'Criar novas avaliações', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(6, 'EDITAR_AVALIACOES_PROPRIAS', 'Editar apenas suas próprias avaliações', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(7, 'VISUALIZAR_AVALIACOES_PROPRIAS', 'Visualizar apenas suas próprias avaliações', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(8, 'GERENCIAR_DISCIPLINAS', 'Gerenciar disciplinas e turmas', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(9, 'GERENCIAR_AGENDA', 'Gerenciar eventos da agenda', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(10, 'VISUALIZAR_AGENDA', 'Visualizar eventos da agenda', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(11, 'AVALIAR_ESTUDANTES', 'Realizar avaliações de estudantes', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(12, 'SER_AVALIADO', 'Ser avaliado por outros usuários', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL);

--
-- Despejando dados para a tabela `questionarios`
--

INSERT INTO `questionarios` (`id_questionario`, `nome_modelo`, `descricao`, `tipo_avaliacao`, `ativo`, `data_criacao`, `data_atualizacao`) VALUES
(1, 'Mini Clinical Evaluation Exercise (Mini-CEX)', 'Avaliação clínica estruturada para competências médicas básicas', 'MINI_CEX', 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(2, 'Avaliação 360° - Professor/Preceptor', 'Avaliação formativa realizada por professores e preceptores', 'AVALIACAO_360_PROFESSOR', 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(3, 'Avaliação 360° - Pares', 'Avaliação formativa realizada por colegas estudantes', 'AVALIACAO_360_PARES', 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(4, 'Avaliação 360° - Equipe de Saúde', 'Avaliação formativa realizada pela equipe multiprofissional', 'AVALIACAO_360_EQUIPE', 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(5, 'Avaliação 360° - Paciente/Família', 'Avaliação formativa realizada por pacientes e familiares', 'AVALIACAO_360_PACIENTE', 1, '2025-08-26 22:30:06', '2025-08-26 22:30:06');

--
-- Despejando dados para a tabela `respostas_itens_avaliacao`
--

INSERT INTO `respostas_itens_avaliacao` (`id_resposta_avaliacao`, `id_avaliacao_preenchida`, `id_competencia_questionario`, `resposta_valor_numerico`, `resposta_texto`, `resposta_multipla_escolha`, `nao_avaliado`, `data_criacao`, `data_atualizacao`) VALUES
(1, 1, 1, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(2, 1, 2, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(3, 1, 3, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(4, 1, 4, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(5, 1, 5, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(6, 1, 6, 5.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(7, 1, 7, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(8, 2, 1, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(9, 2, 2, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(10, 2, 3, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(11, 2, 4, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(12, 2, 5, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(13, 2, 6, 5.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(14, 2, 7, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(15, 3, 1, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(16, 3, 2, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(17, 3, 3, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(18, 3, 4, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(19, 3, 5, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(20, 3, 6, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(21, 3, 7, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(22, 4, 8, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(23, 4, 9, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(24, 4, 10, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(25, 4, 11, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(26, 4, 12, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(27, 4, 13, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(28, 4, 14, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(29, 5, 8, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(30, 5, 9, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(31, 5, 10, 9.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(32, 5, 11, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(33, 5, 12, 9.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(34, 5, 13, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(35, 5, 14, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(36, 6, 15, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(37, 6, 16, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(38, 6, 17, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(39, 6, 18, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(40, 6, 19, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(41, 6, 20, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(42, 6, 21, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(43, 6, 22, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(44, 6, 23, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(45, 6, 24, 9.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(46, 7, 15, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(47, 7, 16, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(48, 7, 17, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(49, 7, 18, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(50, 7, 19, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(51, 7, 20, 6.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(52, 7, 21, 8.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(53, 7, 22, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(54, 7, 23, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(55, 7, 24, 7.0, NULL, NULL, 0, '2025-08-26 22:30:06', '2025-08-26 22:30:06'),
(56, 11, 15, 7.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(57, 11, 16, 6.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(58, 11, 17, 7.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(59, 11, 18, 8.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(60, 11, 19, 9.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(61, 11, 20, 6.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(62, 11, 21, 7.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(63, 11, 22, 8.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(64, 11, 23, 8.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(65, 11, 24, 8.0, NULL, NULL, 0, '2025-08-26 22:56:07', '2025-08-26 22:56:07'),
(66, 12, 15, 8.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(67, 12, 16, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(68, 12, 17, 8.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(69, 12, 18, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(70, 12, 19, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(71, 12, 20, 6.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(72, 12, 21, 8.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(73, 12, 22, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(74, 12, 23, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(75, 12, 24, 7.0, NULL, NULL, 0, '2025-08-30 19:53:32', '2025-08-30 19:53:32'),
(76, 13, 15, 7.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(77, 13, 16, 6.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(78, 13, 17, 7.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(79, 13, 18, 8.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(80, 13, 19, 9.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(81, 13, 20, 6.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(82, 13, 21, 7.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(83, 13, 22, 8.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(84, 13, 23, 8.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(85, 13, 24, 9.0, NULL, NULL, 0, '2025-08-30 19:54:17', '2025-08-30 19:54:17'),
(86, 14, 8, 8.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(87, 14, 9, 7.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(88, 14, 10, 9.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(89, 14, 11, 6.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(90, 14, 12, 9.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(91, 14, 13, 7.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(92, 14, 14, 8.0, NULL, NULL, 0, '2025-08-30 19:55:07', '2025-08-30 19:55:07'),
(103, 19, 35, 1.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(104, 19, 36, 5.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(105, 19, 37, 3.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(106, 19, 38, 2.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(107, 19, 39, 9.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(108, 19, 40, 8.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(109, 19, 41, 6.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(110, 19, 42, 7.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(111, 19, 43, 4.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(112, 19, 44, 3.0, NULL, NULL, 0, '2025-08-31 19:17:01', '2025-08-31 19:17:01'),
(123, 23, 25, 1.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(124, 23, 26, 2.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(125, 23, 27, 3.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(126, 23, 28, 4.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(127, 23, 29, 5.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(128, 23, 30, 6.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(129, 23, 31, 7.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(130, 23, 32, 8.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(131, 23, 33, 9.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(132, 23, 34, 5.0, NULL, NULL, 0, '2025-09-01 00:06:19', '2025-09-01 00:06:19'),
(133, 24, 25, 1.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(134, 24, 26, 1.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(135, 24, 27, 1.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(136, 24, 28, 2.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(137, 24, 29, 2.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(138, 24, 30, 2.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(139, 24, 31, 5.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(140, 24, 32, 5.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(141, 24, 33, 5.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(142, 24, 34, 8.0, NULL, NULL, 0, '2025-09-01 00:13:11', '2025-09-01 00:13:11'),
(153, 15, 15, 1.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(154, 15, 16, 2.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(155, 15, 17, 3.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(156, 15, 18, 4.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(157, 15, 19, 5.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(158, 15, 20, 6.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(159, 15, 21, 4.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(160, 15, 22, 3.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(161, 15, 23, 2.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(162, 15, 24, 1.0, NULL, NULL, 0, '2025-09-01 00:25:28', '2025-09-01 00:25:28'),
(163, 25, 35, 1.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(164, 25, 36, 4.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(165, 25, 37, 3.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(166, 25, 38, 2.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(167, 25, 39, 5.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(168, 25, 40, 5.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(169, 25, 41, 5.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(170, 25, 42, 5.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(171, 25, 43, 3.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(172, 25, 44, 6.0, NULL, NULL, 0, '2025-09-01 01:01:21', '2025-09-01 01:01:21'),
(173, 26, 25, 5.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(174, 26, 26, 4.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(175, 26, 27, 5.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(176, 26, 28, 4.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(177, 26, 29, 5.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(178, 26, 30, 4.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(179, 26, 31, 5.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(180, 26, 32, 4.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(181, 26, 33, 5.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47'),
(182, 26, 34, 4.0, NULL, NULL, 0, '2025-09-01 01:32:47', '2025-09-01 01:32:47');

--
-- Despejando dados para a tabela `turmas`
--

INSERT INTO `turmas` (`id_turma`, `nome_turma`, `ano_letivo`, `semestre`, `data_inicio`, `data_fim`, `ativo`, `data_criacao`, `data_atualizacao`, `codigo_turma`) VALUES
(1, '3º Período - Turma A', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(2, '3º Período - Turma B', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(3, '5º Período - Turma A', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(4, '5º Período - Turma B', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(5, '7º Período - Turma A', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(6, '7º Período - Turma B', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(7, '9º Período - Turma A', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(8, '9º Período - Turma B', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(9, '11º Período - Turma A', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL),
(10, '11º Período - Turma B', '2025', 1, '2025-02-01', '2025-06-30', 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05', NULL);

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nome_completo`, `email`, `senha_hash`, `tipo_usuario`, `matricula_RA`, `telefone`, `foto_perfil_path`, `ativo`, `periodo_atual_aluno`, `observacoes_gerais_aluno`, `id_permissao`, `data_criacao`, `data_atualizacao`) VALUES
(1, 'Dr. Carlos Eduardo Silva', 'admin@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'ADM001', '(11) 99999-0001', NULL, 1, NULL, NULL, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(2, 'Dra. Maria Fernanda Costa', 'admin2@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'ADM002', '(11) 99999-0002', NULL, 1, NULL, NULL, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(3, 'Dr. Roberto Mendes', 'coordenador@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'COORDENADOR', 'COORD001', '(11) 99999-0003', NULL, 1, NULL, NULL, 4, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(4, 'Dra. Ana Paula Santos', 'coordenadora2@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'COORDENADOR', 'COORD002', '(11) 99999-0004', NULL, 1, NULL, NULL, 4, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(5, 'Dr. João Carlos Oliveira', 'joao.oliveira@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF001', '(11) 99999-0005', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(6, 'Dra. Mariana Rodrigues', 'mariana.rodrigues@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF002', '(11) 99999-0006', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(7, 'Dr. Pedro Henrique Lima', 'pedro.lima@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF003', '(11) 99999-0007', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(8, 'Dra. Fernanda Alves', 'fernanda.alves@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF004', '(11) 99999-0008', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(9, 'Dr. Ricardo Barbosa', 'ricardo.barbosa@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF005', '(11) 99999-0009', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(10, 'Dra. Juliana Ferreira', 'juliana.ferreira@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'PROFESSOR', 'PROF006', '(11) 99999-0010', NULL, 1, NULL, NULL, 11, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(11, 'Lucas Gabriel Santos', 'lucas.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001001', '(11) 99999-1001', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(12, 'Ana Carolina Silva', 'ana.silva@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001002', '(11) 99999-1002', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(13, 'Felipe Augusto Costa', 'felipe.costa@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001003', '(11) 99999-1003', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(14, 'Beatriz Oliveira Lima', 'beatriz.lima@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001004', '(11) 99999-1004', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(15, 'Matheus Henrique Souza', 'matheus.souza@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001005', '(11) 99999-1005', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(16, 'Gabriela Fernandes', 'gabriela.fernandes@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001006', '(11) 99999-1006', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(17, 'Rafael Pereira Santos', 'rafael.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001007', '(11) 99999-1007', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(18, 'Camila Rodrigues', 'camila.rodrigues@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001008', '(11) 99999-1008', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(19, 'Thiago Almeida', 'thiago.almeida@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001009', '(11) 99999-1009', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(20, 'Larissa Martins', 'larissa.martins@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA001010', '(11) 99999-1010', NULL, 1, '3', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(21, 'Eduardo Silva Neto', 'eduardo.neto@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002001', '(11) 99999-2001', NULL, 1, '5', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(22, 'Isabela Costa Santos', 'isabela.santos@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002002', '(11) 99999-2002', NULL, 1, '5', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(23, 'Vinícius Oliveira', 'vinicius.oliveira@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002003', '(11) 99999-2003', NULL, 1, '5', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(24, 'Natália Ferreira', 'natalia.ferreira@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002004', '(11) 99999-2004', NULL, 1, '5', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(25, 'Bruno Henrique Lima', 'bruno.lima@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA002005', '(11) 99999-2005', NULL, 1, '5', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(26, 'Amanda Ribeiro', 'amanda.ribeiro@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003001', '(11) 99999-3001', NULL, 1, '7', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(27, 'Gustavo Barbosa', 'gustavo.barbosa@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003002', '(11) 99999-3002', NULL, 1, '7', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(28, 'Priscila Alves', 'priscila.alves@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003003', '(11) 99999-3003', NULL, 1, '7', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(29, 'Rodrigo Mendes', 'rodrigo.mendes@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003004', '(11) 99999-3004', NULL, 1, '7', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(30, 'Carolina Dias', 'carolina.dias@aluno.unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ESTUDANTE', 'RA003005', '(11) 99999-3005', NULL, 1, '7', NULL, 12, '2025-08-26 22:30:05', '2025-08-26 22:30:05'),
(31, 'Usuário Teste', 'teste@unifae.br', '$2b$12$LQv3c1yqBwlVHpPjrxHCLe4cSBY6k9UYd7tn8CdHllUyqCdMf.ZWG', 'ADMINISTRADOR', 'TESTE001', '(11) 99999-9999', NULL, 1, NULL, NULL, 1, '2025-08-26 22:30:05', '2025-08-26 22:30:05');

--
-- Despejando dados para a tabela `usuarios_permissoes`
--

INSERT INTO `usuarios_permissoes` (`id_usuario_permissao`, `id_usuario`, `id_permissao`, `data_atribuicao`) VALUES
(1, 1, 1, '2025-08-26 22:30:05'),
(2, 1, 2, '2025-08-26 22:30:05'),
(3, 1, 3, '2025-08-26 22:30:05'),
(4, 1, 4, '2025-08-26 22:30:05'),
(5, 1, 5, '2025-08-26 22:30:05'),
(6, 1, 6, '2025-08-26 22:30:05'),
(7, 1, 7, '2025-08-26 22:30:05'),
(8, 1, 8, '2025-08-26 22:30:05'),
(9, 1, 9, '2025-08-26 22:30:05'),
(10, 1, 10, '2025-08-26 22:30:05'),
(11, 1, 11, '2025-08-26 22:30:05'),
(12, 1, 12, '2025-08-26 22:30:05'),
(13, 2, 1, '2025-08-26 22:30:05'),
(14, 2, 2, '2025-08-26 22:30:05'),
(15, 2, 3, '2025-08-26 22:30:05'),
(16, 2, 4, '2025-08-26 22:30:05'),
(17, 2, 5, '2025-08-26 22:30:05'),
(18, 2, 6, '2025-08-26 22:30:05'),
(19, 2, 7, '2025-08-26 22:30:05'),
(20, 2, 8, '2025-08-26 22:30:05'),
(21, 2, 9, '2025-08-26 22:30:05'),
(22, 2, 10, '2025-08-26 22:30:05'),
(23, 2, 11, '2025-08-26 22:30:05'),
(24, 2, 12, '2025-08-26 22:30:05'),
(25, 31, 1, '2025-08-26 22:30:05'),
(26, 31, 2, '2025-08-26 22:30:05'),
(27, 31, 3, '2025-08-26 22:30:05'),
(28, 31, 4, '2025-08-26 22:30:05'),
(29, 31, 5, '2025-08-26 22:30:05'),
(30, 31, 6, '2025-08-26 22:30:05'),
(31, 31, 7, '2025-08-26 22:30:05'),
(32, 31, 8, '2025-08-26 22:30:05'),
(33, 31, 9, '2025-08-26 22:30:05'),
(34, 31, 10, '2025-08-26 22:30:05'),
(35, 31, 11, '2025-08-26 22:30:05'),
(36, 31, 12, '2025-08-26 22:30:05'),
(37, 3, 2, '2025-08-26 22:30:05'),
(38, 3, 3, '2025-08-26 22:30:05'),
(39, 3, 4, '2025-08-26 22:30:05'),
(40, 3, 5, '2025-08-26 22:30:05'),
(41, 3, 6, '2025-08-26 22:30:05'),
(42, 3, 7, '2025-08-26 22:30:05'),
(43, 3, 8, '2025-08-26 22:30:05'),
(44, 3, 9, '2025-08-26 22:30:05'),
(45, 3, 10, '2025-08-26 22:30:05'),
(46, 3, 11, '2025-08-26 22:30:05'),
(47, 4, 2, '2025-08-26 22:30:05'),
(48, 4, 3, '2025-08-26 22:30:05'),
(49, 4, 4, '2025-08-26 22:30:05'),
(50, 4, 5, '2025-08-26 22:30:05'),
(51, 4, 6, '2025-08-26 22:30:05'),
(52, 4, 7, '2025-08-26 22:30:05'),
(53, 4, 8, '2025-08-26 22:30:05'),
(54, 4, 9, '2025-08-26 22:30:05'),
(55, 4, 10, '2025-08-26 22:30:05'),
(56, 4, 11, '2025-08-26 22:30:05'),
(57, 5, 5, '2025-08-26 22:30:05'),
(58, 5, 6, '2025-08-26 22:30:05'),
(59, 5, 7, '2025-08-26 22:30:05'),
(60, 5, 10, '2025-08-26 22:30:05'),
(61, 5, 11, '2025-08-26 22:30:05'),
(62, 6, 5, '2025-08-26 22:30:05'),
(63, 6, 6, '2025-08-26 22:30:05'),
(64, 6, 7, '2025-08-26 22:30:05'),
(65, 6, 10, '2025-08-26 22:30:05'),
(66, 6, 11, '2025-08-26 22:30:05'),
(67, 7, 5, '2025-08-26 22:30:05'),
(68, 7, 6, '2025-08-26 22:30:05'),
(69, 7, 7, '2025-08-26 22:30:05'),
(70, 7, 10, '2025-08-26 22:30:05'),
(71, 7, 11, '2025-08-26 22:30:05'),
(72, 8, 5, '2025-08-26 22:30:05'),
(73, 8, 6, '2025-08-26 22:30:05'),
(74, 8, 7, '2025-08-26 22:30:05'),
(75, 8, 10, '2025-08-26 22:30:05'),
(76, 8, 11, '2025-08-26 22:30:05'),
(77, 9, 5, '2025-08-26 22:30:05'),
(78, 9, 6, '2025-08-26 22:30:05'),
(79, 9, 7, '2025-08-26 22:30:05'),
(80, 9, 10, '2025-08-26 22:30:05'),
(81, 9, 11, '2025-08-26 22:30:05'),
(82, 10, 5, '2025-08-26 22:30:05'),
(83, 10, 6, '2025-08-26 22:30:05'),
(84, 10, 7, '2025-08-26 22:30:05'),
(85, 10, 10, '2025-08-26 22:30:05'),
(86, 10, 11, '2025-08-26 22:30:05'),
(87, 11, 7, '2025-08-26 22:30:05'),
(88, 11, 10, '2025-08-26 22:30:05'),
(89, 11, 12, '2025-08-26 22:30:05'),
(90, 12, 7, '2025-08-26 22:30:05'),
(91, 12, 10, '2025-08-26 22:30:05'),
(92, 12, 12, '2025-08-26 22:30:05'),
(93, 13, 7, '2025-08-26 22:30:05'),
(94, 13, 10, '2025-08-26 22:30:05'),
(95, 13, 12, '2025-08-26 22:30:05'),
(96, 14, 7, '2025-08-26 22:30:05'),
(97, 14, 10, '2025-08-26 22:30:05'),
(98, 14, 12, '2025-08-26 22:30:05'),
(99, 15, 7, '2025-08-26 22:30:05'),
(100, 15, 10, '2025-08-26 22:30:05'),
(101, 15, 12, '2025-08-26 22:30:05'),
(102, 16, 7, '2025-08-26 22:30:05'),
(103, 16, 10, '2025-08-26 22:30:05'),
(104, 16, 12, '2025-08-26 22:30:05'),
(105, 17, 7, '2025-08-26 22:30:05'),
(106, 17, 10, '2025-08-26 22:30:05'),
(107, 17, 12, '2025-08-26 22:30:05'),
(108, 18, 7, '2025-08-26 22:30:05'),
(109, 18, 10, '2025-08-26 22:30:05'),
(110, 18, 12, '2025-08-26 22:30:05'),
(111, 19, 7, '2025-08-26 22:30:05'),
(112, 19, 10, '2025-08-26 22:30:05'),
(113, 19, 12, '2025-08-26 22:30:05'),
(114, 20, 7, '2025-08-26 22:30:05'),
(115, 20, 10, '2025-08-26 22:30:05'),
(116, 20, 12, '2025-08-26 22:30:05'),
(117, 21, 7, '2025-08-26 22:30:05'),
(118, 21, 10, '2025-08-26 22:30:05'),
(119, 21, 12, '2025-08-26 22:30:05'),
(120, 22, 7, '2025-08-26 22:30:05'),
(121, 22, 10, '2025-08-26 22:30:05'),
(122, 22, 12, '2025-08-26 22:30:05'),
(123, 23, 7, '2025-08-26 22:30:05'),
(124, 23, 10, '2025-08-26 22:30:05'),
(125, 23, 12, '2025-08-26 22:30:05'),
(126, 24, 7, '2025-08-26 22:30:05'),
(127, 24, 10, '2025-08-26 22:30:05'),
(128, 24, 12, '2025-08-26 22:30:05'),
(129, 25, 7, '2025-08-26 22:30:05'),
(130, 25, 10, '2025-08-26 22:30:05'),
(131, 25, 12, '2025-08-26 22:30:05'),
(132, 26, 7, '2025-08-26 22:30:05'),
(133, 26, 10, '2025-08-26 22:30:05'),
(134, 26, 12, '2025-08-26 22:30:05'),
(135, 27, 7, '2025-08-26 22:30:05'),
(136, 27, 10, '2025-08-26 22:30:05'),
(137, 27, 12, '2025-08-26 22:30:05'),
(138, 28, 7, '2025-08-26 22:30:05'),
(139, 28, 10, '2025-08-26 22:30:05'),
(140, 28, 12, '2025-08-26 22:30:05'),
(141, 29, 7, '2025-08-26 22:30:05'),
(142, 29, 10, '2025-08-26 22:30:05'),
(143, 29, 12, '2025-08-26 22:30:05'),
(144, 30, 7, '2025-08-26 22:30:05'),
(145, 30, 10, '2025-08-26 22:30:05'),
(146, 30, 12, '2025-08-26 22:30:05');

--
-- Despejando dados para a tabela `usuarios_turmas`
--

INSERT INTO `usuarios_turmas` (`id_usuario_turma`, `id_usuario`, `id_turma`, `papel`, `data_vinculacao`, `ativo`) VALUES
(1, 11, 1, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(2, 12, 1, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(3, 13, 1, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(4, 14, 1, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(5, 15, 1, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(6, 5, 1, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(7, 6, 1, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(8, 16, 2, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(9, 17, 2, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(10, 18, 2, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(11, 19, 2, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(12, 20, 2, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(13, 7, 2, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(14, 8, 2, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(15, 21, 3, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(16, 22, 3, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(17, 23, 3, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(18, 9, 3, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(19, 10, 3, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(20, 24, 4, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(21, 25, 4, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(22, 5, 4, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(23, 6, 4, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(24, 26, 5, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(25, 27, 5, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(26, 28, 5, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(27, 7, 5, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(28, 8, 5, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(29, 29, 6, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(30, 30, 6, 'ESTUDANTE', '2025-08-26 22:30:06', 1),
(31, 9, 6, 'PROFESSOR', '2025-08-26 22:30:06', 1),
(32, 10, 6, 'PROFESSOR', '2025-08-26 22:30:06', 1);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_avaliacoes_completas`
--
DROP TABLE IF EXISTS `vw_avaliacoes_completas`;

DROP VIEW IF EXISTS `vw_avaliacoes_completas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_avaliacoes_completas`  AS SELECT `ap`.`id_avaliacao_preenchida` AS `id_avaliacao_preenchida`, `ap`.`data_realizacao` AS `data_realizacao`, `ap`.`horario_inicio` AS `horario_inicio`, `ap`.`horario_fim` AS `horario_fim`, `ap`.`status_avaliacao` AS `status_avaliacao`, `q`.`nome_modelo` AS `questionario`, `q`.`tipo_avaliacao` AS `tipo_avaliacao`, `aluno`.`nome_completo` AS `nome_aluno`, `aluno`.`email` AS `email_aluno`, `avaliador`.`nome_completo` AS `nome_avaliador`, `avaliador`.`email` AS `email_avaliador`, `d`.`nome_disciplina` AS `nome_disciplina`, `t`.`nome_turma` AS `nome_turma`, `le`.`nome_local` AS `nome_local`, `ap`.`feedback_positivo` AS `feedback_positivo`, `ap`.`feedback_melhoria` AS `feedback_melhoria`, `ap`.`data_criacao` AS `data_criacao` FROM ((((((`avaliacoes_preenchidas` `ap` join `questionarios` `q` on(`ap`.`id_questionario` = `q`.`id_questionario`)) join `usuarios` `aluno` on(`ap`.`id_aluno_avaliado` = `aluno`.`id_usuario`)) join `usuarios` `avaliador` on(`ap`.`id_avaliador` = `avaliador`.`id_usuario`)) left join `disciplinas` `d` on(`ap`.`id_disciplina` = `d`.`id_disciplina`)) left join `turmas` `t` on(`ap`.`id_turma` = `t`.`id_turma`)) left join `locais_eventos` `le` on(`ap`.`id_local_evento` = `le`.`id_local_evento`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_estatisticas_avaliacoes`
--
DROP TABLE IF EXISTS `vw_estatisticas_avaliacoes`;

DROP VIEW IF EXISTS `vw_estatisticas_avaliacoes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_estatisticas_avaliacoes`  AS SELECT `u`.`id_usuario` AS `id_usuario`, `u`.`nome_completo` AS `nome_completo`, `u`.`tipo_usuario` AS `tipo_usuario`, count(case when `ap`.`id_aluno_avaliado` = `u`.`id_usuario` then 1 end) AS `total_como_avaliado`, count(case when `ap`.`id_avaliador` = `u`.`id_usuario` then 1 end) AS `total_como_avaliador`, count(case when `ap`.`id_aluno_avaliado` = `u`.`id_usuario` and `ap`.`status_avaliacao` = 'FINALIZADA' then 1 end) AS `finalizadas_como_avaliado`, count(case when `ap`.`id_avaliador` = `u`.`id_usuario` and `ap`.`status_avaliacao` = 'FINALIZADA' then 1 end) AS `finalizadas_como_avaliador`, avg(case when `ria`.`id_avaliacao_preenchida` in (select `avaliacoes_preenchidas`.`id_avaliacao_preenchida` from `avaliacoes_preenchidas` where `avaliacoes_preenchidas`.`id_aluno_avaliado` = `u`.`id_usuario`) then `ria`.`resposta_valor_numerico` end) AS `media_notas_recebidas` FROM ((`usuarios` `u` left join `avaliacoes_preenchidas` `ap` on(`u`.`id_usuario` = `ap`.`id_aluno_avaliado` or `u`.`id_usuario` = `ap`.`id_avaliador`)) left join `respostas_itens_avaliacao` `ria` on(`ap`.`id_avaliacao_preenchida` = `ria`.`id_avaliacao_preenchida`)) WHERE `u`.`ativo` = 1 GROUP BY `u`.`id_usuario`, `u`.`nome_completo`, `u`.`tipo_usuario` ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_usuarios_permissoes`
--
DROP TABLE IF EXISTS `vw_usuarios_permissoes`;

DROP VIEW IF EXISTS `vw_usuarios_permissoes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_usuarios_permissoes`  AS SELECT `u`.`id_usuario` AS `id_usuario`, `u`.`nome_completo` AS `nome_completo`, `u`.`email` AS `email`, `u`.`tipo_usuario` AS `tipo_usuario`, `u`.`ativo` AS `usuario_ativo`, group_concat(`p`.`nome_permissao` separator ', ') AS `permissoes` FROM ((`usuarios` `u` left join `usuarios_permissoes` `up` on(`u`.`id_usuario` = `up`.`id_usuario`)) left join `permissoes` `p` on(`up`.`id_permissao` = `p`.`id_permissao` and `p`.`ativo` = 1)) WHERE `u`.`ativo` = 1 GROUP BY `u`.`id_usuario`, `u`.`nome_completo`, `u`.`email`, `u`.`tipo_usuario`, `u`.`ativo` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
