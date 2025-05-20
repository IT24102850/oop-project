<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
    if (session.getAttribute("userType") == null || !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("logIn.jsp");
        return;
    }

    // Load courses from courses.txt
    List<String> courses = new ArrayList<>();
    String coursesFilePath = application.getRealPath("/WEB-INF/data/courses.txt");
    File coursesFile = new File(coursesFilePath);
    if (coursesFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(coursesFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                courses.add(line);
            }
        } catch (IOException e) {
            System.out.println("Error reading courses.txt: " + e.getMessage());
        }
    } else {
        courses.add("CS101,Introduction to Programming,3,Computer Science,Dr. Smith,Basic programming concepts,true");
    }
    request.setAttribute("courses", courses);

    String activeTab = request.getParameter("activeTab");
    if (activeTab == null) {
        activeTab = "dashboard";
    }

    // Handle course creation
    String action = request.getParameter("action");
    if ("create".equals(action)) {
        String courseCode = request.getParameter("courseCode");
        String title = request.getParameter("title");
        String credits = request.getParameter("credits");
        String department = request.getParameter("department");
        String professor = request.getParameter("professor");
        String syllabus = request.getParameter("syllabus");

        boolean hasError = false;
        String errorMessage = null;

        if (courseCode == null || courseCode.trim().isEmpty() || title == null || title.trim().isEmpty() ||
                credits == null || credits.trim().isEmpty() || department == null || department.trim().isEmpty()) {
            errorMessage = "All required fields must be filled.";
            hasError = true;
        } else if (!courseCode.matches("^[A-Z]{2}\\d{3}$")) {
            errorMessage = "Course code must be in format XX999 (e.g., CS101).";
            hasError = true;
        } else if (!credits.matches("\\d+")) {
            errorMessage = "Credits must be a positive number.";
            hasError = true;
        } else {
            for (String course : courses) {
                String[] parts = course.split(",");
                if (parts[0].equals(courseCode)) {
                    errorMessage = "A course with this code already exists.";
                    hasError = true;
                    break;
                }
            }
        }

        if (!hasError) {
            String newCourse = String.format("%s,%s,%s,%s,%s,%s,true",
                    courseCode, title, credits, department,
                    professor != null ? professor : "",
                    syllabus != null ? syllabus : "");
            courses.add(newCourse);

            // Write updated courses list to courses.txt
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(coursesFile))) {
                for (String course : courses) {
                    writer.write(course);
                    writer.newLine();
                }
            } catch (IOException e) {
                System.out.println("Error writing to courses.txt: " + e.getMessage());
                errorMessage = "Server error while saving course.";
                hasError = true;
            }

            if (!hasError) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=courses&message=course_added");
                return;
            }
        }
        request.setAttribute("error", errorMessage);
    }

    // Handle course update
    if ("update".equals(action)) {
        String originalCourseCode = request.getParameter("originalCourseCode");
        String courseCode = request.getParameter("courseCode");
        String title = request.getParameter("title");
        String credits = request.getParameter("credits");
        String department = request.getParameter("department");
        String professor = request.getParameter("professor");
        String syllabus = request.getParameter("syllabus");

        boolean hasError = false;
        String errorMessage = null;

        if (courseCode == null || courseCode.trim().isEmpty() || title == null || title.trim().isEmpty() ||
                credits == null || credits.trim().isEmpty() || department == null || department.trim().isEmpty()) {
            errorMessage = "All required fields must be filled.";
            hasError = true;
        } else if (!courseCode.matches("^[A-Z]{2}\\d{3}$")) {
            errorMessage = "Course code must be in format XX999 (e.g., CS101).";
            hasError = true;
        } else if (!credits.matches("\\d+")) {
            errorMessage = "Credits must be a positive number.";
            hasError = true;
        } else if (!courseCode.equals(originalCourseCode)) {
            for (String course : courses) {
                String[] parts = course.split(",");
                if (parts[0].equals(courseCode)) {
                    errorMessage = "A course with this code already exists.";
                    hasError = true;
                    break;
                }
            }
        }

        if (!hasError) {
            boolean courseFound = false;
            for (int i = 0; i < courses.size(); i++) {
                String[] parts = courses.get(i).split(",");
                if (parts[0].equals(originalCourseCode)) {
                    String updatedCourse = String.format("%s,%s,%s,%s,%s,%s,%s",
                            courseCode, title, credits, department,
                            professor != null ? professor : "",
                            syllabus != null ? syllabus : "", parts[6]);
                    courses.set(i, updatedCourse);
                    courseFound = true;
                    break;
                }
            }

            if (!courseFound) {
                errorMessage = "Course not found.";
                hasError = true;
            } else {
                // Write updated courses list to courses.txt
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(coursesFile))) {
                    for (String course : courses) {
                        writer.write(course);
                        writer.newLine();
                    }
                } catch (IOException e) {
                    System.out.println("Error writing to courses.txt: " + e.getMessage());
                    errorMessage = "Server error while updating course.";
                    hasError = true;
                }
            }

            if (!hasError) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=courses&message=course_updated");
                return;
            }
        }
        request.setAttribute("error", errorMessage);
    }

    // Handle course deletion
    if ("delete".equals(action)) {
        String courseCode = request.getParameter("courseCode");
        boolean courseFound = false;

        for (int i = 0; i < courses.size(); i++) {
            String[] parts = courses.get(i).split(",");
            if (parts[0].equals(courseCode)) {
                courses.remove(i);
                courseFound = true;
                break;
            }
        }

        if (courseFound) {
            // Write updated courses list to courses.txt
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(coursesFile))) {
                for (String course : courses) {
                    writer.write(course);
                    writer.newLine();
                }
            } catch (IOException e) {
                System.out.println("Error writing to courses.txt: " + e.getMessage());
                request.setAttribute("error", "Server error while deleting course.");
            }
            response.sendRedirect("admin-dashboard.jsp?activeTab=courses&message=course_deleted");
            return;
        } else {
            request.setAttribute("error", "Course not found.");
        }
    }

    // Calculate active courses count
    int activeCoursesCount = 0;
    for (String course : courses) {
        String[] parts = course.split(",");
        if (parts.length >= 7 && "true".equals(parts[6])) {
            activeCoursesCount++;
        }
    }

    List<String[]> students = new ArrayList<>();
    String studentsFilePath = application.getRealPath("/WEB-INF/data/students.txt");
    File studentsFile = new File(studentsFilePath);
    if (studentsFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(studentsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 3) {
                    students.add(parts);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading students.txt: " + e.getMessage());
        }
    }

    List<String[]> paymentHistory = new ArrayList<>();
    String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
    File paymentsFile = new File(paymentsFilePath);
    if (paymentsFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(paymentsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 11) {
                    paymentHistory.add(parts);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading payments.txt: " + e.getMessage());
        }
    }

    int totalPayments = paymentHistory.size();
    double totalAmount = 0.0;
    int pendingPayments = 0;
    for (String[] payment : paymentHistory) {
        try {
            totalAmount += Double.parseDouble(payment[2].replace("$", ""));
            if ("pending".equals(payment[4]) || "overdue".equals(payment[4])) {
                pendingPayments++;
            }
        } catch (NumberFormatException e) {
            System.out.println("Error parsing amount for payment: " + Arrays.toString(payment));
        }
    }

    // Load admins from admins.txt
    List<String[]> admins = new ArrayList<>();
    String adminsFilePath = application.getRealPath("/WEB-INF/data/admins.txt");
    File adminsFile = new File(adminsFilePath);
    if (adminsFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(adminsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 3) {
                    admins.add(parts);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading admins.txt: " + e.getMessage());
        }
    } else {
        admins.add(new String[]{"admin1", "Admin One", "admin1@nexora.edu"});
    }
    request.setAttribute("admins", admins);

    // Handle admin creation
    if ("createAdmin".equals(action)) {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        boolean hasError = false;
        String errorMessage = null;

        if (username == null || username.trim().isEmpty() || name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            errorMessage = "All fields are required.";
            hasError = true;
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errorMessage = "Invalid email format.";
            hasError = true;
        } else {
            for (String[] admin : admins) {
                if (admin[0].equals(username)) {
                    errorMessage = "An admin with this username already exists.";
                    hasError = true;
                    break;
                }
                if (admin[2].equals(email)) {
                    errorMessage = "An admin with this email already exists.";
                    hasError = true;
                    break;
                }
            }
        }

        if (!hasError) {
            String newAdmin = String.format("%s,%s,%s", username, name, email);
            admins.add(new String[]{username, name, email});

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(adminsFile))) {
                for (String[] admin : admins) {
                    writer.write(String.join(",", admin));
                    writer.newLine();
                }
            } catch (IOException e) {
                System.out.println("Error writing to admins.txt: " + e.getMessage());
                errorMessage = "Server error while saving admin.";
                hasError = true;
            }

            if (!hasError) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=admin-management&message=admin_added");
                return;
            }
        }
        request.setAttribute("error", errorMessage);
    }

    // Handle admin update
    if ("updateAdmin".equals(action)) {
        String originalUsername = request.getParameter("originalUsername");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        boolean hasError = false;
        String errorMessage = null;

        if (username == null || username.trim().isEmpty() || name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            errorMessage = "All fields are required.";
            hasError = true;
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errorMessage = "Invalid email format.";
            hasError = true;
        } else if (!username.equals(originalUsername)) {
            for (String[] admin : admins) {
                if (admin[0].equals(username)) {
                    errorMessage = "An admin with this username already exists.";
                    hasError = true;
                    break;
                }
            }
        } else {
            for (String[] admin : admins) {
                if (admin[2].equals(email) && !admin[0].equals(originalUsername)) {
                    errorMessage = "An admin with this email already exists.";
                    hasError = true;
                    break;
                }
            }
        }

        if (!hasError) {
            boolean adminFound = false;
            for (int i = 0; i < admins.size(); i++) {
                if (admins.get(i)[0].equals(originalUsername)) {
                    admins.set(i, new String[]{username, name, email});
                    adminFound = true;
                    break;
                }
            }

            if (!adminFound) {
                errorMessage = "Admin not found.";
                hasError = true;
            } else {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(adminsFile))) {
                    for (String[] admin : admins) {
                        writer.write(String.join(",", admin));
                        writer.newLine();
                    }
                } catch (IOException e) {
                    System.out.println("Error writing to admins.txt: " + e.getMessage());
                    errorMessage = "Server error while updating admin.";
                    hasError = true;
                }
            }

            if (!hasError) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=admin-management&message=admin_updated");
                return;
            }
        }
        request.setAttribute("error", errorMessage);
    }

    // Handle admin deletion
    if ("deleteAdmin".equals(action)) {
        String username = request.getParameter("username");
        boolean adminFound = false;

        for (int i = 0; i < admins.size(); i++) {
            if (admins.get(i)[0].equals(username)) {
                admins.remove(i);
                adminFound = true;
                break;
            }
        }

        if (adminFound) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(adminsFile))) {
                for (String[] admin : admins) {
                    writer.write(String.join(",", admin));
                    writer.newLine();
                }
            } catch (IOException e) {
                System.out.println("Error writing to admins.txt: " + e.getMessage());
                request.setAttribute("error", "Server error while deleting admin.");
            }
            response.sendRedirect("admin-dashboard.jsp?activeTab=admin-management&message=admin_deleted");
            return;
        } else {
            request.setAttribute("error", "Admin not found.");
        }
    }

    String errorMessage = null;
    String error = request.getParameter("error");
    if (error != null) {
        switch (error) {
            case "empty_fields":
                errorMessage = "All fields are required. Please fill in all the details.";
                break;
            case "duplicate_id_or_email":
                errorMessage = "A student with this ID or email already exists.";
                break;
            case "duplicate_course":
                errorMessage = "A course with this code already exists.";
                break;
            case "course_not_found":
                errorMessage = "The course was not found.";
                break;
            case "server_error":
                errorMessage = "An error occurred on the server. Please try again later.";
                break;
            case "invalid_input":
                errorMessage = "Input contains invalid characters (e.g., commas).";
                break;
            case "payment_not_found":
                errorMessage = "The payment was not found.";
                break;
            default:
                errorMessage = "An unexpected error occurred.";
        }
        request.setAttribute("error", errorMessage);
    }

    String successMessage = null;
    String message = request.getParameter("message");
    if (message != null) {
        switch (message) {
            case "student_added":
                successMessage = "Student successfully added!";
                break;
            case "student_updated":
                successMessage = "Student successfully updated!";
                break;
            case "student_deleted":
                successMessage = "Student successfully deleted!";
                break;
            case "course_added":
                successMessage = "Course successfully added!";
                break;
            case "course_updated":
                successMessage = "Course successfully updated!";
                break;
            case "course_archived":
                successMessage = "Course successfully archived!";
                break;
            case "course_deleted":
                successMessage = "Course successfully deleted!";
                break;
            case "payment_updated":
                successMessage = "Payment status successfully updated!";
                break;
            case "admin_added":
                successMessage = "Admin successfully added!";
                break;
            case "admin_updated":
                successMessage = "Admin successfully updated!";
                break;
            case "admin_deleted":
                successMessage = "Admin successfully deleted!";
                break;
        }
        request.setAttribute("message", successMessage);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Admin Dashboard</title>
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --success-color: #4caf50;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --card-bg: rgba(15, 23, 42, 0.9);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 16px;
            --box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
            --transition: all 0.3s ease-in-out;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--darker-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 280px;
            background: var(--card-bg);
            padding: 25px;
            border-right: 1px solid rgba(0, 242, 254, 0.1);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            margin-bottom: 40px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 15px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            border-radius: var(--border-radius);
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .nav-link:hover {
            background: var(--glass-bg);
            transform: translateX(10px);
            box-shadow: 0 0 10px rgba(0, 242, 254, 0.2);
        }

        .nav-link.active {
            background: linear-gradient(90deg, var(--primary-color), transparent);
            border-left: 4px solid var(--primary-color);
            box-shadow: 0 0 15px rgba(0, 242, 254, 0.4);
        }

        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 40px;
            transition: var(--transition);
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow);
        }

        .stat-card h3 {
            margin-bottom: 10px;
            font-size: 1rem;
            color: var(--text-muted);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .action-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            margin-bottom: 20px;
        }

        .action-card h3 {
            margin-bottom: 15px;
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        .data-table {
            width: 100%;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            border-collapse: collapse;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .data-table th, .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            font-size: 0.9rem;
        }

        .data-table tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.03);
        }

        .data-table th {
            background: var(--glass-bg);
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-family: 'Poppins', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            box-shadow: 0 2px 8px rgba(0, 242, 254, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 242, 254, 0.5);
        }

        .btn-danger {
            background: var(--accent-color);
            color: white;
            box-shadow: 0 2px 8px rgba(255, 77, 126, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 77, 126, 0.5);
        }

        .btn-warning {
            background: #ffc107;
            color: var(--dark-color);
            box-shadow: 0 2px 8px rgba(255, 193, 7, 0.3);
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.5);
        }

        .btn-success {
            background: none;
            border: none;
            color: #00b7eb;
            text-decoration: underline;
            font-size: 1rem;
            cursor: pointer;
            padding: 10px 20px;
        }

        .btn-success:hover {
            color: #63b3ed;
        }

        .btn-futuristic {
            position: relative;
            background: transparent;
            border: none;
            color: var(--text-color);
            font-family: 'Orbitron', sans-serif;
            font-size: 0.85rem;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition);
            overflow: hidden;
        }

        .btn-futuristic i {
            font-size: 1.1rem;
            transition: var(--transition);
            animation: pulsate 2s infinite;
        }

        @keyframes pulsate {
            0% { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
            50% { text-shadow: 0 0 15px rgba(255, 255, 255, 0.8); }
            100% { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
        }

        .btn-futuristic:hover i {
            transform: scale(1.2);
            animation: bounce 0.5s ease;
        }

        @keyframes bounce {
            0% { transform: scale(1); }
            50% { transform: scale(1.3); }
            100% { transform: scale(1.2); }
        }

        .btn-futuristic-update {
            border: 2px solid transparent;
            background: linear-gradient(var(--dark-color), var(--dark-color)) padding-box,
            linear-gradient(45deg, var(--primary-color), var(--secondary-color)) border-box;
            box-shadow: 0 0 10px rgba(0, 242, 254, 0.5);
        }

        .btn-futuristic-update:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 242, 254, 0.8);
        }

        .btn-futuristic-archive {
            border: 2px solid transparent;
            background: linear-gradient(var(--dark-color), var(--dark-color)) padding-box,
            linear-gradient(45deg, #f39c12, #e67e22) border-box;
            box-shadow: 0 0 10px rgba(243, 156, 18, 0.5);
        }

        .btn-futuristic-archive:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(243, 156, 18, 0.8);
        }

        .btn-futuristic-delete {
            border: 2px solid transparent;
            background: linear-gradient(var(--dark-color), var(--dark-color)) padding-box,
            linear-gradient(45deg, var(--accent-color), #d81b60) border-box;
            box-shadow: 0 0 10px rgba(255, 77, 126, 0.5);
        }

        .btn-futuristic-delete:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255, 77, 126, 0.8);
        }

        .btn-futuristic-create {
            border: 2px solid transparent;
            background: linear-gradient(var(--dark-color), var(--dark-color)) padding-box,
            linear-gradient(45deg, #00c853, #4caf50) border-box;
            box-shadow: 0 0 10px rgba(0, 200, 83, 0.5);
        }

        .btn-futuristic-create:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 200, 83, 0.8);
        }

        .btn-futuristic:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }

        .btn-futuristic::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s ease, height 0.5s ease;
        }

        .btn-futuristic:active::after {
            width: 200px;
            height: 200px;
            opacity: 0;
        }

        .btn-futuristic:hover::before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: var(--dark-color);
            color: var(--text-color);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.8rem;
            white-space: nowrap;
            border: 1px solid;
            border-image: linear-gradient(45deg, var(--primary-color), var(--secondary-color)) 1;
            box-shadow: 0 0 8px rgba(0, 242, 254, 0.3);
        }

        .btn-futuristic:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 242, 254, 0.5);
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        label.required::after {
            content: '*';
            color: var(--accent-color);
            margin-left: 4px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.5);
            border-radius: 8px;
            color: var(--text-color);
            font-size: 0.9rem;
            transition: var(--transition);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 8px rgba(0, 242, 254, 0.3);
        }

        .error-text {
            color: var(--accent-color);
            font-size: 0.8rem;
            margin-top: 5px;
            display: none;
        }

        .message {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .message.success {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
        }

        .message.error {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
        }

        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status.active {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
        }

        .status.inactive {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(10px);
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .modal.show {
            opacity: 1;
        }

        .modal-content {
            background: var(--card-bg);
            width: 600px;
            padding: 20px;
            border-radius: var(--border-radius);
            position: relative;
            margin: 5% auto;
            transform: scale(0.8);
            transition: transform 0.3s ease-in-out;
        }

        .modal.show .modal-content {
            transform: scale(1);
        }

        .modal-content h2 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .modal-close {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: var(--text-muted);
            font-size: 1.2rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .modal-close:hover {
            color: var(--text-color);
            transform: rotate(90deg);
        }

        .add-student-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .add-student-form .form-group {
            margin-bottom: 15px;
        }

        .add-student-form .button-group {
            grid-column: span 2;
            text-align: right;
            margin-top: 10px;
        }

        .update-student-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .update-student-form .form-group {
            margin-bottom: 15px;
        }

        .update-student-form .button-group {
            grid-column: span 2;
            text-align: right;
            margin-top: 10px;
        }

        .update-course-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .update-course-form .form-group {
            margin-bottom: 15px;
        }

        .update-course-form .syllabus-group {
            grid-column: span 1;
        }

        .update-course-form textarea {
            height: 80px;
            resize: none;
        }

        .update-course-form .button-group {
            grid-column: span 2;
            text-align: right;
            margin-top: 10px;
        }

        .create-course-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .create-course-form .form-group {
            margin-bottom: 15px;
        }

        .create-course-form .syllabus-group {
            grid-column: span 1;
        }

        .create-course-form textarea {
            height: 80px;
            resize: none;
        }

        .create-course-form .button-group {
            grid-column: span 2;
            text-align: right;
            margin-top: 10px;
        }

        .emergency-contact-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .inline-student-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            background: var(--card-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            margin-bottom: 20px;
        }

        .inline-student-form .form-group {
            margin-bottom: 15px;
        }

        .inline-student-form .button-group {
            grid-column: span 2;
            text-align: right;
            margin-top: 10px;
        }

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .course-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 20px;
        }

        .course-header h3 {
            font-size: 1.5rem;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            cursor: pointer;
            transition: var(--transition);
        }

        .course-header h3:hover {
            transform: translateX(5px);
        }

        .course-content {
            display: none;
        }

        .course-content.active {
            display: block;
        }

        .filter-form {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            justify-content: center;
        }

        .filter-form select {
            padding: 10px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .filter-form button {
            padding: 10px 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: var(--border-radius);
            color: var(--dark-color);
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 242, 254, 0.3);
            transition: var(--transition);
        }

        .filter-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 242, 254, 0.5);
        }

        .course-table-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--box-shadow);
        }

        .course-table-container table {
            width: 100%;
            border-collapse: collapse;
        }

        .course-table-container th, .course-table-container td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.9rem;
        }

        .course-table-container th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .payment-table {
            width: 100%;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            border-collapse: collapse;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .payment-table th, .payment-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            font-size: 0.9rem;
        }

        .payment-table tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.03);
        }

        .payment-table th {
            background: var(--glass-bg);
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-bar input {
            padding: 10px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.5);
            border-radius: 8px;
            color: var(--text-color);
            font-size: 0.9rem;
            transition: var(--transition);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .search-bar input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 8px rgba(0, 242, 254, 0.3);
        }

        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .spinner {
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top: 4px solid var(--primary-color);
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 15px;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .modal-content {
                width: 90%;
            }

            .update-course-form,
            .create-course-form,
            .emergency-contact-form,
            .add-student-form,
            .update-student-form,
            .inline-student-form {
                grid-template-columns: 1fr;
            }

            .update-course-form .syllabus-group,
            .create-course-form .syllabus-group {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
</div>

<div class="sidebar">
    <div class="logo">NexoraSkill Admin</div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="?activeTab=dashboard" class="nav-link <%= "dashboard".equals(activeTab) ? "active" : "" %>" data-section="dashboard" aria-label="Dashboard">
                <i class="fas fa-chart-line"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="?activeTab=students" class="nav-link <%= "students".equals(activeTab) ? "active" : "" %>" data-section="students" aria-label="Student Management">
                <i class="fas fa-users"></i> Student Management
            </a>
        </li>
        <li class="nav-item">
            <a href="?activeTab=courses" class="nav-link <%= "courses".equals(activeTab) ? "active" : "" %>" data-section="courses" aria-label="Course Management">
                <i class="fas fa-book-open"></i> Course Management
            </a>
        </li>

        <li class="nav-item">
            <a href="?activeTab=payment" class="nav-link <%= "payment".equals(activeTab) ? "active" : "" %>" data-section="payment" aria-label="Payment Management">
                <i class="fas fa-credit-card"></i> Payment Management
            </a>
        </li>
        <li class="nav-item">
            <a href="?activeTab=admin-management" class="nav-link <%= "admin-management".equals(activeTab) ? "active" : "" %>" data-section="admin-management" aria-label="Admin Management">
                <i class="fas fa-user-shield"></i> Admin Management
            </a>
        </li>

        <li class="nav-item">
            <a href="?activeTab=reviews" class="nav-link <%= "reviews".equals(activeTab) ? "active" : "" %>" data-section="reviews" aria-label="Review Management">
                <i class="fas fa-star"></i> Review Management
            </a>
        </li>

        <li class="nav-item">
            <a href="?activeTab=course-requests" class="nav-link <%= "course-requests".equals(activeTab) ? "active" : "" %>" data-section="course-requests" aria-label="Course Requests">
                <i class="fas fa-file-alt"></i> Course Requests
            </a>
        </li>

    </ul>
</div>

<div class="main-content">
    <div class="dashboard-header">
        <h1>Admin Dashboard</h1>
        <div class="admin-info">
            <span>Admin User</span>
            <form action="auth" method="post" style="display: inline;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="btn btn-danger" aria-label="Logout">
                    <a href="${pageContext.request.contextPath}/logIn.jsp?logout=true" class="btn btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </button>
            </form>
        </div>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="message error" role="alert"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <div class="message success" role="alert"><%= request.getAttribute("message") %></div>
    <% } %>

    <section id="dashboard" class="content-section <%= "dashboard".equals(activeTab) ? "active" : "" %>">
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Students</h3>
                <p class="stat-value"><%= students.size() %></p>
            </div>
            <div class="stat-card">
                <h3>Active Courses</h3>
                <p class="stat-value"><%= activeCoursesCount %></p>
            </div>
            <div class="stat-card">
                <h3>Pending Requests</h3>
                <p class="stat-value">12</p>
            </div>
        </div>









    </section>


    <section id="students" class="content-section <%= "students".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-users-cog"></i> Student Management</h2>
        </div>

        <div class="course-container">
            <h3>Add New Student</h3>
            <form action="studentRegistration" method="post" class="inline-student-form" onsubmit="return validateAddStudentForm(this)">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="inlineStudentId" class="required">Student ID</label>
                    <input type="text" id="inlineStudentId" name="id" required placeholder="e.g., STU20230001">
                    <div class="error-text" id="inlineStudentIdError"></div>
                </div>
                <div class="form-group">
                    <label for="inlineStudentName" class="required">Full Name</label>
                    <input type="text" id="inlineStudentName" name="name" required placeholder="e.g., John Doe">
                    <div class="error-text" id="inlineStudentNameError"></div>
                </div>
                <div class="form-group">
                    <label for="inlineStudentEmail" class="required">Email</label>
                    <input type="email" id="inlineStudentEmail" name="email" required placeholder="e.g., john.doe@nexora.edu">
                    <div class="error-text" id="inlineStudentEmailError"></div>
                </div>
                <div class="button-group">
                    <button type="submit" id="inlineAddStudentBtn" class="btn-futuristic btn-futuristic-create" data-tooltip="Add this student" aria-label="Add Student">
                        <i class="fas fa-user-plus"></i> Add Student
                    </button>
                </div>
            </form>
        </div>

        <div class="search-bar">
            <input type="text" id="studentSearch" placeholder="Search students by name..." onkeyup="searchStudents()" aria-label="Search students">
            <i class="fas fa-search"></i>
        </div>

        <table class="data-table" id="studentTable">
            <thead>
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (students != null && !students.isEmpty()) {
                    for (String[] student : students) {
            %>
            <tr class="student-row" data-student-name="<%= student[1] %>">
                <td><%= student[0] %></td>
                <td class="student-name"><%= student[1] %></td>
                <td><%= student[2] %></td>
                <td>
                    <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this student" onclick="toggleUpdateForm('<%= student[0] %>')" aria-label="Update Student">
                        <i class="fas fa-pen-nib"></i> Update
                    </button>
                    <a href="studentRegistration?action=delete&id=<%= student[0] %>&activeTab=students" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this student" onclick="return confirmStudentDelete('<%= student[0] %>')" aria-label="Delete Student">
                        <i class="fas fa-trash-can"></i> Delete
                    </a>
                </td>
            </tr>
            <tr id="update-form-<%= student[0] %>" class="update-form-row" style="display: none;">
                <td colspan="4">
                    <form action="studentRegistration" method="post" class="inline-student-form" onsubmit="return validateUpdateStudentForm(this, '<%= student[0] %>')">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= student[0] %>">
                        <div class="form-group">
                            <label for="updateStudentName-<%= student[0] %>" class="required">Full Name</label>
                            <input type="text" id="updateStudentName-<%= student[0] %>" name="name" value="<%= student[1] %>" required>
                            <div class="error-text" id="updateStudentNameError-<%= student[0] %>"></div>
                        </div>
                        <div class="form-group">
                            <label for="updateStudentEmail-<%= student[0] %>" class="required">Email</label>
                            <input type="email" id="updateStudentEmail-<%= student[0] %>" name="email" value="<%= student[2] %>" required>
                            <div class="error-text" id="updateStudentEmailError-<%= student[0] %>"></div>
                        </div>
                        <div class="button-group">
                            <button type="submit" class="btn-futuristic btn-futuristic-create" data-tooltip="Save changes" aria-label="Save Changes">
                                <i class="fas fa-save"></i> Save
                            </button>
                            <button type="button" class="btn-futuristic btn-futuristic-cancel" data-tooltip="Cancel" onclick="toggleUpdateForm('<%= student[0] %>')" aria-label="Cancel Update">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center;">No students available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>

    <script>
        function searchStudents() {
            let input = document.getElementById("studentSearch").value.toLowerCase();
            let table = document.getElementById("studentTable");
            let tr = table.getElementsByClassName("student-row");

            for (let i = 0; i < tr.length; i++) {
                let studentName = tr[i].getAttribute("data-student-name").toLowerCase();
                if (studentName.includes(input)) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        function toggleUpdateForm(studentId) {
            let formRow = document.getElementById("update-form-" + studentId);
            if (formRow.style.display === "none" || formRow.style.display === "") {
                formRow.style.display = "table-row";
            } else {
                formRow.style.display = "none";
            }
        }

        function validateUpdateStudentForm(form, studentId) {
            let name = form.querySelector(`#updateStudentName-${studentId}`).value.trim();
            let email = form.querySelector(`#updateStudentEmail-${studentId}`).value.trim();
            let nameError = document.getElementById(`updateStudentNameError-${studentId}`);
            let emailError = document.getElementById(`updateStudentEmailError-${studentId}`);

            let isValid = true;
            nameError.textContent = "";
            emailError.textContent = "";

            if (name === "") {
                nameError.textContent = "Full Name is required.";
                isValid = false;
            }

            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = "Please enter a valid email address.";
                isValid = false;
            }

            if (isValid) {
                return confirm(`Are you sure you want to update student with ID ${studentId}?`);
            }
            return false;
        }

        function confirmStudentDelete(studentId) {
            return confirm(`Are you sure you want to delete student with ID ${studentId}?`);
        }
    </script>




    <section id="courses" class="content-section <%= "courses".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-book"></i> Course Management</h2>
        </div>

        <div class="course-container">
            <div class="course-header">
                <h3 onclick="toggleCourseSection('create-course-content')">Create New Course</h3>
            </div>
            <div id="create-course-content" class="course-content <%= "courses".equals(activeTab) ? "active" : "" %>">
                <form action="admin-dashboard.jsp" method="post" class="create-course-form" onsubmit="return validateCreateCourseForm(this)">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="activeTab" value="courses">
                    <div class="form-group">
                        <label for="courseCode" class="required">Course Code</label>
                        <input type="text" id="courseCode" name="courseCode" required placeholder="e.g., CS101">
                        <div class="error-text" id="courseCodeError"></div>
                    </div>
                    <div class="form-group">
                        <label for="title" class="required">Title</label>
                        <input type="text" id="title" name="title" required placeholder="e.g., Introduction to Programming">
                        <div class="error-text" id="titleError"></div>
                    </div>
                    <div class="form-group">
                        <label for="credits" class="required">Credits</label>
                        <input type="number" id="credits" name="credits" required placeholder="e.g., 3" min="1">
                        <div class="error-text" id="creditsError"></div>
                    </div>
                    <div class="form-group">
                        <label for="department" class="required">Department</label>
                        <select id="department" name="department" required>
                            <option value="">Select Department</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Mathematics">Mathematics</option>
                            <option value="Physics">Physics</option>
                        </select>
                        <div class="error-text" id="departmentError"></div>
                    </div>
                    <div class="form-group">
                        <label for="professor">Professor</label>
                        <input type="text" id="professor" name="professor" placeholder="e.g., Dr. Smith">
                    </div>
                    <div class="form-group syllabus-group">
                        <label for="syllabus">Syllabus</label>
                        <textarea id="syllabus" name="syllabus" placeholder="e.g., Basic programming concepts" rows="4"></textarea>
                    </div>
                    <div class="button-group">
                        <button type="submit" id="createCourseBtn" class="btn-futuristic btn-futuristic-create" data-tooltip="Create a new course" aria-label="Create a new course">
                            <i class="fas fa-plus"></i> Create Course
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="course-container">
            <div class="course-header">
                <h3 onclick="toggleCourseSection('view-courses-content')">View Courses</h3>
            </div>
            <div id="view-courses-content" class="course-content <%= "courses".equals(activeTab) ? "active" : "" %>">
                <form action="admin-dashboard.jsp" method="get" class="filter-form">
                    <input type="hidden" name="action" value="view">
                    <input type="hidden" name="activeTab" value="courses">
                    <select name="department" aria-label="Filter by Department">
                        <option value="">All Departments</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                    </select>
                    <select name="credits" aria-label="Filter by Credits">
                        <option value="">All Credits</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                    <button type="submit" aria-label="Apply Filters"><i class="fas fa-filter"></i> Filter</button>
                </form>

                <div class="course-table-container">
                    <table>
                        <tr>
                            <th>Course Code</th>
                            <th>Title</th>
                            <th>Credits</th>
                            <th>Department</th>
                            <th>Professor</th>
                            <th>Syllabus</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        <%
                            String filterDepartment = request.getParameter("department");
                            String filterCredits = request.getParameter("credits");
                            if (courses != null && !courses.isEmpty()) {
                                for (String course : courses) {
                                    String[] parts = course.split(",");
                                    if (parts.length < 7) continue;

                                    boolean matchesFilter = true;
                                    if (filterDepartment != null && !filterDepartment.isEmpty() && !parts[3].equals(filterDepartment)) {
                                        matchesFilter = false;
                                    }
                                    if (filterCredits != null && !filterCredits.isEmpty() && !parts[2].equals(filterCredits)) {
                                        matchesFilter = false;
                                    }

                                    if (!matchesFilter) continue;
                        %>
                        <tr>
                            <td><%= parts[0] %></td>
                            <td><%= parts[1] %></td>
                            <td><%= parts[2] %></td>
                            <td><%= parts[3] %></td>
                            <td><%= parts[4] %></td>
                            <td><%= parts[5] %></td>
                            <td><span class="status <%= "true".equals(parts[6]) ? "active" : "inactive" %>"><%= "true".equals(parts[6]) ? "Active" : "Archived" %></span></td>
                            <td class="action-buttons">
                                <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this course" onclick="openUpdateModal('<%= parts[0] %>', '<%= parts[1] %>', '<%= parts[2] %>', '<%= parts[3] %>', '<%= parts[4] %>', '<%= parts[5] %>')" aria-label="Update Course">
                                    <i class="fas fa-pen-nib"></i> Update
                                </button>
                                <% if ("true".equals(parts[6])) { %>
                                <a href="admin-dashboard.jsp?action=archive&courseCode=<%= parts[0] %>&activeTab=courses" class="btn-futuristic btn-futuristic-archive" data-tooltip="Archive this course" aria-label="Archive Course">
                                    <i class="fas fa-box-archive"></i> Archive
                                </a>
                                <% } %>
                                <a href="admin-dashboard.jsp?action=delete&courseCode=<%= parts[0] %>&activeTab=courses" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this course" onclick="return confirmDelete('<%= parts[0] %>')" aria-label="Delete Course">
                                    <i class="fas fa-trash-can"></i> Delete
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="8" style="text-align: center;">No courses available.</td>
                        </tr>
                        <% } %>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal for Updating Course -->
        <div id="updateCourseModal" class="modal">
            <div class="modal-content">
                <button class="modal-close" onclick="closeModal('updateCourseModal')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
                <h2>Update Course</h2>
                <form action="admin-dashboard.jsp" method="post" class="update-course-form" onsubmit="return validateUpdateCourseForm()">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="activeTab" value="courses">
                    <input type="hidden" name="originalCourseCode" id="updateOriginalCourseCode">
                    <div class="form-group">
                        <label for="updateCourseCode" class="required">Course Code</label>
                        <input type="text" id="updateCourseCode" name="courseCode" required placeholder="e.g., CS101">
                        <div class="error-text" id="updateCourseCodeError"></div>
                    </div>
                    <div class="form-group">
                        <label for="updateTitle" class="required">Title</label>
                        <input type="text" id="updateTitle" name="title" required placeholder="e.g., Introduction to Programming">
                        <div class="error-text" id="updateTitleError"></div>
                    </div>
                    <div class="form-group">
                        <label for="updateCredits" class="required">Credits</label>
                        <input type="number" id="updateCredits" name="credits" required placeholder="e.g., 3" min="1">
                        <div class="error-text" id="updateCreditsError"></div>
                    </div>
                    <div class="form-group">
                        <label for="updateDepartment" class="required">Department</label>
                        <select id="updateDepartment" name="department" required>
                            <option value="">Select Department</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Mathematics">Mathematics</option>
                            <option value="Physics">Physics</option>
                        </select>
                        <div class="error-text" id="updateDepartmentError"></div>
                    </div>
                    <div class="form-group">
                        <label for="updateProfessor">Professor</label>
                        <input type="text" id="updateProfessor" name="professor" placeholder="e.g., Dr. Smith">
                    </div>
                    <div class="form-group syllabus-group">
                        <label for="updateSyllabus">Syllabus</label>
                        <textarea id="updateSyllabus" name="syllabus" placeholder="e.g., Basic programming concepts" rows="4"></textarea>
                    </div>
                    <div class="button-group">
                        <button type="submit" class="btn-futuristic btn-futuristic-update" data-tooltip="Update this course" aria-label="Update Course">
                            <i class="fas fa-pen-nib"></i> Update Course
                        </button>
                        <button type="button" class="btn-futuristic btn-futuristic-cancel" data-tooltip="Cancel" onclick="closeModal('updateCourseModal')" aria-label="Cancel Update">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function toggleCourseSection(sectionId) {
                const section = document.getElementById(sectionId);
                section.classList.toggle('active');
            }

            function openUpdateModal(courseCode, title, credits, department, professor, syllabus) {
                // Populate the form fields with the course data
                document.getElementById('updateOriginalCourseCode').value = courseCode;
                document.getElementById('updateCourseCode').value = courseCode;
                document.getElementById('updateTitle').value = title;
                document.getElementById('updateCredits').value = credits;
                document.getElementById('updateDepartment').value = department;
                document.getElementById('updateProfessor').value = professor;
                document.getElementById('updateSyllabus').value = syllabus;

                // Open the modal
                openModal('updateCourseModal');
            }

            function validateCreateCourseForm(form) {
                let isValid = true;
                const courseCode = form.querySelector('#courseCode').value.trim();
                const title = form.querySelector('#title').value.trim();
                const credits = form.querySelector('#credits').value.trim();
                const department = form.querySelector('#department').value.trim();

                // Reset error messages
                form.querySelector('#courseCodeError').textContent = '';
                form.querySelector('#titleError').textContent = '';
                form.querySelector('#creditsError').textContent = '';
                form.querySelector('#departmentError').textContent = '';

                // Validate Course Code (e.g., CS101 format: two letters followed by three digits)
                const courseCodeRegex = /^[A-Z]{2}\d{3}$/;
                if (!courseCodeRegex.test(courseCode)) {
                    form.querySelector('#courseCodeError').textContent = 'Course code must be in format XX999 (e.g., CS101).';
                    isValid = false;
                }

                // Validate Title (not empty)
                if (title === '') {
                    form.querySelector('#titleError').textContent = 'Title is required.';
                    isValid = false;
                }

                // Validate Credits (positive number)
                if (!credits.match(/^\d+$/) || parseInt(credits) <= 0) {
                    form.querySelector('#creditsError').textContent = 'Credits must be a positive number.';
                    isValid = false;
                }

                // Validate Department (not empty)
                if (department === '') {
                    form.querySelector('#departmentError').textContent = 'Department is required.';
                    isValid = false;
                }

                if (isValid) {
                    document.getElementById('loadingOverlay').style.display = 'flex';
                }

                return isValid;
            }

            function validateUpdateCourseForm() {
                let isValid = true;
                const courseCode = document.getElementById('updateCourseCode').value.trim();
                const title = document.getElementById('updateTitle').value.trim();
                const credits = document.getElementById('updateCredits').value.trim();
                const department = document.getElementById('updateDepartment').value.trim();

                // Reset error messages
                document.getElementById('updateCourseCodeError').textContent = '';
                document.getElementById('updateTitleError').textContent = '';
                document.getElementById('updateCreditsError').textContent = '';
                document.getElementById('updateDepartmentError').textContent = '';

                // Validate Course Code (e.g., CS101 format: two letters followed by three digits)
                const courseCodeRegex = /^[A-Z]{2}\d{3}$/;
                if (!courseCodeRegex.test(courseCode)) {
                    document.getElementById('updateCourseCodeError').textContent = 'Course code must be in format XX999 (e.g., CS101).';
                    isValid = false;
                }

                // Validate Title (not empty)
                if (title === '') {
                    document.getElementById('updateTitleError').textContent = 'Title is required.';
                    isValid = false;
                }

                // Validate Credits (positive number)
                if (!credits.match(/^\d+$/) || parseInt(credits) <= 0) {
                    document.getElementById('updateCreditsError').textContent = 'Credits must be a positive number.';
                    isValid = false;
                }

                // Validate Department (not empty)
                if (department === '') {
                    document.getElementById('updateDepartmentError').textContent = 'Department is required.';
                    isValid = false;
                }

                if (isValid) {
                    document.getElementById('loadingOverlay').style.display = 'flex';
                    return confirm(`Are you sure you want to update the course ${courseCode}?`);
                }

                return false;
            }

            function confirmDelete(courseCode) {
                return confirm(`Are you sure you want to delete the course ${courseCode}? This action cannot be undone.`);
            }
        </script>

        <style>
            .action-buttons {
                display: flex;
                gap: 8px;
                align-items: center;
            }

            .course-table-container table tr:hover {
                background: rgba(0, 242, 254, 0.1);
                transition: background 0.3s ease;
            }

            .btn-futuristic-cancel {
                border: 2px solid transparent;
                background: linear-gradient(var(--dark-color), var(--dark-color)) padding-box,
                linear-gradient(45deg, #ff4d7e, #d81b60) border-box;
                box-shadow: 0 0 10px rgba(255, 77, 126, 0.5);
            }

            .btn-futuristic-cancel:hover {
                transform: scale(1.05);
                box-shadow: 0 0 20px rgba(255, 77, 126, 0.8);
            }
        </style>
    </section>






    <section id="payment" class="content-section <%= "payment".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-credit-card"></i> Payment Management</h2>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Payments</h3>
                <p class="stat-value"><%= totalPayments %></p>
            </div>
            <div class="stat-card">
                <h3>Total Amount Collected</h3>
                <p class="stat-value">$<%= String.format("%.2f", totalAmount) %></p>
            </div>
            <div class="stat-card">
                <h3>Pending Payments</h3>
                <p class="stat-value"><%= pendingPayments %></p>
            </div>
        </div>

        <div class="search-bar">
            <input type="text" id="paymentSearch" placeholder="Search payments by student ID..." onkeyup="searchPayments()" aria-label="Search payments">
            <i class="fas fa-search"></i>
        </div>

        <table class="payment-table" id="paymentTable">
            <thead>
            <tr>
                <th>Invoice ID</th>
                <th>Student ID</th>
                <th>Amount</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Payment Date</th>
                <th>Waiver Applied</th>
                <th>Late Fee</th>
                <th>Payment Method</th>
                <th>Subscription Plan</th>
                <th>Start Date</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (paymentHistory != null && !paymentHistory.isEmpty()) {
                    for (String[] payment : paymentHistory) {
                        String status = payment[4].equals("pending") || payment[4].equals("overdue") ? payment[4] : "paid";
            %>
            <tr class="payment-row" data-student-id="<%= payment[1] %>">
                <td><%= payment[0] %></td>
                <td><%= payment[1] %></td>
                <td><%= payment[2] %></td>
                <td><%= payment[3] %></td>
                <td class="status-cell <%= status %>"><%= status.substring(0, 1).toUpperCase() + status.substring(1) %></td>
                <td><%= payment[5].isEmpty() ? "N/A" : payment[5] %></td>
                <td><%= "true".equals(payment[6]) ? "Yes" : "No" %></td>
                <td><%= payment[7] %></td>
                <td><%= payment[8] %></td>
                <td><%= payment[9] %></td>
                <td><%= payment[10] %></td>
                <td>
                    <a href="admin-dashboard.jsp?action=returnPayment&invoiceId=<%= payment[0] %>&activeTab=payment" class="btn-futuristic btn-futuristic-update" data-tooltip="Return this payment" onclick="return confirmReturnPayment('<%= payment[0] %>')" aria-label="Return Payment">
                        <i class="fas fa-undo"></i> Return Payment
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="12" style="text-align: center;">No payment history available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>

    <script>
        function searchPayments() {
            let input = document.getElementById("paymentSearch").value.toLowerCase();
            let table = document.getElementById("paymentTable");
            let tr = table.getElementsByClassName("payment-row");

            for (let i = 0; i < tr.length; i++) {
                let studentId = tr[i].getAttribute("data-student-id").toLowerCase();
                if (studentId.includes(input)) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        function confirmReturnPayment(invoiceId) {
            return confirm(`Are you sure you want to return the payment with Invoice ID ${invoiceId}? This will delete the payment record.`);
        }
    </script>

    <%-- JSP logic to handle payment return (deletion) --%>
        <%
        if ("returnPayment".equals(action)) {
            String invoiceId = request.getParameter("invoiceId");
            boolean paymentFound = false;

            for (int i = 0; i < paymentHistory.size(); i++) {
                String[] payment = paymentHistory.get(i);
                if (payment[0].equals(invoiceId)) {
                    paymentHistory.remove(i);
                    paymentFound = true;
                    break;
                }
            }

            if (paymentFound) {
                // Rewrite the updated payment history to payments.txt
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentsFile))) {
                    for (String[] payment : paymentHistory) {
                        writer.write(String.join(",", payment));
                        writer.newLine();
                    }
                } catch (IOException e) {
                    System.out.println("Error writing to payments.txt: " + e.getMessage());
                    request.setAttribute("error", "Server error while deleting payment.");
                }
                response.sendRedirect("admin-dashboard.jsp?activeTab=payment&message=payment_returned");
                return;
            } else {
                request.setAttribute("error", "Payment not found.");
            }
        }
    %>








    <section id="admin-management" class="content-section <%= "admin-management".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-user-shield"></i> Admin Management</h2>
            <button class="btn-futuristic btn-futuristic-create" data-tooltip="Add new admin" onclick="openModal('addAdmin')" aria-label="Add Admin">
                <i class="fas fa-user-plus"></i> Add Admin
            </button>
        </div>

        <div class="search-bar">
            <input type="text" id="adminSearch" placeholder="Search admins by username or name..." onkeyup="searchAdmins()" aria-label="Search admins">
            <i class="fas fa-search"></i>
            <button class="btn btn-primary" onclick="clearAdminSearch()" aria-label="Clear Search">
                <i class="fas fa-times"></i> Clear
            </button>
        </div>

        <table class="data-table" id="adminTable">
            <thead>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (admins != null && !admins.isEmpty()) {
                    for (String[] admin : admins) {
            %>
            <tr class="admin-row">
                <td><%= admin[0] %></td>
                <td class="admin-name"><%= admin[1] %></td>
                <td><%= admin[2] %></td>
                <td>
                    <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this admin" onclick="openUpdateAdminModal('<%= admin[0] %>', '<%= admin[1] %>', '<%= admin[2] %>', '<%= admin.length > 3 ? admin[3] : "" %>')" aria-label="Update Admin">
                        <i class="fas fa-pen-nib"></i> Update
                    </button>
                    <a href="admin-dashboard.jsp?action=deleteAdmin&username=<%= admin[0] %>&activeTab=admin-management" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this admin" onclick="return confirmAdminDelete('<%= admin[0] %>')" aria-label="Delete Admin">
                        <i class="fas fa-trash-can"></i> Delete
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center;">No admins available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </section>

    <div id="addAdmin" class="modal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal('addAdmin')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
            <h2>Add New Admin</h2>
            <form action="admin-dashboard.jsp" method="post" class="add-student-form" onsubmit="return validateAddAdminForm(this)">
                <input type="hidden" name="action" value="createAdmin">
                <input type="hidden" name="activeTab" value="admin-management">
                <div class="form-group">
                    <label for="adminUsername" class="required">Username</label>
                    <input type="text" id="adminUsername" name="username" required placeholder="e.g., admin2" aria-describedby="adminUsernameError">
                    <div class="error-text" id="adminUsernameError"></div>
                </div>
                <div class="form-group">
                    <label for="adminName" class="required">Full Name</label>
                    <input type="text" id="adminName" name="name" required placeholder="e.g., Admin Two" aria-describedby="adminNameError">
                    <div class="error-text" id="adminNameError"></div>
                </div>
                <div class="form-group">
                    <label for="adminEmail" class="required">Email</label>
                    <input type="email" id="adminEmail" name="email" required placeholder="e.g., admin2@nexora.edu" aria-describedby="adminEmailError">
                    <div class="error-text" id="adminEmailError"></div>
                </div>
                <div class="form-group">
                    <label for="adminPassword" class="required">Password</label>
                    <input type="password" id="adminPassword" name="password" required placeholder="Enter a secure password" aria-describedby="adminPasswordError">
                    <div class="error-text" id="adminPasswordError"></div>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn-futuristic btn-futuristic-create" data-tooltip="Add this admin" aria-label="Add Admin" onclick="return confirmAddAdmin()">
                        <i class="fas fa-user-plus"></i> Add Admin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="updateAdmin" class="modal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal('updateAdmin')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
            <h2>Update Admin</h2>
            <form id="updateAdminForm" action="admin-dashboard.jsp" method="post" onsubmit="return validateUpdateAdminForm()">
                <input type="hidden" name="action" value="updateAdmin">
                <input type="hidden" name="activeTab" value="admin-management">
                <input type="hidden" name="originalUsername" id="updateOriginalUsername">
                <div class="form-group">
                    <label for="updateAdminUsername" class="required">Username</label>
                    <input type="text" id="updateAdminUsername" name="username" required aria-describedby="updateAdminUsernameError">
                    <div class="error-text" id="updateAdminUsernameError"></div>
                </div>
                <div class="form-group">
                    <label for="updateAdminName" class="required">Full Name</label>
                    <input type="text" id="updateAdminName" name="name" required aria-describedby="updateAdminNameError">
                    <div class="error-text" id="updateAdminNameError"></div>
                </div>
                <div class="form-group">
                    <label for="updateAdminEmail" class="required">Email</label>
                    <input type="email" id="updateAdminEmail" name="email" required aria-describedby="updateAdminEmailError">
                    <div class="error-text" id="updateAdminEmailError"></div>
                </div>
                <div class="form-group">
                    <label for="updateAdminPassword" class="required">Password</label>
                    <input type="password" id="updateAdminPassword" name="password" placeholder="Leave blank to keep current password" aria-describedby="updateAdminPasswordError">
                    <div class="error-text" id="updateAdminPasswordError"></div>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn-futuristic btn-futuristic-update" data-tooltip="Update this admin" aria-label="Update Admin">
                        <i class="fas fa-pen-nib"></i> Update Admin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.style.display = 'block';
            setTimeout(() => {
                modal.classList.add('show');
            }, 10);
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.classList.remove('show');
            setTimeout(() => {
                modal.style.display = 'none';
            }, 300);
        }

        function openUpdateAdminModal(username, name, email, currentPassword) {
            document.getElementById('updateOriginalUsername').value = username;
            document.getElementById('updateAdminUsername').value = username;
            document.getElementById('updateAdminName').value = name;
            document.getElementById('updateAdminEmail').value = email;
            document.getElementById('updateAdminPassword').value = currentPassword || '';
            openModal('updateAdmin');
        }

        function confirmAdminDelete(username) {
            return confirm(`Are you sure you want to delete the admin "${username}"? This action cannot be undone.`);
        }

        function confirmAddAdmin() {
            return confirm("Are you sure you want to add this admin? Please verify the details before proceeding.");
        }

        function validateAddAdminForm(form) {
            let isValid = true;
            const username = form.querySelector('#adminUsername').value.trim();
            const name = form.querySelector('#adminName').value.trim();
            const email = form.querySelector('#adminEmail').value.trim();
            const password = form.querySelector('#adminPassword').value.trim();

            // Reset error messages
            form.querySelector('#adminUsernameError').style.display = 'none';
            form.querySelector('#adminNameError').style.display = 'none';
            form.querySelector('#adminEmailError').style.display = 'none';
            form.querySelector('#adminPasswordError').style.display = 'none';

            // Username validation: alphanumeric, 3-20 characters
            const usernameRegex = /^[a-zA-Z0-9]{3,20}$/;
            if (!usernameRegex.test(username)) {
                form.querySelector('#adminUsernameError').textContent = 'Username must be 3-20 alphanumeric characters.';
                form.querySelector('#adminUsernameError').style.display = 'block';
                isValid = false;
            }

            // Name validation: letters and spaces, 2-50 characters
            const nameRegex = /^[a-zA-Z\s]{2,50}$/;
            if (!nameRegex.test(name)) {
                form.querySelector('#adminNameError').textContent = 'Name must be 2-50 characters, letters and spaces only.';
                form.querySelector('#adminNameError').style.display = 'block';
                isValid = false;
            }

            // Email validation: stricter regex
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                form.querySelector('#adminEmailError').textContent = 'Please enter a valid email address.';
                form.querySelector('#adminEmailError').style.display = 'block';
                isValid = false;
            }

            // Password validation: minimum 8 characters, at least one letter and one number
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
            if (!passwordRegex.test(password)) {
                form.querySelector('#adminPasswordError').textContent = 'Password must be at least 8 characters with letters and numbers.';
                form.querySelector('#adminPasswordError').style.display = 'block';
                isValid = false;
            }

            if (isValid) {
                // Show loading overlay
                document.getElementById('loadingOverlay').style.display = 'flex';
            }

            return isValid;
        }

        function validateUpdateAdminForm() {
            let isValid = true;
            const username = document.getElementById('updateAdminUsername').value.trim();
            const name = document.getElementById('updateAdminName').value.trim();
            const email = document.getElementById('updateAdminEmail').value.trim();
            const password = document.getElementById('updateAdminPassword').value.trim();

            // Reset error messages
            document.getElementById('updateAdminUsernameError').style.display = 'none';
            document.getElementById('updateAdminNameError').style.display = 'none';
            document.getElementById('updateAdminEmailError').style.display = 'none';
            document.getElementById('updateAdminPasswordError').style.display = 'none';

            // Username validation: alphanumeric, 3-20 characters
            const usernameRegex = /^[a-zA-Z0-9]{3,20}$/;
            if (!usernameRegex.test(username)) {
                document.getElementById('updateAdminUsernameError').textContent = 'Username must be 3-20 alphanumeric characters.';
                document.getElementById('updateAdminUsernameError').style.display = 'block';
                isValid = false;
            }

            // Name validation: letters and spaces, 2-50 characters
            const nameRegex = /^[a-zA-Z\s]{2,50}$/;
            if (!nameRegex.test(name)) {
                document.getElementById('updateAdminNameError').textContent = 'Name must be 2-50 characters, letters and spaces only.';
                document.getElementById('updateAdminNameError').style.display = 'block';
                isValid = false;
            }

            // Email validation: stricter regex
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                document.getElementById('updateAdminEmailError').textContent = 'Please enter a valid email address.';
                document.getElementById('updateAdminEmailError').style.display = 'block';
                isValid = false;
            }

            // Password validation: optional, but must meet criteria if provided
            if (password) {
                const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
                if (!passwordRegex.test(password)) {
                    document.getElementById('updateAdminPasswordError').textContent = 'Password must be at least 8 characters with letters and numbers.';
                    document.getElementById('updateAdminPasswordError').style.display = 'block';
                    isValid = false;
                }
            }

            if (isValid) {
                // Show loading overlay
                document.getElementById('loadingOverlay').style.display = 'flex';
            }

            return isValid;
        }

        function searchAdmins() {
            const input = document.getElementById('adminSearch').value.toLowerCase();
            const rows = document.querySelectorAll('#adminTable .admin-row');

            rows.forEach(row => {
                const username = row.querySelector('td:nth-child(1)').textContent.toLowerCase();
                const name = row.querySelector('.admin-name').textContent.toLowerCase();
                if (username.includes(input) || name.includes(input)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function clearAdminSearch() {
            const searchInput = document.getElementById('adminSearch');
            searchInput.value = '';
            searchAdmins();
        }
    </script>

    <style>
        /* Enhanced table row hover effect */
        .data-table .admin-row:hover {
            background: rgba(0, 242, 254, 0.1);
            transition: background 0.3s ease;
        }

        /* Improved modal styling */
        .modal-content {
            box-shadow: 0 0 20px rgba(0, 242, 254, 0.3);
            border: 1px solid rgba(0, 242, 254, 0.2);
        }

        .modal-content h2 {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Adjust search bar layout */
        .search-bar {
            position: relative;
            align-items: center;
        }

        .search-bar button {
            margin-left: 10px;
        }
    </style>


    <section id="reviews" class="content-section <%= "reviews".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-star"></i> Review Management</h2>
        </div>

        <div class="search-bar">
            <input type="text" id="reviewSearch" placeholder="Search reviews by author..." onkeyup="searchReviews()" aria-label="Search reviews">
            <i class="fas fa-search"></i>
            <button class="btn btn-primary" onclick="clearReviewSearch()" aria-label="Clear Search">
                <i class="fas fa-times"></i> Clear
            </button>
        </div>

        <div class="admin-reviews-section">
            <div class="reviews-table-container">
                <table class="reviews-table" id="reviewTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Author</th>
                        <th>Review Text</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<String[]> adminReviews = new ArrayList<>();
                        String filePath = application.getRealPath("/WEB-INF/data/reviews.txt");
                        File adminFile = new File(filePath);
                        boolean fileExists = adminFile.exists();

                        if (fileExists) {
                            try (BufferedReader reader = new BufferedReader(new FileReader(adminFile))) {
                                String line;
                                int id = 1;
                                while ((line = reader.readLine()) != null) {
                                    String[] parts = line.split("\\|", 2);
                                    if (parts.length == 2) {
                                        adminReviews.add(new String[]{String.valueOf(id), parts[0], parts[1]});
                                        id++;
                                    }
                                }
                            } catch (IOException e) {
                                request.setAttribute("errorMessage", "Error reading reviews: " + e.getMessage());
                            }
                        }

                        if (adminReviews.isEmpty()) {
                            request.setAttribute("noReviewsMessage", "No reviews found.");
                        }

                        if (request.getAttribute("errorMessage") != null) {
                    %>
                    <div class="error-message">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <%
                        }

                        if (request.getAttribute("noReviewsMessage") != null) {
                    %>
                    <div class="no-reviews-message">
                        <%= request.getAttribute("noReviewsMessage") %>
                    </div>
                    <%
                        }

                        for (String[] review : adminReviews) {
                            String id = review[0];
                            String author = review[1];
                            String adminReviewText = review[2];
                    %>
                    <tr class="review-row" data-review-author="<%= author %>">
                        <td><%= id %></td>
                        <td class="review-author"><%= author %></td>
                        <td><%= adminReviewText %></td>
                        <td>
                            <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this review" onclick="openUpdateReviewModal('<%= id %>', '<%= author %>', '<%= adminReviewText %>')" aria-label="Update Review">
                                <i class="fas fa-pen-nib"></i> Update
                            </button>
                            <a href="${pageContext.request.contextPath}/ReviewServlet?action=delete&id=<%= id %>&activeTab=reviews" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this review" onclick="return confirmReviewDelete('<%= id %>')" aria-label="Delete Review">
                                <i class="fas fa-trash-can"></i> Delete
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal for Updating Review -->
        <div id="updateReviewModal" class="modal">
            <div class="modal-content">
                <button class="modal-close" onclick="closeModal('updateReviewModal')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
                <h2>Update Review</h2>
                <form action="${pageContext.request.contextPath}/ReviewServlet" method="POST" class="update-review-form" onsubmit="return validateUpdateReviewForm()">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="activeTab" value="reviews">
                    <input type="hidden" name="id" id="updateReviewId">
                    <div class="form-group">
                        <label for="updateReviewAuthor" class="required">Author</label>
                        <input type="text" id="updateReviewAuthor" name="currentAuthor" required placeholder="e.g., John Doe">
                        <div class="error-text" id="updateReviewAuthorError"></div>
                    </div>
                    <div class="form-group">
                        <label for="updateReviewText" class="required">Review Text</label>
                        <textarea id="updateReviewText" name="currentReviewText" required placeholder="e.g., Great platform!" rows="4"></textarea>
                        <div class="error-text" id="updateReviewTextError"></div>
                    </div>
                    <div class="button-group">
                        <button type="submit" class="btn-futuristic btn-futuristic-update" data-tooltip="Update this review" aria-label="Update Review">
                            <i class="fas fa-pen-nib"></i> Update Review
                        </button>
                        <button type="button" class="btn-futuristic btn-futuristic-cancel" data-tooltip="Cancel" onclick="closeModal('updateReviewModal')" aria-label="Cancel Update">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function searchReviews() {
                let input = document.getElementById("reviewSearch").value.toLowerCase();
                let table = document.getElementById("reviewTable");
                let tr = table.getElementsByClassName("review-row");

                for (let i = 0; i < tr.length; i++) {
                    let reviewAuthor = tr[i].getAttribute("data-review-author").toLowerCase();
                    if (reviewAuthor.includes(input)) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

            function clearReviewSearch() {
                const searchInput = document.getElementById("reviewSearch");
                searchInput.value = "";
                searchReviews();
            }

            function openUpdateReviewModal(id, author, reviewText) {
                document.getElementById('updateReviewId').value = id;
                document.getElementById('updateReviewAuthor').value = author;
                document.getElementById('updateReviewText').value = reviewText;
                openModal('updateReviewModal');
            }

            function confirmReviewDelete(reviewId) {
                return confirm(`Are you sure you want to delete review with ID ${reviewId}?`);
            }

            function validateUpdateReviewForm() {
                let isValid = true;
                const author = document.getElementById('updateReviewAuthor').value.trim();
                const reviewText = document.getElementById('updateReviewText').value.trim();

                document.getElementById('updateReviewAuthorError').textContent = '';
                document.getElementById('updateReviewTextError').textContent = '';

                const nameRegex = /^[a-zA-Z\s]{2,50}$/;
                if (!nameRegex.test(author)) {
                    document.getElementById('updateReviewAuthorError').textContent = 'Author name must be 2-50 characters, letters and spaces only.';
                    isValid = false;
                }

                if (reviewText === '') {
                    document.getElementById('updateReviewTextError').textContent = 'Review text is required.';
                    isValid = false;
                } else if (reviewText.length > 500) {
                    document.getElementById('updateReviewTextError').textContent = 'Review text must be 500 characters or less.';
                    isValid = false;
                }

                if (isValid) {
                    document.getElementById('loadingOverlay').style.display = 'flex';
                    return confirm('Are you sure you want to update this review?');
                }

                return false;
            }
        </script>

        <style>
            .admin-reviews-section {
                padding: 0;
                margin-top: 20px;
            }

            .reviews-table-container {
                max-width: 1400px;
                margin: 0 auto;
                overflow-x: auto;
            }

            .reviews-table {
                width: 100%;
                border-collapse: collapse;
                background: var(--card-bg);
                backdrop-filter: blur(10px);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
            }

            .reviews-table th,
            .reviews-table td {
                padding: 20px;
                text-align: left;
                border-bottom: 1px solid rgba(0, 242, 254, 0.2);
            }

            .reviews-table th {
                background: linear-gradient(135deg, var(--darker-color), var(--dark-color));
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: var(--text-color);
            }

            .reviews-table td {
                color: var(--text-color);
                transition: var(--transition);
            }

            .reviews-table tr:hover td {
                background: rgba(0, 242, 254, 0.05);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            .error-message,
            .no-reviews-message {
                text-align: center;
                color: var(--secondary-color);
                font-size: 1.2rem;
                padding: 20px;
            }

            .update-review-form {
                display: grid;
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .update-review-form .form-group {
                margin-bottom: 15px;
            }

            .update-review-form textarea {
                height: 80px;
                resize: none;
            }

            .update-review-form .button-group {
                text-align: right;
                margin-top: 10px;
            }

            @media (max-width: 768px) {
                .reviews-table th,
                .reviews-table td {
                    padding: 15px;
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 576px) {
                .reviews-table {
                    display: block;
                    overflow-x: auto;
                }

                .reviews-table th,
                .reviews-table td {
                    display: block;
                    width: 100%;
                    text-align: left;
                }

                .reviews-table th {
                    display: none;
                }

                .reviews-table td {
                    position: relative;
                    padding-left: 50%;
                }

                .reviews-table td:before {
                    content: attr(data-label);
                    position: absolute;
                    left: 10px;
                    font-weight: 600;
                    color: var(--text-muted);
                }

                .reviews-table td[data-label="ID"]:before { content: "ID"; }
                .reviews-table td[data-label="Author"]:before { content: "Author"; }
                .reviews-table td[data-label="Review Text"]:before { content: "Review"; }
                .reviews-table td[data-label="Actions"]:before { content: "Actions"; }
            }
        </style>
    </section>





    <%@ page import="com.studentregistration.dao.StudentDAO" %>
    <%@ page import="com.studentregistration.model.Student" %>

    <section id="course-requests" class="content-section <%= "course-requests".equals(activeTab) ? "active" : "" %>">
        <div class="section-header">
            <h2><i class="fas fa-file-alt"></i> Course Requests</h2>
        </div>

        <%
            // Initialize StudentDAO
            StudentDAO studentDAO = (StudentDAO) application.getAttribute("studentDAO");
            if (studentDAO == null) {
                String studentsPath = application.getRealPath("/WEB-INF/data/students.txt");
                studentDAO = new StudentDAO(studentsPath);
                application.setAttribute("studentDAO", studentDAO);
            }
        %>

        <div class="search-bar">
            <input type="text" id="requestSearch" placeholder="Search requests by student ID or name..." onkeyup="searchRequests()" aria-label="Search course requests">
            <i class="fas fa-search"></i>
            <button class="btn btn-primary" onclick="clearRequestSearch()" aria-label="Clear Search">
                <i class="fas fa-times"></i> Clear
            </button>
        </div>

        <table class="data-table" id="requestTable">
            <thead>
            <tr>
                <th>Request ID</th>
                <th>Student ID</th>
                <th>Student Name</th>
                <th>Student Email</th>
                <th>Course Code</th>
                <th>Request Date</th>
                <th>Status</th>

            </tr>
            </thead>
            <tbody>
            <%
                List<String[]> courseRequests = new ArrayList<>();
                String applyFilePath = application.getRealPath("/WEB-INF/data/apply.txt");
                File applyFile = new File(applyFilePath);
                if (applyFile.exists()) {
                    try (BufferedReader reader = new BufferedReader(new FileReader(applyFile))) {
                        String line;
                        int requestId = 1;
                        while ((line = reader.readLine()) != null) {
                            if (line.trim().isEmpty()) continue;
                            String[] parts = line.split(",");
                            if (parts.length >= 4) {
                                courseRequests.add(new String[]{
                                        String.valueOf(requestId),
                                        parts[0].trim(), // Student ID
                                        parts[1].trim(), // Course Code
                                        parts[2].trim(), // Request Date
                                        parts[3].trim()  // Status
                                });
                                requestId++;
                            }
                        }
                    } catch (IOException e) {
                        System.out.println("Error reading apply.txt: " + e.getMessage());
                        request.setAttribute("error", "Error reading course requests: " + e.getMessage());
                    }
                }

                if (courseRequests.isEmpty()) {
            %>
            <tr>
                <td colspan="8" style="text-align: center;">No course requests available.</td>
            </tr>
            <%
            } else {
                for (String[] rrequest : courseRequests) {
                    String status = rrequest[4];
                    String statusClass = "pending".equals(status) ? "status active" : "status inactive";
                    String statusDisplay = "pending".equals(status) ? "Pending" : status.substring(0, 1).toUpperCase() + status.substring(1);

                    // Fetch student details using StudentDAO
                    Student student = studentDAO.getStudentByEmail(rrequest[1]); // Assuming studentId is used as email in your system
                    String studentName = student != null ? student.getFullName() : "Unknown";
                    String studentEmail = student != null ? student.getEmail() : "Unknown";
            %>
            <tr class="request-row" data-student-id="<%= rrequest[1] %>" data-student-name="<%= studentName.toLowerCase() %>">
                <td><%= rrequest[0] %></td>
                <td><%= rrequest[1] %></td>
                <td><%= studentName %></td>
                <td><%= studentEmail %></td>
                <td><%= rrequest[2] %></td>
                <td><%= rrequest[3] %></td>
                <td><span class="<%= statusClass %>"><%= statusDisplay %></span></td>

            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </section>

    <script>
        function searchRequests() {
            let input = document.getElementById("requestSearch").value.toLowerCase();
            let table = document.getElementById("requestTable");
            let tr = table.getElementsByClassName("request-row");

            for (let i = 0; i < tr.length; i++) {
                let studentId = tr[i].getAttribute("data-student-id").toLowerCase();
                let studentName = tr[i].getAttribute("data-student-name").toLowerCase();
                if (studentId.includes(input) || studentName.includes(input)) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        function clearRequestSearch() {
            const searchInput = document.getElementById("requestSearch");
            searchInput.value = "";
            searchRequests();
        }

        function confirmRequestAction(action, requestId) {
            return confirm(`Are you sure you want to ${action} request with ID ${requestId}?`);
        }
    </script>

    <style>
        .data-table .request-row:hover {
            background: rgba(0, 242, 254, 0.1);
            transition: background 0.3s ease;
        }
    </style>