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
import java.util.Map;

/**
 * SERVLET PARA GERENCIAMENTO DE PERMISSÕES
 * ========================================
 *
 * @version 2.1 - Corrigida chamada a método inexistente setAtivo()
 * @author Sistema UNIFAE
 */
@WebServlet("/admin/permissoes")
public class PermissaoServlet extends HttpServlet {

    private PermissaoDAO permissaoDAO;

    @Override
    public void init() {
        this.permissaoDAO = new PermissaoDAO();
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
                    deletePermissao(request, response);
                    break;
                default:
                    listPermissoes(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Erro ao processar requisição: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idPermissao");
        String nomePermissao = request.getParameter("nomePermissao");
        String descricaoPermissao = request.getParameter("descricaoPermissao");

        Permissao permissao = null;
        try {
            if (idStr != null && !idStr.isEmpty()) {
                Integer id = Integer.parseInt(idStr);
                permissao = permissaoDAO.findById(id).orElseThrow(() -> new ServletException("Permissão não encontrada."));
            } else {
                permissao = new Permissao();
            }

            permissao.setNomePermissao(nomePermissao);
            permissao.setDescricaoPermissao(descricaoPermissao);
            // <<< LINHA REMOVIDA, CAUSA DO ERRO >>>
            // permissao.setAtivo(true); 

            permissaoDAO.save(permissao);
            response.sendRedirect(request.getContextPath() + "/admin/permissoes?success=1");

        } catch (Exception e) {
            request.setAttribute("error", "Erro ao salvar permissão: " + e.getMessage());
            request.setAttribute("permissao", permissao);
            request.setAttribute("action", (idStr != null && !idStr.isEmpty()) ? "edit" : "new");
            request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/form-permissoes.jsp").forward(request, response);
        }
    }

    private void listPermissoes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");

        Map<String, Object> result = permissaoDAO.findWithFiltersAndStats(search);
        List<Permissao> listPermissoes = (List<Permissao>) result.get("list");
        Map<String, Long> stats = (Map<String, Long>) result.get("stats");

        request.setAttribute("listPermissoes", listPermissoes);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("action", "new");
        request.setAttribute("permissao", new Permissao());
        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = Integer.valueOf(request.getParameter("id"));
        Permissao permissaoExistente = permissaoDAO.findById(id)
                .orElseThrow(() -> new ServletException("Permissão não encontrada"));

        request.setAttribute("permissao", permissaoExistente);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/admin/permissoes/form.jsp").forward(request, response);
    }

    private void deletePermissao(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Integer id = Integer.valueOf(request.getParameter("id"));
        permissaoDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/permissoes?deleted=1");
    }
}
