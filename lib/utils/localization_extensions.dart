import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations? get localizations {
    return AppLocalizations.of(this);
  }

  Locale get locale {
    return Localizations.localeOf(this);
  }
}
