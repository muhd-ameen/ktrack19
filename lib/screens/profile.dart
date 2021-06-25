import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  // const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameField = new TextEditingController();
  TextEditingController mailField = new TextEditingController();
  TextEditingController phoneField = new TextEditingController();
  TextEditingController locationField = new TextEditingController();

  String _name;
  String _email;
  String _phoneNumber;
  String _location;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // addStringToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('stringValue', "abc");
  // }
  Widget _buildName() {
    return TextFormField(
      controller: nameField,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        labelText: 'Full Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: _name == null
            ? 'Add Name'
            : _name.toString(),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
      ),
    );
  }
  Widget _buildEmail() {
    return TextFormField(
      controller: mailField,
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email Id is Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter A valid Email Address';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Alexa@example.com',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      controller: phoneField,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (String value) {
        if (value.length < 10) {
          return 'Please Enter 10 Digit Phone Number';
        } else if (value.length == null) {
          return 'Phone Number is Required';
        }
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        labelText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'x x x x x',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildLocation() {
    return TextFormField(
      controller: locationField,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location is Required';
        }
      },
      onSaved: (String value) {
        _location = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        labelText: 'Location',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Areekkode',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
      ),
    );
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.teal[600],
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              imageProfile(),

              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    _buildName(),
                    SizedBox(
                      height: 28,
                    ),
                    _buildPhone(),
                    SizedBox(
                      height: 28,
                    ),
                    _buildEmail(),
                    SizedBox(
                      height: 28,
                    ),
                    _buildLocation(),
                  ],
                ),
              ),

              //

              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ignore: deprecated_member_use
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        if (!_formkey.currentState.validate()) {
                          return;
                        }
                        _formkey.currentState.save();
                        print('Name:$_name');
                        print('Email: $_email');
                        print('Phone: $_phoneNumber');
                        print('Location: $_location');

                        Map<String, dynamic> data = {
                          "Name": nameField.text,
                          "Email": mailField.text,
                          "Phone": phoneField.text,
                          "Location": locationField.text,
                        };
                        print('Form Submitted');
                        FirebaseFirestore.instance
                            .collection("Profile Data")
                            .add(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        print('Navigated');
                      },
                      color: Colors.teal[600],
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.10),
                    offset: Offset(0, 10))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _imageFile == null
                    ? AssetImage('assets/images/login.png')
                    : FileImage(File(_imageFile.path)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: Colors.white),
                color: Colors.teal[600],
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

//   TextField buildTextField(String labelText, String placeholder, String Controller) {
//     return
//       TextField(
//         controller: nameF,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(bottom: 3),
//         labelText: labelText,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         hintText: placeholder,
//         hintStyle: TextStyle(
//             fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
//       ),
//     );
//   }
// }
}
