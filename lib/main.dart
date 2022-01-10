import 'package:driver_app/screens/car_info.dart';
import 'package:driver_app/screens/documents.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/screens/uploaded.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/screens/home.dart';
import 'package:driver_app/screens/login.dart';
import 'package:driver_app/screens/register.dart';
import 'package:driver_app/routes.dart';
import 'screens/search_dropoff/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference driverRef = FirebaseDatabase.instance.reference().child("drivers");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Driver App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SubscriptionScreen.routeName,
        routes: routes,
      ),
    );
  }
}
SomethingWentWrong() {
  return Container(
    child: Text(
      "Error",
    ),
  );
}
Loading() {
  return Container(
    child: Text(
      "Loading",
    ),
  );
}