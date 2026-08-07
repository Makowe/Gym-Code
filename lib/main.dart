import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/view_all_routines.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/services/settings_service.dart';

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
        return MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context).allRoutines,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              dynamicSchemeVariant: DynamicSchemeVariant.expressive,
            ),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
              },
            ),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {'/': (context) => const ViewAllRoutines()},
        );
      },
    );
  }
}
