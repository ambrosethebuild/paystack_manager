import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:paystack_manager/widgets/payment_option_header.dart';
import 'package:paystack_manager/widgets/secured_by.dart';

class LoadingTransactionView extends StatefulWidget {
  LoadingTransactionView({
    Key key,
    this.paymentInfo,
    this.message,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;

  @override
  _LoadingTransactionViewState createState() => _LoadingTransactionViewState();
}

class _LoadingTransactionViewState extends State<LoadingTransactionView> {
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
          height: 50,
        ),
        (Platform.isIOS)
            ? CupertinoActivityIndicator(
                radius: 15,
              )
            : Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      UIColors.primaryColor,
                    ),
                  ),
                  height: 30,
                  width: 30,
                ),
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
          height: 100,
        ),
        SecuredByFooter(),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
