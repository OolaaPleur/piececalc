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

  static m2(date) => "Вот мой месячный бэкап заданий за ${date} из PieceCalc.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addDoneWork" : MessageLookupByLibrary.simpleMessage("Добавить выполненную работу"),
    "addNewField" : MessageLookupByLibrary.simpleMessage("Добавить новое поле"),
    "addNewWork" : MessageLookupByLibrary.simpleMessage("Добавить новую работу"),
    "addWorksInSettings" : MessageLookupByLibrary.simpleMessage("Добавьте работы в настройках"),
    "amount" : MessageLookupByLibrary.simpleMessage("Количество"),
    "appName" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "april" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Апрель', other: 'Апреля')}"),
    "archiveHeader" : MessageLookupByLibrary.simpleMessage("Архив:"),
    "archiveThreeDotMenu" : MessageLookupByLibrary.simpleMessage("Архивировать"),
    "archivedWorksArentShowingInAddTaskWorkSuggestions" : MessageLookupByLibrary.simpleMessage("Архивированные работы не отображаются в предложениях добавления задачи."),
    "areYouSure" : MessageLookupByLibrary.simpleMessage("Вы уверены?"),
    "august" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Август', other: 'Августа')}"),
    "auto" : MessageLookupByLibrary.simpleMessage("Авто"),
    "backup" : MessageLookupByLibrary.simpleMessage("Резервная копия"),
    "backupOfMyData" : MessageLookupByLibrary.simpleMessage("Резервная копия моих данных"),
    "changeCurrency" : MessageLookupByLibrary.simpleMessage("Сменить валюту"),
    "changeLanguage" : MessageLookupByLibrary.simpleMessage("Сменить язык"),
    "chartGuideDaysOnTheXaxisMoneyEarnedOnThe" : MessageLookupByLibrary.simpleMessage("🔍 Гид по графику: дни на оси X, заработанные деньги на оси Y."),
    "commentForTask" : MessageLookupByLibrary.simpleMessage("Комментарий к задаче"),
    "couldNotLaunch" : MessageLookupByLibrary.simpleMessage("Не удалось запустить"),
    "dark" : MessageLookupByLibrary.simpleMessage("Тёмная"),
    "december" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Декабрь', other: 'Декабря')}"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteThreeDotMenu" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "done" : MessageLookupByLibrary.simpleMessage("Готово"),
    "earned" : MessageLookupByLibrary.simpleMessage("Цена"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Редактировать задачу"),
    "editWork" : MessageLookupByLibrary.simpleMessage("Редактировать работу"),
    "emailToMe" : MessageLookupByLibrary.simpleMessage("Есть вопросы? Напишите мне на электронную почту!"),
    "english" : MessageLookupByLibrary.simpleMessage("Английский"),
    "enterDate" : MessageLookupByLibrary.simpleMessage("Введите дату"),
    "error" : MessageLookupByLibrary.simpleMessage("Ошибка"),
    "estonian" : MessageLookupByLibrary.simpleMessage("Эстонский"),
    "february" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Февраль', other: 'Февраля')}"),
    "friday" : MessageLookupByLibrary.simpleMessage("Пятница"),
    "hereIsMyBackupFromPiececalc" : MessageLookupByLibrary.simpleMessage("Вот моя резервная копия из PieceCalc."),
    "homeBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Лента"),
    "hourWork" : MessageLookupByLibrary.simpleMessage("Работа по часам"),
    "hoursOnly" : m0,
    "introFifthScreenBody" : MessageLookupByLibrary.simpleMessage("Выберите свою атмосферу. Переключайтесь между светлыми и темными темами в соответствии с вашим настроением или окружением."),
    "introFifthScreenHeader" : MessageLookupByLibrary.simpleMessage("Светлый и темный режимы 🌓"),
    "introFirstScreenBody" : MessageLookupByLibrary.simpleMessage("Ваш незаменимый спутник для отслеживания и расчета результатов работы. Забудьте о том, как утомительно считать заработок — экономьте время с PieceCa(lc)."),
    "introFirstScreenHeader" : MessageLookupByLibrary.simpleMessage("Добро пожаловать в PieceCa(lc) 📊"),
    "introFourthScreenBody" : MessageLookupByLibrary.simpleMessage("Пользовательский интерфейс, разработанный с учетом вас. Перемещайтесь с легкостью и делайте больше."),
    "introFourthScreenHeader" : MessageLookupByLibrary.simpleMessage("Интуитивный дизайн 🎨"),
    "introSecondAndHalfScreenBody" : MessageLookupByLibrary.simpleMessage("С PieceCa(lc) ваши задачи автоматически сортируются по месяцам. Это делает проще просмотр и отслеживание вашего прогресса."),
    "introSecondAndHalfScreenHeader" : MessageLookupByLibrary.simpleMessage("Ежемесячная организация 📅"),
    "introSecondScreenBody" : MessageLookupByLibrary.simpleMessage("Рассчитайте объем выполненной работы одним касанием и мгновенно получите четкий, организованный обзор."),
    "introSecondScreenHeader" : MessageLookupByLibrary.simpleMessage("Мгновенный расчет работы 💹"),
    "introSixthScreenBody" : MessageLookupByLibrary.simpleMessage("Погрузитесь в PieceCa(lc) и начните делать ваш расчет работы более организованным и эффективным сегодня!"),
    "introSixthScreenHeader" : MessageLookupByLibrary.simpleMessage("Готовы начать? 🚀"),
    "introThirdScreenBody" : MessageLookupByLibrary.simpleMessage("Больше не бойтесь потери данных. Легко создавайте резервные копии всех ваших данных или конкретных задач из любого месяца."),
    "introThirdScreenHeader" : MessageLookupByLibrary.simpleMessage("Безопасное резервное копирование 🛡️"),
    "invalidFormat" : MessageLookupByLibrary.simpleMessage("Неверный формат"),
    "january" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Январь', other: 'Января')}"),
    "july" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Июль', other: 'Июля')}"),
    "june" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Июнь', other: 'Июня')}"),
    "light" : MessageLookupByLibrary.simpleMessage("Светлая"),
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
    "rateUsOnGooglePlay" : MessageLookupByLibrary.simpleMessage("Оцените нас в Google Play!"),
    "removeField" : MessageLookupByLibrary.simpleMessage("Удалить поле"),
    "russian" : MessageLookupByLibrary.simpleMessage("Русский"),
    "saturday" : MessageLookupByLibrary.simpleMessage("Суббота"),
    "save" : MessageLookupByLibrary.simpleMessage("Сохранить"),
    "selectColor" : MessageLookupByLibrary.simpleMessage("Выберите цвет"),
    "selectColorShade" : MessageLookupByLibrary.simpleMessage("Выберите оттенок"),
    "selectTime" : MessageLookupByLibrary.simpleMessage("Выберите время"),
    "selectedColorAndItsShades" : MessageLookupByLibrary.simpleMessage("Выбранный цвет и его оттенки"),
    "september" : MessageLookupByLibrary.simpleMessage("${Intl.plural(day, zero: 'Сентябрь', other: 'Сентября')}"),
    "settingsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "settingsChangeTheme" : MessageLookupByLibrary.simpleMessage("Сменить тему"),
    "shareMonthData" : MessageLookupByLibrary.simpleMessage("Поделиться данными за месяц"),
    "shareSubjectText" : m2,
    "somethingWentWrong" : MessageLookupByLibrary.simpleMessage("Что-то пошло не так. Пожалуйста, попробуйте еще раз."),
    "startTutorialAgain" : MessageLookupByLibrary.simpleMessage("Начать обучение заново"),
    "statsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Статистика"),
    "sunday" : MessageLookupByLibrary.simpleMessage("Воскресенье"),
    "tapToAddTask" : MessageLookupByLibrary.simpleMessage("Нажмите, чтобы добавить задачу"),
    "taskDeletion" : MessageLookupByLibrary.simpleMessage("Удаление задачи"),
    "tasksNotAddedYet" : MessageLookupByLibrary.simpleMessage("Задачи еще не добавлены, нажмите кнопку плюс внизу справа"),
    "thursday" : MessageLookupByLibrary.simpleMessage("Четверг"),
    "timeIsNotPicked" : MessageLookupByLibrary.simpleMessage("Время не выбрано"),
    "timeSpent" : MessageLookupByLibrary.simpleMessage("Потраченное время"),
    "totalEarned" : MessageLookupByLibrary.simpleMessage("Всего заработано"),
    "tuesday" : MessageLookupByLibrary.simpleMessage("Вторник"),
    "unarchiveThreeDotMenu" : MessageLookupByLibrary.simpleMessage("Разархивировать"),
    "wednesday" : MessageLookupByLibrary.simpleMessage("Среда"),
    "workAmount" : MessageLookupByLibrary.simpleMessage("Количество работы"),
    "workDeleted" : MessageLookupByLibrary.simpleMessage("Работа удалена"),
    "workDeletion" : MessageLookupByLibrary.simpleMessage("Удаление работы"),
    "workIsAlreadyUsedInTaskCantDelete" : MessageLookupByLibrary.simpleMessage("Работа уже используется в задаче. Удаление невозможно"),
    "workName" : MessageLookupByLibrary.simpleMessage("Название работы"),
    "worksHasntBeenArchivedYetToArchiveWorkTapThreedot" : MessageLookupByLibrary.simpleMessage("Работы ещё не архивированы. Чтобы архивировать работу, нажмите на трёхточечное меню в списке работ и выберите \'Архивировать\'."),
    "wouldYouLikeToDeleteThisTask" : MessageLookupByLibrary.simpleMessage("Вы хотите удалить эту задачу?"),
    "wouldYouLikeToDeleteThisWork" : MessageLookupByLibrary.simpleMessage("Вы хотите удалить эту работу?"),
    "yes" : MessageLookupByLibrary.simpleMessage("Да"),
    "yourFeedbackMotivatesMeToMakeTheAppEvenBetter" : MessageLookupByLibrary.simpleMessage("Ваш отзыв мотивирует меня сделать приложение еще лучше!")
  };
}
