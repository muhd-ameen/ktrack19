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
  String dataRecieveds;
  Future<List<VaccineData>> geSummaryData() async {
    showLoaderDialog(context);
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/vaccination_summary.json';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    vaccineData = VaccineData.fromJson(responseJson);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        dataRecieveds = vaccineData.summary.totPersonVaccinations.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await geSummaryData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Get Vaccinated',
        ),
        leading: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.teal,),
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
      body: dataRecieveds == null
          ? Container()
          : SingleChildScrollView(
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
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                                    title: "Covid Care Center List",
                                    selectedUrl:
                                        "https://covid19jagratha.kerala.nic.in/home/addCCCList/s",
                                  )));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.medical_services),
                            title: const Text('Covid Care Center List'),
                            subtitle: Text(
                              'Get District Wise Covid Center Data ',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                            leading: Icon(Icons.monetization_on),
                            title: const Text(' Stand with Kerala  '),
                            subtitle: Text(
                              'Chief Ministers Pandemic Relief Fund ',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                                    selectedUrl:
                                        "https://dashboard.cowin.gov.in/",
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
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                          subtitle: Text(vaccineData
                              .summary.totPersonVaccinations
                              .toString()),
                        ),
                        ListTile(
                          leading: Icon(Icons.verified_user_outlined),
                          title: const Text('Second Dose Vaccinated'),
                          subtitle:
                              Text(vaccineData.summary.secondDose.toString()),
                        ),
                        Container(
                            height: 167,
                            width: 200,
                            child:
                                Image.asset('assets/images/vaccine_main.png')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
