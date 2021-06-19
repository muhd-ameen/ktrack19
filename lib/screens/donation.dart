import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
// import 'package:url_launcher/url_launcher.dart';

class Donationpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.teal,
                      size: 30,
                    ),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Donate now',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Kerala is in a battle against COVID19.'
                    ' The people of the State have shown great courage and tenacity in'
                    ' this fight against the pandemic. The outbreak and the consequent '
                    'disruption have affected the lives of many. You can help rebuild the'
                    ' affected lives by making contributions to the Chief Ministers Distress Relief Fund (CMDRF). ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/donation.png'),
                )),
              ),
              Column(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    height: 40,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyWebView(title: " STAND with Kerala",
                                selectedUrl: "https://donation.cmdrf.kerala.gov.in/",)));


                      // const url = 'https://donation.cmdrf.kerala.gov.in/';
                      // if (await canLaunch(url)) {
                      //   await launch(url);
                      // } else {
                      //   throw 'Could not launch $url';
                      // }
                    },
                    color: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Donate Now',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
