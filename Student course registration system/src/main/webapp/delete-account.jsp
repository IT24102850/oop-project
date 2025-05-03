<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Delete Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --success-color: #4caf50;
            --warning-color: #ff9800;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --card-bg: rgba(15, 23, 42, 0.9);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 20px;
            --box-shadow: 0 15px 50px rgba(0, 0, 0, 0.5);
            --transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--darker-color), var(--dark-color));
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .delete-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            max-width: 600px;
            width: 100%;
            box-shadow: var(--box-shadow);
            backdrop-filter: blur(10px);
            text-align: center;
        }

        .delete-header {
            margin-bottom: 30px;
        }

        .delete-header h1 {
            font-size: 2rem;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .delete-header p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        .warning-message {
            background: rgba(255, 77, 126, 0.15);
            border: 1px solid var(--accent-color);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            color: var(--text-color);
            font-size: 1rem;
        }

        .warning-message i {
            color: var(--accent-color);
            margin-right: 10px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
            font-size: 1rem;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 10px rgba(0, 242, 254, 0.3);
        }

        .btn {
            padding: 12px 25px;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            position: relative;
            overflow: hidden;
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        .btn:hover::after {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 242, 254, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--accent-color), #ff2d5a);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 77, 126, 0.4);
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .message {
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            text-align: center;
        }

        .message.error {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
            border: 1px solid rgba(255, 0, 0, 0.3);
        }
    </style>
</head>
<body>
<div class="delete-container">
    <div class="delete-header">
        <h1>Delete Your Account</h1>
        <p>We're sorry to see you go. Please confirm your decision below.</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="warning-message">
        <i class="fas fa-exclamation-triangle"></i>
        Warning: Deleting your account is permanent and cannot be undone. All your data, including enrollment records and progress, will be lost.
    </div>

    <form action="auth" method="post">
        <input type="hidden" name="action" value="deleteAccount">
        <div class="form-group">
            <label for="password">Enter Your Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password to confirm">
        </div>
        <div class="button-group">
            <a href="student-dashboard.jsp" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i> Cancel
            </a>
            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to permanently delete your account?');">
                <i class="fas fa-trash-alt"></i> Confirm Deletion
            </button>
        </div>
    </form>
</div>
</body>
</html>
