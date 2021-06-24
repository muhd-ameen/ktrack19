import 'package:flutter/cupertino.dart';
import 'package:pandamus/Apis/apis/find-slot.dart';
import 'package:pandamus/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VaccineSlot extends StatefulWidget {
  const VaccineSlot({key}) : super(key: key);

  @override
  _VaccineSlotState createState() => _VaccineSlotState();
}

class _VaccineSlotState extends State<VaccineSlot> {
  TextEditingController searchField = new TextEditingController();
  var Pincode = 678006;
  FindVaccineCenter findVaccineCenter = FindVaccineCenter();
  Future<List<VaccineSlot>> getVaccineSlot() async {
    var baseUrl =
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public';
    var vaccineSlotUrl =
        '$baseUrl/findByPin?pincode=${searchField.text}&date=24-06-2021';
    var vaccineSlotResponse = await http.get(vaccineSlotUrl);
    var responseJson = json.decode(vaccineSlotResponse.body);
    findVaccineCenter = FindVaccineCenter.fromJson(responseJson);
    print(vaccineSlotResponse.body);
    print(findVaccineCenter.sessions[1].name);
    if (vaccineSlotResponse.statusCode != 200) {
      print('Something went wrong \n '
          'Status: ${vaccineSlotResponse.statusCode}');
    } else {
      print('Status:Success\n'
          'statusCode: ${vaccineSlotResponse.statusCode}');
    }
  //   print('data: ${findVaccineCenter.sessions.last.name}');
  }

  @override
  void initState() {
    super.initState();
    getVaccineSlot();
  }

  Widget dataBox() {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'vaccineSlot.toUpperCase()',
                  style: TextStyle(
                    color: kTextMediumColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'api',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'vaccineSlot.toUpperCase()',
                  style: TextStyle(
                    color: kTextMediumColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'api',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ],
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
                      "Find Vaccinations Centers",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildInfoTextWithPercentage(
                          percentage: "35.43",
                          title: "Vaccinted in Kerala",
                        ),
                        buildInfoTextWithPercentage(
                          percentage: "18.43",
                          title: "Vaccinted in Kerala",
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              CupertinoSearchTextField(
                placeholder: 'Enter Pincode',
                controller: searchField,
              ),
              SizedBox(height: 20),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.black,
                onPressed: () {
                  getVaccineSlot();
                },
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Widget dataBox(String centerName,String district,String vaccine,String availableDose1,String availableDose2) {

              dataBox(),

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
      Text(
        "250.9% ",
        style: TextStyle(color: kPrimaryColor),
      ),
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
