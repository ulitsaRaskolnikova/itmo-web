document.addEventListener('DOMContentLoaded', () => {
    // Превращение чекбоксов в радиобаттоны
    document.querySelectorAll('input[name="x"]').forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            if (this.checked) {
                document.querySelectorAll('input[name="x"]').forEach(cb => {
                    if (cb !== this) cb.checked = false;
                });
            }
        });
    });
});

function validateAndSend() {
    clearErrors();

    const y = document.getElementById("y").value;
    const radius = document.getElementById("radius").value;
    const checkboxes = document.querySelectorAll('input[name="x"]');

    // Проверка выбора X
    const selectedX = Array.from(checkboxes).find(checkbox => checkbox.checked);
    if (!selectedX) {
        showError('x', "Выберите значение для X.");
        return false;
    }
    const x = selectedX.value;

    // Проверка значения Y
    if (!/^-?\d+(\.\d+)?$/.test(y)) {
        showError('y', "Значение Y должно быть числом.");
        return false;
    }

    const yValue = parseFloat(y);
    if (yValue < -5 || yValue > 3) {
        showError('y', "Значение Y должно быть в пределах от -5 до 3.");
        return false;
    }

    // Проверка выбора радиуса R
    if (!radius) {
        showError('radius', "Выберите значение для радиуса R.");
        return false;
    }

    // AJAX-запрос
    fetch(`/fcgi-bin/web-lab1-jar-with-dependencies.jar?x=${x}&y=${y}&radius=${radius}`, {
        method: 'GET'
    })
        .then(response => response.json())
        .then(data => {
            const resultsTable = document.getElementById("results-table");
            const row = resultsTable.insertRow(-1);

            row.insertCell(0).textContent = data.x;
            row.insertCell(1).textContent = data.y;
            row.insertCell(2).textContent = data.radius;
            row.insertCell(3).textContent = data.hit ? "Попадание" : "Промах";
            row.insertCell(4).textContent = data.currentTime;
            row.insertCell(5).textContent = data.executionTime;
        })
        .catch(error => console.error("Ошибка: " + error.message));

    return false; // Предотвращение перезагрузки страницы
}

// Очистка сообщений об ошибках
function clearErrors() {
    document.querySelectorAll('.error-message').forEach(error => error.remove());
}

// Вывод сообщения об ошибке
function showError(fieldName, message) {
    let field;
    if (fieldName === 'x') {
        field = document.querySelector('input[name="x"]').closest('div');
    } else {
        field = document.querySelector(`[name="${fieldName}"]`);
    }

    const errorElement = document.createElement('div');
    errorElement.className = 'error-message';
    errorElement.style.color = 'red';
    errorElement.textContent = message;

    field.parentNode.appendChild(errorElement);
}
