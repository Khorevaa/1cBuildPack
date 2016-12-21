#Использовать v8runner

Функция ОбернутьВКавычки(Знач Строка);
	Если Лев(Строка, 1) = """" и Прав(Строка, 1) = """" Тогда
		Возврат Строка;
	Иначе
		Возврат """" + Строка + """";
	КонецЕсли;
КонецФункции

_текущийКаталог = ТекущийКаталог();
_каталогБазыРазработки = _текущийКаталог+"\1cbases\develop";
_ванессаБихавиорОбработка = "c:/repo/vanessa-behavior/vanessa-behavior.epf";

УстановитьТекущийКаталог(_текущийКаталог);

УдалитьФайлы("./allurereport","*.xml");
УдалитьФайлы("./allurereport/allure-report");

Конфигуратор = Новый УправлениеКонфигуратором();
Конфигуратор.УстановитьКонтекст("/F"+_каталогБазыРазработки, "admin", "");
Конфигуратор.ЗапуститьВРежимеПредприятия(,Истина,СтрШаблон(" /Execute "+_ванессаБихавиорОбработка+" /C %1", ОбернутьВКавычки("StartFeaturePlayer;VBParams="+_текущийКаталог+"\autotest.json")));

ЗапуститьПриложение("allure generate ./allurereport -o ./allurereport/allure-report", ,Истина);
ЗапуститьПриложение("allure report open -o ./allurereport/allure-report", ,Истина);