import 'package:gym_code/l10n/app_localizations.dart';

enum Apparatus {
  floor,
  pommelHorse,
  rings,
  vault,
  parallelBars,
  horizontalBar,
}

extension ApparatusIcon on Apparatus {
  String get iconAsset {
    switch (this) {
      case Apparatus.floor:
        return 'assets/icons/floor.svg';
      case Apparatus.pommelHorse:
        return 'assets/icons/pommel_horse.svg';
      case Apparatus.rings:
        return 'assets/icons/rings.svg';
      case Apparatus.vault:
        return 'assets/icons/vault.svg';
      case Apparatus.parallelBars:
        return 'assets/icons/parallel_bars.svg';
      case Apparatus.horizontalBar:
        return 'assets/icons/horizontal_bar.svg';
    }
  }
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
