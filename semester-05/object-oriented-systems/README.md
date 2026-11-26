# Online Store Order Processing System

Тема проекта — обработка заказов интернет-магазина. Java 21, объектная модель, UML, паттерны Strategy/Observer/Repository, XML/XSD, потоки и локальные TCP/RMI примеры.

- [Use case](diagrams/use-case.md), [Activity](diagrams/activity.md), [Sequence](diagrams/sequence.md), [Class](diagrams/class.md), [Deployment](diagrams/deployment.md)
- [OnlineStoreDemo.java](OnlineStoreDemo.java) — обработка корзины, расчёт суммы, проверка остатков, сохранение заказов, демонстрационная оплата.
- [NetworkDemo.java](NetworkDemo.java) — TCP и RMI.
- [Проектные решения](design-notes.md)
- [Результаты](results.md)

Из этого каталога: `java OnlineStoreDemo.java` (JDK 21), `java NetworkDemo.java`. Для окна Swing: `java OnlineStoreDemo.java --gui`. Результаты CLI проверены; GUI нужно открыть на компьютере с графической средой. Реальные платежи отсутствуют.

Точный перечень практических заданий и требования проекта пока не получены; реализация следует известной теме.
