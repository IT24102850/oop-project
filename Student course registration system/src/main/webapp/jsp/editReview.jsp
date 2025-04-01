<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Review</title>
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
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-primary:hover {
            background-color: #2980b9;
        }
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Review</h1>
        <form action="UpdateReviewServlet" method="post">
            <input type="hidden" name="id" value="${review.id}">
            
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="${review.title}" required>
            </div>
            
            <div class="form-group">
                <label for="content">Review Content:</label>
                <textarea id="content" name="content" required>${review.content}</textarea>
            </div>
            
            <div class="form-group">
                <label>Rating:</label>
                <div class="rating">
                    <input type="radio" id="star5" name="rating" value="5" ${review.rating == 5 ? 'checked' : ''}><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4" ${review.rating == 4 ? 'checked' : ''}><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3" ${review.rating == 3 ? 'checked' : ''}><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2" ${review.rating == 2 ? 'checked' : ''}><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1" ${review.rating == 1 ? 'checked' : ''}><label for="star1">★</label>
                </div>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category">
                    <option value="Books" ${review.category == 'Books' ? 'selected' : ''}>Books</option>
                    <option value="Movies" ${review.category == 'Movies' ? 'selected' : ''}>Movies</option>
                    <option value="Products" ${review.category == 'Products' ? 'selected' : ''}>Products</option>
                    <option value="Services" ${review.category == 'Services' ? 'selected' : ''}>Services</option>
                </select>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Update Review</button>
                <a href="DeleteReviewServlet?id=${review.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this review?')">Delete Review</a>
            </div>
        </form>
    </div>
</body>
</html>