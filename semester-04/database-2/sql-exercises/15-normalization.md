# Нормализация

Исходное отношение: OrderLine(order_id, product_id, customer_id, customer_name, product_name, price_at_order, quantity). Ключ — (order_id, product_id), если товар встречается в заказе один раз.

- 1НФ: каждое значение атомарно, одна строка на товар в заказе.
- 2НФ: название товара зависит от product_id, покупатель — от order_id. Вынесены отдельные отношения Product и Orders.
- 3НФ: имя покупателя зависит от customer_id, а не от order_id. Вынесена таблица Customer.

Итог:

```sql
CREATE TABLE Customer(id INT PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE Product(id INT PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE Orders(id INT PRIMARY KEY, customer_id INT REFERENCES Customer(id));
CREATE TABLE OrderLine(
 order_id INT REFERENCES Orders(id),
 product_id INT REFERENCES Product(id),
 price_at_order DECIMAL(10,2) NOT NULL CHECK(price_at_order>=0),
 quantity INT NOT NULL CHECK(quantity>0),
 PRIMARY KEY(order_id,product_id)
);
```

Цена в строке заказа остаётся исторической ценой продажи, а не текущей ценой товара. Такое разделение устраняет аномалии добавления, изменения и удаления данных.
