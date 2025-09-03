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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("idTurma");
        String nomeTurma = request.getParameter("nomeTurma");
        String codigoTurma = request.getParameter("codigoTurma");

        Turma turma;
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            turma = turmaDAO.findById(id).orElse(new Turma());
        } else {
            turma = new Turma();
        }

        turma.setNomeTurma(nomeTurma);
        turma.setCodigoTurma(codigoTurma);

        turmaDAO.save(turma);
        response.sendRedirect(request.getContextPath() + "/admin/turmas");
    }

    private void listTurmas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Turma> listTurmas = turmaDAO.findAll();
        request.setAttribute("listTurmas", listTurmas);
        request.getRequestDispatcher("/WEB-INF/views/admin/turmas/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "new");
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
        response.sendRedirect(request.getContextPath() + "/admin/turmas");
    }
}