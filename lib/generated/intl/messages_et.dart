// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a et locale. All the
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
  String get localeName => 'et';

  static m0(count) => "${Intl.plural(count, zero: '0 tundi', one: '1 tund', other: '${count} tundi')}";

  static m1(count) => "${Intl.plural(count, zero: '0 minutit', one: '1 minut', other: '${count} minutit')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addDoneWork" : MessageLookupByLibrary.simpleMessage("Lisa tehtud töö"),
    "addNewField" : MessageLookupByLibrary.simpleMessage("Lisa uus väli"),
    "addNewWork" : MessageLookupByLibrary.simpleMessage("Lisa uus töö"),
    "addWorksInSettings" : MessageLookupByLibrary.simpleMessage("Lisage töid seadetes"),
    "amount" : MessageLookupByLibrary.simpleMessage("Kogus"),
    "appName" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "april" : MessageLookupByLibrary.simpleMessage("Aprill"),
    "august" : MessageLookupByLibrary.simpleMessage("August"),
    "backup" : MessageLookupByLibrary.simpleMessage("Varukoopia"),
    "changeCurrency" : MessageLookupByLibrary.simpleMessage("Muuda valuutat"),
    "changeLanguage" : MessageLookupByLibrary.simpleMessage("Muuda keelt"),
    "december" : MessageLookupByLibrary.simpleMessage("Detsember"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Kustuta"),
    "earned" : MessageLookupByLibrary.simpleMessage("Hind"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Muuda ülesannet"),
    "emailToMe" : MessageLookupByLibrary.simpleMessage("Saada mulle e-kiri!"),
    "english" : MessageLookupByLibrary.simpleMessage("Inglise"),
    "enterDate" : MessageLookupByLibrary.simpleMessage("Sisestage kuupäev"),
    "error" : MessageLookupByLibrary.simpleMessage("Viga"),
    "estonian" : MessageLookupByLibrary.simpleMessage("Eesti"),
    "february" : MessageLookupByLibrary.simpleMessage("Veebruar"),
    "friday" : MessageLookupByLibrary.simpleMessage("Reede"),
    "homeBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Ajajoon"),
    "hourWork" : MessageLookupByLibrary.simpleMessage("Tunnitöö"),
    "hoursOnly" : m0,
    "invalidFormat" : MessageLookupByLibrary.simpleMessage("Vigane formaat"),
    "january" : MessageLookupByLibrary.simpleMessage("Jaanuar"),
    "july" : MessageLookupByLibrary.simpleMessage("Juuli"),
    "june" : MessageLookupByLibrary.simpleMessage("Juuni"),
    "march" : MessageLookupByLibrary.simpleMessage("Märts"),
    "may" : MessageLookupByLibrary.simpleMessage("Mai"),
    "minutesOnly" : m1,
    "monday" : MessageLookupByLibrary.simpleMessage("Esmaspäev"),
    "no" : MessageLookupByLibrary.simpleMessage("Ei"),
    "noDataForThisMonth" : MessageLookupByLibrary.simpleMessage("Selle kuu andmed puuduvad"),
    "noWorkHasBeenAdded" : MessageLookupByLibrary.simpleMessage("Töid ei ole lisatud. Uue töö lisamiseks \n1) Minge Seadetesse \n2) Klõpsake \'Lisa uus töö\'"),
    "noneCurrencyPicked" : MessageLookupByLibrary.simpleMessage("Valikut pole tehtud"),
    "november" : MessageLookupByLibrary.simpleMessage("November"),
    "october" : MessageLookupByLibrary.simpleMessage("Oktoober"),
    "orPressThisButton" : MessageLookupByLibrary.simpleMessage("Või vajutage seda nuppu"),
    "pieceWork" : MessageLookupByLibrary.simpleMessage("Tükktöö"),
    "piececalc" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "pleaseEnterAPrice" : MessageLookupByLibrary.simpleMessage("Palun sisestage hind"),
    "pleaseEnterAValidNumber" : MessageLookupByLibrary.simpleMessage("Palun sisestage kehtiv number"),
    "pleaseEnterAnAmount" : MessageLookupByLibrary.simpleMessage("Palun sisestage summa"),
    "pleaseEnterDate" : MessageLookupByLibrary.simpleMessage("Palun sisestage kuupäev"),
    "pleaseEnterValidWorkName" : MessageLookupByLibrary.simpleMessage("Palun sisestage kehtiv töö nimi"),
    "pleaseEnterWorkName" : MessageLookupByLibrary.simpleMessage("Palun sisestage töö nimi"),
    "priceForOneHour" : MessageLookupByLibrary.simpleMessage("Hind ühe töötunni eest"),
    "priceForOnePiece" : MessageLookupByLibrary.simpleMessage("Hind ühe tüki eest"),
    "removeField" : MessageLookupByLibrary.simpleMessage("Eemalda väli"),
    "russian" : MessageLookupByLibrary.simpleMessage("Vene"),
    "saturday" : MessageLookupByLibrary.simpleMessage("Laupäev"),
    "save" : MessageLookupByLibrary.simpleMessage("Salvesta"),
    "selectTime" : MessageLookupByLibrary.simpleMessage("Vali aeg"),
    "september" : MessageLookupByLibrary.simpleMessage("September"),
    "settingsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Seaded"),
    "settingsChangeTheme" : MessageLookupByLibrary.simpleMessage("Muuda teemat"),
    "shareMonthData" : MessageLookupByLibrary.simpleMessage("Jaga kuu andmeid"),
    "somethingWentWrong" : MessageLookupByLibrary.simpleMessage("Midagi läks valesti. Palun proovige uuesti."),
    "statsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Statistika"),
    "sunday" : MessageLookupByLibrary.simpleMessage("Pühapäev"),
    "tapToAddTask" : MessageLookupByLibrary.simpleMessage("Klõpsake ülesande lisamiseks"),
    "taskDeletion" : MessageLookupByLibrary.simpleMessage("Ülesande kustutamine"),
    "tasksNotAddedYet" : MessageLookupByLibrary.simpleMessage("Ülesandeid pole veel lisatud, vajutage paremal all nuppu pluss"),
    "thursday" : MessageLookupByLibrary.simpleMessage("Neljapäev"),
    "timeIsNotPicked" : MessageLookupByLibrary.simpleMessage("Aega ei ole valitud"),
    "timeSpent" : MessageLookupByLibrary.simpleMessage("Kulutatud aeg"),
    "tuesday" : MessageLookupByLibrary.simpleMessage("Teisipäev"),
    "wednesday" : MessageLookupByLibrary.simpleMessage("Kolmapäev"),
    "workAmount" : MessageLookupByLibrary.simpleMessage("Töö maht"),
    "workDeleted" : MessageLookupByLibrary.simpleMessage("Töö kustutatud"),
    "workDeletion" : MessageLookupByLibrary.simpleMessage("Töö kustutamine"),
    "workIsAlreadyUsedInTaskCantDelete" : MessageLookupByLibrary.simpleMessage("Tööd kasutatakse juba ülesandes. Ei saa kustutada"),
    "workName" : MessageLookupByLibrary.simpleMessage("Töö nimi"),
    "wouldYouLikeToDeleteThisTask" : MessageLookupByLibrary.simpleMessage("Kas soovite selle ülesande kustutada?"),
    "wouldYouLikeToDeleteThisWork" : MessageLookupByLibrary.simpleMessage("Kas soovite selle töö kustutada?"),
    "yes" : MessageLookupByLibrary.simpleMessage("Jah")
  };
}
