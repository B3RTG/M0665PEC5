import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/model/counter_model.dart';

class CounterWidget extends StatelessWidget {
  final counter = 42;

  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        color: Colors.purple[200],
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: consumerCounterModel()),
        ),
      ),
    );
  }

  Widget consumerCounterModel() {
    return Consumer<CounterModel>(
      builder: (context, counter, child) {
        return Text(
          counter.count.toString(),
          style: const TextStyle(
            fontSize: 42.0,
            letterSpacing: -2.0,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
