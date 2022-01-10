import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/components/bottom_button.dart';
import 'package:driver_app/components/input_field.dart';
import 'package:driver_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:driver_app/screens/home.dart';
import 'package:driver_app/screens/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:driver_app/widgets/progressDialog.dart';
import 'package:provider/provider.dart';

import 'car_info.dart';
import 'documents.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0XFF11D86F),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Welcome user,\nLogin to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Brand Bold"
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 1.97,
                  child: Column(
                    children: [
                      SizedBox(height: 50.0,),
                      CustomTextField(
                          phoneTextEditingController: emailTextEditingController,
                          placeholder: "Email",
                          prefixIcon: Icons.mail
                      ),
                      CustomTextField(
                          phoneTextEditingController: passwordTextEditingController,
                          placeholder: "Password",
                          prefixIcon: Icons.lock
                      ),
                      SizedBox(height: 32.0,),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            loginUser(context);
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0XFF11D86F),
                                borderRadius: BorderRadius.circular(64.0)),
                            margin: EdgeInsets.symmetric(
                              horizontal: 64.0,
                              vertical: 24.0,
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Brand Bold",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Authenticating, Please wait...",);
        }
    );
    final APIURL = "https://saisatram.in/rideapis/api/driver/login.php";
    Map userDataMap = {
      "mail": emailTextEditingController.text.trim(),
      "password": passwordTextEditingController.text.trim()
    };
    http.Response response = await http.post(Uri.parse(APIURL), body: userDataMap);

    //getting response from php code, here
    print(response.body);
    var data = jsonDecode(response.body);
    if(data['status'] == 1 && data['state'] == 'approved')
    {
      Provider.of<AppData>(context, listen: false).updateDriverDetails(response);
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
    else if(data['state'] == 'saved') {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, CarInfoScreen.routeName);
    }
    else if(data['state'] == 'deets') {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, DocumentVerificationScreen.routeName);
    }
    else if(data['state'] == 'docs') {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, SubscriptionScreen.routeName);
    }
    else if(data['state'] == 'approved') {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
    else {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
  }
}

toastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}