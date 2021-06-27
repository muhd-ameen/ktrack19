import 'package:flutter/cupertino.dart';
import 'package:pandamus/Apis/apis/Vaccine-Data.dart';
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
  TextEditingController dateFiled = new TextEditingController();

  FindVaccineCenter findVaccineCenter = FindVaccineCenter();
  VaccineData vaccineData = VaccineData();
  DateTime currentDate = DateTime.now();
  String dataRecieveds;

  int boxCounte;

  int datavaccine;

  Future<List<FindVaccineCenter>> geVaccineSlotData() async {
    showLoaderDialog(context);
    var baseUrl =
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public';
    var districtUrl =
        '$baseUrl/findByPin?pincode=${searchField.text}&date=${currentDate.day.toString()}-${currentDate.month.toString()}-${currentDate.year.toString()}';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    findVaccineCenter = FindVaccineCenter.fromJson(responseJson);
    print(districtResponse.body);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        dataRecieveds = findVaccineCenter.sessions.first.name.toString();
        datavaccine = findVaccineCenter.sessions.length.toInt();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await geVaccineSlotData();
    });
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

  dataBox(int id) {
    return dataRecieveds == null
        ? Container()
        : Padding(
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
                        'Date',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].date.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Vaccine Center',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].name.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Loacality',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].blockName.toString(),
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
                        'From',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].from.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'To',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].to.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Fee',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].feeType.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Vaccine Type',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].vaccine.toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Dose 1 Available',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].availableCapacityDose1
                            .toString(),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Dose 1 Available',
                        style: TextStyle(
                          color: kTextMediumColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        findVaccineCenter.sessions[id].availableCapacityDose2
                            .toString(),
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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildInfoTextWithPercentage(
                            percentage: "35.43",
                            title: 'Total Vaccinated',
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
                Text(
                    'Current Date : ${currentDate.day.toString()}-${currentDate.month.toString()}-${currentDate.year.toString()}'),
                SizedBox(height: 10),
                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.black,
                          // padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.black,
                          // padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (currentDate == null) {
                              Text('Select A Date');
                            }
                            // initState();
                            geVaccineSlotData();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(60, 8, 40, 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       RaisedButton(
                //         color: Colors.teal[900],
                //         onPressed: () => _selectDate(context),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12.0),
                //         ),
                //         child: Text(
                //           'Select date',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //       FlatButton(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12.0),
                //         ),
                //         color: Colors.black,
                //         onPressed: () {
                //           if (currentDate == null) {
                //             Text('Select A Date');
                //           }
                //           geVaccineSlotData();
                //         },
                //         child: Text(
                //           '   Search   ',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 20),
                dataRecieveds == null ? Text('No Data Available') : Text(''),
                SizedBox(height: 15),
                dataBox(0),
                dataBox(1),
                dataBox(2),
                dataBox(3),
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
                      SizedBox(height: 10),
                      SvgPicture.asset(
                        "assets/icons/vaccines.svg",
                        height: 250,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
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
