-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19/08/2025 às 04:22
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

-- --------------------------------------------------------

--
-- Estrutura para tabela `agenda_disciplinas_vinculadas`
--

CREATE TABLE `agenda_disciplinas_vinculadas` (
  `id_evento` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacoes_preenchidas`
--

CREATE TABLE `avaliacoes_preenchidas` (
  `id_avaliacao_preenchida` int(11) NOT NULL,
  `id_questionario` int(11) NOT NULL,
  `id_aluno_avaliado` int(11) NOT NULL,
  `id_avaliador` int(11) DEFAULT NULL,
  `tipo_avaliador_nao_usuario` varchar(50) DEFAULT NULL,
  `nome_avaliador_nao_usuario` varchar(100) DEFAULT NULL,
  `data_realizacao` date NOT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fim` time DEFAULT NULL,
  `local_realizacao` varchar(255) DEFAULT NULL,
  `feedback_positivo` text DEFAULT NULL,
  `feedback_melhoria` text DEFAULT NULL,
  `contrato_aprendizagem` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `competencias_questionario`
--

CREATE TABLE `competencias_questionario` (
  `id_competencia_questionario` int(11) NOT NULL,
  `nome_competencia` varchar(255) NOT NULL,
  `tipo_item` varchar(50) DEFAULT NULL,
  `descricao_prompt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `configuracao_calculo_notas`
--

CREATE TABLE `configuracao_calculo_notas` (
  `id_configuracao` int(11) NOT NULL,
  `nome_configuracao` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `peso_osce` decimal(4,2) DEFAULT NULL,
  `peso_prova_teorica` decimal(4,2) DEFAULT NULL,
  `peso_portfolio` decimal(4,2) DEFAULT NULL,
  `peso_avaliacao_pratica_1` decimal(4,2) DEFAULT NULL,
  `peso_avaliacao_pratica_2` decimal(4,2) DEFAULT NULL,
  `limite_percentual_faltas` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

CREATE TABLE `disciplinas` (
  `id_disciplina` int(11) NOT NULL,
  `nome_disciplina` varchar(255) NOT NULL,
  `sigla_disciplina` varchar(10) DEFAULT NULL,
  `ativa` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas_turmas`
--

CREATE TABLE `disciplinas_turmas` (
  `id_disciplina_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `eventos_agenda`
--

CREATE TABLE `eventos_agenda` (
  `id_evento` int(11) NOT NULL,
  `nome_evento` varchar(255) NOT NULL,
  `tipo_evento` varchar(100) DEFAULT 'aula prática',
  `data_evento` date NOT NULL,
  `hora_evento` time NOT NULL,
  `id_local_evento` int(11) DEFAULT NULL,
  `periodo_semanas_estagio` int(11) DEFAULT NULL,
  `data_inicio_estagio` date DEFAULT NULL,
  `data_termino_estagio` date DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `feedbacks_sistema`
--

CREATE TABLE `feedbacks_sistema` (
  `id_feedback` int(11) NOT NULL,
  `tipo_mensagem` varchar(50) DEFAULT NULL,
  `texto_mensagem_livre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_escolar_importado`
--

CREATE TABLE `historico_escolar_importado` (
  `id_historico` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `disciplina` varchar(255) NOT NULL,
  `nota` decimal(4,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `ano_semestre` varchar(20) DEFAULT NULL,
  `data_importacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `locais_eventos`
--

CREATE TABLE `locais_eventos` (
  `id_local_evento` int(11) NOT NULL,
  `nome_local` varchar(255) NOT NULL,
  `tipo_local` varchar(100) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `notas_alunos_disciplinas`
--

CREATE TABLE `notas_alunos_disciplinas` (
  `id_nota_aluno_disciplina` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `id_evento_agenda_referencia` int(11) DEFAULT NULL,
  `nota_osce` decimal(4,2) DEFAULT NULL,
  `nota_prova_teorica` decimal(4,2) DEFAULT NULL,
  `nota_portfolio` decimal(4,2) DEFAULT NULL,
  `id_avaliacao_pratica_1` int(11) DEFAULT NULL,
  `id_avaliacao_pratica_2` int(11) DEFAULT NULL,
  `faltas_contabilizadas` int(11) DEFAULT NULL,
  `percentual_faltas` decimal(5,2) DEFAULT NULL,
  `media_final_calculada` decimal(4,2) DEFAULT NULL,
  `status_disciplina` enum('Aprovado','Reprovado','Recuperação','Cursando') DEFAULT NULL,
  `periodo_letivo_referencia` varchar(20) DEFAULT NULL,
  `composicao_nota_texto` text DEFAULT NULL,
  `observacao_status` text DEFAULT NULL,
  `data_lancamento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `notificacoes`
--

CREATE TABLE `notificacoes` (
  `id_notificacao` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `data_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `lida` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `participantes_eventos`
--

CREATE TABLE `participantes_eventos` (
  `id_participante_evento` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissoes`
--

CREATE TABLE `permissoes` (
  `id_permissao` int(11) NOT NULL,
  `nome_permissao` varchar(50) NOT NULL,
  `descricao_permissao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `questionarios`
--

CREATE TABLE `questionarios` (
  `id_questionario` int(11) NOT NULL,
  `nome_modelo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `respostas_itens_avaliacao`
--

CREATE TABLE `respostas_itens_avaliacao` (
  `id_resposta_item` int(11) NOT NULL,
  `id_avaliacao_preenchida` int(11) NOT NULL,
  `id_competencia_questionario` int(11) NOT NULL,
  `resposta_valor_numerico` decimal(4,1) DEFAULT NULL,
  `resposta_texto` text DEFAULT NULL,
  `nao_avaliado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

CREATE TABLE `turmas` (
  `id_turma` int(11) NOT NULL,
  `nome_turma` varchar(255) NOT NULL,
  `codigo_turma` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome_completo` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `matricula_RA` varchar(6) DEFAULT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `tipo_usuario` enum('Administrador','Professor','Aluno') NOT NULL,
  `foto_perfil_path` varchar(255) DEFAULT NULL,
  `periodo_atual_aluno` varchar(2) DEFAULT NULL,
  `observacoes_gerais_aluno` text DEFAULT NULL,
  `id_permissao` int(11) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios_turmas`
--

CREATE TABLE `usuarios_turmas` (
  `id_usuario_turma` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agenda_disciplinas_vinculadas`
--
ALTER TABLE `agenda_disciplinas_vinculadas`
  ADD PRIMARY KEY (`id_evento`,`id_disciplina`),
  ADD KEY `id_disciplina` (`id_disciplina`);

--
-- Índices de tabela `avaliacoes_preenchidas`
--
ALTER TABLE `avaliacoes_preenchidas`
  ADD PRIMARY KEY (`id_avaliacao_preenchida`),
  ADD KEY `id_questionario` (`id_questionario`),
  ADD KEY `id_aluno_avaliado` (`id_aluno_avaliado`),
  ADD KEY `id_avaliador` (`id_avaliador`);

--
-- Índices de tabela `competencias_questionario`
--
ALTER TABLE `competencias_questionario`
  ADD PRIMARY KEY (`id_competencia_questionario`);

--
-- Índices de tabela `configuracao_calculo_notas`
--
ALTER TABLE `configuracao_calculo_notas`
  ADD PRIMARY KEY (`id_configuracao`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id_disciplina`),
  ADD UNIQUE KEY `nome_disciplina` (`nome_disciplina`),
  ADD UNIQUE KEY `sigla_disciplina` (`sigla_disciplina`);

--
-- Índices de tabela `disciplinas_turmas`
--
ALTER TABLE `disciplinas_turmas`
  ADD PRIMARY KEY (`id_disciplina_turma`),
  ADD KEY `id_disciplina` (`id_disciplina`),
  ADD KEY `id_turma` (`id_turma`);

--
-- Índices de tabela `eventos_agenda`
--
ALTER TABLE `eventos_agenda`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_local_evento` (`id_local_evento`);

--
-- Índices de tabela `feedbacks_sistema`
--
ALTER TABLE `feedbacks_sistema`
  ADD PRIMARY KEY (`id_feedback`);

--
-- Índices de tabela `historico_escolar_importado`
--
ALTER TABLE `historico_escolar_importado`
  ADD PRIMARY KEY (`id_historico`),
  ADD KEY `id_aluno` (`id_aluno`);

--
-- Índices de tabela `locais_eventos`
--
ALTER TABLE `locais_eventos`
  ADD PRIMARY KEY (`id_local_evento`);

--
-- Índices de tabela `notas_alunos_disciplinas`
--
ALTER TABLE `notas_alunos_disciplinas`
  ADD PRIMARY KEY (`id_nota_aluno_disciplina`),
  ADD KEY `id_aluno` (`id_aluno`),
  ADD KEY `id_disciplina` (`id_disciplina`),
  ADD KEY `id_evento_agenda_referencia` (`id_evento_agenda_referencia`),
  ADD KEY `id_avaliacao_pratica_1` (`id_avaliacao_pratica_1`),
  ADD KEY `id_avaliacao_pratica_2` (`id_avaliacao_pratica_2`);

--
-- Índices de tabela `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD PRIMARY KEY (`id_notificacao`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Índices de tabela `participantes_eventos`
--
ALTER TABLE `participantes_eventos`
  ADD PRIMARY KEY (`id_participante_evento`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_evento` (`id_evento`);

--
-- Índices de tabela `permissoes`
--
ALTER TABLE `permissoes`
  ADD PRIMARY KEY (`id_permissao`),
  ADD UNIQUE KEY `nome_permissao` (`nome_permissao`);

--
-- Índices de tabela `questionarios`
--
ALTER TABLE `questionarios`
  ADD PRIMARY KEY (`id_questionario`);

--
-- Índices de tabela `respostas_itens_avaliacao`
--
ALTER TABLE `respostas_itens_avaliacao`
  ADD PRIMARY KEY (`id_resposta_item`),
  ADD KEY `id_avaliacao_preenchida` (`id_avaliacao_preenchida`),
  ADD KEY `id_competencia_questionario` (`id_competencia_questionario`);

--
-- Índices de tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id_turma`),
  ADD UNIQUE KEY `codigo_turma` (`codigo_turma`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `matricula_RA` (`matricula_RA`),
  ADD KEY `id_permissao` (`id_permissao`);

--
-- Índices de tabela `usuarios_turmas`
--
ALTER TABLE `usuarios_turmas`
  ADD PRIMARY KEY (`id_usuario_turma`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_turma` (`id_turma`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

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
-- AUTO_INCREMENT de tabela `configuracao_calculo_notas`
--
ALTER TABLE `configuracao_calculo_notas`
  MODIFY `id_configuracao` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de tabela `feedbacks_sistema`
--
ALTER TABLE `feedbacks_sistema`
  MODIFY `id_feedback` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `historico_escolar_importado`
--
ALTER TABLE `historico_escolar_importado`
  MODIFY `id_historico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `locais_eventos`
--
ALTER TABLE `locais_eventos`
  MODIFY `id_local_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `notas_alunos_disciplinas`
--
ALTER TABLE `notas_alunos_disciplinas`
  MODIFY `id_nota_aluno_disciplina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `notificacoes`
--
ALTER TABLE `notificacoes`
  MODIFY `id_notificacao` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_resposta_item` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `agenda_disciplinas_vinculadas_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `eventos_agenda` (`id_evento`),
  ADD CONSTRAINT `agenda_disciplinas_vinculadas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`);

--
-- Restrições para tabelas `avaliacoes_preenchidas`
--
ALTER TABLE `avaliacoes_preenchidas`
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_1` FOREIGN KEY (`id_questionario`) REFERENCES `questionarios` (`id_questionario`),
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_2` FOREIGN KEY (`id_aluno_avaliado`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `avaliacoes_preenchidas_ibfk_3` FOREIGN KEY (`id_avaliador`) REFERENCES `usuarios` (`id_usuario`);

--
-- Restrições para tabelas `disciplinas_turmas`
--
ALTER TABLE `disciplinas_turmas`
  ADD CONSTRAINT `disciplinas_turmas_ibfk_1` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`),
  ADD CONSTRAINT `disciplinas_turmas_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`);

--
-- Restrições para tabelas `eventos_agenda`
--
ALTER TABLE `eventos_agenda`
  ADD CONSTRAINT `eventos_agenda_ibfk_1` FOREIGN KEY (`id_local_evento`) REFERENCES `locais_eventos` (`id_local_evento`);

--
-- Restrições para tabelas `historico_escolar_importado`
--
ALTER TABLE `historico_escolar_importado`
  ADD CONSTRAINT `historico_escolar_importado_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `usuarios` (`id_usuario`);

--
-- Restrições para tabelas `notas_alunos_disciplinas`
--
ALTER TABLE `notas_alunos_disciplinas`
  ADD CONSTRAINT `notas_alunos_disciplinas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `notas_alunos_disciplinas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`),
  ADD CONSTRAINT `notas_alunos_disciplinas_ibfk_3` FOREIGN KEY (`id_evento_agenda_referencia`) REFERENCES `eventos_agenda` (`id_evento`),
  ADD CONSTRAINT `notas_alunos_disciplinas_ibfk_4` FOREIGN KEY (`id_avaliacao_pratica_1`) REFERENCES `avaliacoes_preenchidas` (`id_avaliacao_preenchida`),
  ADD CONSTRAINT `notas_alunos_disciplinas_ibfk_5` FOREIGN KEY (`id_avaliacao_pratica_2`) REFERENCES `avaliacoes_preenchidas` (`id_avaliacao_preenchida`);

--
-- Restrições para tabelas `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD CONSTRAINT `notificacoes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Restrições para tabelas `participantes_eventos`
--
ALTER TABLE `participantes_eventos`
  ADD CONSTRAINT `participantes_eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `participantes_eventos_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `eventos_agenda` (`id_evento`);

--
-- Restrições para tabelas `respostas_itens_avaliacao`
--
ALTER TABLE `respostas_itens_avaliacao`
  ADD CONSTRAINT `respostas_itens_avaliacao_ibfk_1` FOREIGN KEY (`id_avaliacao_preenchida`) REFERENCES `avaliacoes_preenchidas` (`id_avaliacao_preenchida`),
  ADD CONSTRAINT `respostas_itens_avaliacao_ibfk_2` FOREIGN KEY (`id_competencia_questionario`) REFERENCES `competencias_questionario` (`id_competencia_questionario`);

--
-- Restrições para tabelas `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_permissao`) REFERENCES `permissoes` (`id_permissao`);

--
-- Restrições para tabelas `usuarios_turmas`
--
ALTER TABLE `usuarios_turmas`
  ADD CONSTRAINT `usuarios_turmas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuarios_turmas_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
