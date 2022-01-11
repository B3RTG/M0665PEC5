import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: const Text(
                        'CURRENT URL: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    ),
                    const Text(
                      'https://flutter.dev/',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const Expanded(
                child: WebView(
                  initialUrl: "https://flutter.dev/",
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              )
            ],
          ),
        ));
  }
}


// class MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://flutter.dev',
//     );
//   }
// }