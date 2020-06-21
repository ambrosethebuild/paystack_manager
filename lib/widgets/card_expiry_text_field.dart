import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystack_manager/utils/card_utils.dart';
import 'package:paystack_manager/utils/input_formatters.dart';
import 'package:paystack_manager/widgets/text_input_field.dart';

class CardExpiryTextField extends StatefulWidget {
  CardExpiryTextField({
    Key key,
    this.onSaved,
    this.textEditingController,
  }) : super(key: key);

  final Function onSaved;
  final TextEditingController textEditingController;

  @override
  _CardExpiryTextFieldState createState() => _CardExpiryTextFieldState();
}

class _CardExpiryTextFieldState extends State<CardExpiryTextField> {
  @override
  Widget build(BuildContext context) {
    return InputTextField(
      hintText: "MM / YY",
      labelText: "CARD EXPIRY",
      keyboardType: TextInputType.number,
      validator: CardUtils.validateDate,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
        new CardMonthInputFormatter()
      ],
      onSaved: widget.onSaved,
      textEditingController: widget.textEditingController,
    );
  }
}
