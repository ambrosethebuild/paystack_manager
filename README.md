# Paystack Manager

A Flutter plugin for making payments via Paystack Payment Gateway. Fully supports Android and iOS.

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.dev/).

For help on editing plugin code, view the [documentation](https://flutter.dev/docs/development/packages-and-plugins/using-packages#edit-code).


## Usage

To use this package :

```yaml
dependencies:
    flutter:
      sdk: flutter
    paystack_manager:
```
Then initialize the package whenever you need it:

```dart

    PaystackPayManager(context: context)
        ..setSecretKey("sk_test_7e3a3dbff5d7b8b2ee7e61125b503ecbba8c850f")
        //accepts widget
        ..setCompanyAssetImage(
          Image(
            image: AssetImage("assets/images/logo.png"),
          )
        )
        ..setAmount(152)
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

```

No other configuration required—the plugin works out of the box.

## :helicopter: Testing your implementation
Paystack provides tons of [payment cards](https://developers.paystack.co/docs/test-cards) for testing.

## :arrow_forward: Running Example project
For help getting started with Flutter, view the online [documentation](https://flutter.io/).

An [example project](https://github.com/ambrosethebuild/paystack_manager/tree/master/example) has been provided in this plugin.
Clone this repo and navigate to the **example** folder. Open it with a supported IDE or execute `flutter run` from that folder in terminal.

## :pencil: Contributing, :disappointed: Issues and :bug: Bug Reports
The project is open to public contribution. Please feel very free to contribute.
Experienced an issue or want to report a bug? Please, [report it here](https://github.com/ambrosethebuild/paystack_manager/issues). Remember to be as descriptive as possible.

## :trophy: Credits
Thanks to the authors of Paystack [Flutter](https://github.com/wilburt/flutter_paystack). I leveraged on their work to bring this plugin to fruition.
