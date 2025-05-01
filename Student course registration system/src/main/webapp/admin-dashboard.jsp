<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
    if (session.getAttribute("userType") == null || !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("logIn.jsp");
        return;
    }

    // Fetch courses from request attribute (set by CourseServlet)
    List<String> courses = (List<String>) request.getAttribute("courses");
    if (courses == null || courses.isEmpty()) {
        courses = new ArrayList<>();
        courses.add("CS101,Introduction to Programming,3,Computer Science,Dr. Smith,Basic programming concepts,true");
        request.setAttribute("courses", courses);
    }

    // Determine which section to display based on activeTab (default to "dashboard")
    String activeTab = request.getParameter("activeTab");
    if (activeTab == null) {
        activeTab = "dashboard";
    }

    // Calculate active courses from courses.txt for the Dashboard section
    int activeCoursesCount = 0;
    String coursesFilePath = application.getRealPath("/WEB-INF/data/courses.txt");
    File coursesFile = new File(coursesFilePath);
    if (coursesFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(coursesFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 7 && "true".equals(parts[6])) {
                    activeCoursesCount++;
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading courses.txt: " + e.getMessage());
            activeCoursesCount = 0;
        }
    } else {
        activeCoursesCount = 0;
    }

    // Read student data from students.txt for the Student Management section
    List<String[]> students = new ArrayList<>();
    String studentsFilePath = application.getRealPath("/WEB-INF/data/students.txt");
    File studentsFile = new File(studentsFilePath);
    if (studentsFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(studentsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 3) { // Expecting 3 fields: id,name,email
                    students.add(parts);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading students.txt: " + e.getMessage());
        }
    }

    // Map error codes to user-friendly messages
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
            case "server_error":
                errorMessage = "An error occurred on the server. Please try again later.";
                break;
            case "invalid_input":
                errorMessage = "Input contains invalid characters (e.g., commas).";
                break;
            case "student_not_found":
                errorMessage = "The student was not found.";
                break;
            default:
                errorMessage = "An unexpected error occurred.";
        }
        request.setAttribute("error", errorMessage);
    }

    // Map success messages
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

        .btn-futuristic-create:disabled {
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

        .update-student-form .btn-update {
            background: none;
            border: none;
            color: #00b7eb;
            text-decoration: underline;
            font-size: 1rem;
            cursor: pointer;
            padding: 0;
            transition: var(--transition);
        }

        .update-student-form .btn-update:hover {
            color: #63b3ed;
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

        .update-course-form .btn-update {
            background: none;
            border: none;
            color: #00b7eb;
            text-decoration: underline;
            font-size: 1rem;
            cursor: pointer;
            padding: 0;
            transition: var(--transition);
        }

        .update-course-form .btn-update:hover {
            color: #63b3ed;
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
<div class="sidebar">
    <div class="logo">NexoraSkill Admin</div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="#" class="nav-link <%= "dashboard".equals(activeTab) ? "active" : "" %>" data-section="dashboard" aria-label="Dashboard">
                <i class="fas fa-chart-line"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link <%= "students".equals(activeTab) ? "active" : "" %>" data-section="students" aria-label="Student Management">
                <i class="fas fa-users"></i> Student Management
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link <%= "courses".equals(activeTab) ? "active" : "" %>" data-section="courses" aria-label="Course Management">
                <i class="fas fa-book-open"></i> Course Management
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link <%= "emergency".equals(activeTab) ? "active" : "" %>" data-section="emergency" aria-label="Emergency Contacts">
                <i class="fas fa-exclamation-triangle"></i> Emergency Contacts
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link <%= "admin-tools".equals(activeTab) ? "active" : "" %>" data-section="admin-tools" aria-label="Admin Tools">
                <i class="fas fa-tools"></i> Admin Tools
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
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <div class="message success"><%= request.getAttribute("message") %></div>
    <% } %>

    <section id="dashboard" class="content-section">
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

    <section id="students" class="content-section">
        <div class="section-header">
            <h2><i class="fas fa-users-cog"></i> Student Management</h2>
        </div>

        <div class="course-container">
            <h3>Add New Student </h3>
            <form action="studentRegistration" method="post" class="inline-student-form" onsubmit="return handleAddStudentSubmission(event)">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="inlineStudentId" class="required">Student ID</label>
                    <input type="text" id="inlineStudentId" name="id" required placeholder="e.g., STU20230001">
                </div>
                <div class="form-group">
                    <label for="inlineStudentName" class="required">Full Name</label>
                    <input type="text" id="inlineStudentName" name="name" required placeholder="e.g., John Doe">
                </div>
                <div class="form-group">
                    <label for="inlineStudentEmail" class="required">Email</label>
                    <input type="email" id="inlineStudentEmail" name="email" required placeholder="e.g., john.doe@nexora.edu">
                </div>
                <div class="button-group">
                    <button type="submit" id="inlineAddStudentBtn" class="btn-futuristic btn-futuristic-create" data-tooltip="Add this student" aria-label="Add Student">
                        <i class="fas fa-user-plus"></i> Add Student
                    </button>
                </div>
            </form>
        </div>

        <div class="search-bar">
            <input type="text" id="studentSearch" placeholder="Search students by name..." onkeyup="searchStudents()">
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
            <tr class="student-row">
                <td><%= student[0] %></td>
                <td class="student-name"><%= student[1] %></td>
                <td><%= student[2] %></td>
                <td>
                    <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this student" onclick="openUpdateStudentModal('<%= student[0] %>', '<%= student[1] %>', '<%= student[2] %>')" aria-label="Update Student">
                        <i class="fas fa-pen-nib"></i> Update
                    </button>
                    <a href="studentRegistration?action=delete&id=<%= student[0] %>" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this student" onclick="return confirmStudentDelete('<%= student[0] %>')" aria-label="Delete Student">
                        <i class="fas fa-trash-can"></i> Delete
                    </a>
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

    <section id="courses" class="content-section">
        <div class="section-header">
            <h2><i class="fas fa-book"></i> Course Management</h2>
        </div>

        <div class="course-container">
            <div class="course-header">
                <h3 onclick="toggleCourseSection('create-course-content')">Create New Course</h3>
            </div>
            <div id="create-course-content" class="course-content <%= "courses".equals(activeTab) ? "active" : "" %>">
                <form action="course" method="post" class="create-course-form" onsubmit="return handleCreateSubmission(event)">
                    <input type="hidden" name="action" value="create">
                    <div class="form-group">
                        <label for="courseCode" class="required">Course Code</label>
                        <input type="text" id="courseCode" name="courseCode" required placeholder="e.g., CS101">
                    </div>
                    <div class="form-group">
                        <label for="title" class="required">Title</label>
                        <input type="text" id="title" name="title" required placeholder="e.g., Introduction to Programming">
                    </div>
                    <div class="form-group">
                        <label for="credits" class="required">Credits</label>
                        <input type="number" id="credits" name="credits" required placeholder="e.g., 3" min="1">
                    </div>
                    <div class="form-group">
                        <label for="department" class="required">Department</label>
                        <select id="department" name="department" required>
                            <option value="">Select Department</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Mathematics">Mathematics</option>
                            <option value="Physics">Physics</option>
                        </select>
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
                <form action="course" method="get" class="filter-form">
                    <input type="hidden" name="action" value="view">
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
                            System.out.println("Number of courses: " + courses.size());
                            if (courses != null && !courses.isEmpty()) {
                                for (String course : courses) {
                                    String[] parts = course.split(",");
                                    System.out.println("Course: " + course);
                                    if (parts.length < 7) continue;
                        %>
                        <tr>
                            <td><%= parts[0] %></td>
                            <td><%= parts[1] %></td>
                            <td><%= parts[2] %></td>
                            <td><%= parts[3] %></td>
                            <td><%= parts[4] %></td>
                            <td><%= parts[5] %></td>
                            <td><%= "true".equals(parts[6]) ? "Active" : "Archived" %></td>
                            <td>
                                <button class="btn-futuristic btn-futuristic-update" data-tooltip="Edit this course" onclick="openUpdateModal('<%= parts[0] %>', '<%= parts[1] %>', '<%= parts[2] %>', '<%= parts[3] %>', '<%= parts[4] %>', '<%= parts[5] %>')" aria-label="Update Course">
                                    <i class="fas fa-pen-nib"></i> Update
                                </button>
                                <% if ("true".equals(parts[6])) { %>
                                <a href="course?action=archive&courseCode=<%= parts[0] %>" class="btn-futuristic btn-futuristic-archive" data-tooltip="Archive this course" aria-label="Archive Course">
                                    <i class="fas fa-box-archive"></i> Archive
                                </a>
                                <% } %>
                                <a href="course?action=delete&courseCode=<%= parts[0] %>" class="btn-futuristic btn-futuristic-delete" data-tooltip="Delete this course" onclick="return confirmDelete('<%= parts[0] %>')" aria-label="Delete Course">
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
    </section>

    <section id="emergency" class="content-section">
        <div class="section-header">
            <h2><i class="fas fa-exclamation-circle"></i> Emergency Contacts</h2>
        </div>

        <div class="emergency-contact-form">
            <div class="form-group">
                <label for="studentId">Student ID</label>
                <input type="text" id="studentId" placeholder="Enter Student ID">
            </div>
            <div class="form-group">
                <label for="emergencyContact">Emergency Contact</label>
                <input type="text" id="emergencyContact" placeholder="Contact Name">
            </div>
            <div class="form-group">
                <label for="emergencyPhone">Phone Number</label>
                <input type="tel" id="emergencyPhone" placeholder="Emergency Phone">
            </div>
            <button class="btn btn-primary" aria-label="Update Emergency Contacts">Update Contacts</button>
        </div>
    </section>

    <section id="admin-tools" class="content-section">
        <h2><i class="fas fa-tools"></i> Admin Tools</h2>

        <div class="action-card">
            <h3>Monitor Active Sessions</h3>
            <a href="admin?action=monitorSessions" class="btn btn-primary" aria-label="View Active Sessions">
                <i class="fas fa-eye"></i> View Active Admin Sessions
            </a>
        </div>

        <div class="action-card">
            <h3>Force Password Reset</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="forceReset">
                <div class="form-group">
                    <label for="resetUsername">Username:</label>
                    <input type="text" id="resetUsername" name="username" required>
                </div>
                <button type="submit" class="btn btn-primary" aria-label="Force Password Reset">
                    <i class="fas fa-lock"></i> Force Reset
                </button>
            </form>
        </div>

        <div class="action-card">
            <h3>Deactivate Account</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="deactivate">
                <div class="form-group">
                    <label for="deactivateUsername">Username:</label>
                    <input type="text" id="deactivateUsername" name="username" required>
                </div>
                <button type="submit" class="btn btn-danger" aria-label="Deactivate Account">
                    <i class="fas fa-ban"></i> Deactivate
                </button>
            </form>
        </div>

        <div class="action-card">
            <h3>Purge Expired Unverified Accounts</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="purgeUnverified">
                <button type="submit" class="btn btn-danger" aria-label="Purge Unverified Accounts">
                    <i class="fas fa-trash-alt"></i> Purge Unverified Accounts
                </button>
            </form>
        </div>
    </section>
</div>

<div id="addStudent" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('addStudent')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
        <h2>Add New Student</h2>
        <form action="studentRegistration" method="post" class="add-student-form" onsubmit="return handleAddStudentSubmission(event)">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label for="studentId" class="required">Student ID</label>
                <input type="text" id="studentId" name="id" required placeholder="e.g., STU20230001">
            </div>
            <div class="form-group">
                <label for="studentName" class="required">Full Name</label>
                <input type="text" id="studentName" name="name" required placeholder="e.g., John Doe">
            </div>
            <div class="form-group">
                <label for="studentEmail" class="required">Email</label>
                <input type="email" id="studentEmail" name="email" required placeholder="e.g., john.doe@nexora.edu">
            </div>
            <div class="button-group">
                <button type="submit" id="addStudentBtn" class="btn-futuristic btn-futuristic-create" data-tooltip="Add this student" aria-label="Add Student">
                    <i class="fas fa-user-plus"></i> Add Student
                </button>
            </div>
        </form>
    </div>
</div>

<div id="updateStudent" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('updateStudent')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
        <h2>Update Student</h2>
        <form id="updateStudentForm" action="studentRegistration" method="post" onsubmit="return validateUpdateStudentForm()" class="update-student-form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="originalId" id="updateOriginalId">
            <div class="form-group">
                <label for="updateStudentId" class="required">Student ID</label>
                <input type="text" id="updateStudentId" name="id" required>
            </div>
            <div class="form-group">
                <label for="updateStudentName" class="required">Full Name</label>
                <input type="text" id="updateStudentName" name="name" required>
            </div>
            <div class="form-group">
                <label for="updateStudentEmail" class="required">Email</label>
                <input type="email" id="updateStudentEmail" name="email" required>
            </div>
            <div class="button-group">
                <button type="submit" class="btn-futuristic btn-futuristic-update" data-tooltip="Update this student" aria-label="Update Student">
                    <i class="fas fa-pen-nib"></i> Update Student
                </button>
            </div>
        </form>
    </div>
</div>

<div id="updateCourse" class="modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('updateCourse')" aria-label="Close Modal"><i class="fas fa-times"></i></button>
        <h2>Update Course</h2>
        <form id="updateCourseForm" action="course" method="post" onsubmit="return validateUpdateForm()" class="update-course-form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="originalCourseCode" id="updateOriginalCourseCode">
            <div class="form-group">
                <label for="updateCourseCode" class="required">Course Code</label>
                <input type="text" id="updateCourseCode" name="courseCode" required>
            </div>
            <div class="form-group">
                <label for="updateTitle" class="required">Title</label>
                <input type="text" id="updateTitle" name="title" required>
            </div>
            <div class="form-group">
                <label for="updateCredits" class="required">Credits</label>
                <input type="number" id="updateCredits" name="credits" required min="1">
            </div>
            <div class="form-group">
                <label for="updateDepartment" class="required">Department</label>
                <select id="updateDepartment" name="department" required>
                    <option value="">Select Department</option>
                    <option value="Computer Science">Computer Science</option>
                    <option value="Mathematics">Mathematics</option>
                    <option value="Physics">Physics</option>
                </select>
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
            </div>
        </form>
    </div>
</div>

<script>
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const sectionId = link.getAttribute('data-section');

            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            sections.forEach(section => section.style.display = 'none');
            document.getElementById(sectionId).style.display = 'block';
        });
    });

    const urlParams = new URLSearchParams(window.location.search);
    const activeTab = urlParams.get('activeTab');
    if (activeTab) {
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('data-section') === activeTab) {
                link.classList.add('active');
            }
        });
        sections.forEach(section => {
            section.style.display = 'none';
            if (section.id === activeTab) {
                section.style.display = 'block';
            }
        });
    } else {
        document.getElementById('dashboard').style.display = 'block';
        document.querySelector('.nav-link[data-section="dashboard"]').classList.add('active');
    }

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

    function openUpdateModal(courseCode, title, credits, department, professor, syllabus) {
        document.getElementById('updateOriginalCourseCode').value = courseCode;
        document.getElementById('updateCourseCode').value = courseCode;
        document.getElementById('updateTitle').value = title;
        document.getElementById('updateCredits').value = credits;
        document.getElementById('updateDepartment').value = department;
        document.getElementById('updateProfessor').value = professor;
        document.getElementById('updateSyllabus').value = syllabus;
        openModal('updateCourse');
    }

    function openUpdateStudentModal(id, name, email) {
        document.getElementById('updateOriginalId').value = id;
        document.getElementById('updateStudentId').value = id;
        document.getElementById('updateStudentName').value = name;
        document.getElementById('updateStudentEmail').value = email;
        openModal('updateStudent');
    }

    window.onclick = function(e) {
        if (e.target.className === 'modal') {
            closeModal(e.target.id);
        }
    }

    function toggleCourseSection(sectionId) {
        const content = document.getElementById(sectionId);
        content.classList.toggle('active');
    }

    function validateUpdateForm() {
        const courseCode = document.getElementById('updateCourseCode').value.trim();
        const title = document.getElementById('updateTitle').value.trim();
        const credits = document.getElementById('updateCredits').value.trim();
        const department = document.getElementById('updateDepartment').value.trim();

        if (!courseCode || !title || !credits || !department) {
            alert('Please fill in all required fields.');
            return false;
        }

        if (credits <= 0) {
            alert('Credits must be a positive number.');
            return false;
        }

        const confirmUpdate = confirm('Are you sure you want to update this course?');
        if (!confirmUpdate) {
            return false;
        }

        closeModal('updateCourse');
        return true;
    }

    function validateUpdateStudentForm() {
        const id = document.getElementById('updateStudentId').value.trim();
        const name = document.getElementById('updateStudentName').value.trim();
        const email = document.getElementById('updateStudentEmail').value.trim();

        if (!id || !name || !email) {
            alert('Please fill in all required fields.');
            return false;
        }

        const confirmUpdate = confirm('Are you sure you want to update this student?');
        if (!confirmUpdate) {
            return false;
        }

        closeModal('updateStudent');
        return true;
    }

    function confirmDelete(courseCode) {
        return confirm('Are you sure you want to delete the course ' + courseCode + '? This action cannot be undone.');
    }

    function confirmStudentDelete(studentId) {
        return confirm('Are you sure you want to delete the student with ID ' + studentId + '? This action cannot be undone.');
    }

    function handleCreateSubmission(event) {
        event.preventDefault();

        const courseCode = document.getElementById('courseCode').value.trim();
        const title = document.getElementById('title').value.trim();
        const credits = document.getElementById('credits').value.trim();
        const department = document.getElementById('department').value.trim();

        if (!courseCode || !title || !credits || !department) {
            alert('Please fill in all required fields.');
            return false;
        }

        if (credits <= 0) {
            alert('Credits must be a positive number.');
            return false;
        }

        const confirmCreate = confirm('Are you sure you want to create the course "' + title + '"?');
        if (!confirmCreate) {
            return false;
        }

        const createBtn = document.getElementById('createCourseBtn');
        createBtn.disabled = true;
        createBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating...';

        setTimeout(() => {
            event.target.submit();
        }, 500);

        return true;
    }

    function handleAddStudentSubmission(event) {
        event.preventDefault();

        const form = event.target;
        const idField = form.querySelector('[name="id"]').id;
        const nameField = form.querySelector('[name="name"]').id;
        const emailField = form.querySelector('[name="email"]').id;
        const submitBtn = form.querySelector('button[type="submit"]').id;

        const id = document.getElementById(idField).value.trim();
        const name = document.getElementById(nameField).value.trim();
        const email = document.getElementById(emailField).value.trim();
        const addBtn = document.getElementById(submitBtn);

        // Log form details for debugging
        console.log('Attempting to add student - Form ID:', form.id, 'ID:', id, 'Name:', name, 'Email:', email);

        // Validate required fields
        if (!id || !name || !email) {
            console.log('Validation failed: Missing required fields');
            alert('Please fill in all required fields.');
            addBtn.disabled = false;
            addBtn.innerHTML = '<i class="fas fa-user-plus"></i> Add Student';
            return false;
        }

        // Validate email format
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            console.log('Validation failed: Invalid email format - Email:', email);
            alert('Please enter a valid email address (e.g., example@domain.com).');
            addBtn.disabled = false;
            addBtn.innerHTML = '<i class="fas fa-user-plus"></i> Add Student';
            return false;
        }

        // Confirm with user
        const confirmAdd = confirm('Are you sure you want to add the student "' + name + '"?');
        if (!confirmAdd) {
            console.log('User canceled the addition of student:', name);
            addBtn.disabled = false;
            addBtn.innerHTML = '<i class="fas fa-user-plus"></i> Add Student';
            return false;
        }

        // Disable button and show loading state
        addBtn.disabled = true;
        addBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
        console.log('Submitting form for student:', name);

        // Close the modal if this is the modal form
        if (form.closest('#addStudent')) {
            closeModal('addStudent');
        }

        // Submit the form
        setTimeout(() => {
            form.submit();
        }, 500);

        return true;
    }

    function searchStudents() {
        const input = document.getElementById('studentSearch').value.toLowerCase();
        const table = document.getElementById('studentTable');
        const rows = table.getElementsByClassName('student-row');

        for (let i = 0; i < rows.length; i++) {
            const nameCell = rows[i].getElementsByClassName('student-name')[0];
            const name = nameCell.textContent || nameCell.innerText;
            if (name.toLowerCase().indexOf(input) > -1) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
</script>
</body>
</html>