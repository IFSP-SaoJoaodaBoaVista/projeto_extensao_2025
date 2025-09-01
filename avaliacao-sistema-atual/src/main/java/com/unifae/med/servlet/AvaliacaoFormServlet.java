package com.unifae.med.servlet;

import com.unifae.med.dao.*;
import com.unifae.med.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/avaliacao/form")
public class AvaliacaoFormServlet extends HttpServlet {

    private AvaliacaoPreenchidaDAO avaliacaoDAO;
    private QuestionarioDAO questionarioDAO;
    private UsuarioDAO usuarioDAO;
    private CompetenciaQuestionarioDAO competenciaDAO;
    private RespostaItemAvaliacaoDAO respostaDAO;
    private LocalEventoDAO localEventoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.avaliacaoDAO = new AvaliacaoPreenchidaDAO();
        this.questionarioDAO = new QuestionarioDAO();
        this.usuarioDAO = new UsuarioDAO();
        this.competenciaDAO = new CompetenciaQuestionarioDAO();
        this.respostaDAO = new RespostaItemAvaliacaoDAO();
        this.localEventoDAO = new LocalEventoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String questionarioIdStr = request.getParameter("questionarioId");
        String avaliacaoIdStr = request.getParameter("id");

        try {
            // Carregar dados básicos
            List<Usuario> alunos = usuarioDAO.findByTipoUsuario(TipoUsuario.ESTUDANTE);
            List<Usuario> professores = usuarioDAO.findByTipoUsuario(TipoUsuario.PROFESSOR);
            List<LocalEvento> locaisEventos = localEventoDAO.findAll();
            List<Questionario> questionarios = questionarioDAO.findAll();

            request.setAttribute("alunos", alunos);
            request.setAttribute("professores", professores);
            request.setAttribute("locaisEventos", locaisEventos);
            request.setAttribute("questionarios", questionarios);
            request.setAttribute("action", action);

            // Se for edição, carregar dados da avaliação PRIMEIRO
            if ("edit".equals(action) && avaliacaoIdStr != null) {
                Integer avaliacaoId = Integer.parseInt(avaliacaoIdStr);
                AvaliacaoPreenchida avaliacao = avaliacaoDAO.findById(avaliacaoId)
                        .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));

                // Se questionarioId não foi fornecido, usar o da avaliação IMEDIATAMENTE
                if (questionarioIdStr == null) {
                    questionarioIdStr = avaliacao.getQuestionario().getIdQuestionario().toString();
                }

                // Carregar respostas com eager loading garantido
                List<RespostaItemAvaliacao> respostas = respostaDAO.findByAvaliacaoPreenchida(avaliacao);

