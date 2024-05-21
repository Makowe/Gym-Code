import 'package:flutter/material.dart';
import 'package:gym_code/services/settings_service.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/button_group.dart';

class GlobalSettings extends StatefulWidget {
  const GlobalSettings({super.key});

  @override
  State<GlobalSettings> createState() => _GlobalSettingsState();
}

class _GlobalSettingsState extends State<GlobalSettings> {
  Language? selectedLanguage = getLanguage();

  String settingsString = '';

  @override
  void initState() {
    getVocabulary(Vocabulary.settings).then((String res) {
      setState(() {
        settingsString = res;
      });
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            automaticallyImplyLeading: false,
            title: Text(settingsString),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sprache'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<Language>(
                    initialSelection: selectedLanguage,
                    onSelected: (Language? newLanguage) {
                      setState(() {
                        selectedLanguage = newLanguage;
                      });
                    },
                    dropdownMenuEntries: Language.values
                        .map<DropdownMenuEntry<Language>>(
                            (Language language) {
                      return DropdownMenuEntry<Language>(
                        value: language,
                        label: language.displayName,
                      );
                  }).toList(),
                  ),
                )
              ],
              ),
              const Expanded(child: SizedBox()),
              ButtonGroup([
                ButtonSpec(vocabulary: Vocabulary.cancel, color: Colors.red, onPressed: cancel, icon: Icons.cancel),
                ButtonSpec(vocabulary: Vocabulary.save, color: Colors.blue, onPressed: save, icon: Icons.save),
              ])
            ],
          ),
        ));
  }

  void cancel() {
      Navigator.pop(context, false);
  }

  void save() {
    if(selectedLanguage != null) { updateLanguage(selectedLanguage!); }
    Navigator.pop(context, true);
  }
}
