## Internals

1. For theme I used flex_color_scheme package (Theme - M3 Mango Mojito), also author has great website, to fine-tune some widgets use site https://rydmike.com/flexcolorscheme/themesplayground-v7-2/#/
2. On naming exception and InfoMessage enums, its name should be used in localization string name, e.g. CantFetchBoltScootersData - AppLocalizations.of(context)!.snackbarCantFetchBoltScootersData or InfoMessage.noNeedToDownload - AppLocalizations.of(context)!.snackbarNoNeedToDownload
3. To find similar colors I used https://www.color-hex.com/color/fff59d
4. I do not close database, it leads to unexpected errors (probably it happens because i use single instance of database connection).
5. To make new release - 1) change version in pubspec.yaml (could simply change build) 2) run tagAndPush.sh
6. To start Debug-Over-WIfi on hotspot - run adb_connect.bat.