                // Definir atributos com dados completos
                request.setAttribute("avaliacao", avaliacao);
                request.setAttribute("respostas", respostas);
                request.setAttribute("questionarioIdSelecionado", avaliacao.getQuestionario().getIdQuestionario());
            }

            // Carregar questionário se fornecido
            if (questionarioIdStr != null) {
                Integer questionarioId = Integer.parseInt(questionarioIdStr);
                request.setAttribute("questionarioIdSelecionado", questionarioId);

                Questionario questionario = questionarioDAO.findById(questionarioId)
                        .orElseThrow(() -> new RuntimeException("Questionário não encontrado"));
                request.setAttribute("questionario", questionario);
            }

            // Redirecionar para o formulário apropriado baseado no questionário
            String jspPath = determinarJSP(questionarioIdStr);
            request.getRequestDispatcher(jspPath).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar formulário: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String questionarioIdStr = request.getParameter("questionarioId");
        String avaliacaoIdStr = request.getParameter("avaliacaoId");

        try {
            // Dados básicos da avaliação
            String alunoAvaliadoIdStr = request.getParameter("alunoAvaliadoId");
            String avaliadorIdStr = request.getParameter("avaliadorId");
            String tipoAvaliadorNaoUsuario = request.getParameter("tipoAvaliadorNaoUsuario");
            String nomeAvaliadorNaoUsuario = request.getParameter("nomeAvaliadorNaoUsuario");
            String dataRealizacaoStr = request.getParameter("dataRealizacao");
            String horarioInicioStr = request.getParameter("horarioInicio");
            String horarioFimStr = request.getParameter("horarioFim");
            String localRealizacao = request.getParameter("localRealizacao");
            String feedbackPositivo = request.getParameter("feedbackPositivo");
            String feedbackMelhoria = request.getParameter("feedbackMelhoria");
            String contratoAprendizagem = request.getParameter("contratoAprendizagem");

            // Buscar entidades
            Integer questionarioId = Integer.parseInt(questionarioIdStr);
            Questionario questionario = questionarioDAO.findById(questionarioId)
                    .orElseThrow(() -> new RuntimeException("Questionário não encontrado"));

            Integer alunoAvaliadoId = Integer.parseInt(alunoAvaliadoIdStr);
            Usuario alunoAvaliado = usuarioDAO.findById(alunoAvaliadoId)
                    .orElseThrow(() -> new RuntimeException("Aluno não encontrado"));

            Usuario avaliador = null;
            // CONDIÇÃO CORRIGIDA PARA EVITAR ERRO COM STRING VAZIA
            if (avaliadorIdStr != null && !avaliadorIdStr.isEmpty() && !avaliadorIdStr.equals("0")) {
                Integer avaliadorId = Integer.parseInt(avaliadorIdStr);
                avaliador = usuarioDAO.findById(avaliadorId).orElse(null);
            }

            // Criar ou buscar avaliação
            AvaliacaoPreenchida avaliacao;
            if ("edit".equals(action) && avaliacaoIdStr != null) {
                Integer avaliacaoId = Integer.parseInt(avaliacaoIdStr);
                avaliacao = avaliacaoDAO.findById(avaliacaoId)
                        .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));
            } else {
                avaliacao = new AvaliacaoPreenchida();
            }

            // Definir dados da avaliação
            avaliacao.setQuestionario(questionario);
            avaliacao.setAlunoAvaliado(alunoAvaliado);
            avaliacao.setAvaliador(avaliador);
            avaliacao.setTipoAvaliadorNaoUsuario(tipoAvaliadorNaoUsuario);
            avaliacao.setNomeAvaliadorNaoUsuario(nomeAvaliadorNaoUsuario);
            avaliacao.setDataRealizacao(LocalDate.parse(dataRealizacaoStr));

            if (horarioInicioStr != null && !horarioInicioStr.isEmpty()) {
                avaliacao.setHorarioInicio(LocalTime.parse(horarioInicioStr));
            }
            if (horarioFimStr != null && !horarioFimStr.isEmpty()) {
                avaliacao.setHorarioFim(LocalTime.parse(horarioFimStr));
            }

            avaliacao.setLocalRealizacao(localRealizacao);
            avaliacao.setFeedbackPositivo(feedbackPositivo);
            avaliacao.setFeedbackMelhoria(feedbackMelhoria);
            avaliacao.setContratoAprendizagem(contratoAprendizagem);

            // Salvar avaliação
            avaliacao = avaliacaoDAO.save(avaliacao);

            // Se for edição, remover respostas antigas
            if ("edit".equals(action)) {
                respostaDAO.deleteByAvaliacaoPreenchida(avaliacao);
            }

            // Processar respostas das competências com mapeamento correto
            processarRespostasCompetencias(request, avaliacao, questionario);

            // Redirecionar para a lista de avaliações
            response.sendRedirect(request.getContextPath() + "/avaliacoes?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao salvar avaliação: " + e.getMessage());
            doGet(request, response);
        }
    }

    /**
     * Processa as respostas das competências com mapeamento correto dos nomes
     * dos parâmetros
     */
    private void processarRespostasCompetencias(HttpServletRequest request,
            AvaliacaoPreenchida avaliacao,
            Questionario questionario) {

        // Buscar APENAS competências deste questionário específico
        List<CompetenciaQuestionario> competencias
                = competenciaDAO.findByQuestionario(questionario.getIdQuestionario());

        // Obter mapeamento de nomes de parâmetros para este questionário
        Map<String, String> mapeamentoParametros = obterMapeamentoParametros(questionario);

        // Salvar respostas
        for (CompetenciaQuestionario competencia : competencias) {
            String nomeCompetencia = competencia.getNomeCompetencia().toLowerCase().trim();
            String nomeParametro = mapeamentoParametros.get(nomeCompetencia);

            if (nomeParametro != null) {
                String respostaValorStr = request.getParameter(nomeParametro);
                String naoAvaliadoStr = request.getParameter("nao_avaliado_" + nomeParametro.replace("resposta_", ""));

                RespostaItemAvaliacao resposta = new RespostaItemAvaliacao();
                resposta.setAvaliacaoPreenchida(avaliacao);
                resposta.setCompetenciaQuestionario(competencia);

                if ("true".equals(naoAvaliadoStr)) {
                    resposta.setNaoAvaliado(true);
                } else {
                    resposta.setNaoAvaliado(false);
                    if (respostaValorStr != null && !respostaValorStr.isEmpty()) {
                        resposta.setRespostaValorNumerico(new BigDecimal(respostaValorStr));
                    }
                }

                respostaDAO.save(resposta);
            }
        }
    }

    /**
     * Retorna o mapeamento de nomes de competências para nomes de parâmetros
     * baseado no tipo de questionário
     */
    /**
     * Retorna o mapeamento de nomes de competências para nomes de parâmetros
     * baseado no tipo de questionário
     */
    private Map<String, String> obterMapeamentoParametros(Questionario questionario) {
        Map<String, String> mapeamento = new HashMap<>();

        String nomeQuestionario = questionario.getNomeModelo().toLowerCase();

        if (nomeQuestionario.contains("(mini-cex)") || (nomeQuestionario.contains("360") && nomeQuestionario.contains("professor"))) {
            // Mapeamento para Mini CEX e Avaliação 360° Professor
            mapeamento.put("entrevista médica", "resposta_entrevista_medica");
            mapeamento.put("exame físico", "resposta_exame_fisico");
            mapeamento.put("profissionalismo", "resposta_profissionalismo");
            mapeamento.put("julgamento clínico", "resposta_julgamento_clinico");
            mapeamento.put("habilidade de comunicação", "resposta_comunicacao");
            mapeamento.put("organização e eficiência", "resposta_organizacao");
            mapeamento.put("avaliação clínica geral", "resposta_avaliacao_geral");

        } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("pares")) {
            // Mapeamento específico para 360° Pares
            mapeamento.put("anamnese", "resposta_anamnese");
            mapeamento.put("exame físico", "resposta_exame_fisico");
            mapeamento.put("raciocínio clínico", "resposta_raciocinio_clinico");
            mapeamento.put("profissionalismo", "resposta_profissionalismo");
            mapeamento.put("comunicação", "resposta_comunicacao");
            mapeamento.put("organização e eficiência", "resposta_organizacao");
            mapeamento.put("competência profissional global", "resposta_competencia_global");
            mapeamento.put("atitude de compaixão e respeito", "resposta_compaixao");
            mapeamento.put("abordagem suave e sensível ao paciente", "resposta_abordagem_suave");
            mapeamento.put("comunicação e interação respeitosa com a equipe", "resposta_interacao_equipe");

        } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("equipe")) {
            // Mapeamento CORRIGIDO e específico para 360° Equipe
            mapeamento.put("colaboração em equipe", "resposta_colaboracao_equipe");
            mapeamento.put("comunicação interprofissional", "resposta_comunicacao_interprofissional");
            mapeamento.put("respeito mútuo", "resposta_respeito_mutuo");
            mapeamento.put("responsabilidade compartilhada", "resposta_responsabilidade_compartilhada");
            mapeamento.put("liderança situacional", "resposta_lideranca_situacional");
            mapeamento.put("resolução de conflitos", "resposta_resolucao_conflitos");
            mapeamento.put("empatia profissional", "resposta_empatia_profissional");
            mapeamento.put("ética no trabalho em equipe", "resposta_etica_trabalho_equipe");
            mapeamento.put("flexibilidade e adaptação", "resposta_flexibilidade_adaptacao");
            mapeamento.put("contribuição para o ambiente de trabalho", "resposta_contribuicao_ambiente");

        } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("paciente")) {
            // Mapeamento para Avaliação 360° Paciente
            mapeamento.put("cortesia e educação", "resposta_cortesia_educacao");
            mapeamento.put("respeito à privacidade", "resposta_respeito_privacidade");
            mapeamento.put("demonstração de interesse", "resposta_demonstracao_interesse");
            mapeamento.put("demonstração de cuidado", "resposta_demonstracao_cuidado");
            mapeamento.put("clareza na comunicação", "resposta_clareza_comunicacao");
            mapeamento.put("explicação sobre procedimentos", "resposta_explicacao_procedimentos");
            mapeamento.put("envolvimento na tomada de decisão", "resposta_envolvimento_decisao");
            mapeamento.put("capacidade de tranquilizar", "resposta_capacidade_tranquilizar");
            mapeamento.put("tempo dedicado", "resposta_tempo_dedicado");
            mapeamento.put("satisfação geral", "resposta_satisfacao_geral");
        }

        return mapeamento;
    }

    /**
     * Determina qual JSP usar baseado no questionário
     */
    private String determinarJSP(String questionarioIdStr) {
        if (questionarioIdStr == null) {
            // Fallback para a lista se nenhum ID for fornecido
            return "/avaliacoes";
        }

        try {
            Integer questionarioId = Integer.parseInt(questionarioIdStr);
            Questionario questionario = questionarioDAO.findById(questionarioId).orElse(null);

            if (questionario != null) {
                String nomeQuestionario = questionario.getNomeModelo().toLowerCase();

                if (nomeQuestionario.contains("mini cex")) {
                    return "/WEB-INF/views/avaliacoes/minicex-form.jsp";
                } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("professor")) {
                    return "/WEB-INF/views/avaliacoes/avaliacao360-professor-form.jsp";
                } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("pares")) {
                    return "/WEB-INF/views/avaliacoes/avaliacao360-pares-form.jsp";
                } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("equipe")) { // <-- NOVA CONDIÇÃO
                    return "/WEB-INF/views/avaliacoes/avaliacao360-equipe-form.jsp";
                } else if (nomeQuestionario.contains("360") && nomeQuestionario.contains("paciente")) { // <-- NOVA CONDIÇÃO
                    return "/WEB-INF/views/avaliacoes/avaliacao360-paciente-form.jsp";
                }
            }
        } catch (NumberFormatException e) {
            // Ignorar erro e usar JSP padrão
        }

        // Fallback para o primeiro formulário se não conseguir determinar
        return "/WEB-INF/views/avaliacoes/minicex-form.jsp";
    }
}
