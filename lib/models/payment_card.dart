class PaymentCard {
  String number;
  String cvv;
  String month;
  String year;

  PaymentCard({
    this.number,
    this.cvv,
    this.month,
    this.year,
  });

  dynamic toJOSNObject() {
    return {
      "number": this.number,
      "cvv": this.cvv,
      "expiry_month": this.month,
      "expiry_year": this.year,
    };
  }
}
