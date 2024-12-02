<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Проверка попадания точки в область</title>
    <link rel="stylesheet" href="styles.css">
    <script src="./script.js" defer></script>
</head>
<body>
<header>
    <h1 id="laboratory-work">Лабораторная работа</h1>
    <p>Малышев Никита Александрович</p>
    <p>P3212</p>
    <p>Вариант: 12184</p>
</header>

<main>
    <section>
        <h2>Форма для ввода данных</h2>
        <div id="section">
            <form id="check-form" method="POST">
                <%@include file="jsp/requestForm.jsp" %>
            </form>
            <canvas id="canvas" width="500" height="500"></canvas>
        </div>
    </section>
    <section id="error-message" style="display: none; text-align: center; color: red;">
        <p>'Ошибка:' + 'сервер не отвечает'</p>
    </section>
    <section>
        <h2>Результаты</h2>
        <table id="results">
            <%@ include file="jsp/table.jsp" %>
        </table>
    </section>
</main>
</body>
</html>
<script>
    const points = [
        <c:forEach var="row" items="${sessionScope.TableEntries}">
        {
            x: ${row.point().x()},
            y: ${row.point().y()}
        }<c:if test="${!row.equals(sessionScope.TableEntries[sessionScope.TableEntries.size() - 1])}">, </c:if>
        </c:forEach>
    ];
</script>