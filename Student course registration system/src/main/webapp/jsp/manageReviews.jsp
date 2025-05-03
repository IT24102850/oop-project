<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Reviews</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .action-btns {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s ease;
        }
        .btn-edit {
            background-color: #3498db;
            color: white;
        }
        .btn-edit:hover {
            background-color: #2980b9;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .btn-delete:hover {
            background-color: #c0392b;
        }
        .btn-add {
            background-color: #2ecc71;
            color: white;
        }
        .btn-add:hover {
            background-color: #27ae60;
        }
        .search-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .search-box {
            padding: 8px 15px;
            width: 300px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 14px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin-top: 30px;
        }
        .pagination li {
            margin: 0 5px;
        }
        .pagination a {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #3498db;
            transition: all 0.3s ease;
        }
        .pagination a.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .pagination a:hover:not(.active) {
            background-color: #f1f1f1;
        }
        .no-reviews {
            text-align: center;
            padding: 40px;
            color: #777;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Manage Reviews</h1>

    <div class="search-container">
        <input type="text" class="search-box" placeholder="Search reviews..." id="searchInput">
        <a href="addReview.jsp" class="btn btn-add">Add New Review</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Category</th>
            <th>Rating</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty reviews}">
                <c:forEach var="review" items="${reviews}">
                    <tr>
                        <td>${review.id}</td>
                        <td>${review.title}</td>
                        <td>${review.category}</td>
                        <td>
                            <c:forEach begin="1" end="5" var="i">
                                <span style="color:${i <= review.rating ? '#ffc107' : '#ddd'}">★</span>
                            </c:forEach>
                            (${review.rating}/5)
                        </td>
                        <td>${review.date}</td>
                        <td class="action-btns">
                            <a href="EditReviewServlet?id=${review.id}" class="btn btn-edit">Edit</a>
                            <a href="DeleteReviewServlet?id=${review.id}" class="btn btn-delete"
                               onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" class="no-reviews">No reviews found. Be the first to add one!</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <ul class="pagination">
        <li><a href="#">&laquo;</a></li>
        <li><a href="#" class="active">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">&raquo;</a></li>
    </ul>
</div>

<script>
    // Simple search functionality
    document.getElementById('search