package com.studentregistration.servlets;

import com.studentregistration.dao.UserDAO;
import com.studentregistration.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import java.io.IOException;
import static org.mockito.Mockito.*;

public class ProfileServletTest {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private RequestDispatcher dispatcher;
    private ProfileServlet servlet;
    private UserDAO userDao;

    @BeforeEach
    public void setUp() {
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        dispatcher = mock(RequestDispatcher.class);
        userDao = mock(UserDAO.class);
        servlet = new ProfileServlet();

        // Inject mock DAO via reflection (for testing)
        try {
            var field = ProfileServlet.class.getDeclaredField("userDao");
            field.setAccessible(true);
            field.set(servlet, userDao);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    public void testDoGet_Success() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userId")).thenReturn("123");
        when(userDao.getUserById("123")).thenReturn(new User("123", "test@uni.edu", "1234567890"));
        when(request.getRequestDispatcher("/jsp/profile.jsp")).thenReturn(dispatcher);

        servlet.doGet(request, response);

        verify(request).setAttribute(eq("user"), any(User.class));
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testDoPost_Update() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userId")).thenReturn("123");
        when(request.getParameter("action")).thenReturn("update");
        when(request.getParameter("email")).thenReturn("new@uni.edu");
        when(request.getParameter("phone")).thenReturn("9876543210");
        when(userDao.updateUser(any(User.class))).thenReturn(true);

        servlet.doPost(request, response);

        verify(response).sendRedirect("profile?success=update");
    }
}
