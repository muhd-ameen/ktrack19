import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/Apis/apis/Vaccine-Data.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/screens/payment.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
import 'package:pandamus/vaccine/vaccine_registration.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';
import 'package:http/http.dart' as http;

class GetVaccinated extends StatefulWidget {
  const GetVaccinated({key}) : super(key: key);

  @override
  _GetVaccinatedState createState() => _GetVaccinatedState();
}

class _GetVaccinatedState extends State<GetVaccinated> {
  VaccineData vaccineData = VaccineData();
  Future<List<VaccineData>> getVaccineData() async {
    var baseUrl = 'https://keralastats.coronasafe.live';
    var VaccineUrl = '$baseUrl/vaccination_summary.json';
    var VaccineResponse = await http.get(VaccineUrl);
    var responseJson = json.decode(VaccineResponse.body);
    vaccineData = VaccineData.fromJson(responseJson);
    if (vaccineData == null) {
      print('no data available');
    }
    print(VaccineResponse.body);
  }

  @override
  void initState() {
    super.initState();
    getVaccineData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: Text(
          'Get Vaccinated',
        ),
        leading: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VaccineRegister();
                    },
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.view_list_outlined),
                      title: const Text('Vaccine Registration'),
                      subtitle: Text(
                        'Fill The Form',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VaccineSlot();
                    },
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.search_outlined),
                      title: const Text('Check Vaccine Slot'),
                      subtitle: Text(
                        'Search By Pincode',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyWebView(
                              title: "Cowin Statistics",
                              selectedUrl: "https://dashboard.cowin.gov.in/",
                            )));
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.dashboard_outlined),
                      title: const Text('Cowin Statistics'),
                      subtitle: Text(
                        'Know more about Vaccination',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PaymentPage();
                    },
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.search_outlined),
                      title: const Text(' STAND with Kerala  '),
                      subtitle: Text(
                        'Chief Ministers Pandemic Relief Fund ',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.verified_user_outlined),
                    title: const Text('Total Vaccinations'),
                    subtitle: Text(vaccineData.summary.totPersonVaccinations.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_user_outlined),
                    title: const Text('Second Dose Vaccinated'),
                    subtitle: Text(vaccineData.summary.secondDose.toString()),
                  ),
                  SizedBox(height: 5),
                  Image.asset('assets/images/vaccine_main.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
