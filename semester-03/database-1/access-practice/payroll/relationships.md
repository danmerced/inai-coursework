# Схема базы «Заработная плата»

```mermaid
erDiagram
    EMPLOYEES ||--o| PAYROLL : has
```

Первичный ключ payroll.employee_id также является внешним ключом на employees.id. Представление payroll_summary объединяет сотрудника, ставку, расчёт удержаний и сумму к выплате.
