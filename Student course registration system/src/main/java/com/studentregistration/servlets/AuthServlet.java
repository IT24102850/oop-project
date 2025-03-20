import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

class User {
    private String username;
    private String password;

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}

class Admin {
    private String username;
    private String password;

    public Admin(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}

class UserDAO {
    private List<User> users = new ArrayList<>();

    public UserDAO() {
        users.add(new User("user1", "pass1"));
    }

    public List<User> getAllUsers() {
        return users;
    }
}

class AdminDAO {
    private List<Admin> admins = new ArrayList<>();

    public AdminDAO() {
        admins.add(new Admin("admin", "adminpass"));
    }

    public List<Admin> getAllAdmins() {
        return admins;
    }
}

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    private AdminDAO adminDAO = new AdminDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check admin
        for (Admin admin : adminDAO.getAllAdmins()) {
            if (admin.getUsername().equals(username) && admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", admin);
                response.sendRedirect("adminDashboard.jsp");
                return;
            }
        }

        // Check user
        for (User user : userDAO.getAllUsers()) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
                return;
            }
        }

        // Login failed
        response.sendRedirect("login.jsp?error=1");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
}
