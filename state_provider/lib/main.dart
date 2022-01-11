import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/model/counter_model.dart';
import 'widgets/green_widget.dart';
import 'widgets/orange_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          title: const Text('Lifting up state'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            GreenWidget(),
            OrangeWidget(),
          ],
        ),
      ),
    );
  }
}
