class Address {
  late String? placeFormattedAddress;
  late String placeName;
  late String? placeID;
  late double latitude;
  late double longitude;
  late String? id;

  Address({this.placeFormattedAddress, required this.placeName, this.placeID, required this.latitude, required this.longitude, this.id});
}