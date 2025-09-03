package com.unifae.med.servlet.admin;

import com.unifae.med.dao.PermissaoDAO;
import com.unifae.med.entity.Permissao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/permissoes")
public class PermissaoServlet extends HttpServlet {

    private PermissaoDAO permissaoDAO;

    @Override
    public void init() {
        this.permissaoDAO = new PermissaoDAO();
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
                    deletePermissao(request, response);
                    break;
                default:
                    listPermissoes(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("idPermissao");
        String nomePermissao = request.getParameter("nomePermissao");
        String descricaoPermissao = request.getParameter("descricaoPermissao");

        Permissao permissao;
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            permissao = permissaoDAO.findById(id).orElse(new Permissao());
        } else {
            permissao = new Permissao();
        }

        permissao.setNomePermissao(nomePermissao);
        permissao.setDescricaoPermissao(descricaoPermissao);

        permissaoDAO.save(permissao);
        response.sendRedirect(request.getContextPath() + "/admin/permissoes");
    }

    private void listPermissoes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Permissao> listPermissoes = permissaoDAO.findAll();
        request.setAttribute("listPermissoes", listPermissoes);
        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "new");
        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Permissao permissaoExistente = permissaoDAO.findById(id).orElseThrow(() -> new ServletException("Permissão não encontrada"));
        request.setAttribute("permissao", permissaoExistente);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/form.jsp").forward(request, response);
    }

    private void deletePermissao(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        permissaoDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/permissoes");
    }
}
