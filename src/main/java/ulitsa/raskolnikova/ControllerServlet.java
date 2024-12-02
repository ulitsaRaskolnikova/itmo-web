package ulitsa.raskolnikova;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;


public class ControllerServlet extends HttpServlet {
    private static final String INVALID_DATA = "Неправильный формат данных";
    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleRequest(req, resp);
    }

    protected void handleRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (BufferedReader reader = req.getReader()) {
            long startTime = System.currentTimeMillis();

            Point point = MAPPER.readValue(reader, Point.class);
            
            req.setAttribute("x", point.x());
            req.setAttribute("y", point.y());
            req.setAttribute("r", point.r());
            req.setAttribute("time", startTime);
            req.getRequestDispatcher("/Checker").forward(req, resp);
        }
        catch (Exception e) {
            sendError(resp, INVALID_DATA);
            resp.getWriter().write("Неправильные данные: " + e.getMessage());
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void sendError(HttpServletResponse resp, String errMessage) throws IOException {
        resp.setStatus(HttpServletResponse.SC_NON_AUTHORITATIVE_INFORMATION);
        resp.setContentType("application/json");
        resp.getWriter().write("Неправильные данные: " + errMessage);
    }
}
