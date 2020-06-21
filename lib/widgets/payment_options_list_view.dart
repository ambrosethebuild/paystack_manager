import 'package:flutter/material.dart';
import 'package:flutter_paystack/models/payment_option.dart';
import 'package:flutter_paystack/widgets/payment_option_list_view_item.dart';

class PaymentOptionsListview extends StatefulWidget {
  const PaymentOptionsListview({
    Key key,
    @required this.paymentOptionslist,
    this.onItemPressed,
  }) : super(key: key);

  final List<PaymentOption> paymentOptionslist;
  final Function onItemPressed;

  @override
  _PaymentOptionsListviewState createState() => _PaymentOptionsListviewState();
}

class _PaymentOptionsListviewState extends State<PaymentOptionsListview> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.paymentOptionslist.length,
      itemBuilder: (context, index) {

        final mPaymentOption = widget.paymentOptionslist[index];

        return PaymentOptionListViewItem(
          paymentOption: mPaymentOption,
          onPressed: () {
            widget.onItemPressed( mPaymentOption );
          },
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.grey[400],
        );
      },
    );
  }
}
