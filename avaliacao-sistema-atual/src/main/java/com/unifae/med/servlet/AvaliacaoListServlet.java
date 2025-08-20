package com.unifae.med.servlet;

import com.unifae.med.dao.AvaliacaoPreenchidaDAO;
import com.unifae.med.dao.UsuarioDAO;
import com.unifae.med.dao.QuestionarioDAO;
import com.unifae.med.entity.AvaliacaoPreenchida;
import com.unifae.med.entity.Usuario;
import com.unifae.med.entity.Questionario;
import com.unifae.med.entity.TipoUsuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/avaliacoes")
public class AvaliacaoListServlet extends HttpServlet {
    
    private AvaliacaoPreenchidaDAO avaliacaoDAO;
    private UsuarioDAO usuarioDAO;
    private QuestionarioDAO questionarioDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.avaliacaoDAO = new AvaliacaoPreenchidaDAO();
        this.usuarioDAO = new UsuarioDAO();
        this.questionarioDAO = new QuestionarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Buscar parâmetros de filtro
            String alunoId = request.getParameter("alunoId");
            String questionarioId = request.getParameter("questionarioId");
            String avaliadorId = request.getParameter("avaliadorId");
            
            List<AvaliacaoPreenchida> avaliacoes;
            
            // Aplicar filtros conforme parâmetros
            if (alunoId != null && !alunoId.isEmpty()) {
                Usuario aluno = usuarioDAO.findById(Integer.parseInt(alunoId))
                    .orElseThrow(() -> new RuntimeException("Aluno não encontrado"));
                
                if (questionarioId != null && !questionarioId.isEmpty()) {
                    Questionario questionario = questionarioDAO.findById(Integer.parseInt(questionarioId))
                        .orElseThrow(() -> new RuntimeException("Questionário não encontrado"));
                    avaliacoes = avaliacaoDAO.findByAlunoAvaliadoAndQuestionario(aluno, questionario);
                } else {
                    avaliacoes = avaliacaoDAO.findByAlunoAvaliado(aluno);
                }
            } else if (avaliadorId != null && !avaliadorId.isEmpty()) {
                Usuario avaliador = usuarioDAO.findById(Integer.parseInt(avaliadorId))
                    .orElseThrow(() -> new RuntimeException("Avaliador não encontrado"));
                avaliacoes = avaliacaoDAO.findByAvaliador(avaliador);
            } else if (questionarioId != null && !questionarioId.isEmpty()) {
                Questionario questionario = questionarioDAO.findById(Integer.parseInt(questionarioId))
                    .orElseThrow(() -> new RuntimeException("Questionário não encontrado"));
                avaliacoes = avaliacaoDAO.findByQuestionario(questionario);
            } else {
                avaliacoes = avaliacaoDAO.findAll();
            }
            
            // Buscar dados para os filtros
            List<Usuario> alunos = usuarioDAO.findByTipoUsuario(TipoUsuario.Aluno);
            List<Usuario> professores = usuarioDAO.findByTipoUsuario(TipoUsuario.Professor);
            List<Questionario> questionarios = questionarioDAO.findAll();
            
            // Definir atributos para a JSP
            request.setAttribute("avaliacoes", avaliacoes);
            request.setAttribute("alunos", alunos);
            request.setAttribute("professores", professores);
            request.setAttribute("questionarios", questionarios);
            request.setAttribute("alunoIdSelecionado", alunoId);
            request.setAttribute("questionarioIdSelecionado", questionarioId);
            request.setAttribute("avaliadorIdSelecionado", avaliadorId);
            
            // Encaminhar para a JSP
            request.getRequestDispatcher("/WEB-INF/views/avaliacoes/list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar avaliações: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}

