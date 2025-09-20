package com.unifae.med.servlet;

// Importações de classes DAO (Data Access Object) para interagir com o banco de dados.
import com.unifae.med.dao.EventoAgendaDAO;
import com.unifae.med.dao.LocalEventoDAO;
import com.unifae.med.dao.DisciplinaDAO;
import com.unifae.med.dao.TurmaDAO;
import com.unifae.med.dao.UsuarioDAO;
// Importações de classes de Entidade, que modelam os dados do banco.
import com.unifae.med.entity.EventoAgenda;
import com.unifae.med.entity.LocalEvento;
import com.unifae.med.entity.Disciplina;
import com.unifae.med.entity.Turma;
import com.unifae.med.entity.Usuario;
import com.unifae.med.entity.TipoEvento;
import com.unifae.med.entity.StatusEvento;
// Importações de classes do Jakarta Servlet para criar a servlet.
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Importações de classes Java para manipulação de I/O, datas e coleções.
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Servlet que atua como o Controlador (Controller) para todas as requisições
 * relacionadas à agenda de eventos. Ele gerencia as ações de listar, criar,
 * editar, excluir e visualizar eventos no calendário. A anotação
 * @WebServlet("/agenda") mapeia esta servlet para a URL "/agenda".
 */
@WebServlet("/agenda")
public class AgendaServlet extends HttpServlet {

    // DAOs: Objetos responsáveis pela comunicação com o banco de dados para cada entidade.
    private EventoAgendaDAO eventoAgendaDAO;
    private LocalEventoDAO localEventoDAO;
    private DisciplinaDAO disciplinaDAO;
    private TurmaDAO turmaDAO;
    private UsuarioDAO usuarioDAO;

    /**
     * Método de inicialização da Servlet. É executado apenas uma vez quando a
     * servlet é carregada pelo servidor. Aqui, instanciamos todos os DAOs
     * necessários.
     */
    @Override
    public void init() {
        this.eventoAgendaDAO = new EventoAgendaDAO();
        this.localEventoDAO = new LocalEventoDAO();
        this.disciplinaDAO = new DisciplinaDAO();
        this.turmaDAO = new TurmaDAO();
        this.usuarioDAO = new UsuarioDAO();
    }

