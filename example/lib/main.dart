import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_viewer/flutter_text_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextViewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Load asset text'),
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return TextViewerPage(
                  textViewer: TextViewer.asset(
                    'assets/test.txt',
                    highLightColor: Colors.yellow,
                    focusColor: Colors.orange,
                    ignoreCase: true,
                    onErrorCallback: (error) {
                      // show error in your UI
                      if (kDebugMode) {
                        print("Error: $error");
                      }
                    },
                  ),
                  showSearchAppBar: true,
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
