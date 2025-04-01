package com.studentregistration.servlets;


import com.studentregistration.dao.CourseDAO;
import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.model.Course;
import com.studentregistration.model.Enrollment;
import com.studentregistration.util.FileUtil;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import static org.mockito.Mockito.*;

public class CourseServletTest extends Mockito {
    private CourseServlet servlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private static final String TEST_FILE = "test_enrollments.txt";

    @Before
    public void setUp() throws Exception {
        servlet = new CourseServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);

        // Setup test environment
        System.setProperty("enrollment.file.path", TEST_FILE);
        FileUtil.rewriteFile(TEST_FILE, List.of());
    }

    @Test
    public void testDoGetWithCourses() throws Exception {
        CourseDAO.createCourse(new Course("CS101", "Programming", 3, "CS", "Dr. Smith"));
        when(request.getRequestDispatcher("/jsp/viewCourses.jsp")).thenReturn(dispatcher);

        servlet.doGet(request, response);

        verify(request).setAttribute(eq("courses"), any(List.class));
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testDoPostCreateCourse() throws Exception {
        when(request.getParameter("code")).thenReturn("MATH101");
        when(request.getParameter("title")).thenReturn("Algebra");
        when(request.getParameter("credits")).thenReturn("4");
        when(request.getParameter("department")).thenReturn("MATH");
        when(request.getParameter("professor")).thenReturn("Dr. Johnson");

        StringWriter stringWriter = new StringWriter();
        when(response.getWriter()).thenReturn(new PrintWriter(stringWriter));

        servlet.doPost(request, response);

        List<Course> courses = CourseDAO.getAllCourses(null, null);
        assertTrue(courses.stream().anyMatch(c -> c.getCode().equals("MATH101")));
    }

    @Test
    public void testEnrollmentIntegration() throws Exception {
        // Create test course
        CourseDAO.createCourse(new Course("CS101", "Programming", 3, "CS", "Dr. Smith"));

        // Test enrollment
        RegistrationDAO registrationDAO = new RegistrationDAO();
        boolean enrolled = registrationDAO.enrollStudent("test@student.com",
                List.of("CS101"), "A01");

        assertTrue(enrolled);
        assertEquals(1, registrationDAO.getEnrollmentCount("CS101"));
    }

    @After
    public void tearDown() throws IOException {
        FileUtil.rewriteFile(TEST_FILE, List.of());
    }
}