    /**
     * Trata as requisições HTTP GET. GET é geralmente usado para
     * solicitar/visualizar dados. Exemplos: carregar a lista de eventos,
     * mostrar o formulário de criação.
     *
     * @param request O objeto de requisição HTTP.
     * @param response O objeto de resposta HTTP.
     * @throws ServletException Se ocorrer um erro específico da servlet.
     * @throws IOException Se ocorrer um erro de I/O.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtém o parâmetro "action" da URL para determinar qual ação executar.
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Se nenhuma ação for especificada, a ação padrão é "list".
        }

        try {
            // Um switch para direcionar a requisição para o método apropriado.
            switch (action) {
                case "calendar":
                    showCalendar(request, response);
                    break;
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteEvento(request, response);
                    break;
                case "changeStatus":
                    changeStatus(request, response);
                    break;
                default:
                    listEventos(request, response);
                    break;
            }
        } catch (Exception e) {
            // Em caso de erro, lança uma ServletException para ser tratada pela página de erro.
            throw new ServletException("Erro ao processar requisição: " + e.getMessage(), e);
        }
    }

    /**
     * Trata as requisições HTTP POST. POST é usado para enviar dados para serem
     * processados no servidor. Exemplo: salvar um evento novo ou atualizado a
     * partir de um formulário.
     *
     * @param request O objeto de requisição HTTP.
     * @param response O objeto de resposta HTTP.
     * @throws ServletException Se ocorrer um erro específico da servlet.
     * @throws IOException Se ocorrer um erro de I/O.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Coleta todos os dados enviados pelo formulário.
            String idStr = request.getParameter("idEvento");
            String titulo = request.getParameter("titulo");
            String descricao = request.getParameter("descricao");
            String dataInicioStr = request.getParameter("dataInicio");
            String dataFimStr = request.getParameter("dataFim");
            String localEventoIdStr = request.getParameter("localEventoId");
            String disciplinaIdStr = request.getParameter("disciplinaId");
            String turmaIdStr = request.getParameter("turmaId");
            String responsavelIdStr = request.getParameter("responsavelId");
            String tipoEventoStr = request.getParameter("tipoEvento");
            String statusEventoStr = request.getParameter("statusEvento");

            // 2. Validação básica dos campos obrigatórios.
            if (titulo == null || titulo.trim().isEmpty()) {
                throw new ServletException("Título é obrigatório");
            }
            if (dataInicioStr == null || dataInicioStr.trim().isEmpty()) {
                throw new ServletException("Data de início é obrigatória");
            }

            // 3. Converte os dados de String para os tipos corretos (LocalDateTime, etc).
            LocalDateTime dataInicio = parseDateTime(dataInicioStr);
            LocalDateTime dataFim = null;
            if (dataFimStr != null && !dataFimStr.trim().isEmpty()) {
                dataFim = parseDateTime(dataFimStr);
                if (dataFim.isBefore(dataInicio)) {
                    throw new ServletException("Data de fim deve ser posterior à data de início");
                }
            }

            // 4. Busca as entidades relacionadas (Local, Disciplina, etc.) no banco de dados.
            LocalEvento localEvento = (localEventoIdStr != null && !localEventoIdStr.isEmpty())
                    ? localEventoDAO.findById(Integer.valueOf(localEventoIdStr)).orElse(null) : null;
            Disciplina disciplina = (disciplinaIdStr != null && !disciplinaIdStr.isEmpty())
                    ? disciplinaDAO.findById(Integer.valueOf(disciplinaIdStr)).orElse(null) : null;
            Turma turma = (turmaIdStr != null && !turmaIdStr.isEmpty())
                    ? turmaDAO.findById(Integer.valueOf(turmaIdStr)).orElse(null) : null;
            Usuario responsavel = (responsavelIdStr != null && !responsavelIdStr.isEmpty())
                    ? usuarioDAO.findById(Integer.valueOf(responsavelIdStr)).orElse(null) : null;

            TipoEvento tipoEvento = TipoEvento.valueOf(tipoEventoStr);
            StatusEvento statusEvento = StatusEvento.valueOf(statusEventoStr);

            // 5. Verifica se é uma edição (ID existe) ou um novo evento (ID não existe).
            EventoAgenda evento;
            if (idStr != null && !idStr.trim().isEmpty()) {
                // Se for edição, busca o evento existente.
                evento = eventoAgendaDAO.findById(Integer.valueOf(idStr))
                        .orElseThrow(() -> new ServletException("Evento não encontrado"));
            } else {
                // Se for novo, cria um novo objeto.
                evento = new EventoAgenda();
            }

            // 6. Regra de negócio: Verifica se há conflito de horário para o local.
            if (localEvento != null && dataFim != null) {
                boolean hasConflito = eventoAgendaDAO.hasConflito(
                        localEvento, dataInicio, dataFim, evento.getIdEvento());
                if (hasConflito) {
                    // Se houver conflito, retorna ao formulário com uma mensagem de erro.
                    request.setAttribute("erro", "Conflito de horário: já existe evento agendado para este local no período especificado");
                    showFormWithData(request, response, evento);
                    return; // Interrompe a execução para não salvar o evento.
                }
            }

            // 7. Preenche o objeto EventoAgenda com os dados do formulário.
            evento.setTitulo(titulo);
            evento.setDescricao(descricao);
            evento.setDataInicio(dataInicio);
            evento.setDataFim(dataFim);
            evento.setLocalEvento(localEvento);
            evento.setDisciplina(disciplina);
            evento.setTurma(turma);
            evento.setResponsavel(responsavel);
            evento.setTipoEvento(tipoEvento);
            evento.setStatusEvento(statusEvento);

            // 8. Salva (insere ou atualiza) o evento no banco de dados.
            eventoAgendaDAO.save(evento);

            // 9. Redireciona para a página de listagem com um parâmetro de sucesso.
            // Isso evita o reenvio do formulário se o usuário atualizar a página.
            response.sendRedirect(request.getContextPath() + "/agenda?success=1");

        } catch (Exception e) {
            // Em caso de erro, define uma mensagem e recarrega o formulário.
            request.setAttribute("erro", "Erro ao salvar evento: " + e.getMessage());
            showNewForm(request, response);
        }
    }

    /**
     * Busca e exibe a lista de eventos, aplicando os filtros recebidos.
     */
    private void listEventos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Coleta os parâmetros de filtro da requisição.
        String dataStr = request.getParameter("data");
        String tipoEventoStr = request.getParameter("tipoEvento");
        String statusEventoStr = request.getParameter("statusEvento");
        String responsavelIdStr = request.getParameter("responsavelId");
        String disciplinaIdStr = request.getParameter("disciplinaId");
        String turmaIdStr = request.getParameter("turmaId");

