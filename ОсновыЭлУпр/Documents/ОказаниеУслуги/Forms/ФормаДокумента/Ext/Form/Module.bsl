﻿
&НаКлиенте
Процедура ПереченьУслугКоличествоПриИзменении(Элемент)
	СтрокаТабличнойЧасти = Элементы.ПереченьУслуг.ТекущиеДанные;
	РаботаСДокументами.РассчитатьСумму(СтрокаТабличнойЧасти);
КонецПроцедуры

&НаКлиенте
Процедура ПереченьУслугЦенаПриИзменении(Элемент)
	СтрокаТабличнойЧасти = Элементы.ПереченьУслуг.ТекущиеДанные;
	РаботаСДокументами.РассчитатьСумму(СтрокаТабличнойЧасти);
КонецПроцедуры

&НаКлиенте
Процедура МатериалыКоличествоПриИзменении(Элемент)
	СтрокаТабличнойЧасти = Элементы.Материалы.ТекущиеДанные;
	РаботаСДокументами.РассчитатьСумму(СтрокаТабличнойЧасти);
КонецПроцедуры

&НаКлиенте
Процедура МатериалыЦенаПриИзменении(Элемент)
	СтрокаТабличнойЧасти = Элементы.Материалы.ТекущиеДанные;
	РаботаСДокументами.РассчитатьСумму(СтрокаТабличнойЧасти);
КонецПроцедуры

//&НаКлиенте
//Процедура МатериалыМатериалПриИзменении(Элемент)
//	СтрокаТабличнойЧасти = Элементы.Материалы.ТекущиеДанные;
//	//СтрокаТабличнойЧасти.Цена = РаботаСоСправочниками.РозничнаяЦена(Объект.Дата, СтрокаТабличнойЧасти.Материал);
//	РаботаСДокументами.РассчитатьСумму(СтрокаТабличнойЧасти);
//КонецПроцедуры
