# Связи таблиц

```mermaid
erDiagram
    CLIENTS ||--o{ ORDERS : places
    EMPLOYEES o|--o{ ORDERS : handles
    SUPPLIERS o|--o{ PRODUCTS : supplies
    ORDERS ||--o{ ORDER_DETAILS : contains
    PRODUCTS ||--o{ ORDER_DETAILS : includes
    ORDERS ||--o{ PAYMENTS : receives
```

Заказ связан с клиентом и сотрудником; товары входят в заказ через позиции заказа. Каждая позиция хранит цену на момент покупки, количество и долю скидки. Оплаты хранятся отдельно от позиций, поскольку один заказ может оплачиваться несколькими платежами.
