import 'dart:convert';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/models/address.dart';
import 'package:driver_app/screens/car_info.dart';
import 'package:driver_app/screens/documents.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/components/bottom_button.dart';
import 'package:driver_app/components/input_field.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:driver_app/widgets/progressDialog.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  static String routeName = "/register";
  final database = FirebaseDatabase.instance.reference();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0XFF11D86F),
          child: SafeArea(
            child: Container(
              color: Color(0XFF11D86F),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50.0,),
                  Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text(
                      'Welcome!\nRegister as a new Driver.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Brand Bold"
                      ),
                    ),
                  ),
                  SizedBox(height: 75.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height / 4,
                    child: Column(
                      children: [
                        SizedBox(height: 48.0,),
                        CustomTextField(
                          phoneTextEditingController: emailTextEditingController,
                          placeholder: "Email",
                          prefixIcon: Icons.mail,
                        ),
                        CustomTextField(
                          phoneTextEditingController: passwordTextEditingController,
                          placeholder: "Password",
                          prefixIcon: Icons.lock,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if(!emailTextEditingController.text.contains("@")) {
                                toastMessage("Enter a valid email", context);
                              }
                              else if(passwordTextEditingController.text.length < 8) {
                                toastMessage("Password should be minimum 8 characters", context);
                              }
                              else {
                                registerNewUser(context);
                              }
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
                                "Register",
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
      ),
    );
  }
  Future registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, Please wait...",);
        }
    );
    final APIURL = "https://saisatram.in/rideapis/api/driver/register.php";
    Map userDataMap = {
      "mail": emailTextEditingController.text.trim(),
      "password": passwordTextEditingController.text.trim()
    };
    http.Response response = await http.post(Uri.parse(APIURL),body:userDataMap);

    var data = jsonDecode(response.body);
    if(data['status'] == 1 && data['state'] == 'saved')
    {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, CarInfoScreen.routeName);
    }
    else if(data['state'] == 'saved') {
      Provider.of<AppData>(context, listen: false).updateUserBasic(data['driverid'], emailTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, CarInfoScreen.routeName);
    }
    else if(data['state'] == 'deets') {
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, DocumentVerificationScreen.routeName);
    }
    else if(data['state'] == 'docs') {
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, SubscriptionScreen.routeName);
    }
    else if(data['state'] == 'approved') {
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
    else {
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
  }
}

toastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}