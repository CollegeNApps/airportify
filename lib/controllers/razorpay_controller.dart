import 'dart:developer';

import 'package:airportify/getx_ui/client_app/confirmation_screen.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController extends GetxController {
  late Razorpay _razorpay;
  String? paymentId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    log("Payement Successful");

    Get.to(() => const ConfirmationScreen());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("Error message: ${response.message}");
    Get.snackbar("Payment Failed", "Error message :${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
        "Activated external Wallet", "Wallet name : ${response.walletName}");
  }

  void openCheckout(String name, int amount, String contact, String email,
      List<String> wallet, String hostContact) async {
    log("Amount passed :$amount");
    var options = {
      // 'key': 'rzp_live_bYaxNTVqnmHDQH',
      'key': 'rzp_test_7uUd0RnbbGsOzd',
      'amount': amount * 100,
      'name': name,
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': [wallet]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log('Error: $e');
    }
  }
}
