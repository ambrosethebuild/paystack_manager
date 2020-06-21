import 'package:intl/intl.dart';
import 'package:flutter_paystack/models/payment_card.dart';

class PaymentInfo {
  
  String secretKey;
  String companyAssetImage;
  int amount;
  String country;
  String currency;
  String email;
  String firstName;
  String lastName;
  dynamic metadata;
  PaymentCard paymentCard;

  String get formatedAmount {    
    
    double hundredth = this.amount / 100;
    String hundredthInDecimal = NumberFormat("#,###.00").format(hundredth);
    return hundredthInDecimal;

  }

  PaymentInfo({
    this.secretKey,
    this.companyAssetImage,
    this.amount,
    this.country,
    this.currency,
    this.email,
    this.firstName,
    this.lastName,
    this.metadata,
    this.paymentCard,
  });

}
