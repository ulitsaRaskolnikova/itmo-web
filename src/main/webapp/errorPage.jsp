<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
  Created by IntelliJ IDEA.
  User: vim15
  Date: 12.11.2024
  Time: 15:29
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ошибка запроса</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            height: 100%;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            color: #333;
        }

        .error-container {
            text-align: center;
            padding: 30px 40px;
            background-color: #ffe6e6;
            border: 1px solid #ff4d4d;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            width: 90%;
        }

        .error-title {
            font-size: 26px;
            font-weight: bold;
            color: #d00000;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 18px;
            color: #444;
            margin-bottom: 25px;
        }

        .error-details {
            font-size: 14px;
            color: #777;
            margin-bottom: 20px;
            word-wrap: break-word;
        }

        .error-link {
            display: inline-block;
            font-size: 16px;
            color: #0056b3;
            text-decoration: none;
            padding: 10px 20px;
            border: 1px solid #0056b3;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .error-link:hover {
            background-color: #0056b3;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-title">Ошибка</div>
    <p class="error-message">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                ${errorMessage}
            </c:when>
            <c:otherwise>
                Неправильный формат запроса
            </c:otherwise>
        </c:choose>
    </p>
    <p class="error-details">
        <c:if test="${not empty errorDetails}">
            Подробности: ${errorDetails}
        </c:if>
    </p>
    <a href="index.jsp" class="error-link">Вернуться на главную страницу</a>
</div>
</body>
</html>
