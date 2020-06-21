import 'package:flutter/material.dart';

class PaymentOption {
  String name;
  IconData iconData;
  String slug;
  bool isCard;
  bool isBank;
  bool isMomo;

  PaymentOption({
    @required this.name,
    @required this.iconData,
    @required this.slug,
    this.isCard = false,
    this.isBank = false,
    this.isMomo = false,
  });
}
