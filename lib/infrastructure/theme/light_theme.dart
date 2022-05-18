import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme/infrastructure/theme/app_colors.dart';

const _colorTheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.black,
  onPrimary: AppColors.green,
  secondary: AppColors.black,
  onSecondary: AppColors.green,
  error: Colors.purple,
  onError: Colors.red,
  background: Colors.white,
  onBackground: AppColors.black,
  surface: Colors.white,
  onSurface: AppColors.black,
);

Color _getCheckboxCheckedColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.black;
  }
  return Colors.grey;
}

Color _getCheckboxFillColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.green;
  }
  return AppColors.greenDark;
}

Color _getSwitchTrackColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return Colors.grey;
  } else if (states.contains(MaterialState.selected)) {
    return AppColors.black;
  }
  return AppColors.greenDark;
}

Color _getSwitchThumbColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return Colors.grey;
  } else if (states.contains(MaterialState.selected)) {
    return AppColors.green;
  }

  return AppColors.green;
}

Color _getRadioFillColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return AppColors.black;
  }
  return Colors.grey;
}

BorderSide _getOutlinedColor(Set<MaterialState> states) {
  if (!states.contains(MaterialState.disabled)) {
    return const BorderSide(color: AppColors.black);
  }
  return const BorderSide(color: Colors.grey);
}

ThemeData getLightTheme(BuildContext context) {
  final textTheme =
      Typography.material2018(platform: defaultTargetPlatform).black;

  final buttonScaledPadding = ButtonStyleButton.scaledPadding(
    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
  );

  final textButtonScaledPadding = ButtonStyleButton.scaledPadding(
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
  );

  return ThemeData.from(
    colorScheme: _colorTheme,
    textTheme: textTheme.apply(
      fontFamily: 'Open Sans',
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
      decorationColor: AppColors.black,
    ),
  ).copyWith(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.black,
        padding: textButtonScaledPadding,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.black,
        onPrimary: AppColors.green,
        padding: buttonScaledPadding,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: AppColors.black,
        padding: buttonScaledPadding,
      ).copyWith(
        side: MaterialStateProperty.resolveWith(_getOutlinedColor),
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.green),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((_getCheckboxFillColor)),
      checkColor: MaterialStateProperty.resolveWith(_getCheckboxCheckedColor),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith(_getSwitchTrackColor),
      thumbColor: MaterialStateProperty.resolveWith(_getSwitchThumbColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(_getRadioFillColor),
    ),
  );
}
