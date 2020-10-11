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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
              Expanded(
                child: Text(
                  "Pay with ${paymentOption.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: UIColors.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
