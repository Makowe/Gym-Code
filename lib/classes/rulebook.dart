import 'package:gym_code/l10n/app_localizations.dart';

enum Rulebook { cop, lk1 }

extension RulebookLocalization on Rulebook {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case Rulebook.cop:
        return l10n.codeOfPoints;
      case Rulebook.lk1:
        return l10n.lk1;
    }
  }

  String shortName(AppLocalizations l10n) {
    switch (this) {
      case Rulebook.cop:
        return l10n.codeOfPointsShort;
      case Rulebook.lk1:
        return l10n.lk1short;
    }
  }
}
