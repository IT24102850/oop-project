<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Student Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<!-- Sidebar Toggle Button -->
<button class="sidebar-toggle">
    <i class="fas fa-bars"></i>
</button>

<%
    // Retrieve email and studentId from session
    String email = (String) session.getAttribute("email");
    String studentId = (String) session.getAttribute("studentId");
    String displayName = "Guest";
    String firstName = "Guest";
    String initials = "G";
    String studentIdBadge = "NS20230045";

    if (email != null) {
        String studentsFilePath = application.getRealPath("/WEB-INF/data/students.txt");
        try (BufferedReader reader = new BufferedReader(new FileReader(studentsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[2].equals(email)) {
                    studentId = parts[0];
                    session.setAttribute("studentId", studentId);
                    displayName = parts[1].trim();
                    String[] nameParts = displayName.split("\\s+");
                    firstName = nameParts[0];
                    initials = nameParts.length > 1
                            ? nameParts[0].substring(0, 1).toUpperCase() + nameParts[1].substring(0, 1).toUpperCase()
                            : nameParts[0].substring(0, 1).toUpperCase();
                    studentIdBadge = "NS" + studentId.substring(3);
                    break;
                }
            }
        } catch (IOException e) {
            displayName = "Error";
            firstName = "Error";
            initials = "E";
            studentIdBadge = "NS00000000";
            request.setAttribute("error", "Failed to load student data: " + e.getMessage());
        }
    }

    // Fetch enrolled courses and course details
    Map<String, String[]> courseDetailsMap = new HashMap<>();
    String coursesFilePath = application.getRealPath("/WEB-INF/data/courses.txt");
    try (BufferedReader reader = new BufferedReader(new FileReader(coursesFilePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length >= 4) {
                courseDetailsMap.put(parts[0], new String[]{parts[1], parts[2], parts[3]});
            }
        }
    } catch (IOException e) {
        request.setAttribute("error", "Failed to load course data: " + e.getMessage());
    }

    List<String[]> enrolledCourses = new ArrayList<>();
    if (studentId != null) {
        String enrollmentsFilePath = application.getRealPath("/WEB-INF/data/enrollments.txt");
        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6 && parts[1].equals(studentId)) {
                    enrolledCourses.add(parts);
                }
            }
        } catch (IOException e) {
            request.setAttribute("error", "Failed to load enrolled courses: " + e.getMessage());
        }
    }

    // Fetch payment history from payments.txt
    List<String[]> paymentHistory = new ArrayList<>();
    if (studentId != null) {
        String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
        File paymentsFile = new File(paymentsFilePath);
        if (paymentsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(paymentsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 9 && parts[1].equals(studentId)) {
                        paymentHistory.add(parts);
                    }
                }
            } catch (IOException e) {
                request.setAttribute("error", "Failed to load payment history: " + e.getMessage());
            }
        }
    }

    // Hardcoded progress for demonstration
    Map<String, String> courseProgress = new HashMap<>();
    courseProgress.put("CS401", "65%");
    courseProgress.put("AI301", "82%");
    courseProgress.put("DB202", "45%");

    // Check if invoice is overdue
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date currentDate = dateFormat.parse("2025-05-02"); // Current date as of May 02, 2025

    // Handle form submission for making a payment
    String action = request.getParameter("action");
    if ("makePayment".equals(action)) {
        String subscriptionPlan = request.getParameter("subscriptionPlan");
        String amount = request.getParameter("amount");
        String startDate = request.getParameter("startDate");
        String paymentMethod = request.getParameter("paymentMethod");

        // Generate a unique invoice ID
        String invoiceId = "INV" + System.currentTimeMillis();
        String dueDate = "";
        try {
            Date startDateParsed = dateFormat.parse(startDate);
            Calendar cal = Calendar.getInstance();
            cal.setTime(startDateParsed);
            if ("monthly".equals(subscriptionPlan)) {
                cal.add(Calendar.MONTH, 1);
            } else if ("quarterly".equals(subscriptionPlan)) {
                cal.add(Calendar.MONTH, 3);
            } else if ("yearly".equals(subscriptionPlan)) {
                cal.add(Calendar.YEAR, 1);
            }
            dueDate = dateFormat.format(cal.getTime());
        } catch (Exception e) {
            dueDate = "N/A";
        }

        // Payment details
        String status = "pending";
        String paymentDate = "";
        String waiverApplied = "false";
        String lateFee = "0.00";

        // Prepare the payment entry
        String paymentEntry = String.join(",",
                invoiceId, studentId, amount, dueDate, status, paymentDate, waiverApplied, lateFee, paymentMethod, subscriptionPlan, startDate);

        // Write to payments.txt
        String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentsFilePath, true))) {
            writer.write(paymentEntry);
            writer.newLine();
            paymentHistory.add(paymentEntry.split(","));
            response.sendRedirect("student-dashboard.jsp?message=payment_made");
        } catch (IOException e) {
            request.setAttribute("error", "Failed to save payment: " + e.getMessage());
        }
    }
