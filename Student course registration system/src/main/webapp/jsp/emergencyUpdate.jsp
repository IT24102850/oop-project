<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Emergency Update</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .profile-form {
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group textarea {
            min-height: 80px;
            resize: vertical;
        }
        .form-actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-emergency {
            background-color: #f39c12;
            color: white;
        }
        .btn-cancel {
            background-color: #95a5a6;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Emergency Contact Update</h1>
        <form action="adminProfile" method="post" class="profile-form">
            <input type="hidden" name="action" value="emergency">
            <div class="form-group">
                <label for="userId">User ID:</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="newPhone">New Phone:</label>
                <input type="tel" id="newPhone" name="newPhone" required>
            </div>
            <div class="form-group">
                <label for="reason">Reason:</label>
                <textarea id="reason" name="reason" rows="3" required></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-emergency">Override</button>
                <a href="adminDashboard.jsp" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>