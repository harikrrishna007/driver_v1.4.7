import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/config.dart';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/helpers/request.dart';
import 'package:driver_app/models/address.dart';

class RequestMethods {
  static Future<String> searchCoordinateAddress(Position position, context) async {
    String currentAddress = "";
    String pickupAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await Request.getRequest(url);
    if(response != "Failed") {
      currentAddress = response['results'][0]["formatted_address"];
      pickupAddress = response['results'][0]["address_components"][1]["long_name"] + ", " +
          response['results'][0]["address_components"][2]["long_name"] + ", " +
          response['results'][0]["address_components"][3]["long_name"] + ", " +
          response['results'][0]["address_components"][4]["long_name"] + ".";
      Address userPickupAddress = new Address(
          placeName: currentAddress,
          latitude: position.latitude,
          longitude: position.longitude
      );
      Provider.of<AppData>(context, listen: false).updateuserPickupLocationAddress(userPickupAddress);
    }

    return pickupAddress;
  }
}