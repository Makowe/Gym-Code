import 'package:gym_code/l10n/app_localizations.dart';

enum RoutineHint { missingDismount, missingElements, codeOfPoints, lk1 }

extension RoutineHintLocalization on RoutineHint {
  String localizedText(AppLocalizations l10n) {
    switch (this) {
      case RoutineHint.missingDismount:
        return l10n.routineMissingDismount;
      case RoutineHint.missingElements:
        return l10n.missingElements;
      case RoutineHint.codeOfPoints:
        return l10n.codeOfPointsShort;
      case RoutineHint.lk1:
        return l10n.lk1short;
    }
  }
}
