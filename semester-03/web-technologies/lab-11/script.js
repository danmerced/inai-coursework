let admin;
let name = 'Джон';
admin = name;
console.log(admin);
const ourPlanetName = 'Земля';
let currentUserName = 'Алексей';
const BIRTHDAY = '2000-05-10';
const birthday = new Date(BIRTHDAY);
const now = new Date();
let age = now.getFullYear() - birthday.getFullYear();
if (now.getMonth() < birthday.getMonth() || (now.getMonth() === birthday.getMonth() && now.getDate() < birthday.getDate())) {
    age--;
}
console.log(ourPlanetName, currentUserName, BIRTHDAY, age);
if (typeof document !== 'undefined') {
    document.getElementById('show-admin').addEventListener('click', () => alert(admin));
}
