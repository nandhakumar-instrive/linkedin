import 'package:flutter/material.dart';
import 'package:linkedin/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FirstWidget(),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (builder) => AlertDialog(
              content: Container(
                color: Colors.red,
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
          );
          await Network.signinWithLinkedIn()
              .then((value) => Navigator.pop(context));
        },
        child: Icon(
          Icons.login,
        ),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
