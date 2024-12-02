<%--
  Created by IntelliJ IDEA.
  User: vim15
  Date: 10.11.2024
  Time: 0:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<label>Координата X:</label>
<div class="radio-group">
    <input type="radio" id="value-3" class="radio-button" name="value" value="-3">
    <label for="value-3"><span>-3</span></label>

    <input type="radio" id="value-2" class="radio-button"  name="value" value="-2">
    <label for="value-2"><span>-2</span></label>

    <input type="radio" id="value-1" class="radio-button" name="value" value="-1">
    <label for="value-1"><span>-1</span></label>

    <input type="radio" id="value0" class="radio-button" name="value" value="0">
    <label for="value0"><span>0</span></label>

    <input type="radio" id="value1" class="radio-button" name="value" value="1">
    <label for="value1"><span>1</span></label>

    <input type="radio" id="value2" class="radio-button" name="value" value="2">
    <label for="value2"><span>2</span></label>

    <input type="radio" id="value3" class="radio-button" name="value" value="3">
    <label for="value3"><span>3</span></label>

    <input type="radio" id="value4" class="radio-button" name="value" value="4">
    <label for="value4"><span>4</span></label>

    <input type="radio" id="value5" class="radio-button" name="value" value="5">
    <label for="value5"><span>5</span></label>
</div>
<br><label for="y">Координата Y:</label>
<div id="input-text">
    <input type="text" id="y" name="y" required>
</div>

<br><label for="r-buttons">Параметр R:</label>
<div id="r-buttons">
    <button type="button" class="r-button" value="1">1</button>
    <button type="button" class="r-button" value="2">2</button>
    <button type="button" class="r-button" value="3">3</button>
    <button type="button" class="r-button" value="4">4</button>
    <button type="button" class="r-button" value="5">5</button>

    <input type="hidden" id="r-value" name="r">
</div>

<br>
<button id="submit" data-tooltip="Нажмите для отправки" type="submit">SEND</button>