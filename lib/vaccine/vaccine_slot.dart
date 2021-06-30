import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pandamus/Apis/apis/Vaccine-Data.dart';
import 'package:pandamus/Apis/apis/find-slot.dart';
import 'package:pandamus/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/screens/about.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/screens/payment.dart';
import 'package:pandamus/screens/profile.dart';
import 'package:pandamus/vaccine/get_vaccinated.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //location
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;

  void location() {
    var locationOption =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _streamSubscription = Geolocator()
        .getPositionStream(locationOption)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates)
            .then((value) => _address = value);
      });
    });
  }

  //location

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await geVaccineSlotData();
      print('location:${_address?.locality ?? '-'}');
    });
     location();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
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



  Widget phcData(){
    return dataRecieveds == null ? Container(): ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: findVaccineCenter.sessions.length,itemBuilder: (context, index) {
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
                    'Date',
                    style: TextStyle(
                      color: kTextMediumColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    findVaccineCenter.sessions[index].date.toString(),
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
                    findVaccineCenter.sessions[index].name.toString(),
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
                    findVaccineCenter.sessions[index].blockName.toString(),
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
                    findVaccineCenter.sessions[index].from.toString(),
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
                    findVaccineCenter.sessions[index].to.toString(),
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
                    findVaccineCenter.sessions[index].feeType.toString(),
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
                    findVaccineCenter.sessions[index].vaccine.toString(),
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
                    findVaccineCenter.sessions[index].availableCapacityDose1
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
                    'Dose 2 Available',
                    style: TextStyle(
                      color: kTextMediumColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    findVaccineCenter.sessions[index].availableCapacityDose2
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
                    'Min Age Limit',
                    style: TextStyle(
                      color: kTextMediumColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    findVaccineCenter.sessions[index].minAgeLimit
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
    );}

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
                  'Current Date : ${currentDate.day.toString()}-${currentDate.month.toString()}-${currentDate.year.toString()}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700]),
                ),
                SizedBox(height: 5),
                Text(
                  'Pincode:${_address?.postalCode ?? ' -'}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[700]),
                ),
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
                            geVaccineSlotData();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                dataRecieveds == null ? Text('No Data Available') : Text(''),
                SizedBox(height: 15),
                phcData(),
                // dataBox(1),
                // dataBox(2),
                // dataBox(3),
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
