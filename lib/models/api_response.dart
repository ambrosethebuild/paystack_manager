import 'package:paystack_manager/models/transaction_status.dart';

class APIResponse {
  bool status;
  String statusMessage;
  dynamic data;
  String reference;
  String dataMessage;
  TransactionState nextAction;
  String displayText;
  String authUrl;

  APIResponse({
    this.status,
    this.statusMessage,
    this.data,
    this.reference,
    this.dataMessage,
    this.nextAction,
    this.displayText,
    this.authUrl,
  });

  factory APIResponse.fromObject(dynamic object) {
    final apiResponse = APIResponse();
    apiResponse.status = object["status"];
    apiResponse.statusMessage = object["message"];
    apiResponse.data = object["data"];
    apiResponse.reference = apiResponse.data["reference"];
    apiResponse.dataMessage = apiResponse.data["message"] ?? "";
    apiResponse.displayText = apiResponse.data["display_text"] ?? "";
    apiResponse.authUrl = apiResponse.data["url"] ?? "";

    TransactionState mNextAction = TransactionState.PENDING;

    switch (apiResponse.data["status"]) {
      case "pending":
        mNextAction = TransactionState.PENDING;
        break;
      case "failed":
        mNextAction = TransactionState.FAILED;
        break;
      case "success":
        mNextAction = TransactionState.SUCCESS;
        break;
      case "send_otp":
        mNextAction = TransactionState.SEND_OTP;
        break;
      case "send_pin":
        mNextAction = TransactionState.SEND_PIN;
        break;
      case "send_phone":
        mNextAction = TransactionState.SEND_PHONE;
        break;
      case "send_birthday":
        mNextAction = TransactionState.SEND_BIRTHDATE;
        break;
      case "pay_offline":
        mNextAction = TransactionState.PAY_OFFLINE;
        break;
      case "send_address":
        mNextAction = TransactionState.SEND_ADDRESS;
        break;
      case "open_url":
        mNextAction = TransactionState.SEND_AUTH_URL;
        break;
      default:
        mNextAction = TransactionState.PENDING;
        break;
    }

    apiResponse.nextAction = mNextAction;

    return apiResponse;
  }
}
