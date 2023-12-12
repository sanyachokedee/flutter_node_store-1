import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
    Locale('zh')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, How are you ?'**
  String get hello;

  /// No description provided for @menu_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menu_home;

  /// No description provided for @menu_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menu_about;

  /// No description provided for @menu_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get menu_contact;

  /// No description provided for @menu_report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get menu_report;

  /// No description provided for @menu_notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get menu_notification;

  /// No description provided for @menu_info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get menu_info;

  /// No description provided for @menu_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get menu_account;

  /// No description provided for @menu_changepass.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get menu_changepass;

  /// No description provided for @menu_changelang.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get menu_changelang;

  /// No description provided for @menu_setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get menu_setting;

  /// No description provided for @menu_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get menu_profile;

  /// No description provided for @menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get menu_logout;

  /// No description provided for @label_chooselang.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get label_chooselang;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'th': return AppLocalizationsTh();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
