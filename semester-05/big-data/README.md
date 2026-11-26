# Введение в большие данные

Практики 1–15 по темам семестра, на собственных синтетических данных.

| Недели | Материалы |
|---|---|
| 1, 3, 10, 11 | [Теоретические задания](worksheets.md) |
| 2 | [PostgreSQL: JOIN, выплаты и транзакции](labs/week02_postgresql.sql) |
| 4 | [PostgreSQL: data gate](labs/week04_postgresql.sql), [Spark provenance](labs/week04_spark_sql.py) |
| 5 | [SQL качество данных](labs/week05_postgresql.sql), [ETL](labs/week05_spark_etl.py) |
| 6 | [SQL mart](labs/week06_postgresql.sql), [Spark ELT](labs/week06_spark_elt.py) |
| 7–9 | [Partitions](labs/week07_spark_partitions.py), [Parquet](labs/week08_spark_storage.py), [cache](labs/week09_spark_memory.py) |
| 12 | [Интегрированный Spark-практикум](labs/week12.py) |
| 13–14 | [ML Pipeline](labs/week13.py), [Supervised learning](labs/week14.py) |
| 15 | [KMeans](labs/week15.py) |
| Финальный проект | [Интегрированная аналитика](final-project.md) |

## Запуск

Python 3.11, JDK 17, PostgreSQL 15+ для SQL-части.

```sh
python -m pip install -r requirements.txt
python data/generate.py
python labs/week12.py
python labs/week15.py
```

SQL выполнять в выделенной пустой базе с помощью psql из этого каталога, последовательно week02, week04, week05, week06. Для Spark запускать файлы по одному. Для week09 наблюдать Spark UI во время выполнения. Реальные Exchange, планы и UI необходимо получить в Spark.

Локальная сверка без Spark: `python labs/local_analysis.py`. [Фактический вывод pandas, SQLite и scikit-learn](results.md); компиляция Python-скриптов прошла, PySpark и PostgreSQL в тестовой среде отсутствуют. Полные worksheets 1–14 и финальная рубрика не получены.
