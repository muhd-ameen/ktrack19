
import 'package:pandamus/constants.dart';
import 'package:pandamus/initialPages/onbording.dart';
import 'package:pandamus/screens/about.dart';
import 'package:pandamus/screens/donate.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/vaccine/get_vaccinated.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pandamus/covid-updates/new-cases.dart';
import 'package:pandamus/covid-updates/total-death.dart';
import 'package:pandamus/covid-updates/total-recovered.dart';
import 'package:pandamus/widgets/info_card.dart';
import 'package:pandamus/covid-updates/confirmed-cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {},
      child: Scaffold(
        key: _scaffoldKey,

        appBar: AppBar(
          title: Center(
              child: Text(
            ' 🩺 Pandamus',
            style:
                TextStyle(color: Colors.teal[600], fontWeight: FontWeight.w700),
          )),
          backgroundColor: kBackgroundColor,
          elevation: 0,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black, size: 20),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Onbording()));
              },
            ),
          ],
        ),
//wrap singlechildscrollview for correct displaying in small density devices
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: <Widget>[
                    InfoCard(
                      title: "Confirmed Cases",
                      iconColor: Color(0xFFFF8C00),
                      effectedNum: 1062,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ConfrmedCases();
                            },
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      title: "Total Deaths",
                      iconColor: Color(0xFFFF2D55),
                      effectedNum: 75,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TotalDeaths();
                            },
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      title: "Total Recovered",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: 689,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TotalRecovered();
                            },
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      title: "New Cases",
                      iconColor: Color(0xFF5856D6),
                      effectedNum: 75,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NewCases();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Preventions",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      buildPreventation(),
                      SizedBox(height: 40),
                      buildHelpCard(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            const url = 'tel:1056';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Icon(Icons.call),
          backgroundColor: Color(0xFF1B8D59),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/drawer.png"),
                  ),
                  // color: Colors.teal,
                ),
                child: Text(' Pandamus'),
              ),
              ListTile(
                title: Text('💉 Get Vaccinated'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetVaccinated()),
                  );
                },
              ),
              ListTile(
                title: Text('🏥 Find Vaccine Slot'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VaccineSlot()),
                  );
                },
              ),
              ListTile(
                title: Text('🚨 Emergency contacts'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyContact()),
                  );
                },
              ),
              ListTile(
                title: Text('🧑‍💻 About Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              ListTile(
                title: Text('💰 Donate'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Donationpage()),
                  );
                },
              ),
              ListTile(
                title: Text('🏢 Gov Portal'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyWebView(
                            title: "covid-19 jagratha",
                            selectedUrl:
                            "https://covid19jagratha.kerala.nic.in",
                          )));

                },
              ),
              ListTile(
                title: Text('🥺 Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onbording()),
                  );
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              Column(
                children: [
                  Text('V0.0.01'),
                  IconButton(icon: Icon(Icons.code_outlined), onPressed: () async{
                    const url = 'https://github.com/muhd-ameen/pandamus';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }

                    print('Link Opened');
                  }),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Wash Hands",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use Masks",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Clean Disinfect",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 1056 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}

// class Fcm extends StatefulWidget {
//   const Fcm({key}) : super(key: key);
//
//   @override
//   _FcmState createState() => _FcmState();
// }
//
// class _FcmState extends State<Fcm> {
//   @override
//   void intState(){
//     super.initState();
//     FirebaseMessaging.getInstance().getToken()
//         .addOnCompleteListener(new OnCompleteListener<String>() ,{
//     @Override
//     public void onComplete(@NonNull Task<String> task) {
//     if (!task.isSuccessful()) {
//     Log.w(TAG, "Fetching FCM registration token failed", task.getException());
//     return;
//     }
//
//     // Get new FCM registration token
//     String token = task.getResult();
//
//     // Log and toast
//     String msg = getString(R.string.msg_token_fmt, token);
//     Log.d(TAG, msg);
//     Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
//     }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
