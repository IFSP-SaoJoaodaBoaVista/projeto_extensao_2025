package com.unifae.med.servlet.admin;

import com.unifae.med.dao.DisciplinaDAO;
import com.unifae.med.entity.Disciplina;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/disciplinas")
public class DisciplinaServlet extends HttpServlet {

    private DisciplinaDAO disciplinaDAO;

    @Override
    public void init() {
        this.disciplinaDAO = new DisciplinaDAO();
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
                    deleteDisciplina(request, response);
                    break;
                default:
                    listDisciplinas(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("idDisciplina");
        String nomeDisciplina = request.getParameter("nomeDisciplina");
        String siglaDisciplina = request.getParameter("siglaDisciplina");
        boolean ativa = "on".equals(request.getParameter("ativa"));

        Disciplina disciplina;
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            disciplina = disciplinaDAO.findById(id).orElse(new Disciplina());
        } else {
            disciplina = new Disciplina();
        }

        disciplina.setNomeDisciplina(nomeDisciplina);
        disciplina.setSiglaDisciplina(siglaDisciplina);
        disciplina.setAtiva(ativa);

        disciplinaDAO.save(disciplina);
        response.sendRedirect(request.getContextPath() + "/admin/disciplinas");
    }

    private void listDisciplinas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Disciplina> listDisciplinas = disciplinaDAO.findAll();
        request.setAttribute("listDisciplinas", listDisciplinas);
        request.getRequestDispatcher("/WEB-INF/views/admin/disciplinas/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "new");
        request.getRequestDispatcher("/WEB-INF/views/admin/disciplinas/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Disciplina disciplinaExistente = disciplinaDAO.findById(id).orElseThrow(() -> new ServletException("Disciplina não encontrada"));
        request.setAttribute("disciplina", disciplinaExistente);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/admin/disciplinas/form.jsp").forward(request, response);
    }

    private void deleteDisciplina(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        disciplinaDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/disciplinas");
    }
}