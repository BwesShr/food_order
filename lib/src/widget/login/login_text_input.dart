import 'package:flutter/material.dart';
import 'package:food_order/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_order/src/utils/app_config.dart' as config;
import 'package:food_order/src/utils/color_theme.dart';

class LoginTextInput extends StatefulWidget {
  LoginTextInput({
    Key key,
    @required this.label,
    @required this.hint,
    this.validated,
    @required this.textController,
    @required this.focusNode,
    this.nxtFocusNode,
    this.prefixIcon,
    @required this.keyboardType,
    @required this.inputAction,
    @required this.validator,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final String hint;
  bool validated = false;
  final TextEditingController textController;
  final FocusNode focusNode;
  final FocusNode nxtFocusNode;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final ValueChanged<String> validator;
  final ValueChanged<String> onChanged;

  @override
  _LoginTextInputState createState() => _LoginTextInputState();
}

class _LoginTextInputState extends State<LoginTextInput> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: _appConfig.horizontalSpace(),
      ),
      title: Text(
        widget.label,
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      subtitle: TextFormField(
        controller: widget.textController,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        textInputAction: widget.inputAction,
        obscureText: widget.label.contains(LocaleKeys.hint_password.tr())
            ? _hidePassword
            : false,
        onFieldSubmitted: (value) {
          widget.focusNode.unfocus();
          if (widget.nxtFocusNode != null)
            FocusScope.of(context).requestFocus(widget.nxtFocusNode);
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Theme.of(context).focusColor.withOpacity(0.7),
          ),
          prefixIconConstraints: BoxConstraints(),
          suffixIconConstraints: BoxConstraints(),
          prefixIcon: widget.prefixIcon == null
              ? Offstage()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    widget.prefixIcon,
                    color: Theme.of(context).buttonColor,
                    size: 20.0,
                  ),
                ),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              widget.label.contains(LocaleKeys.hint_password.tr())
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        color: Theme.of(context).focusColor,
                        icon: Icon(_hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    )
                  : Offstage(),
              widget.validated
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Offstage(),
            ],
          ),
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
