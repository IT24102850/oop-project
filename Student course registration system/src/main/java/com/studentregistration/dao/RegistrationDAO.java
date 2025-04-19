package com.studentregistration.dao;

import com.studentregistration.model.Student;
import com.studentregistration.model.User;
import com.studentregistration.util.PasswordUtil;

import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationDAO {
    private final String userFilePath;
    private final String studentFilePath;
    private final String enrollmentFilePath;
    private static final Logger logger = Logger.getLogger(RegistrationDAO.class.getName());

    public RegistrationDAO(String userFilePath, String studentFilePath, String enrollmentFilePath) {
        this.userFilePath = userFilePath;
        this.studentFilePath = studentFilePath;
        this.enrollmentFilePath = enrollmentFilePath;
        initializeFiles();
    }

    private void initializeFiles() {
        initializeFile(userFilePath);
        initializeFile(studentFilePath);
        initializeFile(enrollmentFilePath);
    }

    private void initializeFile(String filePath) {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                logger.info("Initialized file: " + filePath);
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to initialize file: " + filePath, e);
                throw new RuntimeException("File initialization failed", e);
            }
        }
    }

    public void registerUser(User user, boolean isAdmin) throws IOException {
        if (!isEmailAvailable(user.getEmail())) {
            logger.warning("Email already exists: " + user.getEmail());
            throw new IllegalArgumentException("Email already exists");
        }

        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setActive(false);
        user.setLastLogin(LocalDateTime.now());

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFilePath, true))) {
            writer.write(user.toFileString());
            writer.newLine();
            logger.info("User registered (pending verification): " + user.getEmail());
        }

        if (!isAdmin) {
            Student student = new Student(String.valueOf(user.getId()), user.getFullName(), user.getEmail(), user.getPassword());
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(studentFilePath, true))) {
                writer.write(student.getStudentId() + "," + student.getFullName() + "," + student.getEmail() + "," + student.getPassword());
                writer.newLine();
                logger.info("Student record added: " + student.getEmail());
            }
        }
    }

    public boolean isEmailAvailable(String email) {
        try (BufferedReader reader = new BufferedReader(new FileReader(userFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromFileString(line);
                if (user.getEmail().equalsIgnoreCase(email)) {
                    return false;
                }
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to check email availability", e);
            throw new RuntimeException("Failed to check email availability", e);
        }
        return true;
    }

    public void resendVerificationEmail(String email) {
        List<User> users = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(userFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromFileString(line);
                if (user.getEmail().equalsIgnoreCase(email) && !user.isActive()) {
                    found = true;
                    logger.info("Verification email resent to: " + email);
                }
                users.add(user);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read users for verification resend", e);
            throw new RuntimeException("Failed to resend verification email", e);
        }

        if (!found) {
            logger.warning("No unverified user found with email: " + email);
            throw new IllegalArgumentException("No unverified user found with email: " + email);
        }
    }

    public void purgeExpiredUnverifiedAccounts() {
        List<User> users = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();
        boolean changesMade = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(userFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromFileString(line);
                if (!user.isActive() && user.getLastLogin() != null &&
                        user.getLastLogin().plusHours(24).isBefore(now)) {
                    changesMade = true;
                    logger.info("Purging expired unverified account: " + user.getEmail());
                    continue;
                }
                users.add(user);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read users for purging", e);
            throw new RuntimeException("Failed to purge unverified accounts", e);
        }

        if (changesMade) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFilePath))) {
                for (User user : users) {
                    writer.write(user.toFileString());
                    writer.newLine();
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to write updated user data", e);
                throw new RuntimeException("Failed to update user data after purging", e);
            }
        }
    }

    // **Enrollment System: Create (C) - Enroll student in multiple courses**
    public void enrollStudentInCourses(String studentId, List<String> courseIds) throws IOException {
        for (String courseId : courseIds) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(enrollmentFilePath, true))) {
                // Store enrollment with timestamp for deadline checking
                String enrollmentLine = String.format("%s,%s,active,%s",
                        studentId, courseId, LocalDateTime.now().toString());
                writer.write(enrollmentLine);
                writer.newLine();
                logger.info("Student " + studentId + " enrolled in course: " + courseId);
            }
        }
    }

    // **Enrollment System: Read (R) - View enrollment lists with student-course mapping**
    public List<String> getEnrollmentsByStudent(String studentId) {
        List<String> enrollments = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(studentId) && parts[2].equals("active")) {
                    enrollments.add("Student: " + studentId + ", Course: " + parts[1]);
                }
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read enrollments for student: " + studentId, e);
            throw new RuntimeException("Failed to read enrollments", e);
        }
        return enrollments;
    }

    // **Enrollment System: Update (U) - Change student’s course section**
    public void changeCourseSection(String studentId, String oldCourseId, String newCourseId) {
        List<String> enrollments = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(studentId) && parts[1].equals(oldCourseId)) {
                    enrollments.add(studentId + "," + newCourseId + "," + parts[2] + "," + parts[3]);
                    updated = true;
                    logger.info("Changed course for student " + studentId + ": " + oldCourseId + " to " + newCourseId);
                } else {
                    enrollments.add(line);
                }
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read enrollments for update", e);
            throw new RuntimeException("Failed to update course section", e);
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(enrollmentFilePath))) {
                for (String enrollment : enrollments) {
                    writer.write(enrollment);
                    writer.newLine();
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to write updated enrollments", e);
                throw new RuntimeException("Failed to write updated enrollments", e);
            }
        } else {
            logger.warning("No enrollment found for student " + studentId + " in course " + oldCourseId);
            throw new IllegalArgumentException("No enrollment found to update");
        }
    }

    // **Enrollment System: Delete (D) - Drop course enrollment before deadline**
    public void dropCourse(String studentId, String courseId) {
        List<String> enrollments = new ArrayList<>();
        boolean dropped = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(studentId) && parts[1].equals(courseId)) {
                    LocalDateTime enrollmentTime = LocalDateTime.parse(parts[3]);
                    LocalDateTime now = LocalDateTime.now();
                    // Example: 7-day deadline for dropping
                    if (enrollmentTime.plusDays(7).isBefore(now)) {
                        throw new IllegalStateException("Cannot drop course after deadline");
                    }
                    dropped = true;
                    logger.info("Dropped course for student " + studentId + ": " + courseId);
                    continue;
                }
                enrollments.add(line);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read enrollments for dropping", e);
            throw new RuntimeException("Failed to drop course", e);
        }

        if (dropped) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(enrollmentFilePath))) {
                for (String enrollment : enrollments) {
                    writer.write(enrollment);
                    writer.newLine();
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to write updated enrollments after drop", e);
                throw new RuntimeException("Failed to update enrollments after drop", e);
            }
        } else {
            logger.warning("No enrollment found for student " + studentId + " in course " + courseId);
            throw new IllegalArgumentException("No enrollment found to drop");
        }
    }
}