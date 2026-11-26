const form = document.getElementById('signup');
const password = document.getElementById('password');
const confirmPassword = document.getElementById('confirm');
function checkPassword() {
    confirmPassword.setCustomValidity(password.value === confirmPassword.value ? '' : 'Пароли не совпадают');
}
password.addEventListener('input', checkPassword);
confirmPassword.addEventListener('input', checkPassword);
form.addEventListener('submit', function (event) {
    event.preventDefault();
    document.getElementById('result').textContent = 'Форма заполнена корректно. Данные не отправляются на сервер.';
});
