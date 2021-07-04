import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pandamus/Apis/apis/Summary-api.dart';
import 'package:pandamus/Services/services.dart';
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

class ActiveCases extends StatefulWidget {
  @override
  _ActiveCasesState createState() => _ActiveCasesState();
}

String dataRecievedsa;
String Palakkada;
String Malappurama;
String Pathanamthittaa;
String Wayanada;
String Thiruvananthapurama;
String Kannura;
String Thrissura;
String Kottayama;
String Kollama;
String Idukkia;
String Ernakulama;
String Alappuzhaa;
String Kozhikodea;
String Kasaragoda;
String Summaryvaluea;
String lastUpdatea;

class _ActiveCasesState extends State<ActiveCases> {
  DistrictWise latestData = DistrictWise();
  SummaryData summaryData = SummaryData();
  LocationServicesState locationServices = LocationServicesState();

  // ignore: missing_return
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
        dataRecievedsa= latestData.summary.palakkad.confirmed.toString();
        Thrissura= latestData.summary.thrissur.confirmed.toString();
        Palakkada = latestData.summary.palakkad.confirmed.toString();
        Malappurama= latestData.summary.malappuram.confirmed.toString();
        Ernakulama= latestData.summary.ernakulam.confirmed.toString();
        Kozhikodea = latestData.summary.kozhikode.confirmed.toString();
        Kannura = latestData.summary.kannur.confirmed.toString();
        Kasaragoda= latestData.summary.kasaragod.confirmed.toString();
        Idukkia= latestData.summary.idukki.confirmed.toString();
        Kottayama = latestData.summary.kottayam.confirmed.toString();
        Thiruvananthapurama= latestData.summary.thiruvananthapuram.confirmed.toString();
        Pathanamthittaa = latestData.summary.pathanamthitta.confirmed.toString();
        Alappuzhaa= latestData.summary.alappuzha.confirmed.toString();
        Wayanada= latestData.summary.wayanad.confirmed.toString();
        Kollama= latestData.summary.kollam.confirmed.toString();
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
        Summaryvaluea = summaryData.summary.active.toString();
        lastUpdatea = summaryData.lastUpdated.toString();
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
      if (dataRecievedsa == null) {
        await getDistrictWise();
        await geSummaryData();
      }
    });
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
      body: dataRecievedsa == null
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
                          // Text('${_address?.subLocality?? '-'}, ${_address?.locality?? '-'}',
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.blueAccent[700]
                          //   ),
                          // ),
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
                          dataRecievedsa == null
                              ? Text('')
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    buildInfoTextWithPercentage(
                                      percentage: "Last Updated",
                                      title: lastUpdatea,
                                    ),
                                    buildInfoTextWithPercentage(
                                      percentage: "Total Cases",
                                      title: Summaryvaluea,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    dataBox("Palakkad", Palakkada),
                    dataBox("Malappuram", Malappurama),
                    dataBox("Pathanamthitta", Pathanamthittaa),
                    dataBox("Wayanad", Wayanada),
                    dataBox("Thiruvananthapuram", Thiruvananthapurama),
                    dataBox("Kannur", Kannura),
                    dataBox("Thrissur", Thrissura),
                    dataBox("Kottayam", Kottayama),
                    dataBox("Kollam", Kollama),
                    dataBox("Idukki", Idukkia),
                    dataBox("Ernakulam", Ernakulama),
                    dataBox("Alappuzha", Alappuzhaa),
                    dataBox("Kozhikode", Kozhikodea),
                    dataBox("Kasaragod", Kasaragoda),
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
                                " ",
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
                ), child: null,
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
              title: Text('👨 Profile'),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PaymentPage();
            }));
          },
        ),
      ],
    );
  }
}
