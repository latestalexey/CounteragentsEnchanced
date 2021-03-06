﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПИК_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущаяДата = ТекущаяДатаСеанса();
	
КонецПроцедуры

&НаСервере
Процедура ПИК_ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_ОбработкаНавигационнойСсылки(НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	ПользовательскиеНастройки = ПользовательскиеНастройкиДляРасшифровки(ЭтотОбъект);
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	
	НастройкаОтбора = ПользовательскиеНастройки.Элементы.Добавить(Тип("ОтборКомпоновкиДанных"));
	НастройкаОтбора.ИдентификаторПользовательскойНастройки = "Отбор";
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(НастройкаОтбора, "Контрагент", ТекущиеДанные.Ссылка, ВидСравненияКомпоновкиДанных.Равно);
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("РежимРасшифровки",          Истина);
	ПараметрыОтчета.Вставить("ВидРасшифровки",            2);
	ПараметрыОтчета.Вставить("ПользовательскиеНастройки", ПользовательскиеНастройки);
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗадолженностьПоставщикам" Тогда
		ДополнительныеСвойства.Вставить("КлючВарианта", "ЗадолженностьПоставщикам");
		ОткрытьФорму("Отчет.ЗадолженностьПоставщикам.Форма.ФормаОтчета", ПараметрыОтчета, ЭтотОбъект);
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "ЗадолженностьПокупателей" Тогда
		ДополнительныеСвойства.Вставить("КлючВарианта", "ЗадолженностьПокупателей");
		ОткрытьФорму("Отчет.ЗадолженностьПокупателей.Форма.ФормаОтчета", ПараметрыОтчета, ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПИК_СоздатьСчетПокупателю(Команда)
	
	СоздатьДокумент("СчетНаОплатуПокупателю");
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_СоздатьРеализацию(Команда)
	
	СоздатьДокумент("РеализацияТоваровУслуг");
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_СоздатьАктОказанияУслуг(Команда)
	
	СоздатьДокумент("АктОбОказанииПроизводственныхУслуг");
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_СоздатьПоступлениеТоваровУслуг(Команда)
	
	СоздатьДокумент("ПоступлениеТоваровУслуг");
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_СоздатьАктСверкиВзаиморасчетов(Команда)
	
	СоздатьДокумент("АктСверкиВзаиморасчетов");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПИК_ДекорацияДокументыНажатие(Элемент)

	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Новый Структура("Контрагент", ТекущиеДанные.Ссылка));
	ПараметрыФормы.Вставить("КлючНазначенияИспользования", "ДокументыПоКонтрагенту");
	
	ОткрытьФорму("ЖурналДокументов.ЖурналОпераций.Форма.ФормаСписка", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_СписокПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ПриАктивизацииСтроки", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_ДекорацияРазвернутьНажатие(Элемент)
	
	СвернутьПанель = НЕ СвернутьПанель;
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура ПИК_ДекорацияСвернутьНажатие(Элемент)
	
	СвернутьПанель = НЕ СвернутьПанель;
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриАктивизацииСтроки()
	
	Если СвернутьПанель Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РазместитьДанныеКонтрагента(ТекущиеДанные.Ссылка, ТекущиеДанные.ЭтоГруппа);
	
КонецПроцедуры

&НаСервере
Процедура РазместитьДанныеКонтрагента(Знач Контрагент, Знач ЭтоГруппа)
	
	ДанныеКонтрагента = ДанныеДляЗаполненияПоКонтрагенту(Контрагент);
	Если ЭтоГруппа Тогда
		Элементы.ДекорацияНаименованиеПолное.Заголовок = Контрагент;
	Иначе
		Элементы.ДекорацияНаименованиеПолное.Заголовок = ДанныеКонтрагента.НаименованиеПолное;
	КонецЕсли;
	Элементы.ДекорацияДолгНам.Заголовок = НадписьВзаиморасчетов(ДанныеКонтрагента.Дебиторка, "Дт");
	Элементы.ДекорацияДолгНаш.Заголовок = НадписьВзаиморасчетов(ДанныеКонтрагента.Кредиторка, "Кт");
	
	Если ПустаяСтрока(ДанныеКонтрагента.ИНН) Тогда
		Элементы.ДекорацияИНН.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияИНН.Видимость = Истина;
		Элементы.ДекорацияИНН.Заголовок = СтрШаблон(НСтр("ru='ИНН: %1'"), СокрЛП(ДанныеКонтрагента.ИНН));
	КонецЕсли;
	
	Если ПустаяСтрока(ДанныеКонтрагента.КПП) Тогда
		Элементы.ДекорацияКПП.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияКПП.Видимость = Истина;
		Элементы.ДекорацияКПП.Заголовок = СтрШаблон(НСтр("ru='КПП: %1'"), СокрЛП(ДанныеКонтрагента.КПП));
	КонецЕсли;
	
	Если ПустаяСтрока(ДанныеКонтрагента.Адрес) Тогда
		Элементы.ДекорацияАдрес.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияАдрес.Видимость = Истина;
		Элементы.ДекорацияАдрес.Заголовок = СтрШаблон(НСтр("ru='Юр. адрес: %1'"), СокрЛП(ДанныеКонтрагента.Адрес));
	КонецЕсли;
	
	Если ПустаяСтрока(ДанныеКонтрагента.Телефон) Тогда
		Элементы.ДекорацияТелефон.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияТелефон.Видимость = Истина;
		Элементы.ДекорацияТелефон.Заголовок = СтрШаблон(НСтр("ru='Телефон: %1'"), ДанныеКонтрагента.Телефон);
	КонецЕсли;

	Если ПустаяСтрока(ДанныеКонтрагента.Емаил) Тогда
		Элементы.ДекорацияЕмаил.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияЕмаил.Видимость = Истина;
		Элементы.ДекорацияЕмаил.Заголовок = СтрШаблон(НСтр("ru='E-mail: %1'"), ДанныеКонтрагента.Емаил);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СвернутьРазвернутьПанель(СвернутьПанель)
	
	Если СвернутьПанель Тогда
		Элементы.ПанельИнформации.Видимость = Ложь;
		Элементы.ГруппаЗаглушка.Видимость   = Истина;
	Иначе
		Элементы.ПанельИнформации.Видимость = Истина;
		Элементы.ГруппаЗаглушка.Видимость   = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеДляЗаполненияПоКонтрагенту(Знач Контрагент)
	
	ДанныеКонтрагента = Новый Структура;
	ДанныеКонтрагента.Вставить("НаименованиеПолное", "Полное наименование");
	ДанныеКонтрагента.Вставить("ИНН",                "");
	ДанныеКонтрагента.Вставить("КПП",                "");
	ДанныеКонтрагента.Вставить("Дебиторка",          0);
	ДанныеКонтрагента.Вставить("Кредиторка",         0);
	ДанныеКонтрагента.Вставить("Адрес",              "");
	ДанныеКонтрагента.Вставить("Телефон",            "");
	ДанныеКонтрагента.Вставить("Емаил",              "");
	
	СчетаУчетаРасчетовПокупателей = БухгалтерскиеОтчеты.СчетаУчетаРасчетовПокупателей();
	СчетаУчетаРасчетовПоставщиков = БухгалтерскиеОтчеты.СчетаУчетаРасчетовПоставщиков();
	
	МассивСчетов = Новый Массив;
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСчетов, СчетаУчетаРасчетовПокупателей.СчетаСДокументомРасчетов, Истина);
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСчетов, СчетаУчетаРасчетовПокупателей.СчетаБезДокументаРасчетов, Истина);
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСчетов, СчетаУчетаРасчетовПоставщиков.СчетаСДокументомРасчетов, Истина);
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСчетов, СчетаУчетаРасчетовПоставщиков.СчетаБезДокументаРасчетов, Истина);
	
	АналитикаРасчетов = Новый Массив;
	АналитикаРасчетов.Добавить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Контрагенты);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.УстановитьПараметр("СчетаРасчетовСКонтрагентом", МассивСчетов);
	Запрос.УстановитьПараметр("АналитикаРасчетов", АналитикаРасчетов);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Хозрасчетный.Ссылка
	|ПОМЕСТИТЬ СчетаУчетаРасчетов
	|ИЗ
	|	ПланСчетов.Хозрасчетный КАК Хозрасчетный
	|ГДЕ
	|	Хозрасчетный.Ссылка В(&СчетаРасчетовСКонтрагентом)
	| И НЕ Хозрасчетный.Валютный
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Контрагенты.Ссылка,
	|	Контрагенты.ИНН,
	|	Контрагенты.КПП,
	|	Контрагенты.НаименованиеПолное
	|ПОМЕСТИТЬ ВТКонтрагенты
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.Ссылка = &Контрагент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КонтрагентыКонтактнаяИнформация.Ссылка КАК Ссылка,
	|	КонтрагентыКонтактнаяИнформация.Представление КАК Адрес
	|ПОМЕСТИТЬ ЮридическийАдрес
	|ИЗ
	|	Справочник.Контрагенты.КонтактнаяИнформация КАК КонтрагентыКонтактнаяИнформация
	|ГДЕ
	|	КонтрагентыКонтактнаяИнформация.Ссылка = &Контрагент
	|	И КонтрагентыКонтактнаяИнформация.ВидДляСписка = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ЮрАдресКонтрагента)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КонтрагентыКонтактнаяИнформация.Ссылка КАК Ссылка,
	|	КонтрагентыКонтактнаяИнформация.Представление КАК Емаил
	|ПОМЕСТИТЬ АдресаЭлектроннойПочты
	|ИЗ
	|	Справочник.Контрагенты.КонтактнаяИнформация КАК КонтрагентыКонтактнаяИнформация
	|ГДЕ
	|	КонтрагентыКонтактнаяИнформация.Ссылка = &Контрагент
	|	И КонтрагентыКонтактнаяИнформация.ВидДляСписка = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.EmailКонтрагенты)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КонтрагентыКонтактнаяИнформация.Ссылка КАК Ссылка,
	|	КонтрагентыКонтактнаяИнформация.Представление КАК Телефон
	|ПОМЕСТИТЬ НомераТелефонов
	|ИЗ
	|	Справочник.Контрагенты.КонтактнаяИнформация КАК КонтрагентыКонтактнаяИнформация
	|ГДЕ
	|	КонтрагентыКонтактнаяИнформация.Ссылка = &Контрагент
	|	И КонтрагентыКонтактнаяИнформация.ВидДляСписка = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ТелефонКонтрагента)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕстьNull(ХозрасчетныйОстатки.СуммаОстатокДт, 0) КАК Дебиторка,
	|	ЕстьNull(ХозрасчетныйОстатки.СуммаОстатокКт, 0) КАК Кредиторка,
	|	ВТКонтрагенты.НаименованиеПолное,
	|	ВТКонтрагенты.ИНН,
	|	ВТКонтрагенты.КПП,
	|	ВТКонтрагенты.Ссылка КАК Контрагент,
	|	АдресаЭлектроннойПочты.Емаил,
	|	НомераТелефонов.Телефон,
	|	ЮридическийАдрес.Адрес
	|ИЗ
	|	ВТКонтрагенты КАК ВТКонтрагенты
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрБухгалтерии.Хозрасчетный.Остатки(
	|				,
	|				Счет В ИЕРАРХИИ
	|					(ВЫБРАТЬ
	|						СчетаУчетаРасчетов.Ссылка
	|					ИЗ
	|						СчетаУчетаРасчетов КАК СчетаУчетаРасчетов),
	|				&АналитикаРасчетов,
	|				Субконто1 = &Контрагент) КАК ХозрасчетныйОстатки
	|		ПО ВТКонтрагенты.Ссылка = ХозрасчетныйОстатки.Субконто1
	|		ЛЕВОЕ СОЕДИНЕНИЕ АдресаЭлектроннойПочты КАК АдресаЭлектроннойПочты
	|		ПО ВТКонтрагенты.Ссылка = АдресаЭлектроннойПочты.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ НомераТелефонов КАК НомераТелефонов
	|		ПО ВТКонтрагенты.Ссылка = НомераТелефонов.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЮридическийАдрес КАК ЮридическийАдрес
	|		ПО ВТКонтрагенты.Ссылка = ЮридическийАдрес.Ссылка";
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ЗаполнитьЗначенияСвойств(ДанныеКонтрагента, Выборка);
	КонецЕсли;
	
	Возврат ДанныеКонтрагента;
	
