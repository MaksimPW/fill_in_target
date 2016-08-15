## Примеры

Написано для интерфейса на Русском языке.
Язык интерфейса можно поменять на сайте в настройках.

Для запуска задачи, нужно ввести:
```
rake :fill_in_target[:login,:password,:audience_name,:box_player,:box_payer,:all_conditions,:expand]
```
Где
* login(string) - Логин
* password(string) - Пароль
* audience_name(string) - Название аудитории
* box_player(true/false) - Опция: Все игравшие в платформе
* box_player(true/false) - Опция: Все платившие в платформе
* all_conditions(true/false) - Опция: Достигнуты все условия
* expand(true/false) - Опция: Расширить охват на другие устройства пользователя


## Что можно улучшить

* Файл secret.rb с приватными данными в .gitignore
* Сохрание сессии для rake task
* DRY
* Написать тесты для проверки всех параметров(сейчас проблемы с чтением из JS)
* Написать тесты для проверки данных из API(см. следующий)

* Получить API этого сайта и не использовать бот(костыль) :)
* и тд.


## Тесты

Для того, чтобы тесты проходили, необходимо ввести login и password в target_rake_spec.rb

```
rspec
```