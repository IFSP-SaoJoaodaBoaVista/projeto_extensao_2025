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
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/avaliacao/form")
public class AvaliacaoFormServlet extends HttpServlet {
    
    private AvaliacaoPreenchidaDAO avaliacaoDAO;
    private UsuarioDAO usuarioDAO;
    private QuestionarioDAO questionarioDAO;
    private CompetenciaQuestionarioDAO competenciaDAO;
    private RespostaItemAvaliacaoDAO respostaDAO;
    private LocalEventoDAO localEventoDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.avaliacaoDAO = new AvaliacaoPreenchidaDAO();
        this.usuarioDAO = new UsuarioDAO();
        this.questionarioDAO = new QuestionarioDAO();
        this.competenciaDAO = new CompetenciaQuestionarioDAO();
        this.respostaDAO = new RespostaItemAvaliacaoDAO();
        this.localEventoDAO = new LocalEventoDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String action = request.getParameter("action");
            String avaliacaoId = request.getParameter("id");
            String questionarioId = request.getParameter("questionarioId");
            
            AvaliacaoPreenchida avaliacao = null;
            List<RespostaItemAvaliacao> respostas = null;
            
            // Se for edição, carregar avaliação existente
            if ("edit".equals(action) && avaliacaoId != null) {
                avaliacao = avaliacaoDAO.findById(Integer.parseInt(avaliacaoId))
                    .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));
                respostas = respostaDAO.findByAvaliacaoPreenchida(avaliacao);
                questionarioId = avaliacao.getQuestionario().getIdQuestionario().toString();
            }
            
            // Buscar dados necessários para o formulário
            List<Usuario> alunos = usuarioDAO.findByTipoUsuario(TipoUsuario.Aluno);
            List<Usuario> professores = usuarioDAO.findByTipoUsuario(TipoUsuario.Professor);
            List<Questionario> questionarios = questionarioDAO.findAll();
            List<LocalEvento> locaisEventos = localEventoDAO.findAll();
            
            List<CompetenciaQuestionario> competencias = null;
            if (questionarioId != null && !questionarioId.isEmpty()) {
                // Buscar competências do questionário específico
                // Por enquanto, buscar todas as competências
                competencias = competenciaDAO.findAll();
            }
            
            // Definir atributos para a JSP
            request.setAttribute("avaliacao", avaliacao);
            request.setAttribute("respostas", respostas);
            request.setAttribute("alunos", alunos);
            request.setAttribute("professores", professores);
            request.setAttribute("questionarios", questionarios);
            request.setAttribute("locaisEventos", locaisEventos);
            request.setAttribute("competencias", competencias);
            request.setAttribute("questionarioIdSelecionado", questionarioId);
            request.setAttribute("action", action != null ? action : "new");
            
            // Encaminhar para a JSP apropriada baseada no tipo de questionário
            String jspPath = "/WEB-INF/views/avaliacoes/minicex-form.jsp"; // padrão
            if (questionarioId != null) {
                Questionario questionario = questionarioDAO.findById(Integer.parseInt(questionarioId)).orElse(null);
                if (questionario != null) {
                    if (questionario.getNomeModelo().toLowerCase().contains("mini cex")) {
                        jspPath = "/WEB-INF/views/avaliacoes/minicex-form.jsp";
                    } else if (questionario.getNomeModelo().toLowerCase().contains("professor")) {
                        jspPath = "/WEB-INF/views/avaliacoes/avaliacao360-professor-form.jsp";
                    } else if (questionario.getNomeModelo().toLowerCase().contains("pares")) {
                        jspPath = "/WEB-INF/views/avaliacoes/avaliacao360-pares-form.jsp";
                    } else if (questionario.getNomeModelo().toLowerCase().contains("360")) {
                        jspPath = "/WEB-INF/views/avaliacoes/avaliacao360-professor-form.jsp"; // padrão para 360
                    }
                }
            }
            
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
        
        try {
            String action = request.getParameter("action");
            String avaliacaoId = request.getParameter("avaliacaoId");
            
            // Dados básicos da avaliação
            Integer questionarioId = Integer.parseInt(request.getParameter("questionarioId"));
            Integer alunoAvaliadoId = Integer.parseInt(request.getParameter("alunoAvaliadoId"));
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
            
            // Buscar entidades relacionadas
            Questionario questionario = questionarioDAO.findById(questionarioId)
                .orElseThrow(() -> new RuntimeException("Questionário não encontrado"));
            Usuario alunoAvaliado = usuarioDAO.findById(alunoAvaliadoId)
                .orElseThrow(() -> new RuntimeException("Aluno não encontrado"));
            
            Usuario avaliador = null;
            if (avaliadorIdStr != null && !avaliadorIdStr.isEmpty()) {
                avaliador = usuarioDAO.findById(Integer.parseInt(avaliadorIdStr)).orElse(null);
            }
            
            // Criar ou atualizar avaliação
            AvaliacaoPreenchida avaliacao;
            if ("edit".equals(action) && avaliacaoId != null) {
                avaliacao = avaliacaoDAO.findById(Integer.parseInt(avaliacaoId))
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
            
            // Processar respostas das competências
            List<CompetenciaQuestionario> competencias = competenciaDAO.findAll();
            
            // Se for edição, remover respostas antigas
            if ("edit".equals(action)) {
                respostaDAO.deleteByAvaliacaoPreenchida(avaliacao);
            }
            
            // Salvar novas respostas
            for (CompetenciaQuestionario competencia : competencias) {
                String respostaValorStr = request.getParameter("resposta_" + competencia.getIdCompetenciaQuestionario());
                String respostaTexto = request.getParameter("resposta_texto_" + competencia.getIdCompetenciaQuestionario());
                String naoAvaliadoStr = request.getParameter("nao_avaliado_" + competencia.getIdCompetenciaQuestionario());
                
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
                    if (respostaTexto != null && !respostaTexto.isEmpty()) {
                        resposta.setRespostaTexto(respostaTexto);
                    }
                }
                
                respostaDAO.save(resposta);
            }
            
            // Redirecionar para a lista de avaliações
            response.sendRedirect(request.getContextPath() + "/avaliacoes?success=true");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao salvar avaliação: " + e.getMessage());
            doGet(request, response);
        }
    }
}

