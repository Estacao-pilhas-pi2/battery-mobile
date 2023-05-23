import 'package:flutter/material.dart';

class BaseForm extends StatelessWidget {
  final appBarText;
  final children;
  const BaseForm({super.key, this.appBarText, this.children});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppBar appBar = AppBar(
      title: Text(appBarText),
    );
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: size.height - appBar.preferredSize.height),
              child: Column(children: [children]),
            ),
          );
        },
      ),
    );
  }
}
