let form = document.getElementById('check-form');
let rButtons = document.querySelectorAll('.r-button');
let rValueInput = document.getElementById('r-value');
document.addEventListener('DOMContentLoaded', main);

function main() {
    console.log("Работаем")
    setupRButtons(rButtons);
    setupSubmitForm(form);
    drawGraphic(1);
    setupCanvasClickHandler();
}

function setupCanvasClickHandler() {
    const canvas = document.getElementById('canvas');
    canvas.addEventListener('click', (event) => {
        if (rValueInput.value) {
            handleClickOnGraphic(canvas, event, rValueInput.value);
        } else {
            alert("Значение R не установлено");
        }
    });
}

function handleClickOnGraphic(graphic, event, rValue) {
    const rect = graphic.getBoundingClientRect();
    const clickX = event.clientX - rect.left;
    const clickY = event.clientY - rect.top;
    const centerX = graphic.width / 2;
    const centerY = graphic.height / 2;
    const R = (graphic.height - 50) / 2 / (5 / rValue);

    const X = (clickX - centerX) / R * rValue;
    const Y = (centerY - clickY) / R * rValue;

    handleSubmitForm(X, Y, rValue);

    // drawPoint(clickX, clickY, isHit(X, Y, rValue));
}

function isHit(x, y, r) {
    if (x >= 0 && y >= 0) {
        return y <= -x + r / 2;
    }
    if (x <= 0 && y >= 0) {
        return y <= r && x >= (-r / 2);
    }
    if (x >= 0 && y <= 0) {
        return x*x + y*y <= r*r;
    }
    return false;
}

function drawPoint(X, Y, isHit) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');

    ctx.fillStyle = (isHit) ? "green" : "red";
    ctx.beginPath();
    ctx.arc(X, Y, 5, 0, 2 * Math.PI); // радиус точки 5
    ctx.fill();
}

function setupRButtons() {
    // let value = document.getElementById('r-value');
    rButtons.forEach(bt => bt.addEventListener('click',
        function () {
            handlerRButtonClick(this);
            drawGraphic(rValueInput.value);
            drawPoints(document.getElementById('canvas'), points, rValueInput.value);
        }
    ));
}

function handlerRButtonClick(button) {
    rValueInput.value = button.value;
    rButtons.forEach(bt => bt.classList.remove('active'));
    button.classList.add('active');
}

function setupSubmitForm() {
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        handleSubmitFrom();
    })
}

function getXValue() {
    const selectedRadio = document.querySelector('input[name="value"]:checked');
    return selectedRadio ? selectedRadio.value : null;
}

function handleSubmitFrom() {
    let xCord = getXValue();
    let yCord = document.getElementById('y').value;
    let rCord = rValueInput.value;
    if (validateForm(xCord, yCord, rCord)) {
        sendRequest(xCord, yCord, rCord);
    } else {
        alert('Заполните все поля правильно!');
    }
}

function handleSubmitForm(x, y, r){
    sendRequest(x, y, r);
}

function validateForm(x, y, r) {
    console.log(x == null, !validateY(y), r === '');
    return !(x == null || !validateY(y) || r === '');

}

function validateY(y) {
    let value = y.parseFloat;
    let regex = /^-?\d+(\.\d{0,5})?$/;
    console.log(y);
    if (Number.isNaN(value)) return false;
    console.log(regex.test(y));
    return value >= -5 || value <= 5 || regex.test(y);
}

async function sendRequest(x, y, r) {
    let data = {x: x, y: y, r: r};
    fetch("../hit", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data)
    })
        .then(response => {
            if (!response.ok) {
                document.getElementById('error-message').style.display = 'block';
                document.getElementById('error-message').innerText = 'Ошибка: ' + response.status + "\n" + response.statusText;
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.text();
        })
        .then(html => {
            document.open();
            document.write(html);
            document.close();
        })
        .catch(error => {
            console.error('Error fetching and displaying the page:', error);
        });
    
}

function drawGraphic(rValue) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    const R = (canvas.height - 50) / 2 / (5 / rValue);

    const centerX = (canvas.width) / 2;
    const centerY = (canvas.height) / 2;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = "rgba(66, 170, 255, 0.8)";
    ctx.strokeStyle = "black";
    ctx.lineWidth = 1;

    ctx.beginPath();
    ctx.rect(centerX - R / 2, centerY - R, R / 2, R);
    ctx.fill();

    ctx.beginPath();
    ctx.moveTo(centerX + R / 2, centerY);
    ctx.lineTo(centerX, centerY - R / 2);
    ctx.lineTo(centerX, centerY);
    ctx.closePath();
    ctx.fill();

    ctx.beginPath();
    ctx.arc(centerX, centerY, R / 2, 0, Math.PI / 2, false);
    ctx.lineTo(centerX, centerY);
    ctx.closePath();
    ctx.fill();

    ctx.beginPath();
    ctx.moveTo(centerX, 0);
    ctx.lineTo(centerX, canvas.height - 0);
    ctx.moveTo(0, centerY);
    ctx.lineTo(canvas.width - 0, centerY);
    ctx.strokeStyle = "black";
    ctx.stroke();

    ctx.font = "bold 16px Arial ";
    ctx.fillStyle = "black";
    ctx.fillText(`${rValue}`, centerX + R - 5, centerY + 15);
    ctx.fillText(`${rValue / 2}`, centerX + R / 2 - 10, centerY + 15);
    ctx.fillText(`${-rValue / 2}`, centerX - R / 2 - 20, centerY + 15);
    ctx.fillText(`${-rValue}`, centerX - R - 15, centerY + 15);
    ctx.fillText(`${rValue}`, centerX + 5, centerY - R + 5);
    ctx.fillText(`${rValue / 2}`, centerX + 5, centerY - R / 2 + 5);
    ctx.fillText(`${-rValue / 2}`, centerX + 5, centerY + R / 2 + 5);
    ctx.fillText(`${-rValue}`, centerX + 5, centerY + R + 5);
}

function drawPoints(graphic, points, rValue) {
    const centerX = graphic.width / 2;
    const centerY = graphic.height / 2;
    const R = (graphic.height - 50) / 2 / (5 / rValue);
    points.forEach(point => {
        drawPoint(point.x / rValue * R + centerX,
            -(point.y / rValue * R - centerY),
            isHit(point.x, point.y, rValueInput.value))
    })
}
