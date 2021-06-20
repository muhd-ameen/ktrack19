import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/vaccine/regis_sucsses.dart';

class VaccineRegister extends StatefulWidget {
  @override
  _VaccineRegisterState createState() => _VaccineRegisterState();
}

class _VaccineRegisterState extends State<VaccineRegister> {
  String _name;
  String _email;
  String _phoneNumber;
  String _pincode;
  String _aadhaar;
  String _age;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
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
    );
  }

  Widget _buildPhonenumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (String value) {
        if (value.length < 6) {
          return 'Please Enter 10 Digit Phone Number';
        } else if (value.length == null) {
          return 'Phone Number is Required';
        }
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildNPincode() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pincode'),
      maxLength: 6,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.length < 6) {
          return 'Please Enter 6 Digit Pincode';
        } else if (value.length == null) {
          return 'Pincode is Required';
        }
      },
      onSaved: (String value) {
        _pincode = value;
      },
    );
  }
  Widget _buildaadhaar() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Aadhaar Number'),
      maxLength: 14,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.length < 14) {
          return 'Please Enter 14 Digit Aadhaar Number';
        } else if (value.length == null) {
          return 'Aadhaar Number is Required';
        }
      },
      onSaved: (String value) {
        _aadhaar = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int age = int.tryParse(value);
        if (age == null || age < 18) {
          return 'Age must be above 18';
        }
      },
      onSaved: (String value) {
        _age = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Center(child: Text('Vaccine Registeration')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Colors.white, size: 20),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 70, 24, 0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildName(),
                _buildPhonenumber(),
                _buildEmail(),
                _buildaadhaar(),
                _buildNPincode(),
                _buildAge(),
                SizedBox(
                  height: 100,
                ),

                TextButton(
                  child: Text(
                    '  Register  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.teal, //
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.teal[600]),
                    ), // foreground
                  ),
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    _formkey.currentState.save();
                    print('Name:$_name');
                    print('Email: $_email');
                    print('Phone: $_phoneNumber');
                    print('Pincode: $_pincode');
                    print('Age: $_age');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisSuccess()));
                    print('pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
