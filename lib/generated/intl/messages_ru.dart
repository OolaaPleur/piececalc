// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(count) => "${Intl.plural(count, zero: '0 часов', one: '1 час', few: '${count} часа', many: '${count} часов', other: '${count} часов')}";

  static m1(count) => "${Intl.plural(count, zero: '0 минут', one: '1 минута', few: '${count} минуты', many: '${count} минут', other: '${count} минут')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addDoneWork" : MessageLookupByLibrary.simpleMessage("Добавить выполненную работу"),
    "addNewField" : MessageLookupByLibrary.simpleMessage("Добавить новое поле"),
    "addNewWork" : MessageLookupByLibrary.simpleMessage("Добавить новую работу"),
    "addWorksInSettings" : MessageLookupByLibrary.simpleMessage("Добавьте работы в настройках"),
    "amount" : MessageLookupByLibrary.simpleMessage("Количество"),
    "appName" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "april" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Апрель', other: 'Апреля')}"),
    "august" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Август', other: 'Августа')}"),
    "backup" : MessageLookupByLibrary.simpleMessage("Резервная копия"),
    "changeCurrency" : MessageLookupByLibrary.simpleMessage("Сменить валюту"),
    "changeLanguage" : MessageLookupByLibrary.simpleMessage("Сменить язык"),
    "december" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Декабрь', other: 'Декабря')}"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "earned" : MessageLookupByLibrary.simpleMessage("Цена"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Редактировать задачу"),
    "emailToMe" : MessageLookupByLibrary.simpleMessage("Написать мне на почту!"),
    "english" : MessageLookupByLibrary.simpleMessage("Английский"),
    "enterDate" : MessageLookupByLibrary.simpleMessage("Введите дату"),
    "error" : MessageLookupByLibrary.simpleMessage("Ошибка"),
    "estonian" : MessageLookupByLibrary.simpleMessage("Эстонский"),
    "february" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Февраль', other: 'Февраля')}"),
    "friday" : MessageLookupByLibrary.simpleMessage("Пятница"),
    "homeBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Лента"),
    "hourWork" : MessageLookupByLibrary.simpleMessage("Работа по часам"),
    "hoursOnly" : m0,
    "invalidFormat" : MessageLookupByLibrary.simpleMessage("Неверный формат"),
    "january" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Январь', other: 'Января')}"),
    "july" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Июль', other: 'Июля')}"),
    "june" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Июнь', other: 'Июня')}"),
    "march" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Март', other: 'Марта')}"),
    "may" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Май', other: 'Мая')}"),
    "minutesOnly" : m1,
    "monday" : MessageLookupByLibrary.simpleMessage("Понедельник"),
    "no" : MessageLookupByLibrary.simpleMessage("Нет"),
    "noDataForThisMonth" : MessageLookupByLibrary.simpleMessage("Данные за этот месяц отсутствуют"),
    "noWorkHasBeenAdded" : MessageLookupByLibrary.simpleMessage("Работы не добавлены. Чтобы добавить новую работу \n1) Перейдите в Настройки \n2) Нажмите \'Добавить новую работу\'"),
    "noneCurrencyPicked" : MessageLookupByLibrary.simpleMessage("Валюта не выбрана"),
    "november" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Ноябрь', other: 'Ноября')}"),
    "october" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Октябрь', other: 'Октября')}"),
    "orPressThisButton" : MessageLookupByLibrary.simpleMessage("Или нажмите эту кнопку"),
    "pieceWork" : MessageLookupByLibrary.simpleMessage("Работа за единицу"),
    "piececalc" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "pleaseEnterAPrice" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите цену"),
    "pleaseEnterAValidNumber" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите корректное число"),
    "pleaseEnterAnAmount" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите количество"),
    "pleaseEnterDate" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите дату"),
    "pleaseEnterValidWorkName" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите корректное название работы"),
    "pleaseEnterWorkName" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите название работы"),
    "priceForOneHour" : MessageLookupByLibrary.simpleMessage("Цена за один час работы"),
    "priceForOnePiece" : MessageLookupByLibrary.simpleMessage("Цена за единицу"),
    "removeField" : MessageLookupByLibrary.simpleMessage("Удалить поле"),
    "russian" : MessageLookupByLibrary.simpleMessage("Русский"),
    "saturday" : MessageLookupByLibrary.simpleMessage("Суббота"),
    "save" : MessageLookupByLibrary.simpleMessage("Сохранить"),
    "selectTime" : MessageLookupByLibrary.simpleMessage("Выберите время"),
    "september" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Сентябрь', other: 'Сентября')}"),
    "settingsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsChangeTheme" : MessageLookupByLibrary.simpleMessage("Сменить тему"),
    "shareMonthData" : MessageLookupByLibrary.simpleMessage("Поделиться данными за месяц"),
    "somethingWentWrong" : MessageLookupByLibrary.simpleMessage("Что-то пошло не так. Пожалуйста, попробуйте еще раз."),
    "statsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Статистика"),
    "sunday" : MessageLookupByLibrary.simpleMessage("Воскресенье"),
    "tapToAddTask" : MessageLookupByLibrary.simpleMessage("Нажмите, чтобы добавить задачу"),
    "taskDeletion" : MessageLookupByLibrary.simpleMessage("Удаление задачи"),
    "tasksNotAddedYet" : MessageLookupByLibrary.simpleMessage("Задачи еще не добавлены, нажмите кнопку плюс внизу справа"),
    "thursday" : MessageLookupByLibrary.simpleMessage("Четверг"),
    "timeIsNotPicked" : MessageLookupByLibrary.simpleMessage("Время не выбрано"),
    "timeSpent" : MessageLookupByLibrary.simpleMessage("Потраченное время"),
    "tuesday" : MessageLookupByLibrary.simpleMessage("Вторник"),
    "wednesday" : MessageLookupByLibrary.simpleMessage("Среда"),
    "workAmount" : MessageLookupByLibrary.simpleMessage("Количество работы"),
    "workDeleted" : MessageLookupByLibrary.simpleMessage("Работа удалена"),
    "workDeletion" : MessageLookupByLibrary.simpleMessage("Удаление работы"),
    "workIsAlreadyUsedInTaskCantDelete" : MessageLookupByLibrary.simpleMessage("Работа уже используется в задаче. Удаление невозможно"),
    "workName" : MessageLookupByLibrary.simpleMessage("Название работы"),
    "wouldYouLikeToDeleteThisTask" : MessageLookupByLibrary.simpleMessage("Вы хотите удалить эту задачу?"),
    "wouldYouLikeToDeleteThisWork" : MessageLookupByLibrary.simpleMessage("Вы хотите удалить эту работу?"),
    "yes" : MessageLookupByLibrary.simpleMessage("Да")
  };
}
