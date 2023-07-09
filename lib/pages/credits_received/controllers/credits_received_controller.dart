import 'package:estacao_pilhas/models/payment.dart';
import 'package:estacao_pilhas/services/payment_service.dart';

class CreditsReceivedController {
  Future makePayment(String paymentId) async {
    try {
      Payment requestedPayment = await PaymentService().makePayment(paymentId);

      return requestedPayment;
    } catch (error) {
      return error.toString();
    }
  }
}
