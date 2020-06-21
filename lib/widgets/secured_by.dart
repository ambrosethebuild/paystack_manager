import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_paystack/utils/ui_color.dart';


class SecuredByFooter extends StatelessWidget {
  const SecuredByFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          // Icons.lock,
          FontAwesome.lock,
          size: 18,
          color: UIColors.primaryColor,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Secured by",
          style: TextStyle(
            color: UIColors.primaryColor,
          ),
        ),
        SizedBox(
          width: 5,
        ),        
        Image(
          image: AssetImage("assets/images/paystack.png", package: "flutter_paystack"),
          height: 30,
          width: 80,
        ),
      ],
    );
  }
}
