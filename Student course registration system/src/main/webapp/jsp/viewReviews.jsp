<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reviews</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        .reviews-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }
        .review-card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .review-card:hover {
            transform: translateY(-5px);
        }
        .review-title {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
            color: #3498db;
        }
        .review-content {
            margin-bottom: 15px;
            color: #555;
        }
        .review-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
            color: #777;
        }
        .review-rating {
            color: #ffc107;
            font-weight: bold;
        }
        .review-category {
            background-color: #e0e0e0;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.8em;
        }
        .no-reviews {
            text-align: center;
            padding: 40px;
            color: #777;
        }
        .filter-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .filter-group {
            display: flex;
            gap: 10px;
        }
        select, input {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer Reviews</h1>
        
        <div class="filter-container">
            <div class="filter-group">
                <select id="category-filter">
                    <option value="">All Categories</option>
                    <option value="Books">Books</option>
                    <option value="Movies">Movies</option>
                    <option value="Products">Products</option>
                    <option value="Services">Services</option>
                </select>
                <select id="rating-filter">
                    <option value="">All Ratings</option>
                    <option value="5">5 Stars</option>
                    <option value="4">4 Stars</option>
                    <option value="3">3 Stars</option>
                    <option value="2">2 Stars</option>
                    <option value="1">1 Star</option>
                </select>
            </div>
            <input type="text" id="search" placeholder="Search reviews...">
        </div>
        
        <div class="reviews-container">
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-card">
                            <div class="review-title">${review.title}</div>
                            <div class="review-content">${review.content}</div>
                            <div class="review-meta">
                                <span class="review-rating">Rating: ${review.rating}/5</span>
                                <span class="review-category">${review.category}</span>
                            </div>
                            <div class="review-date">${review.date}</div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-reviews">
                        No reviews found. Be the first to add one!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>