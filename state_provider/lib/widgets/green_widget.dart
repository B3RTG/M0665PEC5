import 'package:flutter/material.dart';
import 'blue_widget.dart';

class GreenWidget extends StatelessWidget {
  const GreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: const BlueWidget(),
    );
  }
}
