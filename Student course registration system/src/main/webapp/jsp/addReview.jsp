<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Review</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 150px;
            resize: vertical;
        }
        .rating {
            display: flex;
            justify-content: space-between;
            width: 200px;
            margin-bottom: 15px;
        }
        .rating input {
            display: none;
        }
        .rating label {
            font-size: 24px;
            color: #ccc;
            cursor: pointer;
        }
        .rating input:checked ~ label {
            color: #ffc107;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Review</h1>
        <form action="AddReviewServlet" method="post">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="content">Review Content:</label>
                <textarea id="content" name="content" required></textarea>
            </div>
            <div class="form-group">
                <label>Rating:</label>
                <div class="rating">
                    <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1" checked><label for="star1">★</label>
                </div>
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category">
                    <option value="Books">Books</option>
                    <option value="Movies">Movies</option>
                    <option value="Products">Products</option>
                    <option value="Services">Services</option>
                </select>
            </div>
            <button type="submit" class="btn">Submit Review</button>
        </form>
    </div>
</body>
</html>