// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a et locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'et';

  static String m0(count) =>
      "${Intl.plural(count, zero: '0 tundi', one: '1 tund', other: '${count} tundi')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: '0 minutit', one: '1 minut', other: '${count} minutit')}";

  static String m2(date) =>
      "Siin on minu kuu ülesannete varukoopia ${date} PieceCalc\'ist.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDoneWork": MessageLookupByLibrary.simpleMessage("Lisa tehtud töö"),
        "addNewField": MessageLookupByLibrary.simpleMessage("Lisa uus väli"),
        "addNewWork": MessageLookupByLibrary.simpleMessage("Lisa uus töö"),
        "addWorksInSettings":
            MessageLookupByLibrary.simpleMessage("Lisage töid seadetes"),
        "amount": MessageLookupByLibrary.simpleMessage("Kogus"),
        "appName": MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
        "april": MessageLookupByLibrary.simpleMessage("Aprill"),
        "archiveHeader": MessageLookupByLibrary.simpleMessage("Arhiiv:"),
        "archiveThreeDotMenu":
            MessageLookupByLibrary.simpleMessage("Arhiveeri"),
        "archivedWorksArentShowingInAddTaskWorkSuggestions":
            MessageLookupByLibrary.simpleMessage(
                "Arhiveeritud töid ei kuvata ülesande lisamise ettepanekutes."),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Oled sa kindel?"),
        "august": MessageLookupByLibrary.simpleMessage("August"),
        "auto": MessageLookupByLibrary.simpleMessage("Automaatne"),
        "backup": MessageLookupByLibrary.simpleMessage("Varukoopia"),
        "backupOfMyData":
            MessageLookupByLibrary.simpleMessage("Minu andmete varukoopia"),
        "changeCurrency":
            MessageLookupByLibrary.simpleMessage("Muuda valuutat"),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("Muuda keelt"),
        "chartGuideDaysOnTheXaxisMoneyEarnedOnThe":
            MessageLookupByLibrary.simpleMessage(
                "🔍 Graafiku juhend: päevad x-teljel. Teenitud raha y-teljel."),
        "commentForTask":
            MessageLookupByLibrary.simpleMessage("Kommentaar ülesandele"),
        "couldNotLaunch":
            MessageLookupByLibrary.simpleMessage("Ei suutnud käivitada"),
        "dark": MessageLookupByLibrary.simpleMessage("Tume"),
        "dataSuccessfullyUploadedToApp": MessageLookupByLibrary.simpleMessage(
            "Andmed edukalt rakendusse üles laetud."),
        "december": MessageLookupByLibrary.simpleMessage("Detsember"),
        "deleteTask": MessageLookupByLibrary.simpleMessage("Kustuta"),
        "deleteThreeDotMenu": MessageLookupByLibrary.simpleMessage("Kustuta"),
        "done": MessageLookupByLibrary.simpleMessage("Valmis"),
        "earned": MessageLookupByLibrary.simpleMessage("Hind"),
        "editTask": MessageLookupByLibrary.simpleMessage("Muuda ülesannet"),
        "editWork": MessageLookupByLibrary.simpleMessage("Muuda tööd"),
        "emailToMe": MessageLookupByLibrary.simpleMessage(
            "Küsimused? Kirjuta mulle e-posti teel!"),
        "english": MessageLookupByLibrary.simpleMessage("Inglise"),
        "enterDate": MessageLookupByLibrary.simpleMessage("Sisestage kuupäev"),
        "error": MessageLookupByLibrary.simpleMessage("Viga"),
        "estonian": MessageLookupByLibrary.simpleMessage("Eesti"),
        "exportBackupToFile":
            MessageLookupByLibrary.simpleMessage("Ekspordi varukoopia faili"),
        "february": MessageLookupByLibrary.simpleMessage("Veebruar"),
        "fileIsDamaged":
            MessageLookupByLibrary.simpleMessage("Fail on kahjustatud."),
        "fileIsNotCorrect":
            MessageLookupByLibrary.simpleMessage("Fail ei ole korrektne."),
        "friday": MessageLookupByLibrary.simpleMessage("Reede"),
        "hereIsMyBackupFromPiececalc": MessageLookupByLibrary.simpleMessage(
            "Siin on minu varukoopia PieceCalc-st."),
        "homeBottomNavBarTitle":
            MessageLookupByLibrary.simpleMessage("Ajajoon"),
        "hourWork": MessageLookupByLibrary.simpleMessage("Tunnitöö"),
        "hoursOnly": m0,
        "importBackupFromFile":
            MessageLookupByLibrary.simpleMessage("Impordi varukoopia failist"),
        "introFifthScreenBody": MessageLookupByLibrary.simpleMessage(
            "Valige oma vibe. Vaheta valge ja tumeda teema vahel vastavalt oma tujule või ümbrusele."),
        "introFifthScreenHeader":
            MessageLookupByLibrary.simpleMessage("Hele ja tume režiim 🌓"),
        "introFirstScreenBody": MessageLookupByLibrary.simpleMessage(
            "Teie hädavajalik kaaslane töö tulemuste jälgimiseks ja arvutamiseks. Unustage tüütu teenitud raha arvutamine — säästke aega PieceCa(lc)-ga."),
        "introFirstScreenHeader": MessageLookupByLibrary.simpleMessage(
            "Tere tulemast PieceCa(lc)\'i 📊"),
        "introFourthScreenBody": MessageLookupByLibrary.simpleMessage(
            "Kasutajasõbralik liides on loodud mõeldes sinule. Liikuge hõlpsalt ja saavutage rohkem."),
        "introFourthScreenHeader":
            MessageLookupByLibrary.simpleMessage("Intuitiivne disain 🎨"),
        "introSecondAndHalfScreenBody": MessageLookupByLibrary.simpleMessage(
            "PieceCa(lc) abil sorteeritakse sinu ülesanded automaatselt kuude kaupa. See muudab sinu edusammude ülevaatamise ja jälgimise lihtsamaks kui kunagi varem."),
        "introSecondAndHalfScreenHeader":
            MessageLookupByLibrary.simpleMessage("Kuuline korraldus 📅"),
        "introSecondScreenBody": MessageLookupByLibrary.simpleMessage(
            "Arvuta tehtud töö maht ühe klõpsuga ja saa kohe selge, organiseeritud ülevaade."),
        "introSecondScreenHeader":
            MessageLookupByLibrary.simpleMessage("Kohene töö arvutamine 💹"),
        "introSixthScreenBody": MessageLookupByLibrary.simpleMessage(
            "Sukeldu PieceCa(lc)\'i ja alusta oma töö arvutamist täna organiseeritumalt ja tõhusamalt!"),
        "introSixthScreenHeader":
            MessageLookupByLibrary.simpleMessage("Valmis alustama? 🚀"),
        "introThirdScreenBody": MessageLookupByLibrary.simpleMessage(
            "Ära karda andmekadu. Looge kõigi oma andmete või mis tahes kuu konkreetsete ülesannete jaoks hõlpsasti varukoopiad."),
        "introThirdScreenHeader":
            MessageLookupByLibrary.simpleMessage("Turvaline varundus 🛡️"),
        "invalidFormat": MessageLookupByLibrary.simpleMessage("Vigane formaat"),
        "january": MessageLookupByLibrary.simpleMessage("Jaanuar"),
        "july": MessageLookupByLibrary.simpleMessage("Juuli"),
        "june": MessageLookupByLibrary.simpleMessage("Juuni"),
        "light": MessageLookupByLibrary.simpleMessage("Hele"),
        "march": MessageLookupByLibrary.simpleMessage("Märts"),
        "may": MessageLookupByLibrary.simpleMessage("Mai"),
        "minutesOnly": m1,
        "monday": MessageLookupByLibrary.simpleMessage("Esmaspäev"),
        "no": MessageLookupByLibrary.simpleMessage("Ei"),
        "noDataForThisMonth":
            MessageLookupByLibrary.simpleMessage("Selle kuu andmed puuduvad"),
        "noWorkHasBeenAdded": MessageLookupByLibrary.simpleMessage(
            "Töid ei ole lisatud. Uue töö lisamiseks \n1) Minge Seadetesse \n2) Klõpsake \'Lisa uus töö\'"),
        "noneCurrencyPicked":
            MessageLookupByLibrary.simpleMessage("Valikut pole tehtud"),
        "november": MessageLookupByLibrary.simpleMessage("November"),
        "october": MessageLookupByLibrary.simpleMessage("Oktoober"),
        "orPressThisButton":
            MessageLookupByLibrary.simpleMessage("Või vajutage seda nuppu"),
        "pieceWork": MessageLookupByLibrary.simpleMessage("Tükktöö"),
        "piececalc": MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
        "pleaseEnterAPrice":
            MessageLookupByLibrary.simpleMessage("Palun sisestage hind"),
        "pleaseEnterAValidNumber": MessageLookupByLibrary.simpleMessage(
            "Palun sisestage kehtiv number"),
        "pleaseEnterAnAmount":
            MessageLookupByLibrary.simpleMessage("Palun sisestage summa"),
        "pleaseEnterDate":
            MessageLookupByLibrary.simpleMessage("Palun sisestage kuupäev"),
        "pleaseEnterValidWorkName": MessageLookupByLibrary.simpleMessage(
            "Palun sisestage kehtiv töö nimi"),
        "pleaseEnterWorkName":
            MessageLookupByLibrary.simpleMessage("Palun sisestage töö nimi"),
        "priceForOneHour":
            MessageLookupByLibrary.simpleMessage("Hind ühe töötunni eest"),
        "priceForOnePiece":
            MessageLookupByLibrary.simpleMessage("Hind ühe tüki eest"),
        "rateUsOnGooglePlay":
            MessageLookupByLibrary.simpleMessage("Hinda meid Google Play\'s!"),
        "removeField": MessageLookupByLibrary.simpleMessage("Eemalda väli"),
        "russian": MessageLookupByLibrary.simpleMessage("Vene"),
        "saturday": MessageLookupByLibrary.simpleMessage("Laupäev"),
        "save": MessageLookupByLibrary.simpleMessage("Salvesta"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Vali värv"),
        "selectColorShade":
            MessageLookupByLibrary.simpleMessage("Vali värvi varjund"),
        "selectTime": MessageLookupByLibrary.simpleMessage("Vali aeg"),
        "selectedColorAndItsShades": MessageLookupByLibrary.simpleMessage(
            "Valitud värv ja selle varjundid"),
        "september": MessageLookupByLibrary.simpleMessage("September"),
        "settingsBottomNavBarTitle":
            MessageLookupByLibrary.simpleMessage("Seaded"),
        "settingsChangeTheme":
            MessageLookupByLibrary.simpleMessage("Muuda teemat"),
        "shareMonthData":
            MessageLookupByLibrary.simpleMessage("Jaga kuu andmeid"),
        "shareSubjectText": m2,
        "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Midagi läks valesti. Palun proovige uuesti."),
        "startTutorialAgain":
            MessageLookupByLibrary.simpleMessage("Alusta juhendit uuesti"),
        "statsBottomNavBarTitle":
            MessageLookupByLibrary.simpleMessage("Statistika"),
        "sunday": MessageLookupByLibrary.simpleMessage("Pühapäev"),
        "tapToAddTask": MessageLookupByLibrary.simpleMessage(
            "Klõpsake ülesande lisamiseks"),
        "taskDeletion":
            MessageLookupByLibrary.simpleMessage("Ülesande kustutamine"),
        "tasksNotAddedYet": MessageLookupByLibrary.simpleMessage(
            "Ülesandeid pole veel lisatud, vajutage paremal all nuppu pluss"),
        "thursday": MessageLookupByLibrary.simpleMessage("Neljapäev"),
        "timeIsNotPicked":
            MessageLookupByLibrary.simpleMessage("Aega ei ole valitud"),
        "timeSpent": MessageLookupByLibrary.simpleMessage("Kulutatud aeg"),
        "totalEarned": MessageLookupByLibrary.simpleMessage("Kokku teenitud"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Teisipäev"),
        "unarchiveThreeDotMenu":
            MessageLookupByLibrary.simpleMessage("Eemalda arhiivist"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Kolmapäev"),
        "workAmount": MessageLookupByLibrary.simpleMessage("Töö maht"),
        "workDeleted": MessageLookupByLibrary.simpleMessage("Töö kustutatud"),
        "workDeletion": MessageLookupByLibrary.simpleMessage("Töö kustutamine"),
        "workIsAlreadyUsedInTaskCantDelete":
            MessageLookupByLibrary.simpleMessage(
                "Tööd kasutatakse juba ülesandes. Ei saa kustutada"),
        "workName": MessageLookupByLibrary.simpleMessage("Töö nimi"),
        "worksHasntBeenArchivedYetToArchiveWorkTapThreedot":
            MessageLookupByLibrary.simpleMessage(
                "Tööd pole veel arhiveeritud. Arhiveerimiseks klõpsake tööloendi plaadil kolmepunktimenüül ja valige \'Arhiveeri\'."),
        "wouldYouLikeToDeleteThisTask": MessageLookupByLibrary.simpleMessage(
            "Kas soovite selle ülesande kustutada?"),
        "wouldYouLikeToDeleteThisWork": MessageLookupByLibrary.simpleMessage(
            "Kas soovite selle töö kustutada?"),
        "yes": MessageLookupByLibrary.simpleMessage("Jah"),
        "yourFeedbackMotivatesMeToMakeTheAppEvenBetter":
            MessageLookupByLibrary.simpleMessage(
                "Sinu tagasiside motiveerib mind rakendust veelgi paremaks tegema!")
      };
}
