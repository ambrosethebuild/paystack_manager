import 'package:flutter/material.dart';
import 'package:paystack_manager/models/payment_card.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/utils/card_utils.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:paystack_manager/widgets/accent_button.dart';
import 'package:paystack_manager/widgets/card_cvv_text_field.dart';
import 'package:paystack_manager/widgets/card_expiry_text_field.dart';
import 'package:paystack_manager/widgets/card_number_text_field.dart';
import 'package:paystack_manager/widgets/payment_option_header.dart';
import 'package:paystack_manager/widgets/secured_by.dart';

class CardPaymentView extends StatefulWidget {
  CardPaymentView({
    Key key,
    this.paymentInfo,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final Function onSubmit;

  @override
  _CardPaymentViewState createState() => _CardPaymentViewState();
}

class _CardPaymentViewState extends State<CardPaymentView> {
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  //TextEditingControllers
  TextEditingController _cardNumberTextEditingController =
      new TextEditingController();
  TextEditingController _cardExpiryTextEditingController =
      new TextEditingController();
  TextEditingController _cardCVVTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        //Header View
        PaymentOptionHeader(
          paymentInfo: widget.paymentInfo,
        ),

        Divider(
          height: 30,
        ),

        //Instruction
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              "Enter your card details to pay",
              style: TextStyle(
                color: UIColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //Card details
              SizedBox(
                height: 20,
              ),
              CardNumberTextField(
                textEditingController: _cardNumberTextEditingController,
              ),

              //Expiry and cvv
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: CardExpiryTextField(
                      textEditingController: _cardExpiryTextEditingController,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 8,
                    child: CardCVVTextField(
                        textEditingController: _cardCVVTextEditingController),
                  ),
                ],
              ),

              //Submit Button
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: AccentButton(
                  title:
                      "Pay ${widget.paymentInfo.currency} ${widget.paymentInfo.formatedAmount}",
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.

                      print("Valid");
                      String cardNumber = CardUtils.getCleanedNumber(
                          _cardNumberTextEditingController.text);
                      String cardCVV = _cardCVVTextEditingController.text;
                      int cardExpiryMonth = CardUtils.getExpiryDate(
                          _cardExpiryTextEditingController.text)[0];
                      int cardExpiryYear = CardUtils.getExpiryDate(
                          _cardExpiryTextEditingController.text)[1];

                      final mPaymentCard = PaymentCard(
                        number: cardNumber,
                        cvv: cardCVV,
                        month: cardExpiryMonth.toString(),
                        year: cardExpiryYear.toString(),
                      );

                      widget.paymentInfo.paymentCard = mPaymentCard;

                      //send the payment info to the parent view to start processing the transaction
                      widget.onSubmit(widget.paymentInfo);
                    } else {
                      print("Invalid");
                    }
                  },
                ),
              ),

              //Secured By Footer
              SizedBox(
                height: 40,
              ),
              SecuredByFooter(),
            ],
          ),
        ),
      ],
    );
  }
}
