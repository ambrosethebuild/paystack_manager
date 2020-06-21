import 'package:dio/dio.dart';
import 'package:flutter_paystack/models/api_response.dart';
import 'package:flutter_paystack/models/payment_info.dart';

import 'apis.dart';

class PaystackPaymentApi {
  //Innstance of dio class
  static BaseOptions options = new BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  static Dio dio = new Dio(options);

  static Future<APIResponse> chargeCard({
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "email": paymentInfo.email,
      "amount": paymentInfo.amount,
      "currency": paymentInfo.currency,
      "metadata": paymentInfo.metadata,
      "card": {
        "number": paymentInfo.paymentCard.number,
        "cvv": paymentInfo.paymentCard.cvv,
        "expiry_month": paymentInfo.paymentCard.month,
        "expiry_year": paymentInfo.paymentCard.year
      },
    };

    try {
      var response = await dio.post(
        APIs.chargeUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> sendPIN({
    PaymentInfo paymentInfo,
    String refrence,
    String pin,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "pin": pin,
      "reference": refrence,
    };

    try {
      var response = await dio.post(
        APIs.submitPINUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> sendOTP({
    String refrence,
    String otp,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "otp": otp,
      "reference": refrence,
    };

    try {
      var response = await dio.post(
        APIs.submitOTPUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> sendPhone({
    String refrence,
    String phone,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "phone": phone,
      "reference": refrence,
    };

    try {
      var response = await dio.post(
        APIs.submitPhoneUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> verifyTransaction({
    String refrence,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    try {
      var response = await dio.get(
        //for reading purpose
        APIs.verifyUrl + "" + refrence,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> sendBirthday({
    String refrence,
    String dob,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "birthday": dob,
      "reference": refrence,
    };

    try {
      var response = await dio.post(
        APIs.submitBirthDayUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> sendAddress({
    String refrence,
    String address,
    String city,
    String state,
    String zipCode,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "address": address,
      "city": city,
      "state": state,
      "zipcode": zipCode,
      "reference": refrence,
    };

    try {
      var response = await dio.post(
        APIs.submitAddressUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }

  static Future<APIResponse> mobileMoneyPayment({
    String provider,
    String phone,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "email": paymentInfo.email,
      "amount": paymentInfo.amount,
      "currency": paymentInfo.currency,
      "metadata": paymentInfo.metadata,
      "mobile_money": {
        "phone": phone,
        "provider": provider,
      },
    };

    try {
      var response = await dio.post(
        APIs.chargeUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          //errorMessage = response.data["message"];
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }


  static Future<APIResponse> bankPayment({
    String code,
    String accountNumber,
    PaymentInfo paymentInfo,
  }) async {
    APIResponse apiResponse;

    //Preparing request payload
    final Map<String, dynamic> formDataMap = {
      "email": paymentInfo.email,
      "amount": paymentInfo.amount,
      "currency": paymentInfo.currency,
      "metadata": paymentInfo.metadata,
      "bank": {
        "code": code,
        "account_number": accountNumber,
      },
    };

    try {
      var response = await dio.post(
        APIs.chargeUrl,
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${paymentInfo.secretKey}',
          },
        ),
      );

      if (response.statusCode == 200) {
        //format the response data for system to continue operating
        apiResponse = APIResponse.fromObject(response.data);
      } else {
        var errorMessage = "Request Failed. Please try again later";

        try {
          //alert the user with the message from the server
          //errorMessage = response.data["message"];
          errorMessage =
              response.data["data"]["message"] ?? response.data["message"];
        } catch (error) {
          print("Error Data Getting Failed:: $error");
        }

        throw errorMessage;
      }
    } catch (error) {
      DioError dioError = error as DioError;
      var errorMessage = "Request Failed. Please try again later";

      try {
        //alert the user with the message from the server
        // final jsonObject = convert.jsonDecode(error.message);
        errorMessage = dioError.response.data["data"]["message"] ??
            dioError.response.data["message"];
      } catch (error) {
        print("Error Data Getting Failed:: $error");
      }

      throw errorMessage;
    }

    return apiResponse;
  }
}
