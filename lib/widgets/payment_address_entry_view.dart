import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:paystack_manager/utils/ui_strings.dart';
import 'package:paystack_manager/widgets/accent_button.dart';
import 'package:paystack_manager/widgets/payment_option_header.dart';
import 'package:paystack_manager/widgets/secured_by.dart';
import 'package:paystack_manager/widgets/text_input_field.dart';

class PaymentAddressEntryView extends StatefulWidget {
  PaymentAddressEntryView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _PaymentAddressEntryViewState createState() =>
      _PaymentAddressEntryViewState();
}

class _PaymentAddressEntryViewState extends State<PaymentAddressEntryView> {
  //TextEditingController
  TextEditingController _addressTextEditingController =
      new TextEditingController();
  TextEditingController _cityTextEditingController =
      new TextEditingController();
  TextEditingController _stateTextEditingController =
      new TextEditingController();
  TextEditingController _zipCodeTextEditingController =
      new TextEditingController();

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
            MaterialCommunityIcons.map,
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
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "Address",
            textEditingController: _addressTextEditingController,
            validator: (String value) {
              if (value.isEmpty) {
                return UIStrings.fieldReq;
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "City",
            textEditingController: _cityTextEditingController,
            validator: (String value) {
              if (value.isEmpty) {
                return UIStrings.fieldReq;
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "State",
            textEditingController: _stateTextEditingController,
            validator: (String value) {
              if (value.isEmpty) {
                return UIStrings.fieldReq;
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputTextField(
            labelText: "Zip Code",
            textEditingController: _zipCodeTextEditingController,
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty) {
                return UIStrings.fieldReq;
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
                  _addressTextEditingController.text,
                  _cityTextEditingController.text,
                  _stateTextEditingController.text,
                  _zipCodeTextEditingController.text,
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
