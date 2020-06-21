import 'package:flutter/material.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:paystack_manager/widgets/accent_button.dart';
import 'package:paystack_manager/widgets/payment_option_header.dart';
import 'package:paystack_manager/widgets/secured_by.dart';
import 'package:paystack_manager/widgets/text_input_field.dart';

class PaymentOTPEntryView extends StatefulWidget {
  PaymentOTPEntryView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _PaymentOTPEntryViewState createState() => _PaymentOTPEntryViewState();
}

class _PaymentOTPEntryViewState extends State<PaymentOTPEntryView> {
  //TextEditingController
  TextEditingController pinTextEditingController = new TextEditingController();

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _otpTextEditingController = new TextEditingController();

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
          Image(
            image: AssetImage(
              "assets/images/otp.png",
              package: "paystack_manager",
            ),
            width: 30,
            height: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              widget.message,
              style: TextStyle(
                color: UIColors.primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "OTP",
            textEditingController: _otpTextEditingController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Invalid OTP";
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
                widget.onSubmit(_otpTextEditingController.text);
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
