import 'package:flutter/material.dart';
import 'package:flutter_paystack/models/payment_info.dart';
import 'package:flutter_paystack/utils/ui_color.dart';
import 'package:flutter_paystack/utils/ui_strings.dart';
import 'package:flutter_paystack/widgets/accent_button.dart';
import 'package:flutter_paystack/widgets/payment_option_header.dart';
import 'package:flutter_paystack/widgets/secured_by.dart';
import 'package:flutter_paystack/widgets/text_input_field.dart';

class PaymentBirthDayEntryView extends StatefulWidget {
  PaymentBirthDayEntryView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _PaymentBirthDayEntryViewState createState() =>
      _PaymentBirthDayEntryViewState();
}

class _PaymentBirthDayEntryViewState extends State<PaymentBirthDayEntryView> {
  
  //TextEditingController
  TextEditingController _dobTextEditingController = new TextEditingController();

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
          Image.asset(
            "assets/images/dob.png",
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
            labelText: "Date of Birth",
            textEditingController: _dobTextEditingController,
            hintText: "YYYY-MM-DD",
            readyOnly: true,
            validator: ( String value ){

              if( value.isEmpty ){
                return UIStrings.fieldReq;
              }
              return null;

            },
            onTap: () async {

              //Date of birth picker
              final selectedDateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(
                  1900,
                  1,
                  1,
                ),
                initialDate: DateTime.now(),
                lastDate: DateTime(
                  DateTime.now().year,
                  12,
                  31,
                ),
              );

              //ON user select date time
              if( selectedDateTime != null ){
                _dobTextEditingController.text = "${selectedDateTime.year}-${selectedDateTime.month}-${selectedDateTime.day}";
              }


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
                widget.onSubmit(_dobTextEditingController.text);
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
