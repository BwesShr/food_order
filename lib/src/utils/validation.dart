import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

String textValidator(String value) {
  if (value.isEmpty) {
    return LocaleKeys.valid_text.tr();
  } else {
    return null;
  }
}

String emailValidator(String value) {
  Pattern pattern = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(pattern);

  if (value.isEmpty) {
    return LocaleKeys.valid_text.tr();
  } else if (regExp.hasMatch(value)) {
    return null;
  } else {
    return LocaleKeys.valid_email.tr();
  }
}

String passwordValidator(String value) {
  if (value.isEmpty) {
    return LocaleKeys.valid_text.tr();
  } else if (value.length < 6) {
    return LocaleKeys.vaid_password.tr();
  } else {
    return null;
  }
}

String passwordConfirmValidator(String value, String password) {
  if (value.isEmpty) {
    return LocaleKeys.valid_text.tr();
  } else if (value.length < 6) {
    return LocaleKeys.vaid_password.tr();
  } else if (value != password) {
    return LocaleKeys.vaid_password.tr();
  } else {
    return null;
  }
}

String phoneValidator(String value) {
  Pattern pattern = '^9[0-9]{9}';
  if (!RegExp(pattern).hasMatch(value)) {
    return LocaleKeys.valid_phone.tr();
  } else {
    return null;
  }
}
