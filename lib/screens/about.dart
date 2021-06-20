import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Kerala is in a battle against COVID19.'
                    ' The people of the State have shown great courage and tenacity in'
                    ' this fight against the pandemic. We the Developers In Flutter Community Developed This app For Simplified The Covid Survival Easy. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Version: 0.01'),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/developer.png'),
                )),
              ),
              Column(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    height: 40,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyWebView(
                                    title: "Buy Me A Cofee",
                                    selectedUrl:
                                        "https://buymeacoffee.com/ameens",
                                  )));

                      // const url = 'https://buymeacoffee.com/ameens';
                      // if (await canLaunch(url)) {
                      //   await launch(url);
                      // } else {
                      //   throw 'Could not launch $url';
                      // }
                    },
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Buy me a cofee',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
