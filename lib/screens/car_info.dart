import 'dart:convert';
import 'dart:io';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/screens/documents.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/progressDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:driver_app/components/input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'login.dart';

class CarInfoScreen extends StatefulWidget {
  static String routeName = "/carinfo";

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.0,),
              Image.asset("assets/images/logo.png", width: 390, height: 250.0,),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 0.0),
                child: Column(
                  children: [
                    Text(
                      "Enter Details",
                      style: TextStyle(
                        fontFamily: "Brand-Bold",
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(height: 24.0,),
                    CustomTextField(
                      placeholder: "Enter Your Name",
                      phoneTextEditingController: nameTextEditingController,
                      prefixIcon: Icons.person,
                    ),
                    CustomTextField(
                      placeholder: "Enter Your Mobile",
                      phoneTextEditingController: mobileTextEditingController,
                      prefixIcon: Icons.phone,
                    ),
                    CustomTextField(
                      placeholder: "Enter Your Car Model",
                      phoneTextEditingController: carModelTextEditingController,
                      prefixIcon: Icons.directions_car,
                    ),
                    CustomTextField(
                      placeholder: "Enter Your Car Number",
                      phoneTextEditingController: carNumberTextEditingController,
                      prefixIcon: Icons.keyboard,
                    ),
                    CustomTextField(
                      placeholder: "Enter Your Car Color",
                      phoneTextEditingController: carColorTextEditingController,
                      prefixIcon: Icons.color_lens,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          saveCarInfo(context);
                        },
                        child: Container(
                          height: 48.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFF11D86F),
                              borderRadius: BorderRadius.circular(64.0)),
                          margin: EdgeInsets.symmetric(
                            horizontal: 48.0,
                            vertical: 24.0,
                          ),
                          child: Text(
                            "Continue",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future saveCarInfo(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Saving Details, Please wait...",);
        }
    );
    final APIURL = "https://saisatram.in/rideapis/api/driver/details.php";
    Map userDataMap = {
      "driverid": Provider.of<AppData>(context, listen: false).driverId,
      "name": nameTextEditingController.text.trim(),
      "mobile": mobileTextEditingController.text.trim(),
      "model": carModelTextEditingController.text.trim(),
      "number": carNumberTextEditingController.text.trim(),
      "color": carColorTextEditingController.text.trim(),
    };
    http.Response response = await http.post(Uri.parse(APIURL),body:userDataMap);

    //getting response from php code, here
    var data = jsonDecode(response.body);
    if(data['status'] == 1) {
      Provider.of<AppData>(context, listen: false).updateDriverData(nameTextEditingController.text.trim(), mobileTextEditingController.text.trim(), carModelTextEditingController.text.trim(), carNumberTextEditingController.text.trim(), carColorTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, DocumentVerificationScreen.routeName);
    }
    else if(data['state'] == 'docs') {
      Provider.of<AppData>(context, listen: false).updateDriverData(nameTextEditingController.text.trim(), mobileTextEditingController.text.trim(), carModelTextEditingController.text.trim(), carNumberTextEditingController.text.trim(), carColorTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, SubscriptionScreen.routeName);
    }
    else if(data['state'] == 'approved') {
      Provider.of<AppData>(context, listen: false).updateDriverData(nameTextEditingController.text.trim(), mobileTextEditingController.text.trim(), carModelTextEditingController.text.trim(), carNumberTextEditingController.text.trim(), carColorTextEditingController.text.trim());
      toastMessage(data['message'], context);
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
    else {
      toastMessage(data['message'], context);
      Navigator.pop(context);
    }
  }
}