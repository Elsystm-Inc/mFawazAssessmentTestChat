import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputTextField extends StatelessWidget {
  final Function validator;
  final Function onSave;
  final double width;
  final double height;
  final double marginBottom;
  final double marginTop;
  final double paddingAll;
  final int inputMaxLength;
  final String textLable;
  final TextInputType textInputType;
  final bool obscure;
  final bool autoFoucs;
  final String intialValue;
  final TextEditingController controller;

  const CustomInputTextField({
    Key key,
    @required this.validator,
    this.width = 350,
    this.height = 60,
    this.marginBottom = 10,
    this.paddingAll = 5,
    this.inputMaxLength,
    this.textLable,
    this.textInputType = TextInputType.text,
    this.obscure = false,
    this.marginTop = 0,
    this.autoFoucs = false,
    this.onSave, this.controller, this.intialValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: marginBottom, top: marginTop),
      padding: EdgeInsets.all(paddingAll),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: TextFormField(
        initialValue: intialValue,
        controller: controller,
        autofocus: autoFoucs,
        obscureText: obscure,
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputMaxLength),
        ],
        textAlign: TextAlign.center,
        validator: (value) {
          return validator(value);
        },
        onSaved: onSave,
        decoration: InputDecoration(
          hintMaxLines: 0,
          labelText: textLable,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
