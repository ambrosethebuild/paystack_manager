import 'package:flutter/material.dart';
import 'package:paystack_manager/models/transaction.dart';
import 'package:paystack_manager/paystack_pay_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paystack Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //initiate payment button
            RaisedButton(
              onPressed: _processPayment,
              child: Text(
                "Pay",
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _processPayment() {
    try {

      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_7e3a3dbff5d7b8b2ee7e61125b503ecbba8c850f")
        //accepts widget
        ..setCompanyAssetImage(
          Image(
            image: AssetImage("assets/images/logo.png"),
          )
        )
        ..setAmount(152)
		..setReference("your-transaction-reference")
        ..setCurrency("GHS")
        ..setEmail("bakoambrose@gmail.com")
        ..setFirstName("Ambrose")
        ..setLastName("Bako")
        ..setMetadata(
          {
            "custom_fields": [
              {
                "value": "snapTask",
                "display_name": "Payment to",
                "variable_name": "payment_to"
              }
            ]
          },
        )
        ..onSuccesful(_onPaymentSuccessful)
        ..onFailed(_onPaymentFailed)
        ..onCancel(_onPaymentCancelled)
        ..initialize();

    } catch (error) {
      print("Payment Error ==> $error");
    }

  }


  void _onPaymentSuccessful(Transaction transaction){
    print("Transaction was successful");
    print("Transaction Message ===> ${transaction.message}");
    print("Transaction Refrence ===> ${transaction.refrenceNumber}");
  }

  void _onPaymentFailed(Transaction transaction){
    print("Transaction failed");
  }

  void _onPaymentCancelled(Transaction transaction){
    print("Transaction was cancelled");
  }


}
