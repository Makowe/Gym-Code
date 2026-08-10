import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a66),
      surfaceTint: Color(0xff006a66),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1ec),
      onPrimaryContainer: Color(0xff00504d),
      secondary: Color(0xff505b92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdde1ff),
      onSecondaryContainer: Color(0xff384379),
      tertiary: Color(0xff6a5f11),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff4e489),
      onTertiaryContainer: Color(0xff514700),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffc9c4d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d0),
      primaryFixed: Color(0xff9cf1ec),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff80d5d0),
      onPrimaryFixedVariant: Color(0xff00504d),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff09164b),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff384379),
      tertiaryFixed: Color(0xfff4e489),
      onTertiaryFixed: Color(0xff201c00),
      tertiaryFixedDim: Color(0xffd7c770),
      onTertiaryFixedVariant: Color(0xff514700),
      surfaceDim: Color(0xffd5dbd9),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d3b),
      surfaceTint: Color(0xff006a66),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff187975),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff273267),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f6aa2),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3e3600),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7a6d20),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff0c1212),
      onSurfaceVariant: Color(0xff37353e),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d0),
      primaryFixed: Color(0xff187975),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f5c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f6aa2),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff465188),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7a6d20),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff605505),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c6),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe3e9e8),
      surfaceContainerHigh: Color(0xffd8dedc),
      surfaceContainerHighest: Color(0xffccd3d1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003230),
      surfaceTint: Color(0xff006a66),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00524f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1c285c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3b457b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff332c00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff534900),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4a4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d0),
      primaryFixed: Color(0xff00524f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003a37),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3b457b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff232e63),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff534900),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3a3300),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab8),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f0),
      surfaceContainer: Color(0xffdde4e2),
      surfaceContainerHigh: Color(0xffcfd6d4),
      surfaceContainerHighest: Color(0xffc1c8c6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d5d0),
      surfaceTint: Color(0xff80d5d0),
      onPrimary: Color(0xff003735),
      primaryContainer: Color(0xff00504d),
      onPrimaryContainer: Color(0xff9cf1ec),
      secondary: Color(0xffb9c3ff),
      onSecondary: Color(0xff212c61),
      secondaryContainer: Color(0xff384379),
      onSecondaryContainer: Color(0xffdde1ff),
      tertiary: Color(0xffd7c770),
      onTertiary: Color(0xff383000),
      tertiaryContainer: Color(0xff514700),
      onTertiaryContainer: Color(0xfff4e489),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffc9c4d0),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a66),
      primaryFixed: Color(0xff9cf1ec),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff80d5d0),
      onPrimaryFixedVariant: Color(0xff00504d),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff09164b),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff384379),
      tertiaryFixed: Color(0xfff4e489),
      onTertiaryFixed: Color(0xff201c00),
      tertiaryFixedDim: Color(0xffd7c770),
      onTertiaryFixedVariant: Color(0xff514700),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a39),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff303635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff96ebe6),
      surfaceTint: Color(0xff80d5d0),
      onPrimary: Color(0xff002b29),
      primaryContainer: Color(0xff489e99),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd6daff),
      onSecondary: Color(0xff152155),
      secondaryContainer: Color(0xff838dc8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeedd83),
      onTertiary: Color(0xff2c2600),
      tertiaryContainer: Color(0xff9f9140),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938f99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514e),
      primaryFixed: Color(0xff9cf1ec),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xff80d5d0),
      onPrimaryFixedVariant: Color(0xff003d3b),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000a3e),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff273267),
      tertiaryFixed: Color(0xfff4e489),
      onTertiaryFixed: Color(0xff151100),
      tertiaryFixedDim: Color(0xffd7c770),
      onTertiaryFixedVariant: Color(0xff3e3600),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff3f4645),
      surfaceContainerLowest: Color(0xff040808),
      surfaceContainerLow: Color(0xff181f1e),
      surfaceContainer: Color(0xff232928),
      surfaceContainerHigh: Color(0xff2d3433),
      surfaceContainerHighest: Color(0xff383f3e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabfff9),
      surfaceTint: Color(0xff80d5d0),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7cd1cc),
      onPrimaryContainer: Color(0xff000e0d),
      secondary: Color(0xffefefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb4bffd),
      onSecondaryContainer: Color(0xff00062f),
      tertiary: Color(0xfffff1aa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd3c46d),
      onTertiaryContainer: Color(0xff0e0b00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4eef9),
      outlineVariant: Color(0xffc6c1cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514e),
      primaryFixed: Color(0xff9cf1ec),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff80d5d0),
      onPrimaryFixedVariant: Color(0xff001413),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff000a3e),
      tertiaryFixed: Color(0xfff4e489),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd7c770),
      onTertiaryFixedVariant: Color(0xff151100),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff4b5150),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2120),
      surfaceContainer: Color(0xff2b3231),
      surfaceContainerHigh: Color(0xff363d3c),
      surfaceContainerHighest: Color(0xff414847),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
