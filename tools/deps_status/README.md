# deps_status

## Сетап окружения

python3 -m venv venv
source venv/bin/activate
pip install requests

## Prompt

Напиши python3 скрипт. Используй наиболее актуальные подходы.
Скрипт должен делать следующее:

1. Выполнить dart pub deps --style=compact
2. Собрать список уникальных зависимостей
3. Для каждой зависимости получить информацию через https://pub.dev/api/packages/[dep_name]
4. Для каждой зависимости вывести информацию:
    a. dep_name — название зависимости
    b. dep_local_version — версия зависимости в проекте
    с. dep_latest_version — актуальная версия зависимости из pub.dev
    d. outdated — разница между датой публикации dep_local_version и dep_latest_version (в днях)
    e. latest_version_published — дата публикации последней версии (в формате YYYY.MM.DD)
5. Сохранить полученные значения в csv формате в файл output/deps_status.csv

Пример вывода `dart pub deps --style=compact` для дальнейшего парсинга:

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

Пример ответа https://pub.dev/api/packages/[dep_name]:

```
{
  "name": "yx_scope",
  "latest": {
    "version": "1.0.2",
    "pubspec": {
      "name": "yx_scope",
      "description": "A core package of the compile-safe DI framework with advanced scoping capabilities",
      "version": "1.0.2",
      "repository": "https://github.com/yandex/yx_scope",
      "topics": [
        "di",
        "scope",
        "dependency-injection",
        "dependency-management"
      ],
      "environment": {
        "sdk": "\u003E=2.19.0 \u003C4.0.0"
      },
      "dependencies": {
        "meta": "^1.8.0"
      },
      "dev_dependencies": {
        "test": "^1.16.0",
        "lints": "^2.0.1"
      }
    },
    "archive_url": "https://pub.dev/api/archives/yx_scope-1.0.2.tar.gz",
    "archive_sha256": "af970025bcbc515bcb15203aa30bac6acbdf8ac80a69827e3d034cf1e8ce746d",
    "published": "2024-12-18T15:10:04.131857Z"
  },
  "versions": [
    {
      "version": "1.0.0",
      "pubspec": {
        "name": "yx_scope",
        "description": "Scope management for dependencies",
        "version": "1.0.0",
        "repository": "https://github.com/yandex/yx_scope/packages/yx_scope",
        "environment": {
          "sdk": "\u003E=2.19.0 \u003C4.0.0"
        },
        "dependencies": {
          "meta": "^1.8.0"
        },
        "dev_dependencies": {
          "test": "^1.16.0",
          "lints": "^2.0.1"
        }
      },
      "archive_url": "https://pub.dev/api/archives/yx_scope-1.0.0.tar.gz",
      "archive_sha256": "f03f130a5617c295720eb5113861bf791eeb0f10150dbc49f9829da90b59fa06",
      "published": "2024-10-23T07:36:03.200600Z"
    },
    {
      "version": "1.0.1",
      "pubspec": {
        "name": "yx_scope",
        "description": "A core package of the compile-safe DI framework with advanced scoping capabilities",
        "version": "1.0.1",
        "repository": "https://github.com/yandex/yx_scope/tree/main/packages/yx_scope",
        "environment": {
          "sdk": "\u003E=2.19.0 \u003C4.0.0"
        },
        "dependencies": {
          "meta": "^1.8.0"
        },
        "dev_dependencies": {
          "test": "^1.16.0",
          "lints": "^2.0.1"
        }
      },
      "archive_url": "https://pub.dev/api/archives/yx_scope-1.0.1.tar.gz",
      "archive_sha256": "3e6eea6dfc25d89ec14ce966cc45a9783be747f9770b898bc8cbd0e33034125d",
      "published": "2024-10-23T14:36:43.629352Z"
    },
    {
      "version": "1.0.2",
      "pubspec": {
        "name": "yx_scope",
        "description": "A core package of the compile-safe DI framework with advanced scoping capabilities",
        "version": "1.0.2",
        "repository": "https://github.com/yandex/yx_scope",
        "topics": [
          "di",
          "scope",
          "dependency-injection",
          "dependency-management"
        ],
        "environment": {
          "sdk": "\u003E=2.19.0 \u003C4.0.0"
        },
        "dependencies": {
          "meta": "^1.8.0"
        },
        "dev_dependencies": {
          "test": "^1.16.0",
          "lints": "^2.0.1"
        }
      },
      "archive_url": "https://pub.dev/api/archives/yx_scope-1.0.2.tar.gz",
      "archive_sha256": "af970025bcbc515bcb15203aa30bac6acbdf8ac80a69827e3d034cf1e8ce746d",
      "published": "2024-12-18T15:10:04.131857Z"
    }
  ]
}
```