КонецФункции

&НаСервереБезКонтекста
Функция НадписьВзаиморасчетов(Знач Сумма, Знач ДтКт)
	
	КрупныйШрифт = Новый Шрифт(,11);
	МелкийШрифт = Новый Шрифт(,8);
	
	КомпонентыФС = Новый Массив;
	Если ДтКт = "Кт" Тогда
		КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Мы должны'") + " ", КрупныйШрифт));
		СсылкаНаОтчет = "ЗадолженностьПоставщикам";
	Иначе
		КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Должен нам'") + " ", КрупныйШрифт));
		СсылкаНаОтчет = "ЗадолженностьПокупателей";
	КонецЕсли;
	
	СуммаСтрокой = Формат(Сумма, "ЧДЦ=2; ЧРД=,; ЧРГ=' '; ЧН=0,00");
	ПозицияРазделителя = СтрНайти(СуммаСтрокой, ",");
	КомпонентыЧисла = Новый Массив;
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Лев(СуммаСтрокой, ПозицияРазделителя), КрупныйШрифт));
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Сред(СуммаСтрокой, ПозицияРазделителя+1), МелкийШрифт));
	КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(КомпонентыЧисла, , , , СсылкаНаОтчет));
	КомпонентыФС.Добавить(" " + Константы.ВалютаРегламентированногоУчета.Получить());
	
	Возврат Новый ФорматированнаяСтрока(КомпонентыФС, , ЦветаСтиля.ТекстВторостепеннойНадписи);
	
