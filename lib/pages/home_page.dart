import 'dart:async';
import 'dart:convert';

import 'package:driver_app/components/bottom_button.dart';
import 'package:driver_app/handlers/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _googleMapController = Completer();

  late GoogleMapController newGoogleMapController;
  double rideContainerHeight = 0.0;
  double confirmedContainerHeight = 0.0;
  late String dropoff = "", id, mobile="";

  loadRides() async {
    String statusUrl = "https://saisatram.in/rideapis/api/driver/rides.php";
    http.Response status = await http.get(Uri.parse(statusUrl));
    var stat = jsonDecode(status.body);
    if (stat['status'] == 1) {
      setState(() {
        rideContainerHeight = 200.0;
        dropoff = stat['data']['adropoff'];
        id = stat['data']['id'];
        mobile = stat['data']['usermobile'];
      });
    } else {
      if (mounted) {
        setState(() {
          rideContainerHeight = 0.0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (_) => loadRides());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          initialCameraPosition: Constants.kGooglePlex,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _googleMapController.complete(controller);
            newGoogleMapController = controller;
          },
        ),
        Positioned(
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: rideContainerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "New Booking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            fontFamily: "PTSerif"),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Text(
                        dropoff.isEmpty ? "Nothing" : dropoff,
                        style:
                            TextStyle(fontSize: 16.0, fontFamily: "OpenSans"),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Text(
                        "7 Min",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Brand Bold",
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              confirmRide(context);
                            },
                            child: Container(
                              height: 44.0,
                              width: 128.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(64.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Accept",
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 44.0,
                              width: 128.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(64.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
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
        ),
        Positioned(
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: confirmedContainerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        dropoff.isEmpty ? "Nothing" : dropoff,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            fontFamily: "PTSerif"),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Text(
                        mobile.isEmpty ? "Nothing" : mobile,
                        style:
                            TextStyle(fontSize: 16.0, fontFamily: "OpenSans"),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Text(
                        "7 Min",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Brand Bold",
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              UrlLauncher.launch("tel://8328484639");
                            },
                            child: Container(
                              height: 44.0,
                              width: 128.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(64.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Call",
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 44.0,
                              width: 128.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(64.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Complete Ride",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
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
        ),
      ],
    );
  }

  confirmRide(BuildContext context) async {
    final APIURL = "https://saisatram.in/rideapis/api/driver/confirm.php";
    Map userDataMap = {
      "id": id,
      "did": Provider.of<AppData>(context, listen: false).driverId,
      "drivername": Provider.of<AppData>(context, listen: false).driverName,
      "drivermobile": Provider.of<AppData>(context, listen: false).driverMobile,
      "carnumber": Provider.of<AppData>(context, listen: false).carNumber,
      "carmodel": Provider.of<AppData>(context, listen: false).carModel,
    };
    http.Response response =
        await http.post(Uri.parse(APIURL), body: userDataMap);
    var data = jsonDecode(response.body);
    if (data['status'] == 1) {
      setState(() {
        rideContainerHeight = 0;
        confirmedContainerHeight = 200.0;
      });
      toastMessage(data['message'], context);
    } else {
      toastMessage(data['message'], context);
      Navigator.pop(context);
    }
  }
}
