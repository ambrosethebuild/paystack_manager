import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:paystack_manager/widgets/payment_option_header.dart';
import 'package:paystack_manager/widgets/secured_by.dart';

class PaymentPINEntryView extends StatefulWidget {
  PaymentPINEntryView({
    Key key,
    this.paymentInfo,
    this.message,
    this.onSubmit,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final Function onSubmit;

  @override
  _PaymentPINEntryViewState createState() => _PaymentPINEntryViewState();
}

class _PaymentPINEntryViewState extends State<PaymentPINEntryView> {
  //Stream Controller
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  //TextEditingController
  TextEditingController pinTextEditingController = new TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(
        color: UIColors.accentColor,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

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
        SizedBox(
          height: 40,
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
        PinPut(
          fieldsAlignment: MainAxisAlignment.spaceEvenly,
          fieldsCount: 4,
          onSubmit: widget.onSubmit,
          focusNode: _pinPutFocusNode,
          controller: pinTextEditingController,
          submittedFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(20),
          ),
          selectedFieldDecoration: _pinPutDecoration,
          followingFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: UIColors.accentColor.withOpacity(.5),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        SecuredByFooter(),
      ],
    );
  }
}
