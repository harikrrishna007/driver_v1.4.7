import 'dart:io';
import 'package:driver_app/handlers/app_data.dart';
import 'package:driver_app/screens/home.dart';
import 'package:driver_app/screens/subscription.dart';
import 'package:driver_app/screens/test.dart';
import 'package:driver_app/screens/uploaded.dart';
import 'package:driver_app/widgets/progressDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentVerificationScreen extends StatefulWidget {
  static String routeName = "/verification";
  @override
  _DocumentVerificationScreenState createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState extends State<DocumentVerificationScreen> {
  File? result;
  File? licenseFront;
  File? licenseBack;
  File? rcBook;
  File? insurancePaper;
  File? pollutionPaper;
  File? file;
  late Response response;
  String? progress;
  Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    final licenseFrontFile = licenseFront != null ? basename(licenseFront!.path) : "No File Selected";
    final licenseBackFile = licenseBack != null ? basename(licenseBack!.path) : "No File Selected";
    final rcbookFile = rcBook != null ? basename(rcBook!.path) : "No File Selected";
    final insuranceFile = insurancePaper != null ? basename(insurancePaper!.path) : "No File Selected";
    final pollutionFile = pollutionPaper != null ? basename(pollutionPaper!.path) : "No File Selected";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Upload Documents",
                      style: TextStyle(
                        fontFamily: "Brand-Bold",
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        (progress ?? "")
                    ),
                    SizedBox(height: 12.0,),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          selectLicenseFront();
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
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Upload License Front",
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
                    Padding(
                      padding:
                          EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
                      child: Text(
                        licenseFrontFile,
                        style:
                            TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold"),
                      ),
                    ),
//                    Padding(
//                      padding:
//                      EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
//                      child:progress == null?
//                      Text("Progress: 0%"):
//                      Text(basename("Progress: $progress"),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(fontSize: 18),),
//                    ),uploadFile(Provider.of<AppData>(context, listen: false).userId.toString(), context);
                    Padding(
                      padding:
                      EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          selectLicenseBack();
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
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Upload License Back",
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
                    Padding(
                      padding:
                      EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
                      child: Text(
                        licenseBackFile,
                        style:
                        TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold"),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          selectRC();
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
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Upload RC Book",
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
                    Padding(
                      padding:
                      EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
                      child: Text(
                        rcbookFile,
                        style:
                        TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold"),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          selectIsurance();
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
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Upload Insurance Paper",
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
                    Padding(
                      padding:
                      EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
                      child: Text(
                        insuranceFile,
                        style:
                        TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold"),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          selectPollution();
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
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Pollution",
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
                    Padding(
                      padding:
                      EdgeInsets.only(top: 0.0, left: 24.0, right: 24.0),
                      child: Text(
                        pollutionFile,
                        style:
                        TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold"),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            uploadFile(Provider.of<AppData>(context, listen: false).driverId.toString(), context);
                          },
                          child: Container(
                            height: 48.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0XFF11D86F),
                                borderRadius: BorderRadius.circular(64.0)),
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 24.0,
                            ),
                            child: Text(
                              "Submit For Verification".toUpperCase(),
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

  Future selectLicenseFront() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      licenseFront = File(path!);
    });
  }

  Future selectLicenseBack() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      licenseBack = File(path!);
    });
  }

  Future selectRC() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      rcBook = File(path!);
    });
  }

  Future selectIsurance() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      insurancePaper = File(path!);
    });
  }

  Future selectPollution() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      pollutionPaper = File(path!);
    });
  }

  Future uploadFile(String id, BuildContext context) async {
    print("Hi");
    var verifyUrl = "https://saisatram.in/rideapis/api/driver/documents.php";
    FormData formdata = FormData.fromMap({
      "licensef": await MultipartFile.fromFile(
          licenseFront!.path,
          filename: basename(licenseFront!.path)
          //show only filename from path
      ),
      "licenseb": await MultipartFile.fromFile(
          licenseBack!.path,
          filename: basename(licenseBack!.path)
        //show only filename from path
      ),
      "rcbook": await MultipartFile.fromFile(
          rcBook!.path,
          filename: basename(rcBook!.path)
        //show only filename from path
      ),
      "insurance": await MultipartFile.fromFile(
          insurancePaper!.path,
          filename: basename(insurancePaper!.path)
        //show only filename from path
      ),
      "pollution": await MultipartFile.fromFile(
          pollutionPaper!.path,
          filename: basename(pollutionPaper!.path)
        //show only filename from path
      ),
      "driverid": id,
    });

    response = await dio.post(
      verifyUrl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          //update the progress
        });
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, UploadedScreen.routeName, (route) => false);
    } else {
      print("Error during connection to server.");
    }
  }
}
