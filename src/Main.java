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