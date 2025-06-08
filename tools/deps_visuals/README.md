# deps_visuals

## Prompt

Напиши html файл tools/deps_visuals/index.html для визуализации графа зависимостей по результатам вывода команды dart pub deps --style=compact.

Добавь возможность выбрать 2 файла: 
1. deps.txt — с выводом dart pub deps --style=compact
2. deps_status.csv — со статусом по каждой зависимости

По полученным данным построй граф:
1. Вершины графа — это зависимости-библиотеки. Одна из вершин должна описывать непосредственно корневую библиотеку/приложение, которую мы анализируем.
2. Ребра — зависимости между библиотеками.
3. В каждой вершине указывается информация о dep_local_version, dep_latest_version, outdated, latest_version_published из deps_status.csv.
4. Граф должен быть ориентированным, стрелка должна указывать на направление зависимостей.

Пример файла deps.txt с выводом команды dart pub deps --style=compact:

```
Dart SDK 3.7.0
Flutter SDK 3.29.0
my_lib 1.0.0

dependencies:
- bloc 8.1.4 [meta]
- http 1.4.0 [async http_parser meta web]
- path 1.9.1

dev dependencies:
- lints 5.1.1

transitive dependencies:
- async 2.13.0 [collection meta]
- collection 1.19.1
- http_parser 4.1.2 [collection source_span string_scanner typed_data]
- meta 1.17.0
- source_span 1.10.1 [collection path term_glyph]
- string_scanner 1.4.1 [source_span]
- term_glyph 1.2.2
- typed_data 1.4.0 [collection]
- web 1.1.1
```
Пример вывода файла deps_status.csv:

```
dep_name,dep_local_version,dep_latest_version,outdated,latest_version_published
flutter,0.0.0,0.0.20,,
logging,1.3.0,1.3.0,0,2024.10.17
ui_components,1.0.0,0.0.4,,
url_launcher,6.3.1,6.3.1,0,2024.10.08
flutter_launcher_icons,0.13.1,0.14.3,638,2025.01.17
flutter_lints,3.0.2,6.0.0,426,2025.05.27
archive,3.6.1,4.0.7,326,2025.04.23
args,2.6.0,2.7.0,149,2025.03.12
```