import 'package:flutter/material.dart';
import 'package:state_provider/model/counter_model.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: TextButton(
        onPressed: () {
          // ignore: avoid_print
          print("Nothing happens when we press this button...");
          // ignore: avoid_print
          print("...but we want that counter to be updated!!!");
          Provider.of<CounterModel>(context, listen: false).increment();
        },
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Update counter',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 36.0,
              letterSpacing: -2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
