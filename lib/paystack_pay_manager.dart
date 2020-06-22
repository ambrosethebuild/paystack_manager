library paystack_manager;

// Expose the following files
export 'package:paystack_manager/paystack_pay_manager.dart';
export 'package:paystack_manager/models/transaction.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/models/transaction_status.dart';
import 'package:paystack_manager/views/paystack_payment_checkout_page.dart';

class PaystackPayManager {
  BuildContext _context;
  String _secretKey;
  String _reference;
  Widget _companyAssetImage;
  // String _publicKey;
  int _amount;
  String _country;
  String _currency;
  String _email;
  String _firstName;
  String _lastName;
  dynamic _metadata;

  //Response handler
  Function _onSuccessful;
  Function _onFailed;
  Function _onCancelled;

  PaystackPayManager({@required BuildContext context}) {
    this._context = context;
  }

  // setPublicKey(String publicKey) {
  //   _publicKey = publicKey;
  // }

  setSecretKey(String secretKey) {
    _secretKey = secretKey;
  }

  /*
   * Transaction reference
   */
  setReference(String reference) {
    _reference = reference;
  }

  /*
   * The company image to show user in place of the paystack logo/icon
   */
  setCompanyAssetImage(Widget companyAssetImage) {
    _companyAssetImage = companyAssetImage;
  }

  /*
   * Amount should be in kobo if currency is NGN and pesewas for GHS
   */
  setAmount(amount) {
    _amount = amount;
  }

  /*
   * The country code of the currecny to charge in
   * e.g NG( Nigeria ) or GH( Ghana )
   */
  setCountry(String country) {
    _country = country;
  }

  /*
   * The currecny code to charge in
   * e.g NGN( Nigeria ) or GHS( Ghana )
   */
  setCurrency(String currency) {
    _currency = currency;
  }

  /*
   * The email address of the customer
   */
  setEmail(String email) {
    _email = email;
  }

  /*
   * The first name of the customer (Optional)
   */
  setFirstName(String firstName) {
    _firstName = firstName;
  }

  /*
   * The last name of the customer (Optional)
   */
  setLastName(String lastName) {
    _lastName = lastName;
  }

  /*
   * A JSON object
   * e.g
   * {
    *   custom_fields: [
    *      {
    *        value: "makurdi",
    *        display_name: "Donation for",
    *        variable_name: "donation_for"
    *      }
    *    ]
   * }
   * 
   * for more info
   * https://paystack.com/docs/api/#charge
   */
  setMetadata(dynamic metadata) {
    _metadata = metadata;
  }

  initialize() async {
    // assert( _publicKey != null && _publicKey.isNotEmpty );
    assert(_secretKey != null && _secretKey.isNotEmpty);
    assert(_reference != null && _reference.isNotEmpty);
    assert(_email != null && _email.isNotEmpty);
    assert(_amount != null && _amount > 0);
    assert(_currency != null && _currency.isNotEmpty);

    final mPaymentInfo = PaymentInfo(
      secretKey: _secretKey,
      reference: _reference,
      amount: _amount,
      country: _country,
      currency: _currency,
      email: _email,
      firstName: _firstName,
      lastName: _lastName,
      metadata: _metadata,
      companyAssetImage: _companyAssetImage,
    );

    final transactionResult = await Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (BuildContext context) => PaystackPaymentCheckOutPage(
          paymentInfo: mPaymentInfo,
        ),
      ),
    );

    if (transactionResult.state == TransactionState.SUCCESS) {
      _onSuccessful(transactionResult);
    } else if (transactionResult.state == TransactionState.FAILED) {
      _onFailed(transactionResult);
    } else {
      _onCancelled(transactionResult);
    }
  }

  onSuccesful(Function onSuccesful) {
    _onSuccessful = onSuccesful;
  }

  onFailed(Function onFailed) {
    _onFailed = onFailed;
  }

  onCancel(Function onCancel) {
    _onCancelled = onCancel;
  }
}
