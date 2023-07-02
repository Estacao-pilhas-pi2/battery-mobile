import 'package:estacao_pilhas/pages/payment_history/controllers/payment_history_controller.dart';
import 'package:flutter/material.dart';

import '../../models/payment_report.dart';
import 'components/payment_card.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  bool isScreenLoading = false;
  List<PaymentReport> paymentReportList = [];

  @override
  void initState() {
    super.initState();

    initialRequest();
  }

  Future<void> initialRequest() async {
    List<PaymentReport> requestedPaymentReportList =
        await PaymentHistoryController().getPaymentHistory();

    setState(() {
      paymentReportList = requestedPaymentReportList;
      isScreenLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Histórico"),
        ),
        body: isScreenLoading
            ? const Center(child: CircularProgressIndicator())
            : paymentReportList.isEmpty
                ? const Center(
                    child: Text("Nenhum pagamento encontrado"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: paymentReportList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: PaymentCard(
                          paymentReport: paymentReportList[index],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
