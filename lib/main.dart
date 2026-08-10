import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/view_all_apparatuses.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/services/settings_service.dart';
import 'package:gym_code/theme/theme.dart';
import 'package:gym_code/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initRoutinesDb();
  await initSettingsDb();

  runApp(const GymCodeApp());
}

class GymCodeApp extends StatelessWidget {
  const GymCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (BuildContext context, Locale locale, Widget? child) {
        final TextTheme textTheme = createTextTheme(context, "Anta", "Anta");
        final MaterialTheme materialTheme = MaterialTheme(textTheme);
        return MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context).allApparatuses,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: materialTheme.light().copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android:
                        FadeForwardsPageTransitionsBuilder(),
                  },
                ),
              ),
          darkTheme: materialTheme.dark().copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android:
                        FadeForwardsPageTransitionsBuilder(),
                  },
                ),
              ),
          themeMode: ThemeMode.system,
          initialRoute: '/',
          routes: {'/': (context) => const ViewAllApparatuses()},
        );
      },
    );
  }
}
