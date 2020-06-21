import 'package:flutter/material.dart';
import 'package:paystack_manager/models/payment_option.dart';
import 'package:paystack_manager/utils/ui_color.dart';
class PaymentOptionListViewItem extends StatelessWidget {
  const PaymentOptionListViewItem({
    Key key,
    @required this.paymentOption,
    this.onPressed,
  }) : super(key: key);

  final PaymentOption paymentOption;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Icon(
                paymentOption.iconData,
                size: 16,
                color: UIColors.primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Pay with ${paymentOption.name}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: UIColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
