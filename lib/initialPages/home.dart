import 'package:flutter/cupertino.dart';
import 'package:pandamus/constants.dart';
import 'package:pandamus/Apis/apis/Summary-api.dart';
import 'package:pandamus/covid-updates/Death-Cases.dart';
import 'package:pandamus/covid-updates/confirmed-cases.dart';
import 'package:pandamus/covid-updates/recovered-cases.dart';
import 'package:pandamus/initialPages/onbording.dart';
import 'package:pandamus/screens/about.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/screens/payment.dart';
import 'package:pandamus/screens/profile.dart';
import 'package:pandamus/screens/utils/user_simple_prefereences.dart';
import 'package:pandamus/vaccine/get_vaccinated.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pandamus/covid-updates/Actice-Cases.dart';
import 'package:pandamus/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfilePage profilePage = ProfilePage();

  SummaryData summaryData = SummaryData();
  String dataRecieveds;
  Future<List<SummaryData>> geSummaryData() async {
    showLoaderDialog(context);
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/summary.json';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    summaryData = SummaryData.fromJson(responseJson);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        dataRecieveds = summaryData.summary.active.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  String FNickName = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await geSummaryData();
      FNickName = UserSimplePreferences.getNickname() ?? '';
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("  Working...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {},
      child: SafeArea(
        top: false,
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
                  showAlertDialog(context, 'LogOut');
                },
              ),
            ],
          ),
//wrap singlechildscrollview for correct displaying in small density devices
          body: dataRecieveds == null
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 20),
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
                              effectedNum: summaryData.summary.confirmed,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ConfirmedCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Total Deaths",
                              iconColor: Color(0xFFFF2D55),
                              effectedNum: summaryData.summary.deceased,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DeathCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Total Recovered",
                              iconColor: Color(0xFF50E3C2),
                              effectedNum: summaryData.summary.recovered,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RecoveredCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Active Cases",
                              iconColor: Color(0xFF5856D6),
                              effectedNum: summaryData.summary.active,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ActiceCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            Center(
                                child: Text(
                                    'Last Updated ${summaryData.lastUpdated.toUpperCase()}')),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/images/drawer.png"),
                      ),
                      // color: Colors.teal,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Hi $FNickName',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
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
                      MaterialPageRoute(builder: (context) => EmergencyContact()),
                    );
                  },
                ),
                ListTile(
                  title: Text('💰 Donate'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()),
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
                          selectedUrl: "https://covid19jagratha.kerala.nic.in",
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('👨 Profile'),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
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
                  title: Text('🥺 Logout'),
                  onTap: () {
                    showAlertDialog(context, 'LogOut');
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: [
                    Text('V0.0.01'),
                    IconButton(
                        icon: Icon(Icons.code_outlined),
                        onPressed: () async {
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
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String s) {
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Alert'),
    content: Text('Do you want To Logout?'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text(
          'Log out',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Onbording()),
          );
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
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
