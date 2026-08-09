import 'package:gym_code/l10n/app_localizations.dart';

/// The gymnastics apparatus a [Routine] is performed on.
enum Apparatus {
  floor,
  pommelHorse,
  rings,
  vault,
  parallelBars,
  horizontalBar,
}

extension ApparatusLocalization on Apparatus {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case Apparatus.floor:
        return l10n.apparatusFloor;
      case Apparatus.pommelHorse:
        return l10n.apparatusPommelHorse;
      case Apparatus.rings:
        return l10n.apparatusRings;
      case Apparatus.vault:
        return l10n.apparatusVault;
      case Apparatus.parallelBars:
        return l10n.apparatusParallelBars;
      case Apparatus.horizontalBar:
        return l10n.apparatusHorizontalBar;
    }
  }
}