        // Converte os parâmetros de String para os tipos adequados.
        LocalDateTime dataInicio = null, dataFim = null;
        if (dataStr != null && !dataStr.isEmpty()) {
            LocalDate data = LocalDate.parse(dataStr);
            dataInicio = data.atStartOfDay(); // Início do dia
            dataFim = data.atTime(23, 59, 59); // Fim do dia
        }
        TipoEvento tipoEvento = (tipoEventoStr != null && !tipoEventoStr.isEmpty()) ? TipoEvento.valueOf(tipoEventoStr) : null;
        StatusEvento statusEvento = (statusEventoStr != null && !statusEventoStr.isEmpty()) ? StatusEvento.valueOf(statusEventoStr) : null;
        Usuario responsavel = (responsavelIdStr != null && !responsavelIdStr.isEmpty()) ? usuarioDAO.findById(Integer.valueOf(responsavelIdStr)).orElse(null) : null;
        Disciplina disciplina = (disciplinaIdStr != null && !disciplinaIdStr.isEmpty()) ? disciplinaDAO.findById(Integer.valueOf(disciplinaIdStr)).orElse(null) : null;
        Turma turma = (turmaIdStr != null && !turmaIdStr.isEmpty()) ? turmaDAO.findById(Integer.valueOf(turmaIdStr)).orElse(null) : null;

        // Chama o DAO para buscar os eventos com os filtros aplicados.
        List<EventoAgenda> eventos = eventoAgendaDAO.findWithFilters(dataInicio, dataFim, tipoEvento, statusEvento, responsavel, disciplina, turma);

        // Adiciona os resultados e os dados para os filtros na requisição.
        request.setAttribute("eventos", eventos);
        prepareFormData(request); // Reutiliza o método que prepara dados para os formulários.

