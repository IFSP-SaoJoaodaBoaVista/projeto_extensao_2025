package com.unifae.med.servlet.admin;

import com.unifae.med.dao.TurmaDAO;
import com.unifae.med.entity.Turma;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/turmas")
public class TurmaServlet extends HttpServlet {

    private TurmaDAO turmaDAO;

    @Override
    public void init() {
        this.turmaDAO = new TurmaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                    deleteTurma(request, response);
                    break;
                default:
                    listTurmas(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // ... (código do doPost inalterado, já está correto) ...
        try {
            String idStr = request.getParameter("idTurma");
            String nomeTurma = request.getParameter("nomeTurma");
            String codigoTurma = request.getParameter("codigoTurma");
            String anoLetivoStr = request.getParameter("anoLetivo");
            String semestreStr = request.getParameter("semestre");
            boolean ativo = "on".equals(request.getParameter("ativo"));

            Turma turma;
            if (idStr != null && !idStr.isEmpty()) {
                Integer id = Integer.parseInt(idStr);
                turma = turmaDAO.findById(id).orElseThrow(() -> new ServletException("Turma não encontrada para atualização."));
            } else {
                turma = new Turma();
            }

            turma.setNomeTurma(nomeTurma);
            turma.setCodigoTurma(codigoTurma);

            if (anoLetivoStr != null && !anoLetivoStr.trim().isEmpty()) {
                turma.setAnoLetivo(Integer.parseInt(anoLetivoStr));
            }
            if (semestreStr != null && !semestreStr.trim().isEmpty()) {
                turma.setSemestre(Integer.parseInt(semestreStr));
            }
            turma.setAtivo(ativo);

            turmaDAO.save(turma);
            response.sendRedirect(request.getContextPath() + "/admin/turmas?success=1");
        } catch (Exception e) {
            throw new ServletException("Erro ao salvar a turma.", e);
        }
    }

    private void listTurmas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lógica de filtro adicionada para corresponder ao layout
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        Map<String, Object> result = turmaDAO.findWithFiltersAndStats(search, status);
        List<Turma> listTurmas = (List<Turma>) result.get("list");
        Map<String, Long> stats = (Map<String, Long>) result.get("stats");

        request.setAttribute("listTurmas", listTurmas);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/WEB-INF/views/admin/turmas/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "new");
        request.setAttribute("turma", new Turma());
        request.getRequestDispatcher("/WEB-INF/views/admin/turmas/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Turma turmaExistente = turmaDAO.findById(id).orElseThrow(() -> new ServletException("Turma não encontrada"));
        request.setAttribute("turma", turmaExistente);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/admin/turmas/form.jsp").forward(request, response);
    }

    private void deleteTurma(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        turmaDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/turmas?deleted=1");
    }
}
