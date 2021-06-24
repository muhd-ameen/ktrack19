import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pandamus/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandamus/Apis/apis/District-wise.dart';

class ConfirmedCases extends StatefulWidget {
  const ConfirmedCases({key}) : super(key: key);

  @override
  _ConfirmedCasesState createState() => _ConfirmedCasesState();
}

class _ConfirmedCasesState extends State<ConfirmedCases> {

  DistrictWise latestData = DistrictWise();
  Future<List<DistrictWise>> getDistrictWise() async {
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/latest.json';
    var districtResponse = await http.get(districtUrl);
    var responseJson = json.decode(districtResponse.body);
    latestData = DistrictWise.fromJson(responseJson);
    if (latestData == null){
      print('no data available');
    }
    print(districtResponse.body);
  }

  @override
  void initState() {
    super.initState();
    getDistrictWise();
  }

  Widget dataBox(String district, String api, int padd) {
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
      // resizeToAvoidBottomPadding: false,
      appBar: buildDetailsAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                      "Total Confirmed Cases",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildInfoTextWithPercentage(
                          percentage: "Last Updated",
                          title: latestData.lastUpdated.toString(),
                        ),
                        // buildInfoTextWithPercentage(
                        //   percentage: summaryData.summary.confirmed.toString(),
                        //   title: "Confiremed Cases",
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              dataBox("Palakkad",
                  latestData.summary.palakkad.confirmed.toString(), 20),
              dataBox("Malappuram",
                  latestData.summary.malappuram.confirmed.toString(), 20),
              dataBox("Pathanamthitta",
                  latestData.summary.pathanamthitta.confirmed.toString(), 20),
              dataBox("Wayanad", latestData.summary.wayanad.confirmed.toString(),
                  20),
              dataBox("Thrissur",
                  latestData.summary.thrissur.confirmed.toString(), 20),
              dataBox(
                  "Thiruvananthapuram",
                  latestData.summary.thiruvananthapuram.confirmed.toString(),
                  20),
              dataBox("Kozhikode",
                  latestData.summary.kozhikode.confirmed.toString(), 20),
              dataBox("Kottayam",
                  latestData.summary.kottayam.confirmed.toString(), 20),
              dataBox(
                  "Kollam", latestData.summary.kollam.confirmed.toString(), 20),
              dataBox("Kasaragod",
                  latestData.summary.kasaragod.confirmed.toString(), 20),
              dataBox(
                  "Kannur", latestData.summary.kannur.confirmed.toString(), 20),
              dataBox(
                  "Idukki", latestData.summary.idukki.confirmed.toString(), 20),
              dataBox("Ernakulam",
                  latestData.summary.ernakulam.confirmed.toString(), 20),
              dataBox("Alappuzha",
                  latestData.summary.alappuzha.confirmed.toString(), 20),
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

class ConfrmedCases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}
