import 'package:estacao_pilhas/models/payment_report.dart';
import 'package:estacao_pilhas/services/payment_service.dart';

class PaymentHistoryController {
  Future<List<PaymentReport>> getPaymentHistory(int? maquinaId) async {
    List<PaymentReport> paymentReportList = [];

    if (maquinaId != null) {
      paymentReportList =
          await PaymentService().getPaymentMachineReports(maquinaId);
    } else {
      paymentReportList = await PaymentService().getPaymentReports();
    }

    return paymentReportList;
  }
}
