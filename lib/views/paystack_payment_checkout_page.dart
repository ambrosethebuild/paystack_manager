import 'package:flutter/material.dart';
import 'package:paystack_manager/api/paystack_payment_api.dart';
import 'package:paystack_manager/data/payment_options.dart';
import 'package:paystack_manager/models/api_response.dart';
import 'package:paystack_manager/models/payment_info.dart';
import 'package:paystack_manager/models/payment_option.dart';
import 'package:paystack_manager/models/transaction.dart';
import 'package:paystack_manager/models/transaction_status.dart';
import 'package:paystack_manager/utils/custom_dialog.dart';
import 'package:paystack_manager/widgets/bank_payment_view.dart';
import 'package:paystack_manager/widgets/card_payment_view.dart';
import 'package:paystack_manager/widgets/loading_Transaction_view.dart';
import 'package:paystack_manager/widgets/mobile_money_payment_view.dart';
import 'package:paystack_manager/widgets/payment_address_entry_view.dart';
import 'package:paystack_manager/widgets/payment_bank_auth_view.dart';
import 'package:paystack_manager/widgets/payment_birthday_entry_view.dart';
import 'package:paystack_manager/widgets/payment_failed_view.dart';
import 'package:paystack_manager/widgets/payment_option_list_view_item.dart';
import 'package:paystack_manager/widgets/payment_options_selector_view.dart';
import 'package:paystack_manager/widgets/payment_otp_entry_view.dart';
import 'package:paystack_manager/widgets/payment_phone_entry.dart';
import 'package:paystack_manager/widgets/payment_pin_entry_view.dart';

class PaystackPaymentCheckOutPage extends StatefulWidget {
  PaystackPaymentCheckOutPage({
    Key key,
    @required this.paymentInfo,
  }) : super(key: key);

  final PaymentInfo paymentInfo;

  @override
  _PaystackPaymentCheckOutPageState createState() =>
      _PaystackPaymentCheckOutPageState();
}

