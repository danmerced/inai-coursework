const now = new Date();
const seconds = now.getSeconds() + now.getMilliseconds() / 1000;
const minutes = now.getMinutes() * 60 + seconds;
const hours = (now.getHours() % 12) * 3600 + minutes;
const clock = document.querySelector('.clock');
clock.style.setProperty('--second-delay', -seconds + 's');
clock.style.setProperty('--minute-delay', -minutes + 's');
clock.style.setProperty('--hour-delay', -hours + 's');
