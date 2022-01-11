import 'package:flutter/material.dart';
import 'red_widget.dart';

class OrangeWidget extends StatelessWidget {
  const OrangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.orange[200],
        child: const RedWidget(),
      ),
    );
  }
}
