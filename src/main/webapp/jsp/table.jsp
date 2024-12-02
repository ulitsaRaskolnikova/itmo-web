<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
  Created by IntelliJ IDEA.
  User: vim15
  Date: 09.11.2024
  Time: 23:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
    <c:forEach var="row" items="${sessionScope.TableEntries}">
        <tr>
            <th>${row.point().x()}</th>
            <th>${row.point().y()}</th>
            <th>${row.point().r()}</th>
            <th>${(row.isHit()) ? "Попал": "Не попал"}</th>
            <th>${row.requestTime()}</th>
            <th>${row.processTime()}</th>
        </tr>
    </c:forEach>
</tbody>