import 'package:estacao_pilhas/models/payment.dart';
import 'package:estacao_pilhas/services/maquina_service.dart';

class CreditsReceivedController {
  Future makePayment(String paymentId) async {
    try {
      Payment requestedPayment = await MaquinaService().makePayment(paymentId);

      return requestedPayment;
    } catch (error) {
      return error.toString();
    }
  }
}
