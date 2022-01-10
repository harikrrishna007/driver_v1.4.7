import 'package:driver_app/screens/home.dart';
import 'package:driver_app/screens/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'login.dart';

class SubscriptionScreen extends StatefulWidget {
  static String routeName = "/subscribe";

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Razorpay razorPay;
  @override
  void initState() {
    super.initState();
    razorPay = new Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

  void openCheckout(amount) {
    //TODO:Payment Checkout
    var options = {
      "key" : "rzp_test_Q5eQgIA9jHNW8n",
      "amount" : amount,
      "name" : "Bolt",
      "description" : "Payment for Subscription",
      "prefill" : {
        "contact" : "8328484639",
        "email" : "harikrishnanuvvula@gmail.com"
      },
      "external" : {
        "wallets" : [
          "paytm"
        ]
      }
    };

    try {
      razorPay.open(options);
    } catch(e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, toastLength: Toast.LENGTH_SHORT);
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 100.0,),
                  Center(
                    child: Text(
                      "Choose Your Subscription",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: "Brand-Bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 75.0,),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return HomeScreen();
                            })
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  openCheckout(5000);
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Basic",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "€19.99/mo",
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 20.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6.0),
                                      Container(
                                        height: 125.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("- Upto 39 Rides",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38
                                            ),
                                            ),
                                            Text("- Upto €230 Income",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38
                                              ),),
                                            Text("- Ideal for Part-time Drivers",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38
                                              ),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return HomeScreen();
                            })
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Platinum",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "€39.99/mo",
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 20.0,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      height: 125.0,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("- Upto 79 Rides",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                          Text("- Upto €450 Income",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                          Text("- Perfect package for Taxi Drivers",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return HomeScreen();
                            })
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Container(
                                height: 180.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Diamond",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "€59.99/mo",
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 20.0,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("- Upto 149 Rides",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                          Text("- Upto €900 Income",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                          Text("- Best Package for Fulltime Drivers",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
