import 'package:flutter/material.dart';
import 'package:flutter_paystack/models/payment_info.dart';
import 'package:flutter_paystack/utils/ui_color.dart';


class PaymentOptionHeader extends StatefulWidget {
  const PaymentOptionHeader({
    Key key,
    @required this.paymentInfo,
  }) : super(key: key);

  final PaymentInfo paymentInfo;

  @override
  _PaymentOptionHeaderState createState() => _PaymentOptionHeaderState();
}

class _PaymentOptionHeaderState extends State<PaymentOptionHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //Company/app logo
        Image.asset(
          widget.paymentInfo.companyAssetImage ?? "assets/images/paystack_icon.png",
          width: 30,
          height: 30,
        ),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //Customer email address
              Text(widget.paymentInfo.email),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Pay "),
                  Text(
                    "${widget.paymentInfo.currency} ${widget.paymentInfo.formatedAmount}",
                    style: TextStyle(
                      color: UIColors.accentColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
