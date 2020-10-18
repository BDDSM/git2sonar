#Использовать "../../core"

Процедура ОписаниеКоманды(Команда) Экспорт
	
	Команда.Опция("project", "", "Путь к каталогу проекта Git")
	.ТСтрока()
	.Обязательный(Истина);
	
	Команда.Опция("source", "", "Каталоги исходных кодов")
	.ТСтрока()
	.Обязательный(Истина);
	
	Команда.Опция("key", "", "Ключ проекта SonarQube")
	.ТСтрока()
	.ВОкружении("GIT2SONAR_PROJECT_KEY")
	.Обязательный(Истина);
	
	Команда.Опция("url", "", "Адрес сервера SonarQube")
	.ТСтрока()
	.ВОкружении("GIT2SONAR_URL")
	.Обязательный(Истина);
	
	Команда.Опция("token", "", "Токен авторизации SonarQube")
	.ТСтрока()
	.ВОкружении("GIT2SONAR_TOKEN")
	.Обязательный(Истина);
	
	Команда.Опция("date", ТекущаяДата(), "Дата последнего анализа. По умолчанию используется текущая дата")
	.ТДата()
	.ВОкружении("GIT2SONAR_DATE")
	.Обязательный(Истина);

	Команда.Опция("branch", "master", "Git ветка проекта")
	.ТСтрока()
	.ВОкружении("GIT2SONAR_BRANCH");
	
КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт
	
	НастройкиЗапуска = Новый Структура;
	НастройкиЗапуска.Вставить("ПутьДоКаталогаПроекта", Команда.ЗначениеОпции("project"));
	НастройкиЗапуска.Вставить("КаталогиИсходныхКодов", Команда.ЗначениеОпции("source"));
	НастройкиЗапуска.Вставить("КлючПроекта", Команда.ЗначениеОпции("key"));
	НастройкиЗапуска.Вставить("АдресСонара", Команда.ЗначениеОпции("url"));
	НастройкиЗапуска.Вставить("ТокенСонара", Команда.ЗначениеОпции("token"));
	НастройкиЗапуска.Вставить("ДатаАнализа", Команда.ЗначениеОпции("date"));
	НастройкиЗапуска.Вставить("ВеткаПроекта", Команда.ЗначениеОпции("branch"));
	
	НастройкиЗапуска.ДатаАнализа = Формат(НастройкиЗапуска.ДатаАнализа, "ДФ=yyyy-MM-dd");
	
	Отказ = ВходящиеНастройкиУказаныКорректно(НастройкиЗапуска);
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыПриложения.Логирование().Отладка("Проект: " + НастройкиЗапуска.ПутьДоКаталогаПроекта);
	ПараметрыПриложения.Логирование().Отладка("Каталог исходных кодов: " + НастройкиЗапуска.КаталогиИсходныхКодов);
	ПараметрыПриложения.Логирование().Отладка("Ключ проекта: " + НастройкиЗапуска.КлючПроекта);
	ПараметрыПриложения.Логирование().Отладка("Адрес SonarQube: " + НастройкиЗапуска.АдресСонара);
	ПараметрыПриложения.Логирование().Отладка("Токен SonarQube: " + НастройкиЗапуска.ТокенСонара);
	ПараметрыПриложения.Логирование().Отладка("Дата последнего анализа: " + НастройкиЗапуска.ДатаАнализа);
	ПараметрыПриложения.Логирование().Отладка("Ветка проекта: " + НастройкиЗапуска.ВеткаПроекта);
	
	УправлениеАнализом.ЗапуститьМассовыйАнализ(НастройкиЗапуска);
	
КонецПроцедуры

Функция ВходящиеНастройкиУказаныКорректно(ВходящиеНастройки)
	Отказ = Ложь;
	
	Если ПустаяСтрока(ВходящиеНастройки.ПутьДоКаталогаПроекта) Тогда
		Сообщить("Не заполнен параметр `project`");
		Отказ = Истина;
	КонецЕсли;
	Файл = Новый Файл(ВходящиеНастройки.ПутьДоКаталогаПроекта);
	Если Не Файл.Существует() Тогда
		Сообщить("Каталог проекта из параметра`project` не существует");
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(ВходящиеНастройки.КаталогиИсходныхКодов) Тогда
		Сообщить("Не заполнен параметр `source`");
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(ВходящиеНастройки.КлючПроекта) Тогда
		Сообщить("Не заполнен параметр `key`");
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(ВходящиеНастройки.АдресСонара) Тогда
		Сообщить("Не заполнен параметр `url`");
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(ВходящиеНастройки.ТокенСонара) Тогда
		Сообщить("Не заполнен параметр `token`");
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(ВходящиеНастройки.ДатаАнализа) Тогда
		Сообщить("Не заполнен параметр `date`");
		Отказ = Истина;
	КонецЕсли;
	
	Возврат Отказ;
КонецФункции