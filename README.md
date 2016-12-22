# 1cBuildPack #

Набор скриптов для сборки конфигурации из ЧАСТИ XML-файлов, которые были получены при выгрузке конфигурации в файлы XML. В репозитории хранится не вся конфигурация (т.к. даже не самые сложные в XML весят 700+ Мб), а только те файлы, которые были затронуты доработками.

### Приблизительные сферы применения ###

* хранение в репозиториях только изменений конфигурации без выкладки типового кода 1С (даже небольшие конфигурации типа УНФ весят 700+ Мб в XML)
* автоматическое формирование частичных сборок для передачи внешним подрядчикам
* тестирование итоговых сборок

### Требует ###

* [Git](https://git-scm.com/)
* [Allure](https://github.com/allure-framework/allure1/releases)
* [OneScript](http://oscript.io/)

### Тестовый запуск ###

* setup.os - качает tools и деморепозиторий. 

Детали: Качает [BDDEditor](https://github.com/silverbulleters/vanessa-bdd-editor), [Behavior](https://github.com/silverbulleters/vanessa-behavior), [OneScript](https://github.com/EvilBeaver/oscript-library) и [деморепозиторий](https://github.com/cybjavax/vanessa-bootstrap-1cBuildPackTemplate), создает файлы .json для автозапуска автотестов из командной строки.

* testclone.os - запускает сборку конфигурации из репозитория, формирует отчет о сравнении, запускает тесты.

Детали: Создает папку testclone, клонирует туда репозиторий, создает пустую базу из базы setup.dt, раскладывает ее на XML, сливает в эту папку XML с репозитория, загружают то, что получилось в конфигурацию, после дополнительно (чтобы исключить мусор, генерируемый платформой при выгрузке-загрузке XML) точечно с помощью файла MеrgeSettings.xml загружаются изменения в базу testclone/develop. После чего запускается сравнение базы разработки и собранной таким образом базы, отчет о расхождениях складывается в develop. Потом запускаются тесты vanessa-behavior и отчет выводится через allure report.

### Краткое видео демо testclone.os ###

Собирается самописная конфигурация, часть есть в базе разработки develop/1cbases/develop, а изменения к ней лежат в репозитории develop/src.

Видео (~1 мин): (https://yadi.sk/i/V22Y9nq634LgMp)

### Ограничения ###

* Тестировался на 1С 8.3.9
* Во всех базах должен быть пользователь admin с пустым паролем
* Пока разработан и тестировался только для файловых баз
* Быстродействие, демо делалось на пустой конфигурации 1С с небольшими изменениями (2 справочника, 2 документа), поэтому на видео все быстро. На рабочем проекте на УНФ 1.6 аналогичная операция занимает около 15 минут на SSD. Ближайшая точка оптимизации - заранее подготовить выгруженные XML типовой конфигурации и не выгружать их при каждой сборке, а просто копировать, как setup.dt.