class _PaystackPaymentCheckOutPageState
    extends State<PaystackPaymentCheckOutPage> {
  //Selected Payment Option Model
  PaymentOption _selectedPaymentOption;
  //Payment Info Object
  PaymentInfo _paymentInfo;

  //Page Status Enum
  //use to handle the flow of UI Changes
  TransactionState _transactionState = TransactionState.Idle;
  //Mesage to show user during loading
  String _transactionStateMessage = "";
  String _transactionReference = "";
  String _bankAuthUrl = "";

  @override
  Widget build(BuildContext context) {
    //List of available payment options
    List<PaymentOption> paymentOptionslist = PaymentOptions.getList(
      currency: widget.paymentInfo.currency,
    );

    //Page body context
    Widget pageBodyContent;

    //conditions to determine with UI widget to show
    switch (_transactionState) {
      case TransactionState.Idle:

        //The view to show when user hasn't select a payment option
        if (_selectedPaymentOption == null) {
          pageBodyContent = PaymentOptionSelectorView(
            paymentInfo: widget.paymentInfo,
            paymentOptionslist: paymentOptionslist,
            onItemPressed: (PaymentOption paymentOption) {
              setState(() {
                _selectedPaymentOption = paymentOption;
              });
            },
          );
        }
        //The view to show when user select CARD payment option
        else if (_selectedPaymentOption.isCard) {
          pageBodyContent = CardPaymentView(
            paymentInfo: widget.paymentInfo,
            onSubmit: _processCardPayment,
          );
        }
        //The view to show when user select BANK payment option
        else if (_selectedPaymentOption.isBank) {
          pageBodyContent = BankPaymentView(
            paymentInfo: widget.paymentInfo,
            message: "Please enter your bank account details",
            onSubmit: _processBankPayment,
          );
        }
        //The view to show when user select BANK payment option
        else if (_selectedPaymentOption.isMomo) {
          pageBodyContent = MobileMoneyPaymentView(
            paymentInfo: widget.paymentInfo,
            message: "Please enter your phone number",
            onSubmit: _processMobileMoneyPayment,
          );
        }
        break;

      case TransactionState.Loading:
        pageBodyContent = LoadingTransactionView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
        );
        break;

      case TransactionState.SEND_PIN:

        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Please enter your 4-digit pin to authorize this payment"
            : _transactionStateMessage;
        pageBodyContent = PaymentPINEntryView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
          onSubmit: _processSendPIN,
        );
        break;

      case TransactionState.SEND_OTP:

        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Please enter the otp sent to your phone"
            : _transactionStateMessage;
        pageBodyContent = PaymentOTPEntryView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
          onSubmit: _processSendOTP,
        );

        break;
      case TransactionState.SEND_PHONE:
        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Please enter your phone number"
            : _transactionStateMessage;
        pageBodyContent = PaymentPhoneEntryView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
          onSubmit: _processSendPhone,
        );
        break;

      case TransactionState.SEND_ADDRESS:
        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Please enter your address"
            : _transactionStateMessage;
        pageBodyContent = PaymentAddressEntryView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
          onSubmit: _processSendAddress,
        );
        break;

      case TransactionState.SEND_BIRTHDATE:
        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Please enter your date of birth"
            : _transactionStateMessage;
        pageBodyContent = PaymentBirthDayEntryView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
          onSubmit: _processSendDOB,
        );
        break;

      case TransactionState.SEND_AUTH_URL:
        //load the auth url in a webview for user to interacte with
        pageBodyContent = PaymentAuthView(
          authUrl: _bankAuthUrl,
        );
        break;

      case TransactionState.FAILED:
        //makinng sure there is instruction for the user
        _transactionStateMessage = _transactionStateMessage.isEmpty
            ? "Transaction Failed. please try again or use another payment option if possible"
            : _transactionStateMessage;
        pageBodyContent = PaymentFailedView(
          paymentInfo: widget.paymentInfo,
          message: _transactionStateMessage,
        );
        break;

      default:
        break;
    }

    return WillPopScope(
      //forbidden swipe in iOS(my ThemeData(platform: TargetPlatform.iOS,)
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: FlatButton(
            //when use close the payment page
            onPressed: _closePaystackPayment,
            child: Icon(
              Icons.close,
            ),
          ),
          //when user select a payment option. update the appbar title
          title: (_selectedPaymentOption != null)
              ? PaymentOptionListViewItem(
                  paymentOption: _selectedPaymentOption,
                )
              : SizedBox.shrink(),
          elevation: 0,
          backgroundColor: Colors.grey[200],
          brightness: Brightness.light,
          actions: <Widget>[
            //Show the change payment option
            //if user has selected a payment option and
            //the transaction state is not loading
            (_selectedPaymentOption != null &&
                    _transactionState != TransactionState.Loading &&
                    _transactionState != TransactionState.SUCCESS &&
                    _transactionState != TransactionState.SEND_AUTH_URL)
                ? FlatButton(
                    onPressed: () {
                      setState(() {
                        _selectedPaymentOption = null;
                        _transactionState = TransactionState.Idle;
                      });
                    },
                    child: Text("Change"),
                  )
                //else add an empty box
                : SizedBox.shrink(),
          ],
        ),
        body: Container(
          //if user hasn't select any payment option
          child: pageBodyContent,
        ),
      ),
    );
  }

  ///Functions
  ///Handle card payment process
  void _processCardPayment(PaymentInfo paymentInfo) async {
    //save the payment info for futher action
    _paymentInfo = paymentInfo;

    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.chargeCard(
        paymentInfo: paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;
      _bankAuthUrl = response.authUrl;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Card API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending PIN process
  void _processSendPIN(String pin) async {
    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.sendPIN(
        refrence: _transactionReference,
        pin: pin,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit OTP API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending OTP process
  void _processSendOTP(String otp) async {
    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.sendOTP(
        refrence: _transactionReference,
        otp: otp,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit OTP API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending Phone process
  void _processSendPhone(String phone) async {
    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.sendPhone(
        refrence: _transactionReference,
        phone: phone,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit Phone API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending DOB
  void _processSendDOB(String dob) async {
    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.sendBirthday(
        refrence: _transactionReference,
        dob: dob,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit Birthday API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending Address
  void _processSendAddress(
    String address,
    String city,
    String state,
    String zipCode,
  ) async {
    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.sendAddress(
        refrence: _transactionReference,
        address: address,
        city: city,
        state: state,
        zipCode: zipCode,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit Birthday API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //Handle Sending Mobile Money
  void _processMobileMoneyPayment(String provider, String phoneNumber) async {
    //for future refrence and usage
    _paymentInfo = widget.paymentInfo;

    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.mobileMoneyPayment(
        provider: provider,
        phone: phoneNumber,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit Mobile Money API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  void _processBankPayment(String bankCode, String accountNumber) async {
    //for future refrence and usage
    _paymentInfo = widget.paymentInfo;

    //show loading View
    _updatedViewState(
      TransactionState.Loading,
      "Process transaction. Please wait ...",
    );

    try {
      APIResponse response = await PaystackPaymentApi.bankPayment(
        code: bankCode,
        accountNumber: accountNumber,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //Checking if the api called was successful
      if (response.status) {
        //check of the transaction requires futher action
        _updatedViewState(
          response.nextAction,
          response.dataMessage,
          apiResponse: response,
        );
      }
      //else show the user an error/failed page
      else {
        _updatedViewState(
          TransactionState.FAILED,
          response.dataMessage,
          apiResponse: response,
        );
      }
    } catch (error) {
      print("Submit Bank API error  ==> $error");
      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  //
  void _closePaystackPayment() {
    //check if the use is at AUTH_URL
    if (_transactionState == TransactionState.SEND_AUTH_URL) {
      _retrieveTransactionStatus();
    } else {
      Transaction transaction = Transaction(
        state: TransactionState.CANCELLED,
        message: "You cancelled transaction/payment",
      );

      Navigator.pop(
        context,
        transaction,
      );
    }
  }

  void _retrieveTransactionStatus() async {
    //show loading dialog
    CustomDialog.showAlertDialog(
      context,
      title: "Status",
      message: "Checking transaction status. Please wait...",
      isDismissible: false,
    );

    try {
      //getting transaction status
      APIResponse response = await PaystackPaymentApi.verifyTransaction(
        refrence: _transactionReference,
        paymentInfo: _paymentInfo,
      );

      //save the transaction refrence for futher action
      _transactionReference = response.reference;

      //close alert dialog
      CustomDialog.dismissDialog(context);

      //Checking if the api called was successful
      //check of the transaction requires futher action
      _updatedViewState(
        response.nextAction,
        response.dataMessage,
        apiResponse: response,
      );
    } catch (error) {
      print("Verify Transaction API error  ==> $error");

      //close alert dialog
      CustomDialog.dismissDialog(context);

      _updatedViewState(
        TransactionState.FAILED,
        error.toString(),
      );
    }
  }

  void _updatedViewState(
    TransactionState transactionState,
    String transactionStateMessage, {
    APIResponse apiResponse,
  }) {
    setState(() {
      _transactionState = transactionState;
      _transactionStateMessage = transactionStateMessage;
    });

    if (transactionState == TransactionState.SUCCESS) {
      Transaction transaction = Transaction.fromObject(apiResponse);
      Navigator.pop(
        context,
        transaction,
      );
    } else if (transactionState == TransactionState.FAILED &&
        apiResponse != null) {
      Transaction transaction = Transaction.fromObject(apiResponse);
      Navigator.pop(
        context,
        transaction,
      );
    }
  }
}
