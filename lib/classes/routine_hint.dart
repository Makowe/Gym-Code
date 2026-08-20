import 'package:gym_code/l10n/app_localizations.dart';

/// A non-blocking hint shown to the user about a routine, according to the
/// Code of Points, as opposed to InvalidElementReason which invalidates an
/// individual element.
enum RoutineHint {
  /// The routine does not have a valid dismount.
  missingDismount,
}

extension RoutineHintLocalization on RoutineHint {
  String localizedText(AppLocalizations l10n) {
    switch (this) {
      case RoutineHint.missingDismount:
        return l10n.routineMissingDismount;
    }
  }
}
