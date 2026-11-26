# Результаты локального выполнения

Python, pandas, SQLite и scikit-learn. Это результаты переносимого варианта, а не вывод Spark/PostgreSQL.

 ```text
raw/accepted/quarantine: 6 4 2
reasons: {'missing_city': 1, 'unknown_kind': 1}
normalized accepted: 2
clicks SQL and dataframe: {'Bukhara': 1, 'Samarkand': 1, 'Tashkent': 2}
unmatched ride IDs: [6]
core city counts: {'Bukhara': 1, 'Samarkand': 1, 'Tashkent': 3}
core completed: 4
train/validation/test 360 120 120
validation ROC-AUC: 0.6758
threshold chosen on validation 0.2 {'TP': 27, 'FP': 50, 'FN': 5, 'TN': 38, 'cost': 70, 'precision': 0.3506, 'recall': 0.8438}
final held-out test: {'TP': 25, 'FP': 59, 'FN': 2, 'TN': 34, 'cost': 67, 'precision': 0.2976, 'recall': 0.9259}
test all-negative baseline cost: 108
test MAE regression: 3.766
test MAE mean baseline: 14.008
features:         pages    hour
count  900.00  900.00
mean    10.41   14.05
std      6.47    5.31
min      1.00    2.00
25%      4.00    9.00
50%     10.00   14.00
75%     17.00   19.00
max     24.00   23.00
k=3 seed=7
         size  avg_pages  avg_hour  conversion
cluster                                       
1         303      3.073     7.983       0.109
2         298     10.114    14.161       0.255
0         299     18.154    20.097       0.518
k=3 seed=8
         size  avg_pages  avg_hour  conversion
cluster                                       
0         309      3.168     8.023       0.113
2         292     10.158    14.247       0.253
1         299     18.154    20.097       0.518
k=3 ARI: 0.9801
k=8 seed=7
         size  avg_pages  avg_hour  conversion
cluster                                       
1         126      2.040     8.349       0.063
7         113      3.699     6.142       0.115
4          71      4.099    10.887       0.183
2         186     10.167    15.376       0.231
5         102     10.245    11.863       0.294
0         111     16.514    19.252       0.441
3         108     18.231    21.778       0.546
6          83     20.108    18.916       0.590
k=8 seed=8
         size  avg_pages  avg_hour  conversion
cluster                                       
0         162      2.809     6.556       0.105
5         139      3.309     9.633       0.115
7          50      7.500    15.880       0.200
2          96      9.042    12.667       0.229
4         113     11.336    15.602       0.283
3          43     12.395    11.674       0.326
6         176     17.477    21.108       0.494
1         121     19.215    18.653       0.545
k=8 ARI: 0.5206
 ```

## Интерпретация

Для данного синтетического набора k=3 даёт стабильное разбиение: ARI около 0,980; группы сопоставимы по средним значениям и мощности. При k=8 ARI около 0,521 и число элементов в отдельных группах опускается до 43, поэтому мелкая разбивка менее воспроизводима. Это сравнение локального алгоритма scikit-learn, для Spark нужно получить собственные таблицы.

Модель отмены уменьшает условную стоимость с 108 до 67 при выбранном пороге, однако precision составляет около 0,30. Регрессия на тестовой части даёт MAE около 3,77 минут против 14,01 у среднего train. Данные были сгенерированы по заданным закономерностям; результаты не доказывают качество на реальных поездках.
