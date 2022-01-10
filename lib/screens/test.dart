import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  static String routeName = "/test";
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Bolt"),
      ),
      body: Center(child: Container(
        child: Text("Payment Page"),
      )),
    ));
  }
}
