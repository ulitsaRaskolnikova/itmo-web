<%--
  Created by IntelliJ IDEA.
  User: vim15
  Date: 10.11.2024
  Time: 0:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<label>Координата X:</label>
<div class="button-group">
    <button type="button" class="button" value="-3">-3</button>
    <button type="button" class="button" value="-2">-2</button>
    <button type="button" class="button" value="-1">-1</button>
    <button type="button" class="button" value="0">0</button>
    <button type="button" class="button" value="1">1</button>
    <button type="button" class="button" value="2">2</button>
    <button type="button" class="button" value="3">3</button>
    <button type="button" class="button" value="4">4</button>
    <button type="button" class="button" value="5">5</button>
</div>

<br><label for="y">Координата Y:</label>
<div id="input-text">
    <input type="text" id="y" name="y" required>
</div>

<br><label for="r-buttons">Параметр R:</label>
<div id="r-buttons">
    <input type="checkbox" class="r-button-checkbox" id="r-1" value="1">
    <label for="r-1" class="r-button">1</label>

    <input type="checkbox" class="r-button-checkbox" id="r-2" value="2">
    <label for="r-2" class="r-button">2</label>

    <input type="checkbox" class="r-button-checkbox" id="r-3" value="3">
    <label for="r-3" class="r-button">3</label>

    <input type="checkbox" class="r-button-checkbox" id="r-4" value="4">
    <label for="r-4" class="r-button">4</label>

    <input type="checkbox" class="r-button-checkbox" id="r-5" value="5">
    <label for="r-5" class="r-button">5</label>

    <input type="hidden" id="r-value" name="r">
</div>

<br>
<button id="submit" data-tooltip="Нажмите для отправки" type="submit">SEND</button>