КонецФункции

&НаКлиенте
Функция ПользовательскиеНастройкиДляРасшифровки(Форма)
	
	НачалоПериода = НачалоМесяца(Форма.ТекущаяДата);
	КонецПериода = Форма.ТекущаяДата;
	
	// Инициализация пользовательских настроек
	// Добавим в настройки все параметры которые могут использоваться в отчетах руководителю
	ПользовательскиеНастройки = Новый ПользовательскиеНастройкиКомпоновкиДанных;
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РежимРасшифровки", Истина);
	ДополнительныеСвойства.Вставить("Организация",      Неопределено);
	ДополнительныеСвойства.Вставить("НачалоПериода",    НачалоПериода);
	ДополнительныеСвойства.Вставить("КонецПериода",     КонецПериода);
	ДополнительныеСвойства.Вставить("Период",           Форма.ТекущаяДата);
	
	Возврат ПользовательскиеНастройки;
	
КонецФункции

&НаКлиенте
Процедура СоздатьДокумент(ИмяДокумента)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Контрагент", ТекущиеДанные.Ссылка);
	СтруктураПараметров = Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ИмяФормыДокумента = СтрШаблон("Документ.%1.ФормаОбъекта", ИмяДокумента);
	ОткрытьФорму(ИмяФормыДокумента, СтруктураПараметров, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти