import 'package:estacao_pilhas/models/payment_report.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';

class PaymentHistoryController {
  Future<List<PaymentReport>> getPaymentHistory() async {
    List<PaymentReport> paymentReportList = [];

    paymentReportList = await UsuarioService().getPaymentReports();

    return paymentReportList;
  }
}
