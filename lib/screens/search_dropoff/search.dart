import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/config.dart';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/helpers/request.dart';
import 'package:driver_app/models/address.dart';
import 'package:driver_app/models/predictions.dart';
import 'package:driver_app/widgets/divider.dart';
import 'package:driver_app/widgets/progressDialog.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController dropoffTextEditingController = TextEditingController();
  List<Predictions> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 25.0,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5.0,),
                    Stack(
                      children: [
                        GestureDetector(
                          child: Icon(
                              Icons.arrow_back,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text(
                            "Enter Drop Location",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (val) {
                                  searchPlace(val);
                                },
                                controller: dropoffTextEditingController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(64.0),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  hintText: "Enter Pickup",
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.0,),
            (placePredictionList.length > 0)
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              child: ListView.separated(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  return PredictionTile(placePredictions: placePredictionList[index],);
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24.0,),
                itemCount: placePredictionList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              ),
            )
                : Container(

            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchPlace(String placeName) async {
    if(placeName.length > 0) {
      String autocompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:in";
      var response = await Request.getRequest(autocompleteUrl);
      if(response == "failed") {
        return;
      }
      if(response['status'] == "OK") {
        var predictions = response['predictions'];
        var placesList = (predictions as List).map((e) => Predictions.fromJson(e)).toList();
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final Predictions placePredictions;
  const PredictionTile({Key? key, required this.placePredictions,}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getPlaceDetails(placePredictions.placeID, context);
      },
      child: Column(
        children: [
          SizedBox(width: 10.0,),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 32.0,
              ),
              SizedBox(width: 14.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placePredictions.mainText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 3.0,),
                    Text(
                      placePredictions.secondaryText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 10.0,),
        ],
      ),
    );
  }
  void getPlaceDetails(String placeID, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Setting Dropoff",)
    );
    String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=$placeID&key=$mapKey";
    var response = await Request.getRequest(placeDetailsUrl);
    Navigator.pop(context);
    if(response == "Failed") {
      return;
    }
    if(response['status'] == "OK") {
      Address address = Address(
        placeName: response["result"]["name"],
        placeID: placeID,
        latitude: response["result"]["geometry"]["location"]["lat"],
        longitude: response["result"]["geometry"]["location"]["lng"],
      );
      Provider.of<AppData>(context, listen: false).updateuserDropoffLocationAddress(address);
    }
  }
}
