import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_paystack/models/payment_info.dart';
import 'package:flutter_paystack/utils/ui_color.dart';
import 'package:flutter_paystack/widgets/accent_button.dart';
import 'package:flutter_paystack/widgets/payment_option_header.dart';
import 'package:flutter_paystack/widgets/secured_by.dart';
import 'package:flutter_paystack/widgets/text_input_field.dart';

class PaymentPhoneEntryView extends StatefulWidget {
  PaymentPhoneEntryView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _PaymentPhoneEntryViewState createState() => _PaymentPhoneEntryViewState();
}

class _PaymentPhoneEntryViewState extends State<PaymentPhoneEntryView> {
  //TextEditingController
  TextEditingController _phoneNumberTextEditingController = new TextEditingController();

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Use the must basic widgets for normal undestanding sha
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          //Header View
          PaymentOptionHeader(
            paymentInfo: widget.paymentInfo,
          ),
          Divider(
            height: 30,
          ),
          SizedBox(
            height: 40,
          ),
          Icon(
            FontAwesome.mobile_phone,
            size: 42,
            color: UIColors.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              widget.message,
              style: TextStyle(
                color:UIColors.primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "Phone Number",
            textEditingController: _phoneNumberTextEditingController,
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty || value.length < 10 || value.length > 13 ) {
                return "Invalid Phone Number";
              }

              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          AccentButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                print("Valid");
                widget.onSubmit( _phoneNumberTextEditingController.text );
              } else {
                print("Invalid");
              }
            },
            title: "Submit",
          ),
          SizedBox(
            height: 50,
          ),
          SecuredByFooter(),
        ],
      ),
    );
  }
}
