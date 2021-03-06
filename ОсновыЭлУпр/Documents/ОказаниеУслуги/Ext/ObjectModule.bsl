
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ОстаткиМатериалов Расход
	Движения.ОстаткиМатериалов.Записывать = Истина;
	Для Каждого ТекСтрокаМатериалы Из Материалы Цикл
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Материал = ТекСтрокаМатериалы.Материал;
		Движение.Склад = Склад;
		Движение.Количество = ТекСтрокаМатериалы.Количество;
		//Движение.Регистратор = Ссылка; 
	КонецЦикла;
	Движения.Взаимозачеты.Записывать = Истина;
	Движение = Движения.Взаимозачеты.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Контрагент = Клиент;
	Движение.Сумма = ИтогПоДокументу;
	//Движение.Регистратор = Ссылка; 
		//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
			//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СебестоимостьТоваровОстатки.Номенклатура,
		|	СебестоимостьТоваровОстатки.СуммаОстаток КАК Сумма,
		|	СебестоимостьТоваровОстатки.КоличествоОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.СебестоимостьТоваров.Остатки (
		| &МоментВремени,
		| Номенклатура В 
		| ( ВЫБРАТЬ ОказаниеУслугиМатериалы.Материал
		| ИЗ Документ.ОказаниеУслуги.Материалы как ОказаниеУслугиМатериалы
		|  ГДЕ ОказаниеУслугиМатериалы.Ссылка = &Ссылка))
		| КАК СебестоимостьТоваровОстатки";
	
	Запрос.УстановитьПараметр("МоментВремени", МоментВремени());
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	
	СуммаСебестоимости = 0;
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Движения.СебестоимостьТоваров.Записывать = Истина;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СебестоимостьЕдиницы = ВыборкаДетальныеЗаписи.Сумма / ВыборкаДетальныеЗаписи.Количество;
		Движение = Движения.СебестоимостьТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Номенклатура = ВыборкаДетальныеЗаписи.Номенклатура;
		ТекСтр = Материалы.Найти(ВыборкаДетальныеЗаписи.Номенклатура, "Материал");
		Движение.Количество = ТекСтр.Количество;
		Движение.Сумма = СебестоимостьЕдиницы * ТекСтр.Количество;
		Движение.Регистратор = Ссылка; 		

		СуммаСебестоимости = СуммаСебестоимости + СебестоимостьЕдиницы * ТекСтр.Количество;
	КонецЦикла;
	
	Движения.РегистрБухУчет.Записывать = Истина;
	
	Проводка = Движения.РегистрБухУчет.Добавить();
	Проводка.Период = Дата;
	Проводка.СчетДт = ПланыСчетов.БухгалтерскийУчет.Покупатели;
	Проводка.СчетКт = ПланыСчетов.БухгалтерскийУчет.Выручка;
	Проводка.Сумма = ИтогПоДокументу;
	
	Движения.РегистрБухУчет.Записывать = Истина;
	
	Проводка = Движения.РегистрБухУчет.Добавить();
	Проводка.Период = Дата;
	Проводка.СчетДт = ПланыСчетов.БухгалтерскийУчет.Себестоимость;
	Проводка.СчетКт = ПланыСчетов.БухгалтерскийУчет.Товары;
	Проводка.Сумма = СуммаСебестоимости;

	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	//Движения.Записать();

	Если Режим = РежимПроведенияДокумента.Оперативный Тогда
			//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОстаткиМатериаловОстатки.Материал КАК Материал,
		|	ОстаткиМатериаловОстатки.Склад КАК Склад,
		|	ОстаткиМатериаловОстатки.КоличествоОстаток КАК КоличествоОстаток
		|ИЗ
		|	РегистрНакопления.ОстаткиМатериалов.Остатки (
		|,
		|Склад = &Склад
		| И Материал В
		| (ВЫБРАТЬ МатериалыМатериал.Материал из
		|  Документ.ОказаниеУслуги.Материалы как МатериалыМатериал
		| ГДЕ МатериалыМатериал.Ссылка = &Ссылка))
		|КАК ОстаткиМатериаловОстатки ГДЕ ОстаткиМатериаловОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	
	
	Если РезультатЗапроса.Пустой() Тогда
	иначе
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
		Сообщить("Недостаточно товара " + ВыборкаДетальныеЗаписи.Материал + " в количестве " + ВыборкаДетальныеЗаписи.КоличествоОстаток);
	КонецЦикла;
	
	КонецЕсли;

	конецесли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	ИтогПоДокументу = Материалы.Итог("Сумма") + ПереченьУслуг.Итог("Сумма");
КонецПроцедуры
