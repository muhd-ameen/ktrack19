import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/screens/widgets/my_webview.dart';
import 'package:pandamus/vaccine/vaccine_registration.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';

class GetVaccinated extends StatelessWidget {
  const GetVaccinated({key}) : super(key: key);

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
            SizedBox(height: 10,),
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
                        builder: (context) => MyWebView(title: "Cowin Statistics",
                          selectedUrl: "https://dashboard.cowin.gov.in/",)));
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
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.verified_user_outlined),
                    title: const Text('Know my Status'),

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100,0,0,0),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return VaccineRegister();
                                },
                              ),
                            );
                          },
                          child: const Text('Dose 1'),
                        ),
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return VaccineRegister();
                                },
                              ),
                            );
                          },
                          child: const Text('Dose 2'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    // child: Text(
                    //   'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    // ),
                  ),

                  SizedBox(height: 20,),
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
