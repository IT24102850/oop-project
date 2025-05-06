<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Instructor Dashboard - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --glass-bg: rgba(15, 23, 42, 0.8);
            --border-radius: 12px;
            --box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(ellipse at bottom, var(--darker-color) 0%, var(--dark-color) 100%);
            color: var(--text-color);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            position: relative;
            overflow: hidden;
        }

        body::before, body::after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.15) 0%, rgba(0, 242, 254, 0) 70%);
            z-index: -1;
        }

        body::before {
            top: -100px;
            left: -100px;
            animation: float 15s infinite alternate ease-in-out;
        }

        body::after {
            bottom: -100px;
            right: -100px;
            animation: float 18s infinite alternate-reverse ease-in-out;
        }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(50px, 50px) scale(1.1); }
            100% { transform: translate(-50px, -50px) scale(0.9); }
        }

        .dashboard-container {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: var(--border-radius);
            width: 100%;
            max-width: 600px;
            box-shadow: var(--box-shadow);
            text-align: center;
            transition: var(--transition);
        }

        .dashboard-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 242, 254, 0.3);
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            margin-bottom: 20px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        p {
            margin: 10px 0;
            font-size: 1rem;
        }

        .info-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            text-decoration: none;
            border-radius: 10px;
            margin-top: 20px;
            font-weight: 600;
            transition: var(--transition);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 242, 254, 0.3);
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h2>Welcome, <%= session.getAttribute("name") %>!</h2>
    <p><span class="info-label">Instructor ID:</span> <%= session.getAttribute("userId") %></p>
    <p><span class="info-label">Email:</span> <%= session.getAttribute("email") %></p>
    <p><span class="info-label">Course ID:</span> <%= session.getAttribute("courseId") %></p>
    <p><span class="info-label">Course Name:</span> <%= session.getAttribute("courseName") %></p>
    <p><span class="info-label">Semester:</span> <%= session.getAttribute("semester") %></p>
    <p><span class="info-label">Department:</span> <%= session.getAttribute("department") %></p>
    <p><span class="info-label">Supervisor:</span> <%= session.getAttribute("supervisor") %></p>
    <p><span class="info-label">Prerequisite:</span> <%= session.getAttribute("prerequisite") %></p>
    <p><span class="info-label">Account Status:</span> <%= "true".equals(session.getAttribute("active")) ? "Active" : "Inactive" %></p>
    <a href="logout.jsp" class="logout-btn">Logout</a>
</div>
</body>
</html>