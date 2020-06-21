import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_paystack/models/payment_info.dart';
import 'package:flutter_paystack/utils/ui_color.dart';
import 'package:flutter_paystack/widgets/payment_option_header.dart';
import 'package:flutter_paystack/widgets/secured_by.dart';


class PaymentFailedView extends StatefulWidget {
  PaymentFailedView({
    Key key,
    this.paymentInfo,
    this.message,
    this.title = "Transaction Failed",
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final String message;
  final String title;

  @override
  _PaymentFailedViewState createState() => _PaymentFailedViewState();
}

class _PaymentFailedViewState extends State<PaymentFailedView> {
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
        Icon(
          //Icons.close,
          FlutterIcons.error_mdi,
          size: 48,
          color: Colors.red,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: UIColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            widget.message,
            style: TextStyle(
              color: UIColors.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        SecuredByFooter(),
      ],
    );
  }
}
