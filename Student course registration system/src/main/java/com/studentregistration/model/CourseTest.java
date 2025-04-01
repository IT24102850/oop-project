package com.studentregistration.model;

import org.junit.Test;
import static org.junit.Assert.*;

public class CourseTest {
    @Test
    public void testCourseCreation() {
        Course course = new Course("CS101", "Intro to CS", 3, "CS", "Dr. Smith");
        assertEquals("CS101", course.getCode());
        assertTrue(course.isActive());
    }
}