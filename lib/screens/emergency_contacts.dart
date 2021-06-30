import 'package:pandamus/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/screens/payment.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class EmergencyContact extends StatelessWidget {
  Widget CallCard(String ServicesName, Widget expand) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 21),
              blurRadius: 53,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ServicesName.toUpperCase(),
              style: TextStyle(
                color: kTextMediumColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Expanded(
                flex: 1,
                child: expand,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: buildDetailsAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Emergency Contact Numbers",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Press Call Icon to Call",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),                    SizedBox(height: 15),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        CallCard(
                            'Ambulance',
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed: () async {
                                    const url = 'tel:108';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              ),
                            )),
                        CallCard(
                            'Disha (Toll Free)',
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed: () async {
                                    const url = 'tel:1056';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              ),
                            )),
                        CallCard(
                            'State Helpline)',
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed: () async {
                                    const url = 'tel:108';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              ),
                            )),
                        CallCard(
                            'Women Helpline',
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed: () async {
                                    const url = 'tel:1091';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              ),
                            ),),
                        CallCard(
                          'Disaster Helpline',
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.call),
                                onPressed: () async {
                                  const url = 'tel:1070';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 54,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Global Map",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SvgPicture.asset("assets/icons/map.svg"),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$percentage% \n",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: kTextMediumColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.redeem_rounded),
          color: Colors.teal,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PaymentPage();
            }));
          },
        ),
      ],
    );
  }
}