%>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">NexoraSkill</div>

    <div class="user-profile">
        <div class="user-avatar"><%= initials %></div>
        <div class="user-info">
            <h3><%= displayName %></h3>
            <p>Computer Science</p>
        </div>
    </div>

    <ul class="nav-menu">
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="dashboard">
                <i class="fas fa-home"></i> <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="profile">
                <i class="fas fa-user"></i> <span>Profile</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="courses">
                <i class="fas fa-book-open"></i> <span>My Courses</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="enrollment">
                <i class="fas fa-tasks"></i> <span>Enrollment</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="deadlines">
                <i class="fas fa-calendar-alt"></i> <span>Deadlines</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link active" data-section="payment">
                <i class="fas fa-credit-card"></i> <span>Payment</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="settings">
                <i class="fas fa-cog"></i> <span>Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getParameter("message") != null) { %>
    <div class="message success">
        <% String message = request.getParameter("message");
            if ("payment_made".equals(message)) { %>
        Payment made successfully!
        <% } else if ("waiver_applied".equals(message)) { %>
        Late fee waiver applied successfully!
        <% } else if ("late_fee_applied".equals(message)) { %>
        Late fee applied successfully!
        <% } else if ("invoice_voided".equals(message)) { %>
        Invoice voided successfully!
        <% } else if ("payment_cancelled".equals(message)) { %>
        Payment cancelled successfully!
        <% } %>
    </div>
    <% } %>

    <!-- Dashboard Section -->
    <section id="dashboard" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Welcome back, <%= firstName %>!</h1>
                <p>Your academic journey awaits</p>
            </div>
            <div class="user-actions">
                <div class="notification-bell">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">2</span>
                </div>
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Active Courses</h3>
                <p class="stat-value"><%= enrolledCourses.size() %></p>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> Updated
                </div>
            </div>
            <div class="stat-card">
                <h3>Assignments Due</h3>
                <p class="stat-value">3</p>
                <div class="stat-change negative">
                    <i class="fas fa-exclamation-circle"></i> 1 overdue
                </div>
            </div>
            <div class="stat-card">
                <h3>Overall Progress</h3>
                <p class="stat-value">78%</p>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> 5% up
                </div>
            </div>
        </div>

        <div class="courses-container">
            <% for (String[] enrollment : enrolledCourses) {
                String courseId = enrollment[2];
                String[] courseDetails = courseDetailsMap.get(courseId);
                if (courseDetails != null) {
                    String courseCode = courseDetails[0];
                    String courseTitle = courseDetails[1];
                    String instructor = courseDetails[2];
                    String progress = courseProgress.getOrDefault(courseId, "0%");
            %>
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code"><%= courseCode %></div>
                    <h3 class="course-title"><%= courseTitle %></h3>
                    <div class="course-instructor"><%= instructor %></div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span><%= progress %></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= progress %>"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>
            <% }
            } %>
        </div>
    </section>

    <!-- Profile Section -->
    <section id="profile" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Your Profile</h1>
                <p>Personalize your academic identity</p>
            </div>
            <div class="user-actions">
                <button class="btn btn-primary">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
            </div>
        </div>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="user-avatar-holographic">
                        <div class="hologram-effect"></div>
                        <img src="https://via.placeholder.com/150" alt="Profile Picture" class="avatar-image">
                        <div class="avatar-actions">
                            <button class="btn btn-outline avatar-upload">
                                <i class="fas fa-camera"></i> Update
                            </button>
                            <button class="btn btn-outline avatar-edit">
                                <i class="fas fa-magic"></i> Customize
                            </button>
                        </div>
                    </div>
                    <div class="profile-info">
                        <h2><%= displayName %></h2>
                        <div class="student-id-badge">
                            <i class="fas fa-id-card"></i> <%= studentIdBadge %>
                        </div>
                        <div class="verification-status">
                            <i class="fas fa-shield-check verified"></i> Verified Student
                        </div>
                        <div class="academic-level">
                            <div class="level-progress">
                                <div class="progress-fill" style="width: 78%"></div>
                            </div>
                            <span>Level 3 (78%)</span>
                        </div>
                    </div>
                </div>

                <div class="profile-tabs">
                    <div class="tab active" data-tab="personal">Personal</div>
                    <div class="tab" data-tab="academic">Academic</div>
                    <div class="tab" data-tab="security">Security</div>
                </div>

                <div class="tab-content">
                    <div class="tab-pane active" id="personal-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-user-tag"></i> Basic Info</h3>
                                <div class="detail-item">
                                    <label>Name:</label>
                                    <p><%= displayName %></p>
                                    <button class="btn-edit"><i class="fas fa-pencil-alt"></i></button>
                                </div>
                                <div class="detail-item">
                                    <label>DOB:</label>
                                    <p>March 15, 2001</p>
                                </div>
                                <div class="detail-item">
                                    <label>Gender:</label>
                                    <p>Male</p>
                                </div>
                            </div>
                            <div class="detail-card">
                                <h3><i class="fas fa-address-book"></i> Contact</h3>
                                <div class="detail-item">
                                    <label>Email:</label>
                                    <p><%= email != null ? email : "john.doe@nexora.edu" %></p>
                                </div>
                                <div class="detail-item">
                                    <label>Phone:</label>
                                    <p>+94 77 123 4567</p>
                                </div>
                                <div class="detail-item">
                                    <label>Address:</label>
                                    <p>123 University Dorm, Colombo</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="academic-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-graduation-cap"></i> Program</h3>
                                <div class="detail-item">
                                    <label>Degree:</label>
                                    <p>BSc Computer Science</p>
                                </div>
                                <div class="detail-item">
                                    <label>Enrolled:</label>
                                    <p>September 2020</p>
                                </div>
                                <div class="detail-item">
                                    <label>GPA:</label>
                                    <p>3.72/4.00</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="security-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-lock"></i> Security</h3>
                                <div class="detail-item">
                                    <label>Password:</label>
                                    <p>••••••••</p>
                                    <button class="btn btn-outline">
                                        <i class="fas fa-sync-alt"></i> Change
                                    </button>
                                </div>
                                <div class="detail-item">
                                    <label>2FA:</label>
                                    <p>Not Enabled</p>
                                    <button class="btn btn-primary">
                                        <i class="fas fa-toggle-on"></i> Enable
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="profile-actions">
                    <button class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Courses Section -->
    <section id="courses" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>My Courses</h1>
                <p>Explore your learning path</p>
            </div>
        </div>

        <div class="courses-container">
            <% if (enrolledCourses.isEmpty()) { %>
            <p>No enrolled courses found.</p>
            <% } else { %>
            <% for (String[] enrollment : enrolledCourses) {
                String courseId = enrollment[2];
                String[] courseDetails = courseDetailsMap.get(courseId);
                if (courseDetails != null) {
                    String courseCode = courseDetails[0];
                    String courseTitle = courseDetails[1];
                    String instructor = courseDetails[2];
                    String progress = courseProgress.getOrDefault(courseId, "0%");
            %>
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code"><%= courseCode %></div>
                    <h3 class="course-title"><%= courseTitle %></h3>
                    <div class="course-instructor"><%= instructor %></div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span><%= progress %></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= progress %>"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <button class="btn btn-outline">
                        <i class="fas fa-info-circle"></i> Details
                    </button>
                </div>
            </div>
            <% }
            } %>
            <% } %>
        </div>
    </section>

    <!-- Enrollment Section -->
    <section id="enrollment" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Course Enrollment</h1>
                <p>Manage your course registrations</p>
            </div>
            <a href="enrollment?action=viewEnrollments" class="btn btn-primary">
                <i class="fas fa-list"></i> View My Enrollments
            </a>
        </div>

        <div class="enrollment-section">
            <h2><i class="fas fa-exchange-alt"></i> Change Course Section</h2>
            <form action="enrollment" method="post" class="enrollment-form">
                <input type="hidden" name="action" value="changeSection">
                <div class="form-group">
                    <label for="oldCourseId">Current Course ID:</label>
                    <input type="text" id="oldCourseId" name="oldCourseId" required>
                </div>
                <div class="form-group">
                    <label for="newCourseId">New Course ID:</label>
                    <input type="text" id="newCourseId" name="newCourseId" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-exchange-alt"></i> Change Section
                    </button>
                </div>
            </form>
        </div>

        <div class="enrollment-section">
            <h2><i class="fas fa-minus-circle"></i> Drop Course</h2>
            <form action="enrollment" method="post" class="enrollment-form">
                <input type="hidden" name="action" value="dropCourse">
                <div class="form-group">
                    <label for="courseId">Course ID:</label>
                    <input type="text" id="courseId" name="courseId" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-minus-circle"></i> Drop Course
                    </button>
                </div>
            </form>
        </div>
    </section>

    <!-- Deadlines Section -->
    <section id="deadlines" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Upcoming Deadlines</h1>
                <p>Stay on top of your tasks</p>
            </div>
            <button class="btn btn-outline">
                <i class="fas fa-plus"></i> Add Reminder
            </button>
        </div>

        <div class="deadlines-container">
            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">Final Project</div>
                    <div class="deadline-course">Advanced Algorithms</div>
                </div>
                <div class="deadline-time">
                    <span class="status overdue">Overdue</span>
                </div>
            </div>
            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-laptop-code"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">ML Model</div>
                    <div class="deadline-course">Machine Learning</div>
                </div>
                <div class="deadline-time">
                    <span class="status pending">Due in 2 days</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Payment Section -->
    <section id="payment" class="content-section active">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Payment Management</h1>
                <p>Manage your site subscription to access all courses</p>
            </div>
        </div>

        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fas fa-credit-card"></i> Payment Options</h2>
            </div>

            <div class="payment-section active" id="make-payment-section">
                <h3>Make a Payment</h3>
                <form id="paymentForm" action="student-dashboard.jsp" method="post" class="payment-form">
                    <input type="hidden" name="action" value="makePayment">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <div class="form-group">
                        <label for="subscriptionPlan">Subscription Plan:</label>
                        <select id="subscriptionPlan" name="subscriptionPlan" class="invoice-select" required onchange="updateSubscriptionAmount()">
                            <option value="">-- Select a Plan --</option>
                            <option value="monthly" data-amount="49.99">Monthly Access - $49.99</option>
                            <option value="quarterly" data-amount="129.99">Quarterly Access - $129.99</option>
                            <option value="yearly" data-amount="499.99">Yearly Access - $499.99</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="subscriptionAmount">Amount:</label>
                        <input type="text" id="subscriptionAmount" name="amount" readonly required>
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required min="2025-05-02">
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment Method:</label>
                        <select id="paymentMethod" name="paymentMethod" class="invoice-select" required onchange="togglePaymentDetails()">
                            <option value="">-- Select Payment Method --</option>
                            <option value="creditCard">Credit Card</option>
                            <option value="debitCard">Debit Card</option>
                            <option value="bankTransfer">Bank Transfer</option>
                            <option value="payPal">PayPal</option>
                            <option value="crypto">Crypto</option>
                        </select>
                    </div>

                    <!-- Payment Details Section -->
                    <div id="paymentDetails" style="display: none;">
                        <div class="form-grid">
                            <div class="form-group" id="cardNumberGroup">
                                <label for="cardNumber">Card Number:</label>
                                <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456">
                            </div>
                            <div class="form-group" id="expiryDateGroup">
                                <label for="expiryDate">Expiry Date:</label>
                                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY">
                            </div>
                            <div class="form-group" id="cvvGroup">
                                <label for="cvv">CVV:</label>
                                <input type="text" id="cvv" name="cvv" placeholder="123">
                            </div>
                            <div class="form-group" id="accountNumberGroup" style="display: none;">
                                <label for="accountNumber">Account Number:</label>
                                <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter account number">
                            </div>
                            <div class="form-group" id="routingNumberGroup" style="display: none;">
                                <label for="routingNumber">Routing Number:</label>
                                <input type="text" id="routingNumber" name="routingNumber" placeholder="Enter routing number">
                            </div>
                            <div class="form-group" id="paypalEmailGroup" style="display: none;">
                                <label for="paypalEmail">PayPal Email:</label>
                                <input type="text" id="paypalEmail" name="paypalEmail" placeholder="Enter PayPal email">
                            </div>
                            <div class="form-group" id="cryptoWalletGroup" style="display: none;">
                                <label for="cryptoWallet">Crypto Wallet Address:</label>
                                <input type="text" id="cryptoWallet" name="cryptoWallet" placeholder="Enter wallet address">
                            </div>
                        </div>
                    </div>

                    <div class="payment-actions">
                        <button type="submit" class="btn btn-primary" id="makePaymentBtn">
                            <i class="fas fa-check-circle"></i> Subscribe Now
                        </button>
                    </div>
                </form>
            </div>

            <!-- Payment History Section -->
            <h3 style="margin-top: 40px;">Payment History</h3>
            <table class="payment-table">
                <thead>
                <tr>
                    <th>Invoice ID</th>
                    <th>Plan</th>
                    <th>Amount</th>
                    <th>Start Date</th>
                    <th>Due Date</th>
                    <th>Status</th>
                    <th>Payment Date</th>
                    <th>Waiver Applied</th>
                    <th>Late Fee</th>
                    <th>Payment Method</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] fee : paymentHistory) {
                    boolean isOverdue = false;
                    try {
                        Date dueDate = dateFormat.parse(fee[3]);
                        isOverdue = dueDate.before(currentDate);
                    } catch (Exception e) {}
                    String paymentStatus = !fee[5].isEmpty() ? "paid" : ("pending".equals(fee[4]) ? (isOverdue ? "overdue" : "pending") : fee[4]);
                    String plan = fee.length > 9 ? fee[9] : "N/A";
                %>
                <tr>
                    <td><%= fee[0] %></td>
                    <td><%= plan %></td>
                    <td><%= fee[2] %></td>
                    <td><%= fee.length > 10 ? fee[10] : "N/A" %></td>
                    <td><%= fee[3] %></td>
                    <td class="status-cell <%= paymentStatus %>"><%= paymentStatus.substring(0, 1).toUpperCase() + paymentStatus.substring(1) %></td>
                    <td><%= fee[5].isEmpty() ? "N/A" : fee[5] %></td>
                    <td><%= "true".equals(fee[6]) ? "Yes" : "No" %></td>
                    <td><%= fee[7] %></td>
                    <td><%= fee[8].isEmpty() ? "N/A" : fee[8] %></td>
                    <td class="payment-actions">
                        <% if ("pending".equals(fee[4]) && !"true".equals(fee[6])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="applyWaiver">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-primary btn-sm" title="Apply Waiver">
                                <i class="fas fa-hand-holding-usd"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("pending".equals(fee[4]) && isOverdue && !"true".equals(fee[6])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="applyLateFee">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <div style="display:inline-block; margin-right: 5px;">
                                <input type="text" name="lateFeeAmount" placeholder="Fee" style="width: 80px; padding: 5px;" required>
                            </div>
                            <button type="submit" class="btn btn-warning btn-sm" title="Apply Late Fee">
                                <i class="fas fa-exclamation-triangle"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("pending".equals(fee[4])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="void">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-danger btn-sm" title="Void Invoice">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("paid".equals(fee[4])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="cancelPayment">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-outline btn-sm" title="Cancel Payment">
                                <i class="fas fa-undo"></i>
                            </button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Settings Section -->
    <section id="settings" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Settings</h1>
                <p>Customize your experience</p>
            </div>
        </div>

        <div class="settings-container">
            <div class="settings-form">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" value="<%= displayName %>">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" value="<%= email != null ? email : "john.doe@nexora.edu" %>">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary">
                        <i class="fas fa-save"></i> Save
                    </button>
                </div>
                <div class="form-group">
                    <form action="delete-account.jsp" method="get">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to proceed with deleting your account?');">
                            <i class="fas fa-trash-alt"></i> Delete Account
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    // Navigation
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const sectionId = link.getAttribute('data-section');

            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            sections.forEach(section => section.classList.remove('active'));
            document.getElementById(sectionId).classList.add('active');
        });
    });

    // Sidebar Toggle
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    const toggleBtn = document.querySelector('.sidebar-toggle');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        mainContent.classList.toggle('full-width');
    });

    // Profile Tabs
    document.querySelectorAll('.profile-tabs .tab').forEach(tab => {
        tab.addEventListener('click', () => {
            const tabId = tab.getAttribute('data-tab');

            document.querySelectorAll('.profile-tabs .tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));
            document.getElementById(`${tabId}-tab`).classList.add('active');
        });
    });

    // Notification
    document.querySelector('.notification-bell').addEventListener('click', () => {
        alert('2 new notifications');
    });

    // Payment Section - Auto-populate subscription amount
    function updateSubscriptionAmount() {
        const subscriptionPlan = document.getElementById('subscriptionPlan');
        const subscriptionAmountInput = document.getElementById('subscriptionAmount');
        const selectedOption = subscriptionPlan.options[subscriptionPlan.selectedIndex];

        if (!selectedOption.value) {
            subscriptionAmountInput.value = '';
            return;
        }

        subscriptionAmountInput.value = selectedOption.getAttribute('data-amount');
    }

    // Toggle Payment Details Fields
    function togglePaymentDetails() {
        const paymentMethod = document.getElementById('paymentMethod').value;
        const paymentDetails = document.getElementById('paymentDetails');
        const cardNumberGroup = document.getElementById('cardNumberGroup');
        const expiryDateGroup = document.getElementById('expiryDateGroup');
        const cvvGroup = document.getElementById('cvvGroup');
        const accountNumberGroup = document.getElementById('accountNumberGroup');
        const routingNumberGroup = document.getElementById('routingNumberGroup');
        const paypalEmailGroup = document.getElementById('paypalEmailGroup');
        const cryptoWalletGroup = document.getElementById('cryptoWalletGroup');

        // Reset all fields to hidden
        paymentDetails.style.display = 'none';
        cardNumberGroup.style.display = 'none';
        expiryDateGroup.style.display = 'none';
        cvvGroup.style.display = 'none';
        accountNumberGroup.style.display = 'none';
        routingNumberGroup.style.display = 'none';
        paypalEmailGroup.style.display = 'none';
        cryptoWalletGroup.style.display = 'none';

        // Clear previous validation requirements
        document.querySelectorAll('#paymentDetails input').forEach(input => {
            input.removeAttribute('required');
        });

        // Show relevant fields based on payment method and set required attributes
        if (paymentMethod) {
            paymentDetails.style.display = 'block';
            if (paymentMethod === 'creditCard' || paymentMethod === 'debitCard') {
                cardNumberGroup.style.display = 'block';
                expiryDateGroup.style.display = 'block';
                cvvGroup.style.display = 'block';
                document.getElementById('cardNumber').setAttribute('required', 'required');
                document.getElementById('expiryDate').setAttribute('required', 'required');
                document.getElementById('cvv').setAttribute('required', 'required');
            } else if (paymentMethod === 'bankTransfer') {
                accountNumberGroup.style.display = 'block';
                routingNumberGroup.style.display = 'block';
                document.getElementById('accountNumber').setAttribute('required', 'required');
                document.getElementById('routingNumber').setAttribute('required', 'required');
            } else if (paymentMethod === 'payPal') {
                paypalEmailGroup.style.display = 'block';
                document.getElementById('paypalEmail').setAttribute('required', 'required');
            } else if (paymentMethod === 'crypto') {
                cryptoWalletGroup.style.display = 'block';
                document.getElementById('cryptoWallet').setAttribute('required', 'required');
            }
        }
    }

    // Form Validation and Submission for Make Payment
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        const subscriptionPlan = document.getElementById('subscriptionPlan').value;
        const paymentMethod = document.getElementById('paymentMethod').value;

        if (!subscriptionPlan) {
            e.preventDefault();
            alert('Please select a subscription plan.');
            return;
        }

        if (!paymentMethod) {
            e.preventDefault();
            alert('Please select a payment method.');
            return;
        }

        // Additional validation for payment details
        if (paymentMethod === 'creditCard' || paymentMethod === 'debitCard') {
            const cardNumber = document.getElementById('cardNumber').value;
            const expiryDate = document.getElementById('expiryDate').value;
            const cvv = document.getElementById('cvv').value;
            if (!cardNumber || !expiryDate || !cvv) {
                e.preventDefault();
                alert('Please fill all card details.');
                return;
            }
        } else if (paymentMethod === 'bankTransfer') {
            const accountNumber = document.getElementById('accountNumber').value;
            const routingNumber = document.getElementById('routingNumber').value;
            if (!accountNumber || !routingNumber) {
                e.preventDefault();
                alert('Please fill all bank transfer details.');
                return;
            }
        } else if (paymentMethod === 'payPal') {
            const paypalEmail = document.getElementById('paypalEmail').value;
            if (!paypalEmail) {
                e.preventDefault();
                alert('Please enter your PayPal email.');
                return;
            }

            
        } else if (paymentMethod === 'crypto') {
            const cryptoWallet = document.getElementById('cryptoWallet').value;
            if (!cryptoWallet) {
                e.preventDefault();
                alert('Please enter your crypto wallet address.');
                return;
            }
        }
    });

    // Initialize payment section
    updateSubscriptionAmount();
    togglePaymentDetails();
</script>
</body>
</html>