        // Encaminha a requisição para a página JSP que exibirá a lista.
        request.getRequestDispatcher("/WEB-INF/views/agenda/list.jsp").forward(request, response);
    }

    /**
     * Busca os dados e exibe a visualização em calendário.
     */
    private void showCalendar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Define o mês e ano a serem exibidos (padrão: data atual).
        LocalDate hoje = LocalDate.now();
        int mes = (request.getParameter("mes") != null) ? Integer.parseInt(request.getParameter("mes")) : hoje.getMonthValue();
        int ano = (request.getParameter("ano") != null) ? Integer.parseInt(request.getParameter("ano")) : hoje.getYear();

        // Calcula o primeiro e o último dia do mês.
        LocalDate primeiroDia = LocalDate.of(ano, mes, 1);
        LocalDate ultimoDia = primeiroDia.withDayOfMonth(primeiroDia.lengthOfMonth());

        // Busca todos os eventos dentro do período do mês.
        List<EventoAgenda> eventosDoMes = eventoAgendaDAO.findByPeriodo(primeiroDia.atStartOfDay(), ultimoDia.atTime(23, 59, 59));

        // Agrupa os eventos por dia usando Java Streams para facilitar a exibição no JSP.
        Map<LocalDate, List<EventoAgenda>> eventosPorDia = eventosDoMes.stream()
                .collect(Collectors.groupingBy(evento -> evento.getDataInicio().toLocalDate()));

        // Adiciona os dados necessários para a view na requisição.
        request.setAttribute("eventosPorDia", eventosPorDia);
        request.setAttribute("totalEventos", eventosDoMes.size());
        request.setAttribute("mes", mes);
        request.setAttribute("ano", ano);
        request.setAttribute("primeiroDia", primeiroDia);
        request.setAttribute("ultimoDia", ultimoDia);

        // Encaminha para a página JSP do calendário.
        request.getRequestDispatcher("/WEB-INF/views/agenda/calendar.jsp").forward(request, response);
    }

    /**
     * Prepara os dados e exibe o formulário para um novo evento.
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        prepareFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/agenda/form.jsp").forward(request, response);
    }

    /**
     * Busca os dados de um evento existente e exibe o formulário para edição.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Pega o ID do evento a ser editado.
        Integer id = Integer.valueOf(request.getParameter("idEvento"));
        // Busca o evento no banco. Se não encontrar, lança uma exceção.
        EventoAgenda evento = eventoAgendaDAO.findById(id)
                .orElseThrow(() -> new ServletException("Evento não encontrado com ID: " + id));

        // Adiciona o evento encontrado e os dados do formulário na requisição.
        request.setAttribute("evento", evento);
        prepareFormData(request);

        // Encaminha para a mesma página de formulário, que se adaptará para edição.
        request.getRequestDispatcher("/WEB-INF/views/agenda/form.jsp").forward(request, response);
    }

    /**
     * Exclui um evento com base no ID fornecido.
     */
    private void deleteEvento(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Integer id = Integer.valueOf(request.getParameter("idEvento"));
        eventoAgendaDAO.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/agenda?deleted=1");
    }

    /**
     * Altera o status de um evento (ex: de AGENDADO para EM_ANDAMENTO).
     */
    private void changeStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("idEvento"));
        StatusEvento novoStatus = StatusEvento.valueOf(request.getParameter("status"));

        EventoAgenda evento = eventoAgendaDAO.findById(id)
                .orElseThrow(() -> new ServletException("Evento não encontrado"));

        evento.setStatusEvento(novoStatus);
        eventoAgendaDAO.save(evento);
        response.sendRedirect(request.getContextPath() + "/agenda?statusChanged=1");
    }

    /**
     * Método utilitário para carregar dados comuns necessários para os
     * formulários (listas de locais, disciplinas, usuários, etc.). Evita
     * repetição de código.
     */
    private void prepareFormData(HttpServletRequest request) {
        request.setAttribute("locaisEvento", localEventoDAO.findAll());
        request.setAttribute("disciplinas", disciplinaDAO.findAll());
        request.setAttribute("turmas", turmaDAO.findAll());
        request.setAttribute("usuarios", usuarioDAO.findAtivos());
        request.setAttribute("tiposEvento", TipoEvento.values());
        request.setAttribute("statusEvento", StatusEvento.values());
    }

    /**
     * Método utilitário para reenviar o usuário ao formulário mantendo os dados
     * já preenchidos, útil em caso de erro de validação (como conflito de
     * horário).
     */
    private void showFormWithData(HttpServletRequest request, HttpServletResponse response,
            EventoAgenda evento) throws ServletException, IOException {
        request.setAttribute("evento", evento);
        prepareFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/agenda/form.jsp").forward(request, response);
    }

    /**
     * Método utilitário para converter uma String no formato 'yyyy-MM-ddTHH:mm'
     * para um objeto LocalDateTime.
     */
    private LocalDateTime parseDateTime(String dateTimeStr) throws ServletException {
        try {
            return LocalDateTime.parse(dateTimeStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } catch (DateTimeParseException e) {
            throw new ServletException("Formato de data/hora inválido. Use yyyy-MM-ddTHH:mm. Valor recebido: " + dateTimeStr);
        }
    }
}
