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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(l10n.language),
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
              const Expanded(child: SizedBox()),
              ButtonGroup([
                ButtonSpec(
                    label: l10n.cancel,
                    color: Colors.red,
                    onPressed: cancel,
                    icon: Icons.cancel),
                ButtonSpec(
                    label: l10n.save,
                    color: Colors.blue,
                    onPressed: save,
                    icon: Icons.save),
              ])
            ],
          ),
        ));
  }

  void cancel() {
    Navigator.pop(context);
  }

  Future<void> save() async {
    await updateLocale(selectedLocale);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
