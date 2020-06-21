import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_paystack/data/payment_options.dart';
import 'package:flutter_paystack/models/payment_info.dart';
import 'package:flutter_paystack/models/payment_option.dart';
import 'package:flutter_paystack/utils/ui_color.dart';
import 'package:flutter_paystack/utils/ui_strings.dart';
import 'package:flutter_paystack/widgets/accent_button.dart';
import 'package:flutter_paystack/widgets/payment_option_header.dart';
import 'package:flutter_paystack/widgets/secured_by.dart';
import 'package:flutter_paystack/widgets/text_input_field.dart';


class BankPaymentView extends StatefulWidget {
  BankPaymentView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _BankPaymentViewState createState() => _BankPaymentViewState();
}

class _BankPaymentViewState extends State<BankPaymentView> {
  //TextEditingController
  TextEditingController _accountNumberTextEditingController =
      new TextEditingController();

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  //List of available payment options
  List<PaymentOption> bankOptionslist = PaymentOptions.getBankList();
  PaymentOption _selectedBankOption;

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
            //FontAwesome.mobile_phone,
            // FlutterIcons.smartphone_fea,
            FlutterIcons.bank_mco,
            // FlutterIcons.md_phone_portrait_ion,
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
                color: UIColors.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Colors.grey[500]),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: SizedBox.shrink(),
              elevation: 16,
              hint: Text("Select Bank"),
              items: bankOptionslist
                  .map(
                    (paymentOption) => DropdownMenuItem<PaymentOption>(
                      value: paymentOption,
                      child: Text(paymentOption.name),
                    ),
                  )
                  .toList(),
              onChanged: (PaymentOption newValue) {
                setState(() {
                  _selectedBankOption = newValue;
                });
              },
              value: _selectedBankOption,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "Account Number",
            textEditingController: _accountNumberTextEditingController,
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return UIStrings.fieldReq;
              } else if (value.length != 10) {
                return "Invalid Account Number";
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
                widget.onSubmit(
                  _selectedBankOption.slug,
                  _accountNumberTextEditingController.text,
                );
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
