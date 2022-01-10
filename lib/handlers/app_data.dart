import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:driver_app/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppData extends ChangeNotifier {
  late Address userPickupLocation, userDropoffLocation;
  String? driverId, driverName, driverMobile, carNumber, carModel, driverMail, carColor;

  void updateuserPickupLocationAddress(Address pickupAddress) {
    userPickupLocation = pickupAddress;
    notifyListeners();
  }
  void updateuserDropoffLocationAddress(Address dropoffAddress) {
    userDropoffLocation = dropoffAddress;
    notifyListeners();
  }
  void updateDriverDetails(Response response) {
    var data = jsonDecode(response.body);
    data = data['data'];
    driverId = data['driverid'];
    driverMail = data['mail'];
    driverName = data['name'];
    driverMobile = data['mobile'];
    carNumber = data['number'];
    carModel = data['model'];
    carColor = data['color'];
    notifyListeners();
  }

  void updateDriverData(String name, String mobile, String number, String model, String color) {
    driverName = name;
    driverMobile = mobile;
    carNumber = number;
    carModel = model;
    carColor = color;
    notifyListeners();
  }

  void updateUserBasic(String id, String mail) {
    driverId = id;
    driverMail = mail;
    notifyListeners();
  }

  void updateUserDetails(String name, String mobile, String model, String number, String color) {
    driverName = name;
    driverMobile = mobile;
    carModel = model;
    carNumber = number;
    driverMobile = color;
    notifyListeners();
  }
}