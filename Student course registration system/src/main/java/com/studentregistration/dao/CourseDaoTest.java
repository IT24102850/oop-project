package com.studentregistration.dao;

import com.studentregistration.model.Course;
import org.junit.Test;
import java.util.List;
import static org.junit.Assert.*;

public class CourseDAOTest {
    @Test
    public void testCreateAndReadCourse() throws Exception {
        Course course = new Course("MATH202", "Calculus", 4, "MATH", "Dr. Lee");
        CourseDAO.createCourse(course);
        List<Course> courses = CourseDAO.getAllCourses(null, null);
        assertTrue(courses.stream().anyMatch(c -> c.getCode().equals("MATH202")));
    }
}