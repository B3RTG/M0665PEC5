import 'package:flutter/material.dart';
import 'counter_widget.dart';

class RedWidget extends StatelessWidget {
  const RedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        color: Colors.red[200],
        child: const CounterWidget(),
      ),
    );
  }
}
