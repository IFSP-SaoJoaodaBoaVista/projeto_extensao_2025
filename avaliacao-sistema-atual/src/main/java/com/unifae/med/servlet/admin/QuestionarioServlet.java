package com.unifae.med.servlet.admin;

import com.unifae.med.dao.QuestionarioDAO;
import com.unifae.med.entity.Questionario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * SERVLET PARA GERENCIAMENTO DE QUESTIONÁRIOS
 * ===========================================
 *
 * @version 2.0 - Lógica de busca e stats adicionada para novo layout
 * @author Sistema UNIFAE
 */
@WebServlet("/admin/questionarios")
public class QuestionarioServlet extends HttpServlet {

    private QuestionarioDAO questionarioDAO;

    @Override
    public void init() {
        this.questionarioDAO = new QuestionarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action") != null ? request.getParameter("action") : "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteQuestionario(request, response);
                    break;
                default:
                    listQuestionarios(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Erro ao processar requisição: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idQuestionario");
        String nomeModelo = request.getParameter("nomeModelo");
        String descricao = request.getParameter("descricao");

        Questionario questionario = null;
        try {
            if (idStr != null && !idStr.isEmpty()) {
                Integer id = Integer.parseInt(idStr);
                questionario = questionarioDAO.findById(id).orElseThrow(() -> new ServletException("Questionário não encontrado."));
            } else {
                questionario = new Questionario();
            }

            questionario.setNomeModelo(nomeModelo);
            questionario.setDescricao(descricao);

            questionarioDAO.save(questionario);
            response.sendRedirect(request.getContextPath() + "/admin/questionarios?success=1");

        } catch (Exception e) {
            request.setAttribute("error", "Erro ao salvar questionário: " + e.getMessage());
            request.setAttribute("questionario", questionario);
            request.setAttribute("action", (idStr != null && !idStr.isEmpty()) ? "edit" : "new");
            request.getRequestDispatcher("/WEB-INF/views/admin/questionarios/form.jsp").forward(request, response);
        }
    }

    private void listQuestionarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");

        Map<String, Object> result = questionarioDAO.findWithFiltersAndStats(search);
        List<Questionario> listQuestionarios = (List<Questionario>) result.get("list");
        Map<String, Long> stats = (Map<String, Long>) result.get("stats");

        request.setAttribute("listQuestionarios", listQuestionarios);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/WEB-INF/views/admin/questionarios/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("action", "new");
        request.setAttribute("questionario", new Questionario());
        request.getRequestDispatcher("/WEB-INF/views/admin/questionarios/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = Integer.valueOf(request.getParameter("id"));
        Questionario questionario = questionarioDAO.findById(id)
                .orElseThrow(() -> new ServletException("Questionário não encontrado"));

        request.setAttribute("questionario", questionario);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/admin/questionarios/form.jsp").forward(request, response);
    }

    private void deleteQuestionario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Integer id = Integer.valueOf(request.getParameter("id"));
        questionarioDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/questionarios?deleted=1");
    }
}
