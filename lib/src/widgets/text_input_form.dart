import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/utils/app_config.dart' as config;

class TextInputForm extends StatefulWidget {
  TextInputForm({
    Key key,
    @required this.label,
    @required this.textController,
    @required this.focusNode,
    this.nxtFocusNode,
    @required this.keyboardType,
    @required this.inputAction,
    @required this.validator,
  }) : super(key: key);

  final String label;
  final TextEditingController textController;
  final FocusNode focusNode;
  final FocusNode nxtFocusNode;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final ValueChanged<String> validator;

  @override
  _TextInputFormState createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
  @override
  Widget build(BuildContext context) {
    final _appConfig = config.AppConfig(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        SizedBox(height: _appConfig.extraSmallSpace()),
        TextFormField(
          controller: widget.textController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: widget.inputAction,
          onFieldSubmitted: (value) {
            widget.focusNode.unfocus();
            if (widget.nxtFocusNode != null)
              FocusScope.of(context).requestFocus(widget.nxtFocusNode);
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(
              horizontal: _appConfig.horizontalSpace(),
              vertical: _appConfig.extraSmallSpace(),
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
