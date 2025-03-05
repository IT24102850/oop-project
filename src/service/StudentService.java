import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentService {
    private static final String FILE_PATH = "students.txt";

    // Create a new student
    public void createStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(student.toString());
            writer.newLine();
            System.out.println("Student registered successfully!");
        } catch (IOException e) {
            System.out.println("Error saving student data: " + e.getMessage());
        }
    }

    // Read all students
    public List<Student> readAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                students.add(new Student(data[0], data[1], data[2], data[3]));
            }
        } catch (IOException e) {
            System.out.println("Error reading student data: " + e.getMessage());
        }
        return students;
    }

    // Update a student by email
    public void updateStudent(String email, Student updatedStudent) {
        List<Student> students = readAllStudents();
        boolean found = false;
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(email)) {
                students.set(i, updatedStudent);
                found = true;
                break;
            }
        }
        if (found) {
            saveAllStudents(students);
            System.out.println("Student updated successfully!");
        } else {
            System.out.println("Student not found!");
        }
    }

    // Delete a student by email
    public void deleteStudent(String email) {
        List<Student> students = readAllStudents();
        boolean removed = students.removeIf(student -> student.getEmail().equals(email));
        if (removed) {
            saveAllStudents(students);
            System.out.println("Student deleted successfully!");
        } else {
            System.out.println("Student not found!");
        }
    }

    // Helper method to save all students to the file
    private void saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                writer.write(student.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error saving student data: " + e.getMessage());
        }
    }
}