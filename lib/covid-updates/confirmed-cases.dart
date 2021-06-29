import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pandamus/Apis/apis/Summary-api.dart';
import 'package:pandamus/Services/services.dart';
import 'package:pandamus/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandamus/Apis/apis/District-wise.dart';

class ConfirmedCases extends StatefulWidget {
  const ConfirmedCases({key}) : super(key: key);
  @override
  _ConfirmedCasesState createState() => _ConfirmedCasesState();
}

class _ConfirmedCasesState extends State<ConfirmedCases> {
  DistrictWise latestData = DistrictWise();
  SummaryData summaryData = SummaryData();
  LocationServicesState locationServices = LocationServicesState();
  String dataRecieved;

  String dataRecieveds;

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
        dataRecieved = latestData.summary.palakkad.confirmed.toString();
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
                          // Text('${_address?.subLocality?? '-'}, ${_address?.locality?? '-'}',
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.blueAccent[700]
                          //   ),
                          // ),
                           Text(
                                  "Total Confirmed Cases${locationServices.address?.postalCode?? '-'}",

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
                                percentage: "Total Cases",
                                title: summaryData.summary.confirmed.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    dataBox("Palakkad",
                        latestData.summary.palakkad.confirmed.toString()),
                    dataBox("Malappuram",
                        latestData.summary.malappuram.confirmed.toString()),
                    dataBox("Pathanamthitta",
                        latestData.summary.pathanamthitta.confirmed.toString()),
                    dataBox("Wayanad",
                        latestData.summary.wayanad.confirmed.toString()),
                    dataBox("Thrissur",
                        latestData.summary.thrissur.confirmed.toString()),
                    dataBox(
                        "Thiruvananthapuram",
                        latestData.summary.thiruvananthapuram.confirmed
                            .toString()),
                    dataBox("Kozhikode",
                        latestData.summary.kozhikode.confirmed.toString()),
                    dataBox("Kottayam",
                        latestData.summary.kottayam.confirmed.toString()),
                    dataBox("Kollam",
                        latestData.summary.kollam.confirmed.toString()),
                    dataBox("Kasaragod",
                        latestData.summary.kasaragod.confirmed.toString()),
                    dataBox("Kannur",
                        latestData.summary.kannur.confirmed.toString()),
                    dataBox("Idukki",
                        latestData.summary.idukki.confirmed.toString()),
                    dataBox("Ernakulam",
                        latestData.summary.ernakulam.confirmed.toString()),
                    dataBox("Alappuzha",
                        latestData.summary.alappuzha.confirmed.toString()),
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
          icon: SvgPicture.asset("assets/icons/doante.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
