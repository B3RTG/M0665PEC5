import 'package:flutter/material.dart';
import 'button_widget.dart';

class BlueWidget extends StatelessWidget {
  const BlueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        color: Colors.blue[200],
        child: const ButtonWidget(),
      ),
    );
  }
}
