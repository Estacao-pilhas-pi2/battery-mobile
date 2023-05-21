import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class LocationErrorDialog extends StatefulWidget {
  final String error;

  const LocationErrorDialog(this.error, {super.key});

  @override
  State<LocationErrorDialog> createState() => _LocationErrorDialogState();
}

class _LocationErrorDialogState extends State<LocationErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: const Center(child: Text('Informações')),
      content: Text(widget.error),
      actions: [
        ElevatedButton(
          onPressed: () => AppSettings.openLocationSettings(),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          child: const Text(
            "Ir para configurações",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
