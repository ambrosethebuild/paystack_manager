import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_paystack/models/payment_option.dart';

class PaymentOptions {
  static List<PaymentOption> getList({@required String currency}) {
    final cardOption = PaymentOption(
      name: "Card",
      iconData: Icons.credit_card,
      slug: "card",
      isCard: true,
    );

    final bankOption = PaymentOption(
      name: "Bank",
      iconData: MaterialCommunityIcons.bank,
      slug: "bank",
      isBank: true,
    );

    final mobileMoneyOption = PaymentOption(
      name: "Mobile Money",
      iconData: Icons.smartphone,
      slug: "momo",
      isMomo: true,
    );

    List<PaymentOption> paymentOptions = [];

    //add the card
    paymentOptions.add(cardOption);

    //only add mobile money if the currency is ghanian (GHS)
    if( currency.toUpperCase() == "NGN" ){
      paymentOptions.add(bankOption);
    }

    //only add mobile money if the currency is ghanian (GHS)
    if (currency.toUpperCase() == "GHS") {
      paymentOptions.add(mobileMoneyOption);
    }

    return paymentOptions;
  }

  static List<PaymentOption> getMobileMoneyList() {
    return [
      PaymentOption(
        name: "MTN",
        iconData: Icons.smartphone,
        slug: "mtn",
        isMomo: true,
      ),
      PaymentOption(
        name: "Vodafone",
        iconData: Icons.smartphone,
        slug: "vod",
        isMomo: true,
      ),
      PaymentOption(
        name: "Airtel/Tigo",
        iconData: Icons.smartphone,
        slug: "tgo",
        isMomo: true,
      ),
    ];
  }

  static List<PaymentOption> getBankList() {
    return [
      PaymentOption(
        name: "First Bank of Nigeria",
        iconData: FlutterIcons.bank_mco,
        slug: "011",
        isBank: true,
      ),
      PaymentOption(
        name: "Guaranty Trust Bank",
        iconData: FlutterIcons.bank_mco,
        slug: "058",
        isBank: true,
      ),
      PaymentOption(
        name: "United Bank For Africa",
        iconData: FlutterIcons.bank_mco,
        slug: "033",
        isBank: true,
      ),
      PaymentOption(
        name: "Zenith Bank",
        iconData: FlutterIcons.bank_mco,
        slug: "057",
        isBank: true,
      ),
    ];
  }


}
