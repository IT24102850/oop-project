package com.studentregistration.model;

import org.junit.Test;
import static org.junit.Assert.*;

public class CourseTest {

    @Test
    public void testCourseCreation() {
        Course course = new Course("CS101", "Programming", 3, "CS", "Dr. Smith");

        assertEquals("CS101", course.getCode());
        assertEquals("Programming", course.getTitle());
        assertEquals(3, course.getCredits());
        assertEquals("CS", course.getDepartment());
        assertEquals("Dr. Smith", course.getProfessor());
        assertTrue(course.isActive());
    }

    @Test
    public void testCourseSetters() {
        Course course = new Course("MATH101", "Algebra", 4, "MATH", "Dr. Johnson");

        course.setSyllabus("Linear algebra concepts");
        course.setProfessor("Dr. Brown");
        course.setActive(false);

        assertEquals("Linear algebra concepts", course.getSyllabus());
        assertEquals("Dr. Brown", course.getProfessor());
        assertFalse(course.isActive());
    }
}