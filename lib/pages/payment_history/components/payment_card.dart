import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/globals/utils.dart';
import 'package:estacao_pilhas/models/payment_report.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final PaymentReport paymentReport;
  const PaymentCard({super.key, required this.paymentReport});

  @override
  Widget build(BuildContext context) {
    Widget singleLineInformation(IconData icon, String text) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Icon(
              icon,
              color: AppColors.appTheme.primaryColor,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: AppColors.appTheme.primaryColor),
          )
        ],
      );
    }

    Widget doubleLineInformation(
        String batteryType, int qtdPilhas, double precoPilha) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                batteryType,
                style: const TextStyle(fontSize: 11),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$qtdPilhas Pilhas",
                  style: const TextStyle(fontSize: 11),
                ),
                Text(
                  "$precoPilha Créditos",
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.appTheme.primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                singleLineInformation(Icons.attach_money_outlined,
                    "${paymentReport.valorTotal} Créditos"),
                const Spacer(),
                singleLineInformation(Icons.calendar_month,
                    Utils.formatData(paymentReport.dataVencimento!)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  doubleLineInformation(
                      "AAA",
                      paymentReport.quantidadePilhaAAA!,
                      paymentReport.quantidadePilhaAAA! *
                          paymentReport.precoAAA!),
                  doubleLineInformation(
                      "AA",
                      paymentReport.quantidadePilhaAA!,
                      paymentReport.quantidadePilhaAA! *
                          paymentReport.precoAA!),
                ],
              ),
              Column(
                children: [
                  doubleLineInformation("C", paymentReport.quantidadePilhaC!,
                      paymentReport.quantidadePilhaC! * paymentReport.precoC!),
                  doubleLineInformation("D", paymentReport.quantidadePilhaD!,
                      paymentReport.quantidadePilhaD! * paymentReport.precoD!),
                ],
              ),
              Column(
                children: [
                  doubleLineInformation(
                      "9V",
                      paymentReport.quantidadePilhaV9!,
                      paymentReport.quantidadePilhaV9! *
                          paymentReport.precoV9!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
