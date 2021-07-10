import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  //
  void handlerPaymentSuccess() {
    print('print: Payment Success');
    Toast.show('print: Payment Success', context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaymentPage();
        },
      ),
    );
  }

  void handlerErrorFailure() {
    print('print: Payment Error');
    Toast.show('print: Payment Error', context);
  }

  void handlerExternalWallet() {
    print('print: Payment External Wallet');
    Toast.show('print: Payment External Wallet', context);
  }

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_HQy1dzXkOzzXQT",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "STAND with Kerala",
      "description": "Chief Minister's Pandemic Relief Fund ",
      "prefill": {"contact": "", "email": ""},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: screenHeight * 0.02,
                // ),
                Image.asset(
                  'assets/images/donate.png',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Stand With Kerala',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  '"Give To People From What God Has Provided You.'
                  ' It Will Surely Come Back To You With Greater Value"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   height: 45,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Colors.black,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Row(
                      //     // ignore: prefer_const_literals_to_create_immutables
                      //     children: [
                      //       SizedBox(
                      //           // width: screenWidth * 0.01,
                      //           ),
                      //       Expanded(
                      //         child: TextField(
                      //           decoration: const InputDecoration(
                      //             hintText: 'Enter Amount',
                      //             border: InputBorder.none,
                      //             enabledBorder: InputBorder.none,
                      //             focusedBorder: InputBorder.none,
                      //             contentPadding:
                      //                 EdgeInsets.symmetric(vertical: 13.5),
                      //           ),
                      //           controller: textEditingController,
                      //           keyboardType: TextInputType.number,
                      //           inputFormatters: [
                      //             LengthLimitingTextInputFormatter(10)
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 4,
                      ),
                      // FlatButton(
                      //     padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //     color: Colors.teal,
                      //     onPressed: () {},
                      //     child: RichText(
                      //       text: TextSpan(
                      //         children: [
                      //           TextSpan(
                      //             text: "Donate Now  ",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 17),
                      //           ),
                      //           WidgetSpan(
                      //             child: Icon(
                      //               Icons.payment,
                      //               size: 20,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )),
                      // child: Text('Donate',style: TextStyle(
                      //     fontWeight: FontWeight.bold,color: Colors.white,
                      //     fontSize: 17))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        child: FlatButton(
                          height: 40,
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWebView(
                                  title: "Stand With Kerala",
                                  selectedUrl:
                                      "https://donation.cmdrf.kerala.gov.in/#donation",
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Donate Now",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.payment,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
