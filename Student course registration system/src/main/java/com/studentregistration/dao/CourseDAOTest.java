package com.studentregistration.dao;

import com.studentregistration.model.Course;
import com.studentregistration.util.FileUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import java.io.IOException;
import java.util.List;
import static org.junit.Assert.*;

public class CourseDAOTest {
    private static final String TEST_FILE = "test_courses.txt";

    @Before
    public void setUp() throws IOException {
        // Setup test file path
        System.setProperty("course.file.path", TEST_FILE);
        FileUtil.rewriteFile(TEST_FILE, List.of()); // Clear file
    }

    @Test
    public void testCreateAndReadCourse() throws Exception {
        Course course = new Course("CS101", "Programming", 3, "CS", "Dr. Smith");
        CourseDAO.createCourse(course);

        List<Course> courses = CourseDAO.getAllCourses(null, null);
        assertFalse(courses.isEmpty());
        assertEquals("CS101", courses.get(0).getCode());
    }

    @Test
    public void testFilterCourses() throws Exception {
        CourseDAO.createCourse(new Course("CS101", "Programming", 3, "CS", "Dr. Smith"));
        CourseDAO.createCourse(new Course("MATH101", "Algebra", 4, "MATH", "Dr. Johnson"));

        List<Course> csCourses = CourseDAO.getAllCourses("CS", null);
        assertEquals(1, csCourses.size());
        assertEquals("CS101", csCourses.get(0).getCode());

        List<Course> fourCreditCourses = CourseDAO.getAllCourses(null, 4);
        assertEquals(1, fourCreditCourses.size());
        assertEquals("MATH101", fourCreditCourses.get(0).getCode());
    }

    @After
    public void tearDown() throws IOException {
        // Clean up test file
        FileUtil.rewriteFile(TEST_FILE, List.of());
    }
}
