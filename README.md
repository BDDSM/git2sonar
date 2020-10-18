# Git2Sonar - Выгрузка истории проекта GIT в SonarQube

## Кратко о проекте

Проект позволяет запустить анализ для SonarQube git-проекта по истории из git. Один из примеров использования 
- покоммитный анализ.

## Пример использования

Что нужно:
* `OneScript`
* Текущая библиотека
* `SonarScanner`
* Сервер `SonarQube`

Порядок действий:
1. Качаем Git-проект на 1C / OneScript для анализа
2. Устанавливаем библиотеку `git2sonar`, если ее нет:
```
opm install git2sonar
```
3. Если в переменной среды `PATH` нет пути к SonarScanner - то добавляем. Для проверки в консоли должна работать 
команда `sonarscanner`.
4. Выполняем команду:
```
git2sonar export ...
```

Например:

```sh
git2sonar export --project path/to/project --source src --key acc-export --url http://localhost:9000/ --token t_o_k_e_n --date 2020-01-01 --branch master
```
где:
* `--project` - путь до Git-проекта.
* `--source` - каталог с исходными кодами внутри проекта.
* `--key` - ключ проекта, по этому значению будет произведен поиск / создание проекта в SonarQube.
* `--url` - адрес сервера SonarQube.
* `--token` - токен доступа к SonarQube.
* `--date` - дата последнего анализа, с этой даты будет отфильтрована история Git-проекта.
* `--branch` - git ветка, из которой будут получены коммиты для анализа.

## Ограничения

* Анализируется только ветка `master`
* SonarScanner должен быть прописан в переменных среды в `PATH`

## Как вести разработку

Используется:
* Русский вариант синтаксиса
* Тестирование (пока не опубликовано)
* Разработка по `gitflow`

Прежде чем `кодить` нужно:
* Убедиться, что cуществует issue (или создать)
* Обсудить идею с владельцем проекта

## Лицензия

Используется лицензия [MIT License](LICENSE)