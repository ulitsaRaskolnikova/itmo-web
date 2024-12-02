package ulitsa.raskolnikova;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {
    private double LowerRangeR;
    private double UpperRangeR;

    public void init(ServletConfig config) throws ServletException {
        LowerRangeR = Double.parseDouble(config.getInitParameter("LowerRangeR"));
        UpperRangeR = Double.parseDouble(config.getInitParameter("UpperRangeR"));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        handleRequest(req, res);
    }

    private void handleRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        double x = (double) req.getAttribute("x");
        double y = (double) req.getAttribute("y");
        double r = (double) req.getAttribute("r");
        Point point = new Point(x, y, r);
        HttpSession session = req.getSession();
        if (isValid(point)) {
            if (session.getAttribute("TableEntries") == null) {
                session.setAttribute("TableEntries", new ArrayList<TableEntry>());
            }
            List<TableEntry> table = (List<TableEntry>) session.getAttribute("TableEntries");
            table.add(new TableEntry(
                    point,
                    checkHit(point),
                    LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")),
                    System.currentTimeMillis() - (long) req.getAttribute("time")));
            session.setAttribute("LastR", point.r());
        } else {
            req.getRequestDispatcher("errorPage.jsp").forward(req, res);
        }
        req.getRequestDispatcher("result.jsp").forward(req, res);
    }

    private boolean checkHit(Point point) {
        double x = point.x();
        double y = point.y();
        double r = point.r();
        if (x >= 0 && y >= 0) {
            return y <= -x + r / 2;
        }
        if (x <= 0 && y >= 0) {
            return y <= r && x >= (-r / 2);
        }
        if (x >= 0 && y <= 0) {
            return x*x + y*y <= r*r;
        }
        return false;
    }

    private boolean isValid(Point point) {
        return point.r() >= LowerRangeR && point.r() <= UpperRangeR;
    }

    public record TableEntry(Point point, boolean isHit, String requestTime, long processTime) {

    }
}
