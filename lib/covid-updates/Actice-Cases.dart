import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pandamus/Apis/apis/Summary-api.dart';
import 'package:pandamus/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandamus/Apis/apis/District-wise.dart';
import 'package:pandamus/screens/payment.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/screens/about.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/screens/profile.dart';
import 'package:pandamus/vaccine/get_vaccinated.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiceCases extends StatefulWidget {
  const ActiceCases({key}) : super(key: key);
  @override
  _ActiceCasesState createState() => _ActiceCasesState();
}

class _ActiceCasesState extends State<ActiceCases> {
  DistrictWise latestData = DistrictWise();
  SummaryData summaryData = SummaryData();
  String dataRecieved;

  String dataRecieveds;

  Future<List<DistrictWise>> getDistrictWise() async {
    showLoaderDialog(context);
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/latest.json';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    latestData = DistrictWise.fromJson(responseJson);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        dataRecieved = latestData.summary.palakkad.active.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("  Loading...")),
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getDistrictWise();
      await geSummaryData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget dataBox(String district, String api) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
              district.toUpperCase(),
              style: TextStyle(
                color: kTextMediumColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Text(
              api,
              style: TextStyle(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: dataRecieved == null
          ? Container()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.teal[700],
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
                          SizedBox(height: 10),
                           Text(
                                  "Total Active Cases",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                          SizedBox(height: 15),
                          buildTitleWithMoreIcon(),
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                          dataRecieveds == null
                              ? Text('')
                              :Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              buildInfoTextWithPercentage(
                                percentage: "Last Updated",
                                title: latestData.lastUpdated.toString(),
                              ),
                              buildInfoTextWithPercentage(
                                percentage: "Active Cases",
                                title: summaryData.summary.active.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    dataBox("Palakkad",
                        latestData.summary.palakkad.active.toString()),
                    dataBox("Malappuram",
                        latestData.summary.malappuram.active.toString()),
                    dataBox("Pathanamthitta",
                        latestData.summary.pathanamthitta.active.toString()),
                    dataBox("Wayanad",
                        latestData.summary.wayanad.active.toString()),
                    dataBox("Thrissur",
                        latestData.summary.thrissur.active.toString()),
                    dataBox(
                        "Thiruvananthapuram",
                        latestData.summary.thiruvananthapuram.active
                            .toString()),
                    dataBox("Kozhikode",
                        latestData.summary.kozhikode.active.toString()),
                    dataBox("Kottayam",
                        latestData.summary.kottayam.active.toString()),
                    dataBox("Kollam",
                        latestData.summary.kollam.active.toString()),
                    dataBox("Kasaragod",
                        latestData.summary.kasaragod.active.toString()),
                    dataBox("Kannur",
                        latestData.summary.kannur.active.toString()),
                    dataBox("Idukki",
                        latestData.summary.idukki.active.toString()),
                    dataBox("Ernakulam",
                        latestData.summary.ernakulam.active.toString()),
                    dataBox("Alappuzha",
                        latestData.summary.alappuzha.active.toString()),
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
                'Hi ',
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
                  MaterialPageRoute(
                      builder: (context) => EmergencyContact()),
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
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$percentage \n",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleWithMoreIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "KERALA",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        // Text(
        //   "250.9% ",
        //   style: TextStyle(color: kPrimaryColor),
        // ),
      ],
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
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.redeem_rounded),
          color: Colors.teal,

          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return PaymentPage();
            }));
          },
        ),
      ],
    );
  }
}
