// 181
const weekdays = {1:'Понедельник',2:'Вторник',3:'Среда',4:'Четверг',5:'Пятница',6:'Суббота',7:'Воскресенье'};
console.log(Object.values(weekdays));
// 182
const months = {1:'Январь',2:'Февраль',3:'Март',4:'Апрель',5:'Май',6:'Июнь',7:'Июль',8:'Август',9:'Сентябрь',10:'Октябрь',11:'Ноябрь',12:'Декабрь'};
console.log(months);
// 183
const user = {name:'Иван', surname:'Иванов', patronymic:'Иванович'};
console.log(user.surname, user.name, user.patronymic);
// 184
const now = new Date();
const date = {year: now.getFullYear(), month: now.getMonth()+1, day:now.getDate()};
console.log(date.year + '-' + String(date.month).padStart(2,'0') + '-' + String(date.day).padStart(2,'0'));
// 185–187
const obj = {x:1,y:2,z:3};
console.log(Object.keys(obj).length);
console.log('x' in obj, 'w' in obj);
delete obj.x;
console.log('x' in obj);
// 188–198
console.log(typeof {x:1,y:2,z:3}, typeof {}, typeof obj, typeof obj.y);
console.log(typeof [1,2,3], typeof [1,2,3][0], typeof ['1','2','3'][0]);
console.log(Array.isArray([1,2,3]), Array.isArray({x:1,y:2,z:3}));
