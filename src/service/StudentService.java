import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentService {
    private static final String FILE_PATH = "../data/students.txt";

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


    import java.util.List;
import java.util.Scanner;

    public class Main {
        public static void main(String[] args) {
            StudentService studentService = new StudentService();
            Scanner scanner = new Scanner(System.in);

            while (true) {
                System.out.println("\n1. Register Student");
                System.out.println("2. View All Students");
                System.out.println("3. Update Student");
                System.out.println("4. Delete Student");
                System.out.println("5. Exit");
                System.out.print("Choose an option: ");
                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline

                switch (choice) {
                    case 1:
                        // Register Student
                        System.out.print("Enter Full Name: ");
                        String fullName = scanner.nextLine();
                        System.out.print("Enter Email: ");
                        String email = scanner.nextLine();
                        System.out.print("Enter Password: ");
                        String password = scanner.nextLine();
                        System.out.print("Enter Course: ");
                        String course = scanner.nextLine();

                        Student newStudent = new Student(fullName, email, password, course);
                        studentService.createStudent(newStudent);
                        break;

                    case 2:
                        // View All Students
                        List<Student> students = studentService.readAllStudents();
                        if (students.isEmpty()) {
                            System.out.println("No students found!");
                        } else {
                            System.out.println("\nList of Students:");
                            for (Student student : students) {
                                System.out.println(student.getFullName() + " | " + student.getEmail() + " | " + student.getCourse());
                            }
                        }
                        break;

                    case 3:
                        // Update Student
                        System.out.print("Enter Email of Student to Update: ");
                        String updateEmail = scanner.nextLine();
                        System.out.print("Enter New Full Name: ");
                        String newFullName = scanner.nextLine();
                        System.out.print("Enter New Password: ");
                        String newPassword = scanner.nextLine();
                        System.out.print("Enter New Course: ");
                        String newCourse = scanner.nextLine();

                        Student updatedStudent = new Student(newFullName, updateEmail, newPassword, newCourse);
                        studentService.updateStudent(updateEmail, updatedStudent);
                        break;

                    case 4:
                        // Delete Student
                        System.out.print("Enter Email of Student to Delete: ");
                        String deleteEmail = scanner.nextLine();
                        studentService.deleteStudent(deleteEmail);
                        break;

                    case 5:
                        // Exit
                        System.out.println("Exiting...");
                        scanner.close();
                        System.exit(0);

                    default:
                        System.out.println("Invalid choice! Please try again.");
                }
            }
        }
    }
}