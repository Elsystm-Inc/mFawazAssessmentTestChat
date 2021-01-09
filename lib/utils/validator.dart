import 'package:flutter/material.dart';
import 'package:chat_app/utils/app_localizations.dart';

class Validator {
  final BuildContext context;

  Validator(this.context);

  isNumber(String value, String emptyErrorID, String typeErrorID) {
    if (value == null) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    } else if (value.isEmpty) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    } else if (int.tryParse(value) == null) {
      return AppLocalizations.of(context).translate(typeErrorID);
    }
    return null;
  }

  isEmpty(String value, String emptyErrorID, String minErrorID) {
    if (value == null) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    } else if (value.isEmpty) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    } else if (value.length < 2) {
      return AppLocalizations.of(context).translate(minErrorID);
    }
    return null;
  }

  isNull(String value, String emptyErrorID) {
    if (value == null) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    } else if (value.isEmpty) {
      return AppLocalizations.of(context).translate(emptyErrorID);
    }
    return null;
  }
}
