import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/utils/card_utils.dart';
import 'package:flutter_paystack/utils/input_formatters.dart';
import 'package:flutter_paystack/widgets/text_input_field.dart';

class CardNumberTextField extends StatefulWidget {
  CardNumberTextField({
    Key key,
    this.onSaved,
    this.textEditingController,
  }) : super(key: key);

  final Function onSaved;
  final TextEditingController textEditingController;

  @override
  _CardNumberTextFieldState createState() => _CardNumberTextFieldState();

}

class _CardNumberTextFieldState extends State<CardNumberTextField> {
  Widget cardTypeIcon;

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      trailingIcon: cardTypeIcon,
      hintText: "0000 0000 0000 0000",
      labelText: "CARD NUMBER",
      validator: CardUtils.validateCardNum,
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(19),
        new CardNumberInputFormatter()
      ],
      onChange: (data) {
        //update the card icon for the input
        setState(
          () {
            final cardType = CardUtils.getCardTypeFrmNumber(data);
            cardTypeIcon = Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardUtils.getCardIcon(cardType),
            );
          },
        );
      },
      onSaved: widget.onSaved,
      textEditingController: widget.textEditingController,
    );
  }
}
