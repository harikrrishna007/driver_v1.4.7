import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadedScreen extends StatelessWidget {
  static String routeName = "/uploaded";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline_rounded, color: Color(0XFF11D86F), size: 128.0,),
                SizedBox(height: 32.0,),
                Text("        Uploaded Succesfully\nDocuments sent for verification", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
