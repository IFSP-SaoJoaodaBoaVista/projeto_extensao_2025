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

-- --------------------------------------------------------

--
-- Estrutura para tabela `agenda_disciplinas_vinculadas`
--

DROP TABLE IF EXISTS `agenda_disciplinas_vinculadas`;
CREATE TABLE `agenda_disciplinas_vinculadas` (
  `id_agenda_disciplina` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacoes_preenchidas`
--

DROP TABLE IF EXISTS `avaliacoes_preenchidas`;
CREATE TABLE `avaliacoes_preenchidas` (
  `id_avaliacao_preenchida` int(11) NOT NULL,
  `id_questionario` int(11) NOT NULL,
  `id_aluno_avaliado` int(11) NOT NULL,
  `id_avaliador` int(11) DEFAULT NULL,
  `id_disciplina` int(11) DEFAULT NULL,
  `id_turma` int(11) DEFAULT NULL,
  `id_local_evento` int(11) DEFAULT NULL,
  `data_realizacao` date NOT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fim` time DEFAULT NULL,
  `feedback_positivo` text DEFAULT NULL,
  `feedback_melhoria` text DEFAULT NULL,
  `contrato_aprendizagem` text DEFAULT NULL,
  `status_avaliacao` enum('RASCUNHO','FINALIZADA','CANCELADA') DEFAULT 'RASCUNHO',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `local_realizacao` varchar(255) DEFAULT NULL,
  `nome_avaliador_nao_usuario` varchar(100) DEFAULT NULL,
  `tipo_avaliador_nao_usuario` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `competencias_questionario`
--

DROP TABLE IF EXISTS `competencias_questionario`;
CREATE TABLE `competencias_questionario` (
  `id_competencia_questionario` int(11) NOT NULL,
  `id_questionario` int(11) NOT NULL,
  `nome_competencia` varchar(255) NOT NULL,
  `tipo_item` enum('escala_numerica','texto_livre','multipla_escolha','checkbox') DEFAULT 'escala_numerica',
  `descricao_prompt` text DEFAULT NULL,
  `ordem_exibicao` int(11) DEFAULT 0,
  `obrigatorio` tinyint(1) DEFAULT 1,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
CREATE TABLE `disciplinas` (
  `id_disciplina` int(11) NOT NULL,
  `nome_disciplina` varchar(255) NOT NULL,
  `codigo_disciplina` varchar(20) NOT NULL,
  `descricao` text DEFAULT NULL,
  `carga_horaria` int(11) DEFAULT 0,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ativa` bit(1) NOT NULL,
  `sigla_disciplina` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas_turmas`
--

DROP TABLE IF EXISTS `disciplinas_turmas`;
CREATE TABLE `disciplinas_turmas` (
  `id_disciplina_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_professor` int(11) DEFAULT NULL,
  `data_vinculacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `eventos_agenda`
--

DROP TABLE IF EXISTS `eventos_agenda`;
CREATE TABLE `eventos_agenda` (
  `id_evento` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `id_local_evento` int(11) DEFAULT NULL,
  `id_disciplina` int(11) DEFAULT NULL,
  `id_turma` int(11) DEFAULT NULL,
  `id_responsavel` int(11) DEFAULT NULL,
  `tipo_evento` enum('AULA','PROVA','SEMINARIO','AVALIACAO','REUNIAO','EVENTO') DEFAULT 'AULA',
  `status_evento` enum('AGENDADO','EM_ANDAMENTO','CONCLUIDO','CANCELADO') DEFAULT 'AGENDADO',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `locais_eventos`
--

DROP TABLE IF EXISTS `locais_eventos`;
CREATE TABLE `locais_eventos` (
  `id_local_evento` int(11) NOT NULL,
  `nome_local` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `endereco` varchar(500) DEFAULT NULL,
  `capacidade` int(11) DEFAULT 0,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `tipo_local` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_acoes`
--

DROP TABLE IF EXISTS `log_acoes`;
CREATE TABLE `log_acoes` (
  `id_log` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `acao` varchar(100) NOT NULL,
  `tabela_afetada` varchar(100) DEFAULT NULL,
  `id_registro_afetado` int(11) DEFAULT NULL,
  `dados_anteriores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dados_anteriores`)),
  `dados_novos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dados_novos`)),
  `ip_usuario` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `data_acao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `participantes_eventos`
--

DROP TABLE IF EXISTS `participantes_eventos`;
CREATE TABLE `participantes_eventos` (
  `id_participante_evento` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `papel_participante` enum('ORGANIZADOR','PARTICIPANTE','CONVIDADO') DEFAULT 'PARTICIPANTE',
  `confirmado` tinyint(1) DEFAULT 0,
  `data_confirmacao` timestamp NULL DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissoes`
--

DROP TABLE IF EXISTS `permissoes`;
CREATE TABLE `permissoes` (
  `id_permissao` int(11) NOT NULL,
  `nome_permissao` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `descricao_permissao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `questionarios`
--

DROP TABLE IF EXISTS `questionarios`;
CREATE TABLE `questionarios` (
  `id_questionario` int(11) NOT NULL,
  `nome_modelo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `tipo_avaliacao` enum('MINI_CEX','AVALIACAO_360_PROFESSOR','AVALIACAO_360_PARES','AVALIACAO_360_EQUIPE','AVALIACAO_360_PACIENTE') NOT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `respostas_itens_avaliacao`
--

DROP TABLE IF EXISTS `respostas_itens_avaliacao`;
CREATE TABLE `respostas_itens_avaliacao` (
  `id_resposta_avaliacao` int(11) NOT NULL,
  `id_avaliacao_preenchida` int(11) NOT NULL,
  `id_competencia_questionario` int(11) NOT NULL,
  `resposta_valor_numerico` decimal(4,1) DEFAULT NULL,
  `resposta_texto` text DEFAULT NULL,
  `resposta_multipla_escolha` varchar(255) DEFAULT NULL,
  `nao_avaliado` tinyint(1) DEFAULT 0,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

DROP TABLE IF EXISTS `turmas`;
CREATE TABLE `turmas` (
  `id_turma` int(11) NOT NULL,
  `nome_turma` varchar(255) NOT NULL,
  `ano_letivo` year(4) NOT NULL,
  `semestre` tinyint(4) NOT NULL CHECK (`semestre` in (1,2)),
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `codigo_turma` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome_completo` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `tipo_usuario` enum('ESTUDANTE','PROFESSOR','COORDENADOR','ADMINISTRADOR') NOT NULL,
  `matricula_RA` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `foto_perfil_path` varchar(500) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `periodo_atual_aluno` varchar(2) DEFAULT NULL,
  `observacoes_gerais_aluno` text DEFAULT NULL,
  `id_permissao` int(11) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Acionadores `usuarios`
--
DROP TRIGGER IF EXISTS `tr_usuarios_insert`;
DELIMITER $$
CREATE TRIGGER `tr_usuarios_insert` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO log_acoes (id_usuario, acao, tabela_afetada, id_registro_afetado, dados_novos)
    VALUES (NEW.id_usuario, 'INSERT', 'usuarios', NEW.id_usuario, JSON_OBJECT(
        'nome_completo', NEW.nome_completo,
        'email', NEW.email,
        'tipo_usuario', NEW.tipo_usuario,
        'ativo', NEW.ativo
    ));
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `tr_usuarios_update`;
DELIMITER $$
CREATE TRIGGER `tr_usuarios_update` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios_permissoes`
--

DROP TABLE IF EXISTS `usuarios_permissoes`;
CREATE TABLE `usuarios_permissoes` (
  `id_usuario_permissao` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_permissao` int(11) NOT NULL,
  `data_atribuicao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios_turmas`
--

DROP TABLE IF EXISTS `usuarios_turmas`;
CREATE TABLE `usuarios_turmas` (
  `id_usuario_turma` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `papel` enum('ESTUDANTE','PROFESSOR','MONITOR') NOT NULL,
  `data_vinculacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_avaliacoes_completas`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `vw_avaliacoes_completas`;
CREATE TABLE `vw_avaliacoes_completas` (
`id_avaliacao_preenchida` int(11)
,`data_realizacao` date
,`horario_inicio` time
,`horario_fim` time
,`status_avaliacao` enum('RASCUNHO','FINALIZADA','CANCELADA')
,`questionario` varchar(255)
,`tipo_avaliacao` enum('MINI_CEX','AVALIACAO_360_PROFESSOR','AVALIACAO_360_PARES','AVALIACAO_360_EQUIPE','AVALIACAO_360_PACIENTE')
,`nome_aluno` varchar(255)
,`email_aluno` varchar(255)
,`nome_avaliador` varchar(255)
,`email_avaliador` varchar(255)
,`nome_disciplina` varchar(255)
,`nome_turma` varchar(255)
,`nome_local` varchar(255)
,`feedback_positivo` text
,`feedback_melhoria` text
,`data_criacao` timestamp
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_estatisticas_avaliacoes`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `vw_estatisticas_avaliacoes`;
CREATE TABLE `vw_estatisticas_avaliacoes` (
`id_usuario` int(11)
,`nome_completo` varchar(255)
,`tipo_usuario` enum('ESTUDANTE','PROFESSOR','COORDENADOR','ADMINISTRADOR')
,`total_como_avaliado` bigint(21)
,`total_como_avaliador` bigint(21)
,`finalizadas_como_avaliado` bigint(21)
,`finalizadas_como_avaliador` bigint(21)
,`media_notas_recebidas` decimal(8,5)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_usuarios_permissoes`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `vw_usuarios_permissoes`;
CREATE TABLE `vw_usuarios_permissoes` (
`id_usuario` int(11)
,`nome_completo` varchar(255)
,`email` varchar(255)
,`tipo_usuario` enum('ESTUDANTE','PROFESSOR','COORDENADOR','ADMINISTRADOR')
,`usuario_ativo` tinyint(1)
,`permissoes` mediumtext
);

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

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agenda_disciplinas_vinculadas`
--
ALTER TABLE `agenda_disciplinas_vinculadas`
  ADD PRIMARY KEY (`id_agenda_disciplina`),
  ADD UNIQUE KEY `uk_evento_disciplina` (`id_evento`,`id_disciplina`),
  ADD KEY `idx_agenda_evento` (`id_evento`),
  ADD KEY `idx_agenda_disciplina` (`id_disciplina`);

--
-- Índices de tabela `avaliacoes_preenchidas`
--
ALTER TABLE `avaliacoes_preenchidas`
  ADD PRIMARY KEY (`id_avaliacao_preenchida`),
  ADD KEY `idx_avaliacao_questionario` (`id_questionario`),
  ADD KEY `idx_avaliacao_aluno` (`id_aluno_avaliado`),
  ADD KEY `idx_avaliacao_avaliador` (`id_avaliador`),
  ADD KEY `idx_avaliacao_disciplina` (`id_disciplina`),
  ADD KEY `idx_avaliacao_turma` (`id_turma`),
  ADD KEY `idx_avaliacao_data` (`data_realizacao`),
  ADD KEY `idx_avaliacao_status` (`status_avaliacao`),
  ADD KEY `id_local_evento` (`id_local_evento`),
  ADD KEY `idx_avaliacoes_data_status` (`data_realizacao`,`status_avaliacao`),
  ADD KEY `idx_avaliacoes_aluno_data` (`id_aluno_avaliado`,`data_realizacao`),
  ADD KEY `idx_avaliacoes_avaliador_data` (`id_avaliador`,`data_realizacao`);

--
-- Índices de tabela `competencias_questionario`
--
ALTER TABLE `competencias_questionario`
  ADD PRIMARY KEY (`id_competencia_questionario`),
  ADD KEY `idx_competencia_questionario` (`id_questionario`),
  ADD KEY `idx_competencia_nome` (`nome_competencia`),
  ADD KEY `idx_competencia_ordem` (`ordem_exibicao`),
  ADD KEY `idx_competencia_ativo` (`ativo`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id_disciplina`),
  ADD UNIQUE KEY `codigo_disciplina` (`codigo_disciplina`),
  ADD UNIQUE KEY `UK_o5w330o6es8py0adahujjc83s` (`sigla_disciplina`),
  ADD KEY `idx_disciplina_codigo` (`codigo_disciplina`),
  ADD KEY `idx_disciplina_nome` (`nome_disciplina`),
  ADD KEY `idx_disciplina_ativo` (`ativo`);

--
-- Índices de tabela `disciplinas_turmas`
--
ALTER TABLE `disciplinas_turmas`
  ADD PRIMARY KEY (`id_disciplina_turma`),
  ADD UNIQUE KEY `uk_disciplina_turma` (`id_disciplina`,`id_turma`),
  ADD KEY `idx_disciplina_turma_disciplina` (`id_disciplina`),
  ADD KEY `idx_disciplina_turma_turma` (`id_turma`),
  ADD KEY `idx_disciplina_turma_professor` (`id_professor`);

--
-- Índices de tabela `eventos_agenda`
--
ALTER TABLE `eventos_agenda`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `idx_evento_data_inicio` (`data_inicio`),
  ADD KEY `idx_evento_data_fim` (`data_fim`),
  ADD KEY `idx_evento_local` (`id_local_evento`),
  ADD KEY `idx_evento_disciplina` (`id_disciplina`),
  ADD KEY `idx_evento_turma` (`id_turma`),
  ADD KEY `idx_evento_responsavel` (`id_responsavel`),
  ADD KEY `idx_evento_tipo` (`tipo_evento`),
  ADD KEY `idx_evento_status` (`status_evento`),
  ADD KEY `idx_eventos_data_tipo` (`data_inicio`,`tipo_evento`);

--
-- Índices de tabela `locais_eventos`
--
ALTER TABLE `locais_eventos`
  ADD PRIMARY KEY (`id_local_evento`),
  ADD KEY `idx_local_nome` (`nome_local`),
  ADD KEY `idx_local_ativo` (`ativo`);

--
-- Índices de tabela `log_acoes`
--
ALTER TABLE `log_acoes`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `idx_log_usuario` (`id_usuario`),
  ADD KEY `idx_log_acao` (`acao`),
  ADD KEY `idx_log_tabela` (`tabela_afetada`),
  ADD KEY `idx_log_data` (`data_acao`);

--
-- Índices de tabela `participantes_eventos`
--
ALTER TABLE `participantes_eventos`
  ADD PRIMARY KEY (`id_participante_evento`),
  ADD UNIQUE KEY `uk_evento_usuario` (`id_evento`,`id_usuario`),
  ADD KEY `idx_participante_evento` (`id_evento`),
  ADD KEY `idx_participante_usuario` (`id_usuario`),
  ADD KEY `idx_participante_papel` (`papel_participante`),
  ADD KEY `idx_participante_confirmado` (`confirmado`);

--
-- Índices de tabela `permissoes`
--
ALTER TABLE `permissoes`
  ADD PRIMARY KEY (`id_permissao`),
  ADD UNIQUE KEY `nome_permissao` (`nome_permissao`),
  ADD KEY `idx_permissao_nome` (`nome_permissao`),
  ADD KEY `idx_permissao_ativo` (`ativo`);

--
-- Índices de tabela `questionarios`
--
ALTER TABLE `questionarios`
  ADD PRIMARY KEY (`id_questionario`),
  ADD KEY `idx_questionario_tipo` (`tipo_avaliacao`),
  ADD KEY `idx_questionario_nome` (`nome_modelo`),
  ADD KEY `idx_questionario_ativo` (`ativo`);

--
-- Índices de tabela `respostas_itens_avaliacao`
--
ALTER TABLE `respostas_itens_avaliacao`
  ADD PRIMARY KEY (`id_resposta_avaliacao`),
  ADD UNIQUE KEY `uk_resposta_avaliacao_competencia` (`id_avaliacao_preenchida`,`id_competencia_questionario`),
  ADD KEY `idx_resposta_avaliacao` (`id_avaliacao_preenchida`),
  ADD KEY `idx_resposta_competencia` (`id_competencia_questionario`),
  ADD KEY `idx_resposta_valor` (`resposta_valor_numerico`),
  ADD KEY `idx_resposta_nao_avaliado` (`nao_avaliado`),
  ADD KEY `idx_respostas_valor_competencia` (`resposta_valor_numerico`,`id_competencia_questionario`);

--
-- Índices de tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id_turma`),
  ADD UNIQUE KEY `UK_79r9a4uhk2o7i4cvfel5bfdq` (`codigo_turma`),
  ADD KEY `idx_turma_ano_semestre` (`ano_letivo`,`semestre`),
  ADD KEY `idx_turma_nome` (`nome_turma`),
  ADD KEY `idx_turma_ativo` (`ativo`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `matricula_RA` (`matricula_RA`),
  ADD KEY `idx_usuario_email` (`email`),
  ADD KEY `idx_usuario_tipo` (`tipo_usuario`),
  ADD KEY `idx_usuario_ativo` (`ativo`),
  ADD KEY `idx_usuario_matricula` (`matricula_RA`),
  ADD KEY `id_permissao` (`id_permissao`),
  ADD KEY `idx_usuarios_tipo_ativo` (`tipo_usuario`,`ativo`);

--
-- Índices de tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  ADD PRIMARY KEY (`id_usuario_permissao`),
  ADD UNIQUE KEY `uk_usuario_permissao` (`id_usuario`,`id_permissao`),
  ADD KEY `idx_usuario_permissao_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_permissao_permissao` (`id_permissao`);

--
-- Índices de tabela `usuarios_turmas`
--
ALTER TABLE `usuarios_turmas`
  ADD PRIMARY KEY (`id_usuario_turma`),
  ADD UNIQUE KEY `uk_usuario_turma_papel` (`id_usuario`,`id_turma`,`papel`),
  ADD KEY `idx_usuario_turma_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_turma_turma` (`id_turma`),
  ADD KEY `idx_usuario_turma_papel` (`papel`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agenda_disciplinas_vinculadas`
--
ALTER TABLE `agenda_disciplinas_vinculadas`
  MODIFY `id_agenda_disciplina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `avaliacoes_preenchidas`
--
ALTER TABLE `avaliacoes_preenchidas`
  MODIFY `id_avaliacao_preenchida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `competencias_questionario`
--
ALTER TABLE `competencias_questionario`
  MODIFY `id_competencia_questionario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `disciplinas_turmas`
--
ALTER TABLE `disciplinas_turmas`
  MODIFY `id_disciplina_turma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `eventos_agenda`
--
ALTER TABLE `eventos_agenda`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `locais_eventos`
--
ALTER TABLE `locais_eventos`
  MODIFY `id_local_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log_acoes`
--
ALTER TABLE `log_acoes`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `participantes_eventos`
--
ALTER TABLE `participantes_eventos`
  MODIFY `id_participante_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissoes`
--
ALTER TABLE `permissoes`
  MODIFY `id_permissao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `questionarios`
--
ALTER TABLE `questionarios`
  MODIFY `id_questionario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `respostas_itens_avaliacao`
--
ALTER TABLE `respostas_itens_avaliacao`
  MODIFY `id_resposta_avaliacao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id_turma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  MODIFY `id_usuario_permissao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios_turmas`
--
ALTER TABLE `usuarios_turmas`
  MODIFY `id_usuario_turma` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agenda_disciplinas_vinculadas`
--
ALTER TABLE `agenda_disciplinas_vinculadas`
  ADD CONSTRAINT `agenda_disciplinas_vinculadas_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `eventos_agenda` (`id_evento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `agenda_disciplinas_vinculadas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `avaliacoes_preenchidas`
--
ALTER TABLE `avaliacoes_preenchidas`
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_1` FOREIGN KEY (`id_questionario`) REFERENCES `questionarios` (`id_questionario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_2` FOREIGN KEY (`id_aluno_avaliado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_3` FOREIGN KEY (`id_avaliador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_4` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_5` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_6` FOREIGN KEY (`id_local_evento`) REFERENCES `locais_eventos` (`id_local_evento`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `competencias_questionario`
--
ALTER TABLE `competencias_questionario`
  ADD CONSTRAINT `competencias_questionario_ibfk_1` FOREIGN KEY (`id_questionario`) REFERENCES `questionarios` (`id_questionario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `disciplinas_turmas`
--
ALTER TABLE `disciplinas_turmas`
  ADD CONSTRAINT `disciplinas_turmas_ibfk_1` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `disciplinas_turmas_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `disciplinas_turmas_ibfk_3` FOREIGN KEY (`id_professor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `eventos_agenda`
--
ALTER TABLE `eventos_agenda`
  ADD CONSTRAINT `eventos_agenda_ibfk_1` FOREIGN KEY (`id_local_evento`) REFERENCES `locais_eventos` (`id_local_evento`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `eventos_agenda_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `eventos_agenda_ibfk_3` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `eventos_agenda_ibfk_4` FOREIGN KEY (`id_responsavel`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `log_acoes`
--
ALTER TABLE `log_acoes`
  ADD CONSTRAINT `log_acoes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `participantes_eventos`
--
ALTER TABLE `participantes_eventos`
  ADD CONSTRAINT `participantes_eventos_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `eventos_agenda` (`id_evento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `participantes_eventos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `respostas_itens_avaliacao`
--
ALTER TABLE `respostas_itens_avaliacao`
  ADD CONSTRAINT `respostas_itens_avaliacao_ibfk_1` FOREIGN KEY (`id_avaliacao_preenchida`) REFERENCES `avaliacoes_preenchidas` (`id_avaliacao_preenchida`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respostas_itens_avaliacao_ibfk_2` FOREIGN KEY (`id_competencia_questionario`) REFERENCES `competencias_questionario` (`id_competencia_questionario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_permissao`) REFERENCES `permissoes` (`id_permissao`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  ADD CONSTRAINT `usuarios_permissoes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_permissoes_ibfk_2` FOREIGN KEY (`id_permissao`) REFERENCES `permissoes` (`id_permissao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuarios_turmas`
--
ALTER TABLE `usuarios_turmas`
  ADD CONSTRAINT `usuarios_turmas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_turmas_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
