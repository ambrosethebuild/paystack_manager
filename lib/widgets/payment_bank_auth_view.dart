import 'package:flutter/material.dart';
import 'package:paystack_manager/utils/ui_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentAuthView extends StatefulWidget {
  PaymentAuthView({
    Key key,
    this.authUrl,
  }) : super(key: key);

  final String authUrl;

  @override
  _PaymentAuthViewState createState() => _PaymentAuthViewState();
}

class _PaymentAuthViewState extends State<PaymentAuthView> {
  //handle webview loading state change
  bool _showLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //toogle the linear loading progress indicator
        _showLoading
            ? LinearProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  UIColors.primaryColor,
                ),
              )
            : SizedBox.shrink(),

        //webview itself
        Expanded(
          child: WebView(
            initialUrl: widget.authUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String value) {
              setState(() {
                _showLoading = true;
              });
            },
            onPageFinished: (String value) {
              setState(() {
                _showLoading = false;
              });
            },
          ),
        ),
      ],
    );
  }
}
