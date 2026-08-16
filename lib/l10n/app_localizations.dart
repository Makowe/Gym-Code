import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Button label: persist the current changes
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button label: discard the current changes
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button label: add elements to the routine
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Button label: confirm a deletion
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Button label: abort a deletion and keep the item
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keep;

  /// Button label: open the routine editor
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modify;

  /// Button label: dismiss a dialog
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Title of the routine overview screen
  ///
  /// In en, this message translates to:
  /// **'All Routines'**
  String get allRoutines;

  /// Title of the global settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Title of the element picker screen
  ///
  /// In en, this message translates to:
  /// **'Add Elements'**
  String get addElements;

  /// Title of the rename dialog
  ///
  /// In en, this message translates to:
  /// **'Rename Routine'**
  String get renameRoutine;

  /// Title of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Routine'**
  String get deleteRoutine;

  /// Settings row label for the language selector
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Generic noun for a gymnastics routine
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get routine;

  /// Fallback display name for a routine the user never named
  ///
  /// In en, this message translates to:
  /// **'Unnamed Routine'**
  String get unnamedRoutine;

  /// Button label: create a new routine
  ///
  /// In en, this message translates to:
  /// **'New Routine'**
  String get newRoutine;

  /// Column label for an element's difficulty value
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// Column label for an element's Code of Points group
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// Label for the difficulty value of an element
  ///
  /// In en, this message translates to:
  /// **'D Value'**
  String get dValue;

  /// Label for the number of elements performed in a routine
  ///
  /// In en, this message translates to:
  /// **'Total Elements'**
  String get totalElements;

  /// Label for the number of elements that count towards the score
  ///
  /// In en, this message translates to:
  /// **'Counted Elements'**
  String get countedElements;

  /// Label for the difficulty score of a routine
  ///
  /// In en, this message translates to:
  /// **'D Score'**
  String get dScore;

  /// Label for the deduction applied to a routine
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get penalty;

  /// Heading for the breakdown of elements per difficulty value
  ///
  /// In en, this message translates to:
  /// **'Elements by Value'**
  String get elementsByValue;

  /// Short column label for the element count
  ///
  /// In en, this message translates to:
  /// **'Elements'**
  String get elements;

  /// Heading for the breakdown of elements per group
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// Text field label in the rename dialog
  ///
  /// In en, this message translates to:
  /// **'Routine name'**
  String get routineNameLabel;

  /// Snackbar shown after adding an element to the routine
  ///
  /// In en, this message translates to:
  /// **'Element added'**
  String get elementAdded;

  /// Confirmation question in the delete dialog
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the routine \"{routineName}\"?'**
  String confirmDeleteRoutine(String routineName);

  /// Shown when a routine has more than one dismount
  ///
  /// In en, this message translates to:
  /// **'Invalid routine: too many dismounts'**
  String get routineInvalidTooManyDismounts;

  /// Shown when a routine's dismount is not its last element
  ///
  /// In en, this message translates to:
  /// **'Invalid routine: dismount not at the end'**
  String get routineInvalidDismountNotAtEnd;

  /// Shown when an element is a repetition of a previous element in the routine
  ///
  /// In en, this message translates to:
  /// **'Invalid Element: The element was already shown.'**
  String get elementInvalidRepetition;

  /// Shown when a pommel horse routine has more than one Flop element and this is not the highest-difficulty one
  ///
  /// In en, this message translates to:
  /// **'Invalid Element: Only one flop per routine can be counted.'**
  String get elementInvalidTooManyFlops;

  /// Shown when a pommel horse routine has more than one Combination element and this is not the highest-difficulty one
  ///
  /// In en, this message translates to:
  /// **'Invalid Element: Only 1 Combination per routine can be counted'**
  String get elementInvalidTooManyCombinations;

  /// Shown when a national element's required direct predecessor is not present
  ///
  /// In en, this message translates to:
  /// **'Invalid: The element requires a specific predecessor element.'**
  String get elementInvalidMissingPredecessor;

  /// Title of the dialog shown when tapping an invalid element's warning icon
  ///
  /// In en, this message translates to:
  /// **'Invalid Element'**
  String get invalidElement;

  /// Title of the apparatus overview screen
  ///
  /// In en, this message translates to:
  /// **'Apparatuses'**
  String get allApparatuses;

  /// Name of the floor apparatus
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get apparatusFloor;

  /// Name of the pommel horse apparatus
  ///
  /// In en, this message translates to:
  /// **'Pommel Horse'**
  String get apparatusPommelHorse;

  /// Name of the rings apparatus
  ///
  /// In en, this message translates to:
  /// **'Rings'**
  String get apparatusRings;

  /// Name of the vault apparatus
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get apparatusVault;

  /// Name of the parallel bars apparatus
  ///
  /// In en, this message translates to:
  /// **'Parallel Bars'**
  String get apparatusParallelBars;

  /// Name of the horizontal bar apparatus
  ///
  /// In en, this message translates to:
  /// **'Horizontal Bar'**
  String get apparatusHorizontalBar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
