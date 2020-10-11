import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystack_manager/utils/card_utils.dart';
import 'package:paystack_manager/widgets/text_input_field.dart';

class CardCVVTextField extends StatefulWidget {
  CardCVVTextField({
    Key key,
    this.onSaved,
    this.textEditingController,
  }) : super(key: key);

  final Function onSaved;
  final TextEditingController textEditingController;

  @override
  _CardCVVTextFieldState createState() => _CardCVVTextFieldState();
}

class _CardCVVTextFieldState extends State<CardCVVTextField> {
  @override
  Widget build(BuildContext context) {
    return InputTextField(
      hintText: "",
      labelText: "CVV",
      validator: CardUtils.validateCVV,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
      ],
      onSaved: widget.onSaved,
      textEditingController: widget.textEditingController,
    );
  }
}
