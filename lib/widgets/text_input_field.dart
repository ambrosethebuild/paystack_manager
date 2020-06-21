import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystack_manager/utils/ui_color.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key key,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChange,
    this.onSaved,
    this.trailingIcon,
    this.keyboardType,
    this.inputFormatters,
    this.textEditingController,
    this.readyOnly = false, 
    this.onTap,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final Function validator;
  final Function onChange;
  final Function onSaved;
  final Function onTap;
  final Widget trailingIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController textEditingController;
  final bool readyOnly;


  @override
  _InputTextFieldState createState() => _InputTextFieldState();

}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: UIColors.accentColor,
      onChanged: widget.onChange,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readyOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: UIColors.labelTextColor,
        ),
        border: OutlineInputBorder(),
        focusColor: UIColors.accentColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: UIColors.accentColor,
          ),
        ),
        suffixIcon: widget.trailingIcon,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.textEditingController,
    );
  }
}
