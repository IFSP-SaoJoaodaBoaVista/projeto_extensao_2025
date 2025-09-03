package com.unifae.med.servlet.admin;

import com.unifae.med.dao.PermissaoDAO;
import com.unifae.med.dao.UsuarioDAO;
import com.unifae.med.entity.Permissao;
import com.unifae.med.entity.TipoUsuario;
import com.unifae.med.entity.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/usuarios")
public class UsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;
    private PermissaoDAO permissaoDAO;

    @Override
    public void init() {
        this.usuarioDAO = new UsuarioDAO();
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
                    deleteUsuario(request, response);
                    break;
                default:
                    listUsuarios(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("idUsuario");

        String nomeCompleto = request.getParameter("nomeCompleto");
        String email = request.getParameter("email");
        String senha = request.getParameter("senhaHash");
        TipoUsuario tipoUsuario = TipoUsuario.valueOf(request.getParameter("tipoUsuario"));
        Integer permissaoId = Integer.parseInt(request.getParameter("permissaoId"));
        boolean ativo = "on".equals(request.getParameter("ativo"));
        String matriculaRA = request.getParameter("matriculaRA");
        String telefone = request.getParameter("telefone");
        String periodo = request.getParameter("periodoAtualAluno");

        Permissao permissao = permissaoDAO.findById(permissaoId).orElse(null);

        Usuario usuario;
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            usuario = usuarioDAO.findById(id).orElseThrow(() -> new ServletException("Usuário não encontrado"));
        } else {
            usuario = new Usuario();
        }

        usuario.setNomeCompleto(nomeCompleto);
        usuario.setEmail(email);

        if (senha != null && !senha.isEmpty()) {
            // IMPORTANTE: Em um sistema real, a senha deve ser "hasheada" com um algoritmo como BCrypt.
            // Ex: String senhaHashed = BCrypt.hashpw(senha, BCrypt.gensalt());
            // usuario.setSenhaHash(senhaHashed);
            usuario.setSenhaHash(senha); // Apenas para fins de desenvolvimento
        }

        usuario.setTipoUsuario(tipoUsuario);
        usuario.setPermissao(permissao);
        usuario.setAtivo(ativo);
        usuario.setMatriculaRA(matriculaRA);
        usuario.setTelefone(telefone);
        usuario.setPeriodoAtualAluno(periodo);

        usuarioDAO.save(usuario);
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }

    private void listUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> listUsuarios = usuarioDAO.findAll();
        request.setAttribute("listUsuarios", listUsuarios);
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "new");
        request.setAttribute("tiposUsuario", TipoUsuario.values());
        request.setAttribute("listPermissoes", permissaoDAO.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Usuario usuarioExistente = usuarioDAO.findById(id).orElseThrow(() -> new ServletException("Usuário não encontrado"));
        request.setAttribute("usuario", usuarioExistente);
        request.setAttribute("action", "edit");
        request.setAttribute("tiposUsuario", TipoUsuario.values());
        request.setAttribute("listPermissoes", permissaoDAO.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/form.jsp").forward(request, response);
    }

    private void deleteUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        usuarioDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }
}
