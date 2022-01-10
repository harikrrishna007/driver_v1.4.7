import 'package:driver_app/screens/car_info.dart';
import 'package:driver_app/screens/documents.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/screens/test.dart';
import 'package:driver_app/screens/uploaded.dart';
import 'package:flutter/widgets.dart';
import 'package:driver_app/screens/home.dart';
import 'package:driver_app/screens/login.dart';
import 'package:driver_app/screens/register.dart';
import 'screens/search_dropoff/search.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegistrationScreen.routeName:  (context) => RegistrationScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  CarInfoScreen.routeName: (context) => CarInfoScreen(),
  SubscriptionScreen.routeName: (context) => SubscriptionScreen(),
  DocumentVerificationScreen.routeName: (context) => DocumentVerificationScreen(),
  TestScreen.routeName: (context) => TestScreen(),
  UploadedScreen.routeName: (context) => UploadedScreen(),
};