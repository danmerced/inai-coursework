// 323–325
for (const element of ['a','b','c','d','e']) console.log(element);
const obj = {x:1,y:2,z:3};
for (const key in obj) console.log(key);
for (const key in obj) console.log(obj[key]);
// 326–327
let i = 1;
while (i <= 100) console.log(i++);
i = 11;
while (i <= 33) console.log(i++);
// 328 (начальное значение 1)
let num = 1, count = 0;
while (num <= 1000) {
    num *= 3;
    count++;
}
console.log('Итог:', num, 'итераций:', count);
