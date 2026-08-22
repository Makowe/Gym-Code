import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/services/settings_service.dart';
import 'package:gym_code/widgets/button_group.dart';

class GlobalSettings extends StatefulWidget {
  const GlobalSettings({super.key});

  @override
  State<GlobalSettings> createState() => _GlobalSettingsState();
}

class _GlobalSettingsState extends State<GlobalSettings> {
  Locale selectedLocale = localeNotifier.value;
  ThemeMode selectedThemeMode = themeModeNotifier.value;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            automaticallyImplyLeading: false,
            title: Text(l10n.settings),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(l10n.language,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu<Locale>(
                        initialSelection: selectedLocale,
                        onSelected: (Locale? newLocale) {
                          if (newLocale == null) return;
                          setState(() {
                            selectedLocale = newLocale;
                          });
                        },
                        dropdownMenuEntries: AppLocalizations.supportedLocales
                            .map<DropdownMenuEntry<Locale>>((Locale locale) {
                          return DropdownMenuEntry<Locale>(
                            value: locale,
                            label: displayNameOf(locale),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(l10n.theme,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu<ThemeMode>(
                        initialSelection: selectedThemeMode,
                        onSelected: (ThemeMode? newThemeMode) {
                          if (newThemeMode == null) return;
                          setState(() {
                            selectedThemeMode = newThemeMode;
                          });
                        },
                        dropdownMenuEntries: <DropdownMenuEntry<ThemeMode>>[
                          DropdownMenuEntry<ThemeMode>(
                            value: ThemeMode.system,
                            label: l10n.themeSystem,
                          ),
                          DropdownMenuEntry<ThemeMode>(
                            value: ThemeMode.light,
                            label: l10n.themeLight,
                          ),
                          DropdownMenuEntry<ThemeMode>(
                            value: ThemeMode.dark,
                            label: l10n.themeDark,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                ButtonGroup([
                  ButtonSpec(
                      type: ButtonType.textSecondary,
                      label: l10n.cancel,
                      onPressed: cancel,
                      icon: Icons.cancel),
                  ButtonSpec(
                      label: l10n.save, onPressed: save, icon: Icons.save),
                ])
              ],
            ),
          ),
        ));
  }

  void cancel() {
    Navigator.pop(context);
  }

  Future<void> save() async {
    await updateLocale(selectedLocale);
    await updateThemeMode(selectedThemeMode);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
