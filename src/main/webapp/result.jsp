<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
  Created by IntelliJ IDEA.
  User: vim15
  Date: 12.11.2024
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Проверка попадания точки в область</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <section>
        <h2>Результаты</h2>
        <table id="results">
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Результат</th>
                <th>Время запроса</th>
                <th>Время обработки</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty sessionScope.TableEntries}">
                <c:set var="lastRow" value="${sessionScope.TableEntries[sessionScope.TableEntries.size() - 1]}" />
                <tr>
                    <th>${lastRow.point().x()}</th>
                    <th>${lastRow.point().y()}</th>
                    <th>${lastRow.point().r()}</th>
                    <th>${(lastRow.isHit()) ? "Попал" : "Не попал"}</th>
                    <th>${lastRow.requestTime()}</th>
                    <th>${lastRow.processTime()}</th>
                </tr>
            </c:if>
            </tbody>

        </table>
    </section>
    <section>
        <a href="index.jsp">Вернуться к форме</a>
    </section>
</body>
</html>